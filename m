Date: Fri, 28 Nov 2025 13:32:37 +0100 (CET)
Message-Id: <202511281232.5ASCWb3P026282@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251128112705.12613-1-gert@...1296...>
References: <20251128112705.12613-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dco: process messages
 immediately after read
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
To: Ralf Lici <ralf@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

This was quite a bit of a journey... after staring at the code and deciding
"yes this looks good" it promptly crashed on me, with most interesting
error messages (connecting 100 clients simultaneously and disconnecting
simultaneously as well, no EEN, so triggering 100 quasi-simultaneous
PEER_DEL notifications from the kernel).  After this was fixed, the Gremlins
crashed it again, in an ASSERT(es)...  but with v13 I can no longer break
it *and* we're reasonably sure we understand what is and was happening.

Tested really really hard on ubuntu 20.04 + backports, and lightly
(t_client and t_server, no gremlins) on FreeBSD 14.  Since the FreeBSD
notification mechanism works differently, we do not expect the same sort
of problems (missing / batched notifications) to materialize there.

Added Github references to #900 (sbaranoff), #918, #919 (mine).  The latter
two are basically things that broke in earlier versions of the patch, 
and #918 is kept open to see if we could make the setenv_stats() <-> DCO
interaction better.

Your patch has been applied to the master branch.

commit 7791f5358a5574d4ef1bd27e2d52300c9d98bd72
Author: Ralf Lici
Date:   Fri Nov 28 12:26:59 2025 +0100

     dco: process messages immediately after read

     Signed-off-by: Ralf Lici <ralf@...2726...>
     Acked-by: Gert Doering <gert@...1296...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1403
     Message-Id: <20251128112705.12613-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34785.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


