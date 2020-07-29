# 数据库基础入门

这篇文章带领一个计算机小白从零开始了解数据库，跟随着文章每一小节的视频和笔记往下浏览，相信看完之后你会对数据库有一个基本的认识。

## 数据库基础知识（学习笔记）

### [What is Database & SQL? ](https://www.youtube.com/watch?v=FR4QIeZaPeM#action=share)

  - DBMS (database management system): a collection of programs which enables its users to access database, manipulate data, help in representation of data.
    - hierarchical (trees with nodes of records and branches): Windows registry
    - network DBMS: RDM server
    - **most widely used** relational DBMS (in forms of tables; not many to many relations): MySQL, Oracle, Microsoft SQL server
    - object-oriented relation DBMS (in the form of objects with attributes):  PostgreSQL

  - SQL:  structured query language used to query a database

### [What is a distributed database? ](https://www.youtube.com/watch?v=ZGYW9TGrn_M)

  - centralized database:  data resides in one single location
  - distributed database: data resides in several locations
    - replication
    - fragmentation

### [RDBMS ](https://www.youtube.com/watch?v=t48TGntrX4s)

  store modify extract

  store data in forms of tables

  field (maintain information) & records (row entry)

  SQL statements: select, insert, drop, delete

  - advantages:
    - convenience: be accessed by many people
    - clear & concise
    - carry out different complicated commands
  - disadvantages
    - complicated to implement
    - hard process 
    - slow over response time

### [What is NoSQL? ](https://www.youtube.com/watch?v=qUV2j3XBRHc&feature=youtu.be) 

NoSQL = not only SQL

  - upcoming DBMS; scale out better

  - non_adherence to RDB concepts

  - distribute DB load on multiple host - scale out

  - no SQL no ACID

### [CAP ](https://www.youtube.com/watch?v=k1dtA14EYrk) 

  - consistency

  - availability

  - partition tolerance

    CA: SQL Server\ MySQL \ Oracle \ PostgreSQL

    AP: Cassandra\ CouchDB \ DynamoDB

    CP: MongoDB\ Hbase \ Memcache \ Redis

### [Raft ](https://www.youtube.com/watch?v=P9Ydif5_qvE) 

  - Solve Byzantine failures

  - Terms

    - Leader: accept data from the client; sends data to follower
    - Follower
    - Client
    - Log

  - Vote message

  - Add entries message

  - consensus algorithm: a process  used to achieve agreement on a single data value among distributed processes or systems.

  - election and log propagation:

  - 2-Phase & 3-Phase

  - leader completeness

  - split vote

  - network partition

  - log compaction

  - membership changes

#### 解决分布式共识问题

- **对多个节点提出的议案作裁决并得到一个一致的结论；**
- **让每个节点都感知到最终结论，从而使集群整体状态保持一致**；
- **允许一部分节点宕机后集群仍可正常工作，先前通过的议案仍可访问，集群状态仍维持一致**；

#### Raft 算法子问题

- **Leader election**：描述如何从集群的几个节点中选举出 Leader；

- **Log Replication**：描述如何将日志同步到各个节点从而达成一致；
- **Safety**：定义了一组约束条件来保证 Raft 算法的强一致性；
- **Membership changes**：描述如何变更集群关系（增加或者减少节点）；

#### strong leader 的模型

![img](https://picb.zhimg.com/80/v2-78a9f64619825a0156a6dad03ec7c627_1440w.jpg)

#### 心跳 RPC

leader 会每个心跳间隔至少一次向所有对等方发送一个 AppendEntries RPC，以防止他们开始新的选举。 如果领导者没有新条目要发送到特定对等方，则 AppendEntries RPC 不包含任何条目，并被视为心跳。

#### 几分钟演示 Raft 原理，点击查看： [Raft 原理演示](http://thesecretlivesofdata.com/raft/) 


### [ACID, Isolation Level, MVCC ](http://www.cnblogs.com/lidabnu/p/4495785.html) 

  （1）脏读：指事务读到脏数据，所谓脏数据，指的是不正确的数据，例如事务执行过程中修改了某记录，然后回滚，如果其他事务读到了该记录的中间修改值，则为脏读。

  （2）不可重复读：事务在执行过程中，多次对同一个已经存在的记录进行读取，各次读取的值不同。读提交隔离级别存在不可重复读的问题，事务1、2并发执行，事务2首先读取记录1，然后事务1修改记录1并提交，事务2继续读取记录1，则事务2两次读取到的值不同。

  （3）幻读：幻读是指使用某个条件读取一批记录时，可能读到的记录数不同。幻读与脏读、不可重复读的区别在于，脏读、不可重复读都是针对某个确定的已经存在的记录出现的值不要求（读到脏数据或多次读的值不同），而幻读则是多次使用同一个条件查询一批记录，多次读到的记录数不同，也就是说，脏读、不可重复读是由于多个事务并行执行update引起的，而幻读则是由于多个事务并行执行insert引起的（并发delete引起的问题看起来算哪个都行……）。

  - **原子性**：一个事务是一个不可分割的最小工作单元，其操作要么全部成功，要么全部失败；

  - **一致性**：数据库总是从一个一致性状态转换为另一个一致性状态。所谓一致性状态，就是数据库的所有完整性约束（尤其注意用户定义约束）都被遵守，以银行转账为例，“转账操作必然导致一个账户减少金额，另一个账户增加金额，且这两个账户总金额之和不变”就是一个完整性约束。

  - **持久性：**一旦事务提交，则其所作的修改就会永久保存到数据库中

  - **隔离性**：隔离性用于定义事务之间的相互隔离程度，存在四个隔离级别。

    - Read Uncommited：读未提交，其含义为多个并发事务，任何一个事务可以读到其他事务尚未提交的修改：存在脏读、不可重复读、幻读可能性。

    - Read Commited：读已提交，含义为多个并发事务，任何一个事务只可以读到其他事务已经提交的修改：解决脏读，存在不可重复读、幻读可能性。

    - Repeatable Read：可重复读，含义为多个事务并发执行时，任何一个事务反复读取已存在的记录，每次读到的值都是相同的解决脏读、不可重复读，存在幻读可能性。

    - Serializable：串行化，含义为所有事务串行执行，因此不存在事务并发执行的情况。解决脏读、不可重复读、幻读。

### 多版本并发控制MVCC

   相当于在读事务开始的时刻点，建立了一个系统的快照，该事务读取的所有数据，均是从快照中读取的，因此满足可重复读的条件，**并且可解决幻读的问题，并且也不会读到产生“同样查询条件，事务中第一次读到的记录数大于第二次读到的记录数的问题“（由并发删除引起）**

   从上可知，使用MVCC后，大部分读都不再需要加读锁，因此读不再阻塞写，写也不再阻塞读。读操作只再受限于系统IO能力。

> MVCC provides concurrent access to the database without locking the data. This feature improves the performance of database applications in a multiuser environment. Applications will no longer hang because a read cannot acquire a lock.

> MVCC provides each user connected to the database with a "snapshot" of the data to work with. The data is consistent with a point in time. Other users of the database see no changes until the transaction is committed. The snapshot can be taken at the start of a transaction, or at the start of each statement, as determined by the isolation level setting.

## 其他术语解释

- 分布式数据库

  数据库中的数据不存储在同一计算机的存储设备上。

  特点：独立透明、集中节点结合、复制透明性、易于扩展性、

- Plan 执行计划

  执行计划（execution plan，也叫查询计划或者解释计划）是数据库执行 SQL 语句的具体步骤

- mysql-server

  表示服务器，服务端；核心程序，生成管理数据库实例，数据库实例任务调度线程之类，并提供相关接口供不同客户端调用。用于持久保存数据并为其提供查询接口（SQL）；可以托管多个数据库并处理这些数据库上的查询。

- InnoDB

  是MySQL的数据库引擎之一，现为MySQL的默认存储引擎,支持了[ACID](https://baike.baidu.com/item/ACID/10738)兼容的[事务](https://baike.baidu.com/item/事务/5945882)（Transaction）功能。

- subquery sql

  一個查詢內的查詢，我們可以用來連接資料表，或在不能使用單一語句來完成的查詢時我們就需要用到子查詢。