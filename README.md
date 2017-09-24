## Tiny Blockchain

A blockchain is a continuously growing list of records, called blocks, which are linked and secured using cryptography.

Each block typically contains a *hash* as a link to a previous block, a *timestamp*, *transaction data*, and its *index* in the blockchain. 

Each block includes the previous timestamp and hash in its hash, forming a chain, with each additional hash reinforcing the ones before it.

A blockchain needs a first block, this block is a special block called **genesis block**. To make things easy, this block is of index 0, and it has an arbitrary data value and an arbitrary value in the “previous hash” parameter.


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



  For use as a distributed ledger a blockchain is typically managed by a peer-to-peer network collectively adhering to a protocol for validating new blocks. Once recorded, the data in any given block cannot be altered retroactively without the alteration of all subsequent blocks, which needs a collusion of the network majority.


## Sources
* [Wikipedia Blockchain](https://en.wikipedia.org/wiki/Blockchain)
* [Bitcoin: A Peer-to-Peer Electronic Cash System](https://bitcoin.org/bitcoin.pdf)
* [Let’s Build the Tiniest Blockchain](https://medium.com/crypto-currently/lets-build-the-tiniest-blockchain-e70965a248b)
