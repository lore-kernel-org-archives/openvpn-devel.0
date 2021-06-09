From: Antonio Quartulli <a@...2181...>
Date: Wed,  9 Jun 2021 08:15:32 +0200
Message-Id: <20210609061532.12774-1-a@...2181...>
In-Reply-To: <20210608194330.1431202-1-arne@...1227...>
References: <20210608194330.1431202-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Silence warning about format string in
 check_ca_required
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
Cc: Arne Schwabe <arne@...1227...>, Antonio Quartulli <a@...2181...>

From: Arne Schwabe <arne@...1227...>

clang does not like if the format argument of printf like function
is not a string literal (or constant):

warning: format string is not a string literal (potentially insecure)

Make the format string constant to silence the warning.

Signed-off-by: Arne Schwabe <arne@...1227...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---

Changes from v1:
* use const string instead of introducing "%s".

@Arne I anticipated this change because I "assumed" you would be ok with
it (patch is still yours), but feel free to comment of course.


 src/openvpn/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 819979b1..086f7b6e 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2069,7 +2069,7 @@ check_ca_required(const struct options *options)
         return;
     }
 
-    const char* str = "You must define CA file (--ca)"
+    const char* const str = "You must define CA file (--ca)"
 #ifndef ENABLE_CRYPTO_MBEDTLS
         " or CA path (--capath)"
 #endif
-- 
2.31.1


