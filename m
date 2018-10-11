From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 11 Oct 2018 14:51:42 +0300
Message-Id: <1539258702-15427-1-git-send-email-lstipakov@...277...>
In-Reply-To: <20181011112317.GF962@...1296...>
References: <20181011112317.GF962@...1296...>
Subject: [Openvpn-devel] [PATCH v3] options.c: fix broken unary minus usage
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

Fix by introducing frame_remove_from_extra_frame(),
which makes code semantically more clear and eliminates
the need in negative value and cast.

Since GCC didn't complain (and users too :), it probably performed
cast to signed automatically.

Signed-off-by: Lev Stipakov <lev@...515...>
---
v3:
 - change crypto_overhead and crypto_max_overhead() type to unsigned int
 to avoid additional cast or warning in Visual Studio
 - rename "increment" formal paremeter to "decrement"

v2:
  - use new frame_remove_from_extra_frame() instead of
 passing negative value

 src/openvpn/crypto.c  | 6 +++---
 src/openvpn/crypto.h  | 2 +-
 src/openvpn/mtu.h     | 8 +++++++-
 src/openvpn/options.c | 2 +-
 src/openvpn/ssl.c     | 2 +-
 5 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 6d34acd..8416b89 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -700,7 +700,7 @@ crypto_adjust_frame_parameters(struct frame *frame,
                                bool packet_id,
                                bool packet_id_long_form)
 {
-    size_t crypto_overhead = 0;
+    unsigned int crypto_overhead = 0;
 
     if (packet_id)
     {
@@ -725,10 +725,10 @@ crypto_adjust_frame_parameters(struct frame *frame,
     frame_add_to_extra_frame(frame, crypto_overhead);
 
     msg(D_MTU_DEBUG, "%s: Adjusting frame parameters for crypto by %u bytes",
-        __func__, (unsigned int) crypto_overhead);
+        __func__, crypto_overhead);
 }
 
-size_t
+unsigned int
 crypto_max_overhead(void)
 {
     return packet_id_size(true) + OPENVPN_MAX_IV_LENGTH
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 263725d..1d7f4c5 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -418,7 +418,7 @@ void crypto_adjust_frame_parameters(struct frame *frame,
                                     bool packet_id_long_form);
 
 /** Return the worst-case OpenVPN crypto overhead (in bytes) */
-size_t crypto_max_overhead(void);
+unsigned int crypto_max_overhead(void);
 
 /* Minimum length of the nonce used by the PRNG */
 #define NONCE_SECRET_LEN_MIN 16
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index a82154a..cfa8d2f 100644
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
+frame_remove_from_extra_frame(struct frame *frame, const unsigned int decrement)
+{
+    frame->extra_frame -= decrement;
+}
+
+static inline void
 frame_add_to_extra_tun(struct frame *frame, const int increment)
 {
     frame->extra_tun += increment;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e42029c..3ce620a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3509,7 +3509,7 @@ calc_options_string_link_mtu(const struct options *o, const struct frame *frame)
         struct key_type fake_kt;
         init_key_type(&fake_kt, o->ciphername, o->authname, o->keysize, true,
                       false);
-        frame_add_to_extra_frame(&fake_frame, -(crypto_max_overhead()));
+        frame_remove_from_extra_frame(&fake_frame, crypto_max_overhead());
         crypto_adjust_frame_parameters(&fake_frame, &fake_kt, o->replay,
                                        cipher_kt_mode_ofb_cfb(fake_kt.cipher));
         frame_finalize(&fake_frame, o->ce.link_mtu_defined, o->ce.link_mtu,
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 315303b..9e2fd94 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1987,7 +1987,7 @@ tls_session_update_crypto_params(struct tls_session *session,
     }
 
     /* Update frame parameters: undo worst-case overhead, add actual overhead */
-    frame_add_to_extra_frame(frame, -(crypto_max_overhead()));
+    frame_remove_from_extra_frame(frame, crypto_max_overhead());
     crypto_adjust_frame_parameters(frame, &session->opt->key_type,
                                    options->replay, packet_id_long_form);
     frame_finalize(frame, options->ce.link_mtu_defined, options->ce.link_mtu,
-- 
2.7.4


