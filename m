From: Steffan Karger <steffan@...1856...>
Date: Sat, 19 Jan 2019 11:34:00 +0100
Message-Id: <20190119103400.12887-1-steffan@...1856...>
In-Reply-To: <20190119103028.12497-1-steffan@...1856...>
References: <20190119103028.12497-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH v2] Fix tls-auth/crypt in connection blocks
 with --persist-key
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

If --persist-key was used, we would always try to pre-load the 'global'
tls-auth/crypt file. That would result in using the wrong key (leading
to a failed connection) or en error is there was to 'global' key:

  Sat Jan 19 11:09:01 2019 Cannot pre-load tls-auth keyfile ((null))
  Sat Jan 19 11:09:01 2019 Exiting due to fatal error

Fix that by loading loading the key from the current connection entry.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
v2: Also fix tls-crypt, not just tls-auth.

 src/openvpn/options.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 0cf8db767..bebd30059 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2863,11 +2863,11 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
     {
         if (ce->tls_auth_file && !ce->tls_auth_file_inline)
         {
-            struct buffer in = buffer_read_from_file(o->tls_auth_file, &o->gc);
+            struct buffer in = buffer_read_from_file(ce->tls_auth_file, &o->gc);
             if (!buf_valid(&in))
             {
                 msg(M_FATAL, "Cannot pre-load tls-auth keyfile (%s)",
-                    o->tls_auth_file);
+                    ce->tls_auth_file);
             }
 
             ce->tls_auth_file = INLINE_FILE_TAG;
@@ -2876,11 +2876,11 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
 
         if (ce->tls_crypt_file && !ce->tls_crypt_inline)
         {
-            struct buffer in = buffer_read_from_file(o->tls_crypt_file, &o->gc);
+            struct buffer in = buffer_read_from_file(ce->tls_crypt_file, &o->gc);
             if (!buf_valid(&in))
             {
                 msg(M_FATAL, "Cannot pre-load tls-crypt keyfile (%s)",
-                    o->tls_auth_file);
+                    ce->tls_crypt_file);
             }
 
             ce->tls_crypt_file = INLINE_FILE_TAG;
-- 
2.17.1


