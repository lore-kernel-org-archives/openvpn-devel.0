Date: Tue, 22 Feb 2022 14:31:28 +0100 (CET)
Message-Id: <202202221331.21MDVSMr036509@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220222113832.13383-1-gert@...1296...>
References: <20220222113832.13383-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix --mtu-disc maybe|yes on
 Linux.
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Patch has been applied to the master branch, backported to release/2.5 
(leaving out the mss.c hunks, and the syshead.h one still has HAVE_IPVEC 
to remove...) and to release/2.4 (sys/poll.h in configure.ac).

Verified that 2.5 and 2.4 show the right socket error message
("write UDPv4 [EMSGSIZE Path-MTU=800]"), which is what this bugfix
is fixing - have not verified that the old frame/MTU code actually
works, but I suspect we never managed to break it.

Note: this fixes --mtu-disc over IPv4 transport.  IPv6 transport returns
"extended error messages" now as well, but now the handler seems to expect
something else, and does not recognize this as "mtu".  Will address this
in the next patch.

commit 4225114b96723bdecd68398f7a89765879b31b5d (master)
commit 3e0c506e5d9135ef4b08547db8679cc5bd2a7582 (release/2.5)
commit 4d63d15ef9e1eb34ffdc4028a96f506decced99c (release/2.4)
Author: Gert Doering
Date:   Tue Feb 22 12:38:32 2022 +0100

     Fix --mtu-disc maybe|yes on Linux.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20220222113832.13383-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23863.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


