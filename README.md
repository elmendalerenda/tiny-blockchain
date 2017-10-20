# Tiny Blockchain

## Part 1: The simplest blockchain

A blockchain is a continuously **growing list of records, called blocks**, which are linked and secured using cryptography.

### Blocks

Each block typically contains a **hash** as a link to a previous block, a **timestamp**, **transaction data**, and its **index** in the blockchain. 

### The Chain

Any blockchain needs a first block, this block is a special block called **genesis block**. To make things easy, this block is of index 0, and it has an arbitrary data value and an arbitrary value in the “previous hash” parameter.

The hash of each block includes the **previous timestamp and previous hash**, forming a chain, with each additional hash reinforcing the ones before it all the way back to the original genesis block

So far we have the basic logic of a blockchain:

```ruby
chain = Chain.init
(0..20).each { |e|
  chain.add_block("Block #{e}")
  puts chain.last_block
}
```

```bash
Block 1. Hash 837fe0e4d0c4af5364fdf1668bfe8e94fcb427f9e8214b5aed3ae26c811881c0
Block 2. Hash 02ca5aa87c124e1d38bceeedcb7e93f632fb3e90bdcbe7fd74c96f5ce2c84b1c
Block 3. Hash a7a8fee50d471ccdc2ca300b4383125fc7b13fe9db3338f9cd7492fa294bbf53
Block 4. Hash 833ed0f284fc7e2ee3a15039568d97df1fbe8ef7c52c149c5876d816f49e1c2c
Block 5. Hash 414cee0937587dfe4738be0078cd3b0d078d50aceb8b04d99fac91268093002b
Block 6. Hash 38cc09ac7e95eb7b57b274c58b9b4922cf91e3b83129907d4973c87829d79736
Block 7. Hash c130a96eef6ecd3a41ff72320f317557de27f0670650c4814c0e161c48c81c0d
Block 8. Hash af1e62fabc56a53ce8e1c39e07e99505605e91e06b9e72cd668752aa509ee47a
Block 9. Hash fe19b80b1fb9e89ec23b910be228a19b9444620021acfb124bb5425558daa2cd
Block 10. Hash d40045e79579d54b90f3ecba02c885f8a5a9701485af1958ca56d13d9435ce0d
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

Blockchains are secure by design and are an example of a distributed computing system with high Byzantine fault tolerance. Decentralized consensus has therefore been achieved with a blockchain.


## Sources
* [Wikipedia Blockchain](https://en.wikipedia.org/wiki/Blockchain)
* [Wikipedia Bitcoin](https://en.wikipedia.org/wiki/Bitcoin)
* [Bitcoin: A Peer-to-Peer Electronic Cash System](https://bitcoin.org/bitcoin.pdf)
* [Let’s Build the Tiniest Blockchain](https://medium.com/crypto-currently/lets-build-the-tiniest-blockchain-e70965a248b)
