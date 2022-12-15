Date: Thu, 15 Dec 2022 13:34:09 +0100 (CET)
Message-Id: <202212151234.2BFCY9af082666@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20221214224220.307-1-lstipakov@...277...>
References: <20221214224220.307-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH applied] Re: management: add timer to output
 BYTECOUNT
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

Arne, thanks for the review and ACK.

I have done quite a bit of stare-at-code on this patch myself, and think
I understand what it does - change from "whenever userland updates the
counters, check if mgmt needs to be informed" to "inform mgmt via the
coarse timers", because there are no more userland packets to trigger
this check.  But having the review from someone who understands mgmt 
much better is very welcome :-)

As a side effect, management_bytes_in() and _out() are consolidated
into a single function, which (due to being inlined) should do the
same thing with the same efficiency, but it's a bit easier to see
what happens.

I have subjected this to the full server/client tests on Linux and 
FreeBSD, with/without DCO - and everything works as before.

I have also tested this by connecting to the management interface to
verify that the counters + event stuff works.  No DCO involved, so 
counters were displayed in the expected intervals and values matched
what I expected.  Also, "bytecount 0" works to disable it again.

On a (FreeBSD) DCO system, the effect was not exactly what I expected
- I expected to see >BYTECOUNT: updates "with no interesting content",
but actually after setting "bytecount 10", nothing happened for a 
few minutes - and then it started to work as ordered (without data packets,
of course).  So it seems as the timer activation got delayed somehow
-> this is something we need to come back to, when Linux/FreeBSD DCO
stats get implemented.  Starting with "management-hold", then "bytecount",
then "hold release" gave me counters right away.  Mysteries...


Your patch has been applied to the master and release/2.6 branch.

commit a9991b3eb6644785421398bff8cb3a728d131713 (master)
commit 59a96c3ee05cdb842af0956de0a2ba3ffd993980 (release/2.6)
Author: Lev Stipakov
Date:   Thu Dec 15 00:42:20 2022 +0200

     management: add timer to output BYTECOUNT

     Signed-off-by: Lev Stipakov <lev@...515...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20221214224220.307-1-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg25707.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


