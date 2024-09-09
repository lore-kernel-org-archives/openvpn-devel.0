Date: Mon, 9 Sep 2024 13:39:30 +0200 (CEST)
Message-Id: <202409091139.489BdULT062449@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20240906145745.67596-1-frank@...2641...>
References: <20240906145745.67596-1-frank@...2641...>
Subject: [Openvpn-devel] [PATCH applied] Re: Ensures all params are ready
 before invoking dco_set_peer()
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
To: Gianmarco De Gregori <gianmarco@...2726...>
Cc: openvpn-devel@lists.sourceforge.net

I did not have an obvious way to trigger this, so I first just fed it to 
the DCO-enabled server/client testbed (nothing broke).

Then, after quite a bit of discussion, it was made clear that this is
for "UDP p2mp server configs".  To see the effect, one needs to run with
DCO debugging (--verb 7), and then it will show the difference:

Old:

Sep  9 07:00:26 ubuntu2004 tun-udp-p2mp[1926430]: freebsd-74-amd64/194.97.140.3:64742 peer-id=0 dco_set_peer: peer-id 0, keepalive 10/60, mss 0
Sep  9 07:02:55 ubuntu2004 tun-udp-p2mp[1926430]: freebsd-14-amd64/2001:608:0:814::fb00:14 peer-id=1 dco_set_peer: peer-id 1, keepalive 10/60, mss 0
Sep  9 07:03:15 ubuntu2004 tun-udp-p2mp[1926430]: dco_set_peer: peer-id 2, keepalive 10/60, mss 0
Sep  9 07:03:30 ubuntu2004 tun-udp-p2mp[1926430]: dco_set_peer: peer-id 1, keepalive 10/60, mss 0

New:

Sep  9 12:05:56 ubuntu2004 tun-udp-p2mp[1951062]: freebsd-74-amd64/194.97.140.3:51648 peer-id=0 dco_set_peer: peer-id 0, keepalive 10/60, mss 1380
Sep  9 12:08:31 ubuntu2004 tun-udp-p2mp[1951062]: freebsd-14-amd64/2001:608:0:814::fb00:14 peer-id=1 dco_set_peer: peer-id 1, keepalive 10/60, mss 1380
Sep  9 12:08:50 ubuntu2004 tun-udp-p2mp[1951062]: dco_set_peer: peer-id 2, keepalive 10/60, mss 1380
Sep  9 12:09:06 ubuntu2004 tun-udp-p2mp[1951062]: dco_set_peer: peer-id 1, keepalive 10/60, mss 1380

(not sure why half the log lines have a peer-name prefix and the other
half don't, but this is outside the patch in question)


Since the currently active DCO implementations for Linux and FreeBSD
do not support MSSFIX this is a bit moot today, as the kernel side will
just ignore the value anyway - but with the upcoming new Linux "in tree"
version, at least setting the correct information is needed so the
kernel can eventually do the right thing with it.

As discussed on IRC, I have updated the comment before the
dco_set_peer() call to more correctly reflect what it does.

Also, I have reworded the commit message a bit to make it more clear that
this is fixing a "p2mp server" issue, and that why p2p_set_dco_keepalive()
has been removed.

Your patch has been applied to the master branch.

commit 32e748bd3320cd07b9e7671ee0cec95f4fd85935 (master)
Author: Gianmarco De Gregori
Date:   Fri Sep 6 16:57:45 2024 +0200

     Ensures all params are ready before invoking dco_set_peer()

     Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
     Acked-by: Lev Stipakov <lstipakov@...277...>
     Message-Id: <20240906145745.67596-1-frank@...2641...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29086.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


