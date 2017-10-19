require 'minitest/autorun'
require_relative './blockchain'

class ChainTest < Minitest::Test
  def test_initialize_chain
    chain = Chain.init

    assert chain.block_count == 1
    assert chain.last_block.index == 0
    assert chain.last_block.data == 'Genesis Block'
    assert chain.last_block.prev_hash == '0'
  end

  def test_def_block
    index = 0
    data = ''
    prev_hash = 'ABC'

    b = Block.new(index, data, prev_hash)

    assert b.hash != nil
  end

  def test_add_block
    chain = Chain.init
    genesis = chain.last_block
    chain.add_block("Second Block")

    assert_equal 2, chain.block_count
    assert_equal 1, chain.last_block.index
    assert_equal 'Second Block', chain.last_block.data
    assert_equal genesis.hash, chain.last_block.prev_hash
  end

  def test_block_hash_digest_contains_prev_hash
    b = Block.new(0, "{}", "000")
    b.timestamp = "anytime"

    expected = Digest::SHA256.hexdigest("0anytime{}000")

    assert_equal expected, b.hash
  end

  def test_a_node_add_blocks_via_mining
    node = Node.new(MockPOWGenerator.new)

    tx = { from: 'a sender',
           to: 'a receiver',
           amount: 666 }

    node.submit_transaction(tx)
    node.mine

    chain = node.chain

    assert_equal 2, chain.block_count
    assert_equal( tx , chain.last_block.data[:transactions].first)
  end

  def test_mining_creates_1_asset
    node = Node.new(MockPOWGenerator.new)

    tx = { from: 'a sender',
           to: 'a receiver',
           amount: 666 }

    node.submit_transaction(tx)
    node.mine

    chain = node.chain

    mining_result = { from: 'network',
      to: 'this node',
      amount: 1 }

    assert_equal( { proof_of_work: 'pow',
                    transactions: [tx, mining_result]
                   } , chain.last_block.data)
  end

  def test_mining_requires_proof_of_work
    node = Node.new(MockPOWGenerator.new)

    tx = { from: 'a sender',
      to: 'a receiver',
      amount: 666 }

    node.submit_transaction(tx)
    node.mine

    chain = node.chain

    assert_equal( 'pow'  , chain.last_block.data[:proof_of_work])
  end

  def test_POW
    first_proof = POWGenerator.new.pow(0)

    assert_equal(9, first_proof)

    second_proof = POWGenerator.new.pow(first_proof)

    assert_equal(18, second_proof)
  end

  def test_node_merge_chains
    node = Node.new(MockPOWGenerator.new)
    another_chain = Chain.init
    another_chain.add_block("Another Block")

    assert_equal(1, node.chain.block_count)

    node.merge_chain(another_chain)

    assert_equal(2, node.chain.block_count)
  end

  def test_broadcast_after_mining
    node_miner = Node.new(MockPOWGenerator.new)
    node_receiver = Node.new(MockPOWGenerator.new)
    node_miner.add_peer(node_receiver)
    node_miner.consensus_method = MockConsensus.new

    tx = { from: 'a sender',
      to: 'a receiver',
      amount: 666 }

    node_miner.submit_transaction(tx)
    node_miner.mine

    assert_equal(2, node_receiver.chain.block_count)
    assert_equal(tx , node_receiver.chain.last_block.data[:transactions].first)
  end

  class MockPOWGenerator
    def pow
      'pow'
    end
  end

  class MockConsensus
    def select(a_chain, another_chain)
      another_chain
    end
  end
end
