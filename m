Date: Sun, 14 Sep 2025 15:35:36 +0200 (CEST)
Message-Id: <202509141335.58EDZawu089381@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250908181852.5054-1-gert@...1296...>
References: <20250908181852.5054-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Switch test_ssl certificate
 from RSA 2048 to secp384r1
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

It does what it says on the lid, and the BBs & Mathias have confirmed that
it works, across the range of TLS library versions we use.

No code change in OpenVPN itself.

Your patch has been applied to the master branch.

I would have applied it to release/2.6 ("long-term compat") but test_ssl.c
doesn't exist there yet...

commit 456da311da0fccc9ab64f75a6637587fc04bd979
Author: Arne Schwabe
Date:   Mon Sep 8 20:18:46 2025 +0200

     Switch test_ssl certificate from RSA 2048 to secp384r1

     Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
     Acked-by: Gert Doering <gert@...1296...>
     URL: https://gerrit.openvpn.net/c/openvpn/+/1172
     Message-Id: <20250908181852.5054-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32838.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


