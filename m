From: Frank Lichtenheld <frank@...2641...>
Date: Wed,  1 Feb 2023 14:52:21 +0100
Message-Id: <20230201135221.36135-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Changes.rst: document removal of --keysize
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

When reviweing OpenVPN/openvpn#231 I noticed this was
missing from Changes.rst.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 Changes.rst           | 5 +++++
 src/openvpn/options.c | 1 -
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Changes.rst b/Changes.rst
index 4942a580..dc829032 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -176,6 +176,11 @@ TLS 1.0 and 1.1 are deprecated
     a PRNG is better left to a crypto library. So we use the PRNG
     mbed TLS or OpenSSL now.
 
+``--keysize`` has been removed
+    The ``--keysize`` option was only useful to change the key length when using the
+    BF, CAST6 or RC2 ciphers. For all other ciphers the key size is fixed with the
+    chosen cipher. As OpenVPN v2.6 no longer supports any of these variable length
+    ciphers, this option was removed as well to avoid confusion.
 
 Compression no longer enabled by default
     Unless an explicit compression option is specified in the configuration,
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index a5f6d244..34291edf 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4176,7 +4176,6 @@ options_postprocess_pull(struct options *o, struct env_set *es)
  *
  * --cipher
  * --auth
- * --keysize
  * --secret
  * --no-replay
  *
-- 
2.34.1


