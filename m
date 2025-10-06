Date: Mon, 6 Oct 2025 18:56:49 +0200 (CEST)
Message-Id: <202510061656.596GunaB089582@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20251006145844.27794-1-gert@...1296...>
References: <20251006145844.27794-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Allowing installing FreeBSD
 routes with interface instead of next-hop
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

There is not much to test here, as the "new code" is only used for a
case not yet supported by the rest of the code (--ifconfig-push IPs
outside --server subnet, with DCO, on FreeBSD).  Patch for that is
in gerrit #1192, but that needs more testing.

The code in question is currently only excercised at all for --iroute
on FreeBSD DCO -> tested there, works.

At a future point in time (after 2.7.0 release) I think I/we should remove
the TARGET_FREEBSD parts from route.c, and use networking_freebsd.c
instead (adding what is missing, namely "fe80::1%em0" gateways with
embedded NIC).

As discussed in IRC, I have amended the comment a bit, and then a bit more,
to make it easier to understand what is happening and when it's needed.  No
actual code change.

Your patch has been applied to the master branch.

commit cbcfb9ab3ea90e1d09e5783bdb3bbd18ac0328d1
Author: Arne Schwabe
Date:   Mon Oct 6 16:58:37 2025 +0200

     Allowing installing FreeBSD routes with interface instead of next-hop

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1193
     Message-Id: <20251006145844.27794-1-gert@...1296...>
     URL: https://sourceforge.net/p/openvpn/mailman/message/59242876/
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


