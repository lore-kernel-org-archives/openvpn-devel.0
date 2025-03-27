From: Gert Doering <gert@...1296...>
Date: Thu, 27 Mar 2025 16:36:00 +0100
Message-ID: <20250327153606.15282-1-gert@...1296...>
In-Reply-To: <gerrit.1742996678000.I54073f8b63894a62699f6ecdc90a77f9f131205b@...2715...>
References: <gerrit.1742996678000.I54073f8b63894a62699f6ecdc90a77f9f131205b@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Do not leave half-initialised key wrap
 struct when dynamic tls-crypt fails
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

From: Arne Schwabe <arne@...1227...>

In case when key_state_export_keying_material fails we left a
half-initialised tls_wrap_reneg  structure in the tls_session.
Later calls to try to free this structure causes freeing of
invalid memory locations.

To test: make key_state_export_keying_material return false even though
         HAVE_EXPORT_KEYING_MATERIAL is defined and connect to a server
         supporting dynamic tls-crypt (2.6.0+)

Change-Id: I54073f8b63894a62699f6ecdc90a77f9f131205b
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: MaxF <max@...2606...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/921
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
MaxF <max@...2606...>

        
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index eb7b03d..9e9807d 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -97,6 +97,15 @@
 bool
 tls_session_generate_dynamic_tls_crypt_key(struct tls_session *session)
 {
+    struct key2 rengokeys;
+    if (!key_state_export_keying_material(session, EXPORT_DYNAMIC_TLS_CRYPT_LABEL,
+                                          strlen(EXPORT_DYNAMIC_TLS_CRYPT_LABEL),
+                                          rengokeys.keys, sizeof(rengokeys.keys)))
+    {
+        return false;
+    }
+    rengokeys.n = 2;
+
     session->tls_wrap_reneg.opt = session->tls_wrap.opt;
     session->tls_wrap_reneg.mode = TLS_WRAP_CRYPT;
     session->tls_wrap_reneg.cleanup_key_ctx = true;
@@ -108,16 +117,6 @@
                    session->opt->replay_time,
                    "TLS_WRAP_RENEG", session->key_id);
 
-
-    struct key2 rengokeys;
-    if (!key_state_export_keying_material(session, EXPORT_DYNAMIC_TLS_CRYPT_LABEL,
-                                          strlen(EXPORT_DYNAMIC_TLS_CRYPT_LABEL),
-                                          rengokeys.keys, sizeof(rengokeys.keys)))
-    {
-        return false;
-    }
-    rengokeys.n = 2;
-
     if (session->tls_wrap.mode == TLS_WRAP_CRYPT
         || session->tls_wrap.mode == TLS_WRAP_AUTH)
     {

