Message-ID: <4A23DD11.7080503@...1114...>
Date: Mon, 01 Jun 2009 15:52:17 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1AC345EACB034D778AC18983907FB492@...1205...>
	<49C9FCE3.2010009@...1114...> <4A219D3A.9080902@...41...>
In-Reply-To: <4A219D3A.9080902@...41...>
Subject: Re: [Openvpn-devel] Get server to listen for TCP and UDP connections
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: "M. G." <mg1984@...1204...>, openvpn-devel@lists.sourceforge.net



James Yonan wrote:
> David Sommerseth wrote:
>> M. G. wrote:
>>> Hello,
>>>  
>>> I recently changed my VPN-tunnel from TCP to UDP for the sake of 
>>> better performance. It generally works very well but I noticed that I 
>>> can't connect to my server from some networks when using UDP, e.g. at 
>>> work. This may be an issue with the NAT/firewall configuration which 
>>> I have no influence on.
>>> Since I am connecting from random locations where I don't know 
>>> beforehand if a UDP connection will succeed, I'm now kind of worried 
>>> that it'll get a game of luck if a connection succeeds from a 
>>> specific location.
>>>  
>>> So far my story, now to the question:
>>> What is the reason that OpenVPN doesn't have an option to listen for 
>>> TCP AND UDP connections simultaneously? Is it a technical problem 
>>> that I cannot see, or am I simply the only one who thinks this would 
>>> be a nice feature?
>>
>> In theory, you are very right, this should not be a big issue.  But I 
>> believe this is connected to that openvpn is neither forked nor 
>> threaded when working with connections.  It's all in the same process 
>> scope, which does its own scheduling regarding the connections, if 
>> I've understood the code right.  And to make the current 
>> implementation work concurrently with both TCP and UDP will be 
>> somewhat more difficult.  And due to this, openvpn do not really use 
>> the power of multi-core hosts as one single process can only be run on 
>> one core at the time.
>>
>> I've been looking at the whole connection handling, and I've been 
>> considering to try to rewrite it and to use proper Posix threading.  
>> The challenge with doing that is that it might not work so well on 
>> non-posix compatible platforms.  And I'm not sure how that would work 
>> for the Windows world.  But by moving over to a proper threading 
>> model, I'd expect both performance and scalability to improve, and 
>> also concurrent TCP and UDP setups to work out more easily.  And with 
>> several threads, openvpn can also make better use of all available CPU 
>> cores on the host.
>>
>>> I know I could run two server instances on different tun devices but 
>>> I think it'd be much nicer (and resource-friendly) if I could just 
>>> put "proto udp tcp-server" (or whatever) into the config file and be 
>>> flexible with my connections to the server.
>>
>> It would sure be nicer to use the same tun device, also from a
>> configuration perspective (less instances to take care of).  But I'm 
>> not sure it is that much more resource-friendly, except less memory 
>> usage perhaps.  The kernel usually won't spend much extra CPU time on 
>> sleeping processes or devices.
>>
>> But on the other side, if your openvpn processes are configured to run 
>> on separate CPU cores, you might have a better performance if you have 
>> multiple clients connecting at the same time, given the status of the 
>> current scheduling implementation.
> 
> I worry about trying to debug multi-threaded code -- it could fail in 
> non-deterministic ways.  How can we maintain product quality when the 
> code could have subtle race conditions that only show up in heavy 
> production usage and leave no useful info to enable its reproduction? 
> Personally, multithreading scares me, as does any design pattern that 
> has the potential to introduce non-deterministic bugs.

I can understand that threading can complicate debugging somewhat, but with 
well thought locks this is doable.  It is also plenty of code which do this 
without any issues.

> I would also argue that multithreading is not a performance panacea, 
> because of the necessity of using locking primitives such as mutexes, 
> etc. that lock the global bus, and the often overlooked costs of 
> maintaining cache coherency among multiple processors and cores, when 
> multiple threads are writing to the same data structures.

But the current implementation do have reported issues with more than 150 
clients to one OpenVPN process.  This is an incredibly low number on todays 
hardware.  The current implementation also do not make use of multi-cores, 
which is a big limitation for bigger enterprises.

In Linux there is also done considerable work on FUTEX, as an enhanced 
MUTEX - to overcome the performance loss in mutexes can introduce.

http://en.wikipedia.org/wiki/Futex
http://linux.die.net/man/2/futex

> I believe a better alternative to multithreading, in OpenVPN's case, is 
> to use multiple processes where each process has it's own asynchronous 
> event reactor (e.g. Python/Twisted, libevent, Boost::Asio), and the 
> processes communicate via messaging, such as over a local unix domain 
> socket or Windows named pipe.  This also has a performance advantage, 
> because separate processes aren't going to be fighting over the same 
> memory.

Please ... don't go the Boost path ... that will probably be more a pain. 
Granted, it do have quite some advantages during development, but the pains 
you will hit will not always be as light as you might believe.  (I've been 
looking the Apache Qpid code, and Boost really gives some challenges to 
this project).

Regarding threading vs forking, there is one thing you overlook: The 
performance loss when the kernel needs to swap between processes vs 
threads.  The kernel spends considerably less time on task swapping between 
threands.

I wrote two test programs a long time ago to see the performance difference 
between fork and pthread, and it was quite noticeable.  These test programs 
  uses Posix MQ for communication between two processes which is either 
forked out (separate processes) or threaded.  It sends 10 million messages 
and do not use any form of locking during message transfers.  This test was 
written to do a simple measurement of performance difference between fork 
vs pthread.

For the forked version, load on a dual core Intel Xeon 1.6GHz peaked at 
1.4, average approx. around 1.15 during the run and the time statistics 
looks like this:

real    0m55.007s
user    0m16.547s
sys     1m26.520s

For the pthread version on the same box, the system load reached peaked at 
0.8 and had an approx. average of 0.7.  The time statistics of the run is:

real    0m18.653s
user    0m6.952s
sys     0m28.278s

I have the test programs available if you are interested.  This test was 
run on a older Fedora 8 box running a 2.6.24.7 Real-Time kernel.  The only 
system tweaking I did was to increase /proc/sys/fs/mqueue/msg_max to 1000 
from 10, to avoid the queue to fill up while sending.  Both programs was 
run using non-realtime schedule priority (SCHED_OTHER).

I also noticed that the pthread version peaked on the Queue size (number of 
messages on the queue) at 27, while the fork version peaked at 10.

IMHO, threading is the only way to go if you want performance in any 
product.  Granted that you have to have clever locking mechanism, but that 
is anyway a more sensible model than to implement an internal scheduler as 
OpenVPN seems to have now for handling all connections.  In addition, the 
kernel do swapping between threads way faster than between separate 
processes, which again disfavours separate processes.

And again for performance IPC needs to be memory based.  Writing to sockets 
still introduce more latency and makes the kernel work even more on the 
communication between the processes.  Another thing to keep in mind is that 
you should, in OpenVPN perspective, try to avoid moving data between kernel 
space and user space as much as possible, which very often happens when 
using system calls like read() and write().


kind regards,

David Sommerseth


