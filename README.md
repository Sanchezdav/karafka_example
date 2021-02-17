# Karafka Example

## Requirements

First, you need to install Java because Kafka depends of it and then install Kafka:

```
brew install java
brew install kafka
```

## Development

Before of all we need to have runnig Kafka, to do that first start with Zookeeper with this command `brew services start zookeeper` and finally Kafka with `brew services start kafka`, at this point we have running Kafka in local.

In our Rails app console we need to run the Karafka server with this `bundle exec karafka server`.

Here we can do some tests:

```
> rails c

UsersResponder.call({ event_name: "user_created", payload: { id: 1 } })

# Output

[2021-02-16T22:47:53.200369 #12763]  INFO -- : Sending 1 messages to 192.168.1.77:9092 (node_id=0)
D, [2021-02-16T22:47:53.200846 #12763] DEBUG -- : [produce] Opening connection to 192.168.1.77:9092 with client id delivery_boy...
D, [2021-02-16T22:47:53.201818 #12763] DEBUG -- : [produce] Sending produce API request 1 to 192.168.1.77:9092
D, [2021-02-16T22:47:53.443563 #12763] DEBUG -- : [produce] Waiting for response 1 from 192.168.1.77:9092
D, [2021-02-16T22:47:53.456032 #12763] DEBUG -- : [produce] Received response 1 from 192.168.1.77:9092
D, [2021-02-16T22:47:53.456735 #12763] DEBUG -- : Successfully appended 1 messages to users/0 on 192.168.1.77:9092 (node_id=0)
=> {"users"=>[["{\"event_name\":\"user_created\",\"payload\":{\"id\":1}}", {:topic=>"users"}]]}

> bundle exec karafka server

# Output

New [User] event: #<Karafka::Params::Params:0x00007fe1044d99b8>
Inline processing of topic users with 1 messages took 0 ms
1 message on users topic delegated to UsersConsumer
[[karafka_example_example] {}:] Marking users/0:0 as processed
[[karafka_example_example] {}:] Committing offsets with recommit: users/0:1
[[karafka_example_example] {}:] [offset_commit] Sending offset_commit API request 13 to 192.168.1.77:9092
```
