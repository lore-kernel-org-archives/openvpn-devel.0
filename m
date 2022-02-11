Date: Fri, 11 Feb 2022 09:58:05 +0100 (CET)
Message-Id: <202202110858.21B8w5MH085949@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20220210162632.3309974-1-arne@...1227...>
References: <20220210162632.3309974-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Replace TUN_MTU_SIZE with
 frame->tun_mtu
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

Acked-by: Gert Doering <gert@...1296...>

Code change looks very straight forward :-)

Passes all my torture tests on client and server (except frame max 
setting on P2P TAP, but that's known and will be fixed at the end 
of the series).

For reference, this was 19/21 in v1 and 12/14 in v3 of the series,
which could not go in because it broke compilation.  The difference
v3 -> v4 is "more TUN_MTU_SIZE() calls get converted" - all of
these in code parts that got removed in other parts of the v3 patch
series, but breaking compilation nonetheless.

Doing this as 01/08 now will also magically fix the "ifconfig has
the wrong mtu value" problem that made me stall 09/14 v3.

Your patch has been applied to the master branch.

commit 364b7b4f04985600e0a0a46e79555379b5df9977
Author: Arne Schwabe
Date:   Thu Feb 10 17:26:25 2022 +0100

     Replace TUN_MTU_SIZE with frame->tun_mtu

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20220210162632.3309974-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23752.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


