From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 10 Oct 2018 15:26:17 +0300
Message-Id: <1539174377-2678-1-git-send-email-lstipakov@...277...>
In-Reply-To: <CAGyAFMULV02g3gyCbvQ1+L+cMdE4UZMmzVfey-T1g4Y0NcmKeg@...278...>
References: <CAGyAFMULV02g3gyCbvQ1+L+cMdE4UZMmzVfey-T1g4Y0NcmKeg@...278...>
Subject: [Openvpn-devel] [PATCH v2] options.c: fix broken unary minus usage
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

Fix by introducing frame_remove_from_extra_frame function,
which makes code semantically more clear and eliminates
the need in negative value and cast.

Since GCC didn't complain (and users too :), it probably performed
cast to signed automatically.

Signed-off-by: Lev Stipakov <lev@...515...>
---
v2: use frame_remove_from_extra_frame instead of passing negative value

 src/openvpn/crypto.c  | 2 +-
 src/openvpn/init.c    | 2 +-
 src/openvpn/mtu.h     | 8 +++++++-
 src/openvpn/options.c | 2 +-
 src/openvpn/ssl.c     | 2 +-
 5 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 6d34acd..b1d6780 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -722,7 +722,7 @@ crypto_adjust_frame_parameters(struct frame *frame,
 
     crypto_overhead += kt->hmac_length;
 
-    frame_add_to_extra_frame(frame, crypto_overhead);
+    frame_add_to_extra_frame(frame, (unsigned int) crypto_overhead);
 
     msg(D_MTU_DEBUG, "%s: Adjusting frame parameters for crypto by %u bytes",
         __func__, (unsigned int) crypto_overhead);
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 52c64da..fe70175 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2675,7 +2675,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     if (c->options.pull || c->options.mode == MODE_SERVER)
     {
         /* Account for worst-case crypto overhead before allocating buffers */
-        frame_add_to_extra_frame(&c->c2.frame, crypto_max_overhead());
+        frame_add_to_extra_frame(&c->c2.frame, (unsigned int) crypto_max_overhead());
     }
     else
     {
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index a82154a..690eb81 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -271,12 +271,18 @@ frame_add_to_link_mtu(struct frame *frame, const int increment)
 }
 
 static inline void
-frame_add_to_extra_frame(struct frame *frame, const int increment)
+frame_add_to_extra_frame(struct frame *frame, const unsigned int increment)
 {
     frame->extra_frame += increment;
 }
 
 static inline void
+frame_remove_from_extra_frame(struct frame *frame, const unsigned int increment)
+{
+    frame->extra_frame -= increment;
+}
+
+static inline void
 frame_add_to_extra_tun(struct frame *frame, const int increment)
 {
     frame->extra_tun += increment;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e42029c..be47090 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3509,7 +3509,7 @@ calc_options_string_link_mtu(const struct options *o, const struct frame *frame)
         struct key_type fake_kt;
         init_key_type(&fake_kt, o->ciphername, o->authname, o->keysize, true,
                       false);
-        frame_add_to_extra_frame(&fake_frame, -(crypto_max_overhead()));
+        frame_remove_from_extra_frame(&fake_frame, (unsigned int) crypto_max_overhead());
         crypto_adjust_frame_parameters(&fake_frame, &fake_kt, o->replay,
                                        cipher_kt_mode_ofb_cfb(fake_kt.cipher));
         frame_finalize(&fake_frame, o->ce.link_mtu_defined, o->ce.link_mtu,
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 315303b..747e176 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1987,7 +1987,7 @@ tls_session_update_crypto_params(struct tls_session *session,
     }
 
     /* Update frame parameters: undo worst-case overhead, add actual overhead */
-    frame_add_to_extra_frame(frame, -(crypto_max_overhead()));
+    frame_remove_from_extra_frame(frame, (unsigned int) crypto_max_overhead());
     crypto_adjust_frame_parameters(frame, &session->opt->key_type,
                                    options->replay, packet_id_long_form);
     frame_finalize(frame, options->ce.link_mtu_defined, options->ce.link_mtu,
-- 
2.7.4


