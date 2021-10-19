From: Arne Schwabe <arne@...1227...>
Date: Tue, 19 Oct 2021 20:23:25 +0200
Message-Id: <20211019182332.613155-21-arne@...1227...>
In-Reply-To: <20211019182332.613155-1-arne@...1227...>
References: <20211019182332.613155-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 15/16] Fix error when BF-CBC is not
 available
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
To: openvpn-devel@lists.sourceforge.net

Through the multiple iteration of allowing OpenVPN to run without
BF-CBC we accidentially made a regression and still required BF-CBC.

This patch fixes the code path and restores its intended function.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/options.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index ab7b00783..fe873944b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3797,6 +3797,9 @@ calc_options_string_link_mtu(const struct options *o, const struct frame *frame)
 
             /* overhead of BF-CBC: 64 bit block size, 64 bit IV size */
             frame_add_to_extra_frame(&fake_frame, 64/8 + 64/8);
+            /* set ciphername to none, so its size does get added in the fake_kt and
+             * the cipher is not tried to be resolved */
+            ciphername = "none";
         }
 
         init_key_type(&fake_kt, ciphername, o->authname, true, false);
-- 
2.33.0


