A blockchain is a continuously growing list of records, called blocks, which are linked and secured using cryptography.[1][6] (Wikipedia)


Each block typically contains a hash as a link to a previous block, a timestamp and transaction data. (WIKIpedia)

Each block includes the previous timestamp and hash in its hash, forming a chain, with each additional hash reinforcing the ones before it. (bitcoin WP)


A blockchain needs a first block, this block is called 'genesis block'. We’ll create a function that simply returns a genesis block to make things easy. This block is of index 0, and it has an arbitrary data value and an arbitrary value in the “previous hash” parameter.


So far we have the basic logic of a blockchain:

  for i in range(0, num_of_blocks_to_add):
  block_to_add = next_block(previous_block)
  blockchain.append(block_to_add)
  previous_block = block_to_add
# Tell everyone about it!
  print "Block #{} has been added to the blockchain!".format(block_to_add.index)
  print "Hash: {}\n".format(block_to_add.hash)




  For use as a distributed ledger a blockchain is typically managed by a peer-to-peer network collectively adhering to a protocol for validating new blocks. Once recorded, the data in any given block cannot be altered retroactively without the alteration of all subsequent blocks, which needs a collusion of the network majority.

  sources
  wikipedia
  bitcoin white paper
  articulo
