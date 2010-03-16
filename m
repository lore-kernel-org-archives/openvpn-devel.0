Message-ID: <4B9F9EA0.6060308@...1147...>
Date: Tue, 16 Mar 2010 16:07:12 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <4B950E0B.1030908@...41...> <4B964BEC.3040504@...1114...>
	<4B991408.8030207@...1147...> <4B9E5240.1080008@...1147...>
	<4B9E5EEF.6030800@...1114...>
In-Reply-To: <4B9E5EEF.6030800@...1114...>
Subject: Re: [Openvpn-devel] Linux tun/tap performance issues
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
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi David,

David Sommerseth wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 15/03/10 16:29, Jan Just Keijser wrote:
>   
>> More tests, this time with 'oprofile' : here's a recap:
>> - nothing changed on the server side:
>> openvpn --ifconfig 10.222.0.1 10.222.0.2 --dev tun --secret secret.key
>> --cipher none
>>
>> - upgraded to kernel 2.6.32.9-70.fc12.x86_64 on my laptop
>> - selinux is disabled
>> - installed the debuginfo rpms to get a 'vmlinux'
>> - configure the oprofile deamon using
>> opcontrol
>> --vmlinux=/usr/lib/debug/lib/modules/2.6.32.9-70.fc12.x86_64/vmlinux
>> - now start it, reset the statistics, start openvpn
>>  opcontrol --start
>>  opcontrol --reset
>>  ./openvpn --ifconfig 10.222.0.2 10.222.0.1 --dev tun --secret
>> secret.key --remote kudde.nikhef.nl --cipher none
>> - download a file using 'nc' (this maxes out my 100 Mbps LAN at roughly
>> 11 MB/s)
>> - get the statistics
>>  opcontrol --dump
>>  opreport -l > stats
>>     
>
> Thanks a lot!  This is way cool!  It just strikes me that you probably
> should play with ftrace instead of oprofile.  It's better and got a
> lower overhead than oprofile, afaik.
>
> <http://lwn.net/Articles/322666/>
>
> (btw. with an ftrace enabled kernel, it's even available on embedded
> devices. You only need 'mount', 'echo' and 'cat' to interact with ftrace
> ... even though Steven Rostedt is working on a GUI for ftrace, called
> kernelshark)
>
> With such new kernel, there's also the perf tool.
>
> <http://perf.wiki.kernel.org/index.php/Main_Page>
>
> In both of these tools you have something called callgraph, iirc.  And
> with that you see which function is calling which function and the
> amount of time each step used.
>
> I'll ask some people who's been involved in both ftrace and perf for
> some better pointers!
>   
your wish is my command ;-) :

actually, 'perf' is a lot easier to use then opcontrol/opreport.  I ran

  perf record -g -f -- ./openvpn ..................
  perf report --call-graph > perf.data-20100316

At
  http://www.nikhef.nl/~janjust/openvpn/perf.callgraph-20100316.gz
you will find the callgraph for a 512 MB file copy ; the rest is 
identical to the previous tests.

share and enjoy,

JJK / Jan Just Keijser


