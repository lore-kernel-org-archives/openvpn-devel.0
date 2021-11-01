Date: Mon, 1 Nov 2021 21:00:10 +0100 (CET)
Message-Id: <202111012000.1A1K0Ax1084409@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20211019183127.614175-12-arne@...1227...>
References: <20211019183127.614175-12-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Use EVP_MD_get0_name instead
 EV_MD_name
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

Some context massaging required (ssl_compat context, 08, v3->v4, ...)

1.1.1 builds & passes "make check" just fine.

3.0.0 shows the same failures as before (ncp_testdriver, t_lpback.sh),
which means "nothing new broke", so this change seems to be good enough.

Your patch has been applied to the master branch.

commit 5a112250745b69a3ca2f3e00aed9ea02b2e717bb
Author: Arne Schwabe
Date:   Tue Oct 19 20:31:17 2021 +0200

     Use EVP_MD_get0_name instead EV_MD_name

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Max Fillinger <maximilian.fillinger@...2507...>
     Message-Id: <20211019183127.614175-12-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23016.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


