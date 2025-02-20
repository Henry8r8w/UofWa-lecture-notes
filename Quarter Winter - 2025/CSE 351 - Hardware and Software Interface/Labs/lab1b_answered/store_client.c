/*
 * CSE 351 Lab 1b (Manipulating Bits in C)
 *
 * Name(s):  
 * NetID(s): 
 *
 * This is a file for managing a store of various aisles, represented by an
 * array of 64-bit integers. See aisle_manager.c for details on the aisle
 * layout and descriptions of the aisle functions that you may call here.
 *
 * Written by Porter Jones (pbjones@cs.washington.edu)
 */

#include <stddef.h>  // To be able to use NULL
#include "aisle_manager.h"
#include "store_client.h"
#include "store_util.h"

// Number of aisles in the store
#define NUM_AISLES 10

// Number of sections per aisle
#define SECTIONS_PER_AISLE 4

// Number of items in the stockroom (2^6 different id combinations)
#define NUM_ITEMS 64

// Maximum number of items that can be stored in a section
#define NUM_SPACES 16

// Global array of aisles in this store. Each unsigned long in the array
// represents one aisle.
unsigned long aisles[NUM_AISLES];

// Array used to stock items that can be used for later. The index of the array
// corresponds to the item id and the value at an index indicates how many of
// that particular item are in the stockroom.
int stockroom[NUM_ITEMS];


/* Starting from the first aisle, refill as many sections as possible using
 * items from the stockroom. A section can only be filled with items that match
 * the section's item id. Prioritizes and fills sections with lower addresses
 * first. Sections with lower addresses should be fully filled (if possible)
 * before moving onto the next section.
 */
void refill_from_stockroom() {
  for (int aisle_idx = 0; aisle_idx < NUM_AISLES; aisle_idx++) {
      for (int section_idx = 0; section_idx < SECTIONS_PER_AISLE; section_idx++) {
          unsigned short id = get_id(&aisles[aisle_idx], section_idx); // Get the item ID of the section
          unsigned short empty_spaces = NUM_SPACES - num_items(&aisles[aisle_idx], section_idx); // Calculate empty spaces

          if (empty_spaces > 0 && stockroom[id] > 0) {
              // Determine how many items to add (minimum of empty spaces and stockroom items)
              int items_to_add = (empty_spaces < stockroom[id]) ? empty_spaces : stockroom[id];
              add_items(&aisles[aisle_idx], section_idx, items_to_add); // Add items to the section
              stockroom[id] -= items_to_add; // Update the stockroom
          }
      }
  }
}

/* Remove at most num items from sections with the given item id, starting with
 * sections with lower addresses, and return the total number of items removed.
 * Multiple sections can store items of the same item id. If there are not
 * enough items with the given item id in the aisles, first remove all the
 * items from the aisles possible and then use items in the stockroom of the
 * given item id to finish fulfilling an order. If the stockroom runs out of
 * items, you should remove as many items as possible.
 */
int fulfill_order(unsigned short id, int num) {
  int total_removed = 0; // Initialize the total number of items removed

  for (int aisle_idx = 0; aisle_idx < NUM_AISLES && total_removed < num; aisle_idx++) {
      for (int section_idx = 0; section_idx < SECTIONS_PER_AISLE && total_removed < num; section_idx++) {
          if (get_id(&aisles[aisle_idx], section_idx) == id) {
              unsigned short items_in_section = num_items(&aisles[aisle_idx], section_idx);
              int items_to_remove = (num - total_removed < items_in_section) ? num - total_removed : items_in_section;
              remove_items(&aisles[aisle_idx], section_idx, items_to_remove);
              total_removed += items_to_remove;
          }
      }
  }

  // If there are still items to remove, take them from the stockroom
  if (total_removed < num && stockroom[id] > 0) {
      int items_to_remove = (num - total_removed < stockroom[id]) ? num - total_removed : stockroom[id];
      stockroom[id] -= items_to_remove;
      total_removed += items_to_remove;
  }

  return total_removed;
}

/* Return a pointer to the first section in the aisles with the given item id
 * that has no items in it or NULL if no such section exists. Only consider
 * items stored in sections in the aisles (i.e., ignore anything in the
 * stockroom). Break ties by returning the section with the lowest address.
 */
unsigned short* empty_section_with_id(unsigned short id) {
  for (int aisle_idx = 0; aisle_idx < NUM_AISLES; aisle_idx++) {
        for (int section_idx = 0; section_idx < SECTIONS_PER_AISLE; section_idx++) {
            if (get_id(&aisles[aisle_idx], section_idx) == id && num_items(&aisles[aisle_idx], section_idx) == 0) {
                return (unsigned short*)&aisles[aisle_idx] + section_idx;
            }
        }
    }
    return NULL;
}

/* Return a pointer to the section with the most items in the store. Only
 * consider items stored in sections in the aisles (i.e., ignore anything in
 * the stockroom). Break ties by returning the section with the lowest address.
 */
unsigned short* section_with_most_items() {
    unsigned short* max_section = NULL;
    int max_items = -1;

    for (int aisle_idx = 0; aisle_idx < NUM_AISLES; aisle_idx++) {
        for (int section_idx = 0; section_idx < SECTIONS_PER_AISLE; section_idx++) {
            int items_in_section = num_items(&aisles[aisle_idx], section_idx);
            if (items_in_section > max_items) {
                max_items = items_in_section;
                max_section = (unsigned short*)&aisles[aisle_idx] + section_idx;
            }
        }
    }

    return max_section;
}