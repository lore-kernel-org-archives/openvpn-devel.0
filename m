Date: Sun, 22 Dec 2024 12:53:37 +0100 (CET)
Message-Id: <202412221153.4BMBrbun085111@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20241221223905.18820-1-gert@...1296...>
References: <20241221223905.18820-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Split init_key_ctx_bi into
 send/recv init
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

This is a fairly straightforward and mechanical change, so easy to review
(still fed to the full client/server testbed, just to be sure).

Your patch has been applied to the master branch.

commit 435cc9a7535c86c1ab513ae106895960c183095e
Author: Arne Schwabe
Date:   Sat Dec 21 23:39:05 2024 +0100

     Split init_key_ctx_bi into send/recv init

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20241221223905.18820-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30151.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


