From: Aaron Sethman <androsyn@...45...>
Message-ID: <Pine.LNX.4.50.0305071032410.17462-100000@...48...>
MIME-Version: 1.0
Subject: [Openvpn-devel] an idea for openvpn..
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
Date: Wed May  7 07:38:10 2003
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

One of the things that I just thought about is, that we can probably have
openvpn call sched_setscheduler() using something like SCHED_RR.  This
might be of more use than just renicing the process.  Considering we are
in a fairly performance critical path for a userspace process this would
seem to make sense.  Not sure how to deal with SCHED_RR wrt to threads
though.  On my systems I haven't noticed much of a difference, when doing
this, but my systems aren't heavily loaded either.

Thoughts, comments?

-Aaron

