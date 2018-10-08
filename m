From: Lev Stipakov <lstipakov@...277...>
Date: Mon,  8 Oct 2018 19:09:10 +0300
Message-Id: <1539014950-21921-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] options.c: fix broken unary minus usage
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

From: Lev Stipakov <lev@...515...>

In Visual Studio when unary minus is applied to unsigned,
result is still unsigned. This means that when we use result
as function formal parameter, we pass incorrect value.

Fix by adding explicit cast to signed type.

Since GCC doesn't complain (and users too :), it probably
casts to signed automatically.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/options.c | 2 +-
 src/openvpn/ssl.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e42029c..1927a32 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3509,7 +3509,7 @@ calc_options_string_link_mtu(const struct options *o, const struct frame *frame)
         struct key_type fake_kt;
         init_key_type(&fake_kt, o->ciphername, o->authname, o->keysize, true,
                       false);
-        frame_add_to_extra_frame(&fake_frame, -(crypto_max_overhead()));
+        frame_add_to_extra_frame(&fake_frame, -(int)(crypto_max_overhead()));
         crypto_adjust_frame_parameters(&fake_frame, &fake_kt, o->replay,
                                        cipher_kt_mode_ofb_cfb(fake_kt.cipher));
         frame_finalize(&fake_frame, o->ce.link_mtu_defined, o->ce.link_mtu,
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 315303b..18b1fbd 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1987,7 +1987,7 @@ tls_session_update_crypto_params(struct tls_session *session,
     }
 
     /* Update frame parameters: undo worst-case overhead, add actual overhead */
-    frame_add_to_extra_frame(frame, -(crypto_max_overhead()));
+    frame_add_to_extra_frame(frame, -(int)(crypto_max_overhead()));
     crypto_adjust_frame_parameters(frame, &session->opt->key_type,
                                    options->replay, packet_id_long_form);
     frame_finalize(frame, options->ce.link_mtu_defined, options->ce.link_mtu,
-- 
2.7.4


