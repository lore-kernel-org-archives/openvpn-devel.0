From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 18 May 2022 20:37:15 +0200
Message-Id: <20220518183715.931-1-frank@...2641...>
In-Reply-To: <2735E502-7F1F-48E9-8011-6740251E81DE@...2674...>
References: <2735E502-7F1F-48E9-8011-6740251E81DE@...2674...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] cipher-negotiation.rst missing from
 doc/Makefile.am
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

From: Jan Mikkelsen <janm@...2674...>

Signed-off-by: Jan Mikkelsen <janm@...2674...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---
 doc/Makefile.am | 1 +
 1 file changed, 1 insertion(+)

I have reformatted this with git-format-patch to make the patch
easier to apply. Also checked that this is indeed the only missing
file currently.

diff --git a/doc/Makefile.am b/doc/Makefile.am
index affe1b90..c9e83750 100644
--- a/doc/Makefile.am
+++ b/doc/Makefile.am
@@ -25,6 +25,7 @@ dist_doc_DATA = \
 
 openvpn_sections = \
 	man-sections/advanced-options.rst \
+	man-sections/cipher-negotiation.rst \
 	man-sections/client-options.rst \
 	man-sections/connection-profiles.rst \
 	man-sections/encryption-options.rst \
-- 
2.30.2


