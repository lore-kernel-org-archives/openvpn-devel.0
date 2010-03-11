Message-ID: <4B991408.8030207@...1147...>
Date: Thu, 11 Mar 2010 17:02:16 +0100
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
References: <4B950E0B.1030908@...41...> <4B964BEC.3040504@...1114...>
In-Reply-To: <4B964BEC.3040504@...1114...>
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
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, James Yonan <jim@...41...>

Hi all,

just ran a very silly test, all with openvpn 2.1.1, on my laptop running 
FC12 (2.6.31.12-174.2.22.fc12.x86_64) ,  Intel(R) Core(TM)2 Duo CPU 
T9300 @ 2.50GHz, connected to a 100 Mbps LAN

server side:  
  openvpn --ifconfig 10.222.0.1 10.222.0.2 --dev tun --secret secret.key 
--cipher none
client side:
  time ./openvpn --ifconfig 10.222.0.2 10.222.0.1 --dev tun --secret 
secret.key --remote kudde.nikhef.nl --cipher none

and then use 'nc' to pipe a 100 MB file from server to client :

nc'ing it once:
user    0m2.150s
sys     0m3.972s

nc'ing it twice:
user    0m4.128s
sys     0m8.012s

Now with some encryption:

server side:  
  openvpn --ifconfig 10.222.0.1 10.222.0.2 --dev tun --secret secret.key
client side:
  time ./openvpn --ifconfig 10.222.0.2 10.222.0.1 --dev tun --secret 
secret.key --remote kudde.nikhef.nl

nc'ing it once:
user    0m5.010s
sys     0m4.385s

nc'ing it twice:
user    0m9.922s
sys     0m8.536s

Transfer speeds are about 10 Mb/s in all cases, i.e. the LAN is maxed out.

So yes , quite some time is spent in 'sys' but I don't think it is too 
much ... my guess is that with older CPUs the amount of time spent in 
the kernel vs the time spent in user space was different, i.e. older 
CPUs had more trouble with the encryption/decryption, hence you'd see a 
larger difference between user vs sys.


cheers,

JJK / Jan Just Keijser



David Sommerseth wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 08/03/10 15:47, James Yonan wrote:
>   
>> I believe this has been discussed before, but I noticed recently that a 
>> Linux-based OpenVPN client (Linux 2.6.24, OpenVPN 2.1.1) spends a lot 
>> more CPU time in kernel space than in user space.  This is surprising, 
>> given the fact that all of the CPU-intensive cryptographic operations 
>> are being done in user space.
>>
>> Using the 'time' utility on the OpenVPN client, while a wget of a 50MB 
>> file was done over the VPN, I found that 80% of the CPU time was taken 
>> by the kernel, and 20% by user space (I should add that the Linux client 
>> was running as a VM on VMWare Fusion).
>>
>> I'm wondering if anyone with kernel background has any insights on this. 
>>   Are there performance bottlenecks in the tun/tap driver?
>>     
>
> I'm not a hardcore kernel developer, but I'm interested in the to
>
> James, would you mind trying to run a test on the 2.6.33 kernel?  That's
> the newest stable kernel available, just to see if your observations are
> visible there as well, and if they are better or worse.
>
> And when you say earlier kernels did not use so much time in kernel
> space, which kernels did you compare against?  It would be interesting
> to look through the changelog from the "good" kernel version to 2.6.24,
> to see what was changed in tun.c.
>
> In this case, it would be easier to try to nail down where such a
> behavioural change happened.  And after all, 2.6.24 was released about 2
> years ago (Jan 24 14:58:37 2008) ... and the drivers/net/tun.c has been
> changed 72 times, as far as I can see.  It's a big job going on getting
> rid of the BKL (big kernel lock, blocking all apps while kernel is doing
> something) ... so it's difficult to say now just what could have been
> the reason for what you observe.
>
> James, if you have a "test script" with configuration files, I can setup
> a test environment and run some tests and also enable ftrace [1], which
> could also pin-point more where the kernel spends its time doing things.
>
>   


