Message-ID: <4C3862BF.40401@...1388...>
Date: Sun, 11 Jul 2010 00:08:31 +1200
From: Michal Ludvig <mludvig@...1388...>
MIME-Version: 1.0
References: <4C3843A5.50700@...1388...> <20100710102921.GZ361@...1296...>
In-Reply-To: <20100710102921.GZ361@...1296...>
Subject: Re: [Openvpn-devel] feat_ipv6_payload problems on Solaris 10
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: openvpn-devel@lists.sourceforge.net

  On 07/10/2010 10:29 PM, Gert Doering wrote:
> Hi,
>
> On Sat, Jul 10, 2010 at 09:55:49PM +1200, Michal Ludvig wrote:
>> I'm having a problem with feat_ipv6_payload branch (checked out from git
>> yesterday). One end is Solaris 10 (sparc) and the other end is Linux.
> Which version of the tun driver are you using for Solaris?
>
> My test solaris machine (Solaris 10 on Sparc64, but not the very latest
> version) uses the driver from http://www.whiteboard.ne.jp/~admin2/tuntap/
> and IPv6 works fine there.  The web page says that this driver did not
> support IPv6 before 11/16/2009 - so maybe this is the problem.
That was it! Works now:

[Linux] ~ # ping6 -n 2001:cafe::1
PING 2001:cafe::1(2001:cafe::1) 56 data bytes
64 bytes from 2001:cafe::1: icmp_seq=343 ttl=255 time=54.3 ms
64 bytes from 2001:cafe::1: icmp_seq=344 ttl=255 time=50.1 ms
^C

I used to have CSWtun from Blastwave - it's labeled as version 1.1 as 
well so I believed it was the right thing.

Is there any way to check that the right module is loaded at runtime? 
That may help avoid some confusion in the future...

Thanks a lot for your work!

(BTW is there any work in progress for a v6 transport?)

Michal


