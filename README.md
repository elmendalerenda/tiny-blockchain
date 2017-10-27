# Tiny Blockchain

In general terms, a Blockchain is a way to structure data, and the foundation of cryptocurrencies like Bitcoin. It consists of concatenated blocks of transactions and given its decentralized nature, allows to share a digital ledger across a network of computers without need for a central authority.

In this exercise, we will make a very simple version of a blockchain to store a currency. Let's call it ChiquiCoin.

## Part 1: The simplest blockchain

### Blocks

A blockchain is a continuously **growing list of records, called blocks**, which are linked and secured using cryptography.

Each block contains a **hash** as a link to a previous block, a **timestamp**, the **transaction data**, and its **index** in the blockchain. 

```ruby
irb(main):001:0> Block.new(0, 'Transaction details', "prev. hash")
=> Block: 0. Hash: d83b6c9428a509fd142efd7314b91998b83a183b95f7991a7bc741f1027fc083. Data: Transaction details. Previous Hash: prev. hash
```

### The Chain

Any blockchain needs a first block, this block is a special block called **genesis block**. To make things easy, this block is of index 0, and it has an arbitrary data value and an arbitrary value in the “previous hash” parameter.

The hash of each block includes the **previous timestamp and previous hash**, forming a chain, with each additional hash reinforcing the ones before it all the way back to the original genesis block

```ruby
irb(main):001:0> chain = Chain.init
=> #<Chain:0x007fc669d48208>
irb(main):002:0> (0..9).each { |e| chain.add_block("Block #{e}") }
=> 0..9
irb(main):003:0> puts chain.to_s
Block 0. Hash a50c8291a441ec9d95a460394e4d50dd1ff76bf60191dd07a89195e657335750
Block 1. Hash 74910f102134b76ee3ad72f0e584eb2c35dc3c36a5617f81017da6b5b12dbe9c
Block 2. Hash 161acbd73bb4065f947c5599d6c42b0c6892f60418667499cadec5216755bed1
Block 3. Hash f9209dbc40d412e3939c2ae37724d7fa1fd5ef3b77586943fe31b2c0e04170b4
Block 4. Hash e29a51c99b3b9d454a9a31d070a471713fc43165354ceecb4c17eaecea20ca89
Block 5. Hash 8cdd063792179faeb8759f9bfdfb2bc6a7a20929c27809a7b3a7b9add30e3180
Block 6. Hash de0f212298d6b73b71c8fc7d112ad7c4ee9136e993239827b0f6fb4c30210110
Block 7. Hash bc5129b1d57a578d41ec55414ee9ac37fcebba5bc96260dc52f98a8979e93bdc
Block 8. Hash 0984094b9b6c5eca4bb20e27b5b747714c66968734087676d09bbe9e4f5e8a95
Block 9. Hash ae8b93ae9d4934ddd82e949fe7277a936a3e787d61ae46eff8cce191efb4b54e
Block 10. Hash ad650fd74b9d1c73587ff63f5b1e844936b9aacfc066aac9dd4c6cd614bddc2b
=> nil
```

## Part 2: Making the blockchain distributed

So far we have a extremely simple blockchain, it lacks one of the features that makes blockchain so powerful: decentralization. That means making the blockchain replicated, shared, and synchronized. 

For use as a [distributed ledger](https://en.wikipedia.org/wiki/Distributed_ledger) a blockchain is typically managed by a peer-to-peer network collectively adhering to a protocol for validating new blocks. Once recorded, the data in any given block cannot be altered retroactively without the alteration of all subsequent blocks, which needs a collusion of the network majority.

### A transaction

Although we can store any kind of data in a block, let's use the blockchain to run a cryptocurrency. From now on, the data will contain three fields: a sender, a receiver and an amount.
```json
{
  "from": "sender-public-key",
  "to": "receiver-public-key",
  "amount": 3
}
```

### Nodes

Now that we have defined a transaction, we need a way to add them to the network. We call *node* or *miner* to each peer in the network. Every node in a decentralized system has a copy of the blockchain, data quality is maintained by massive replication.

### Coin supply

How assets are generated?

In order to be accepted by the rest of the network, a new block must contain a so-called proof-of-work. The proof-of-work requires miners to find a number called a nonce. This proof is easy for any node in the network to verify, but time-consuming to generate. The successful miner finding the new block is rewarded with newly created bitcoins and transaction fees. To claim the reward, a special transaction called a coinbase is included with the processed payments.

we’ll create a somewhat simple Proof-of-Work algorithm. To create a new block, a miner’s computer will have to increment a number. When that number is divisible by 9  and the proof number of the last block, a new  block will be mined and the miner will be given a brand new coin.

A node will be able to accept transactions and add them to the blockchain after *mining* a new block. Mining is a record-keeping service done through the use of computer processing power.

Mining nodes validate transactions, add them to the block they are building, and then broadcast the completed block to other nodes.

### Decentralization

Blockchains are secure by design and are an example of a distributed computing system with high fault tolerance. 

To achieve this, we make each node broadcast its version of the chain to the others and allow them to receive the chains of other nodes. After that, each node has to verify the other nodes’ chains so that the every node in the network can come to a consensus of what the resulting blockchain will look like.

Our consensus algorithm will be rather simple: if a node’s chain is different from another’s, then the longest chain in the network stays and all shorter chains will be deleted. If there is no conflict between the chains in our network, then we carry on.


## Sources
* [Wikipedia Blockchain](https://en.wikipedia.org/wiki/Blockchain)
* [Wikipedia Bitcoin](https://en.wikipedia.org/wiki/Bitcoin)
* [Bitcoin: A Peer-to-Peer Electronic Cash System](https://bitcoin.org/bitcoin.pdf)
* [Let’s Build the Tiniest Blockchain](https://medium.com/crypto-currently/lets-build-the-tiniest-blockchain-e70965a248b)
