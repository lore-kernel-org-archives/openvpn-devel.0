Date: Tue, 14 Mar 2023 16:03:47 +0100 (CET)
Message-Id: <202303141503.32EF3lgr025340@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20230314144854.182110-2-arne@...1227...>
References: <20230314144854.182110-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix memory leaks in dco open tun
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

This one is fairly straightforward (and the leak is small) - I've
re-read all the code involved for v2 of the patch (set) and the
change is correct.  The device name involved stays unchanged in
the current iterations of open_tun_dco(), so there is no need to
save it there (fallout of the many rewrites of these parts).

Your patch has been applied to the master and release/2.6 branch.

commit 021952705ba4b77a1d94bec85f6f02e6c612a37e (master)
commit be7a5640fbce2d3d56bdcee23e3d76ea15a678d1 (release/2.6)
Author: Arne Schwabe
Date:   Tue Mar 14 15:48:54 2023 +0100

     Fix memory leaks in dco open tun

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20230314144854.182110-2-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26411.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


