Date: Mon, 20 Jul 2020 22:13:28 +0200 (CEST)
Message-Id: <202007202013.06KKDScB023447@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20200720121704.20333-1-arne@...1227...>
References: <20200720121704.20333-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Require AEAD support in the
 crypto library
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

Quick sanity check on FreeBSD/1.0.2s, Linux/1.1.1g, Linux/mbedTLS
(client side only).  All good.

Your patch has been applied to the master branch.

commit 94edc7c5dd3cf8988df15fe4d7bd6cba9486b2a6
Author: Arne Schwabe
Date:   Mon Jul 20 14:17:04 2020 +0200

     Require AEAD support in the crypto library

     Signed-off-by: Arne Schwabe <arne@...1227...>
     Acked-by: Steffan Karger <steffan.karger@...2507...>
     Message-Id: <20200720121704.20333-1-arne@...1227...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20506.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


