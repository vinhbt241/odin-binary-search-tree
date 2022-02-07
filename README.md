# Binary Search Tree
Created as part of The Odin Project curriculum.

## Functionality
This is the binary tree project, which serves to introduce data structures by creating binary trees.

## Methods

| Method | Description | 
| --- | --- |
| #build_tree(array) | Takes an array of data and turns it into a balanced binary tree full of Node objects appropriately placed, The #build_tree method should return the level-0 root node |
| #insert(value) | Insert value to binary tree object |
| #delete(value) | Remove value from binary tree object, self-rebalance after remove |
| #find(value) | Return node with value from binary tree object |
| #level_order(&block) | Traverse the tree in breadth-first level order and yield each node to the provided block. Return an array of values if no block is given |
| #inorder(&block) | Traverse the tree inorder and yield each node to the provided block. Return an array of values if no block is given |
| #preorder(&block) | Traverse the tree preorder and yield each node to the provided block. Return an array of values if no block is given |
| #postorder(&block) | Traverse the tree postorder and yield each node to the provided block. Return an array of values if no block is given |
| #height(node) | Return node's height. Height is defined as the number of edges in longest path from a given node to a leaf node |
| #depth(node) | Return node's depth. Depth is defined as the number of edges in path from a given node to the tree’s root node |
| #balanced? | Checks if the tree is balanced |
| #rebalance | Rebalances an unbalanced tree |
