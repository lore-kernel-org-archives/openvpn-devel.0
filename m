Message-Id: <200305080633.h486XC111141@...41...>
Subject: Re: [Openvpn-devel] an idea for openvpn..
From: "James Yonan" <jim@...41...>
In-Reply-To: <Pine.LNX.4.50.0305071032410.17462-100000@...48...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed May  7 23:41:05 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Aaron Sethman <androsyn@...45...>, openvpn-devel@lists.sourceforge.net

Aaron,

I've found that the linux scheduler on 2.4 does a fairly good job at giving
openvpn the CPU that it needs, even on a more heavily loaded system.  When
openvpn is forwarding tunnel packets, it is essentially i/o bound, and as such
gets a priority boost.  When TLS keys are being negotiated, however, openvpn
becomes a CPU hog for as much as several seconds, so you wouldn't want to lock
up the machine during this period, especially given the fact that TLS
renegotiations are not in the critical path of tunnel packet forwarding
operations.  Overall, it's not clear to me that we need more scheduling
flexibility than --nice or --nice-work can give us.  And nice scheduling has
the safety factor as well of never completely locking up the machine, even if
something of high priority does a CPU grab.

James

Aaron Sethman <androsyn@...45...> said:

> 
> One of the things that I just thought about is, that we can probably have
> openvpn call sched_setscheduler() using something like SCHED_RR.  This
> might be of more use than just renicing the process.  Considering we are
> in a fairly performance critical path for a userspace process this would
> seem to make sense.  Not sure how to deal with SCHED_RR wrt to threads
> though.  On my systems I haven't noticed much of a difference, when doing
> this, but my systems aren't heavily loaded either.
> 
> Thoughts, comments?
> 
> -Aaron
> 
> 
> -------------------------------------------------------
> Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
> The only event dedicated to issues related to Linux enterprise solutions
> www.enterpriselinuxforum.com
> 
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> 



-- 




