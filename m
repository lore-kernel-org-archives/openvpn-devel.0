Message-ID: <4A219D3A.9080902@...41...>
Date: Sat, 30 May 2009 14:55:22 -0600
From: James Yonan <jim@...41...>
MIME-Version: 1.0
References: <1AC345EACB034D778AC18983907FB492@...1205...>
	<49C9FCE3.2010009@...1114...>
In-Reply-To: <49C9FCE3.2010009@...1114...>
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
To: David Sommerseth <openvpn.list@...1114...>
Cc: "M. G." <mg1984@...1204...>, openvpn-devel@lists.sourceforge.net

David Sommerseth wrote:
> M. G. wrote:
>> Hello,
>>  
>> I recently changed my VPN-tunnel from TCP to UDP for the sake of better 
>> performance. It generally works very well but I noticed that I can't 
>> connect to my server from some networks when using UDP, e.g. at work. 
>> This may be an issue with the NAT/firewall configuration which I have no 
>> influence on.
>> Since I am connecting from random locations where I don't know 
>> beforehand if a UDP connection will succeed, I'm now kind of worried 
>> that it'll get a game of luck if a connection succeeds from a specific 
>> location.
>>  
>> So far my story, now to the question:
>> What is the reason that OpenVPN doesn't have an option to listen for TCP 
>> AND UDP connections simultaneously? Is it a technical problem that I 
>> cannot see, or am I simply the only one who thinks this would be a nice 
>> feature?
> 
> In theory, you are very right, this should not be a big issue.  But I 
> believe this is connected to that openvpn is neither forked nor threaded 
> when working with connections.  It's all in the same process scope, which 
> does its own scheduling regarding the connections, if I've understood the 
> code right.  And to make the current implementation work concurrently with 
> both TCP and UDP will be somewhat more difficult.  And due to this, openvpn 
> do not really use the power of multi-core hosts as one single process can 
> only be run on one core at the time.
> 
> I've been looking at the whole connection handling, and I've been 
> considering to try to rewrite it and to use proper Posix threading.  The 
> challenge with doing that is that it might not work so well on non-posix 
> compatible platforms.  And I'm not sure how that would work for the Windows 
> world.  But by moving over to a proper threading model, I'd expect both 
> performance and scalability to improve, and also concurrent TCP and UDP 
> setups to work out more easily.  And with several threads, openvpn can also 
> make better use of all available CPU cores on the host.
> 
>> I know I could run two server instances on different tun devices but I 
>> think it'd be much nicer (and resource-friendly) if I could just put 
>> "proto udp tcp-server" (or whatever) into the config file and be 
>> flexible with my connections to the server.
> 
> It would sure be nicer to use the same tun device, also from a
> configuration perspective (less instances to take care of).  But I'm not 
> sure it is that much more resource-friendly, except less memory usage 
> perhaps.  The kernel usually won't spend much extra CPU time on sleeping 
> processes or devices.
> 
> But on the other side, if your openvpn processes are configured to run on 
> separate CPU cores, you might have a better performance if you have 
> multiple clients connecting at the same time, given the status of the 
> current scheduling implementation.

I worry about trying to debug multi-threaded code -- it could fail in 
non-deterministic ways.  How can we maintain product quality when the 
code could have subtle race conditions that only show up in heavy 
production usage and leave no useful info to enable its reproduction? 
Personally, multithreading scares me, as does any design pattern that 
has the potential to introduce non-deterministic bugs.

I would also argue that multithreading is not a performance panacea, 
because of the necessity of using locking primitives such as mutexes, 
etc. that lock the global bus, and the often overlooked costs of 
maintaining cache coherency among multiple processors and cores, when 
multiple threads are writing to the same data structures.

I believe a better alternative to multithreading, in OpenVPN's case, is 
to use multiple processes where each process has it's own asynchronous 
event reactor (e.g. Python/Twisted, libevent, Boost::Asio), and the 
processes communicate via messaging, such as over a local unix domain 
socket or Windows named pipe.  This also has a performance advantage, 
because separate processes aren't going to be fighting over the same memory.

James

