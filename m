Resent-To: "openvpn-devel@lists.sourceforge.net"
	<openvpn-devel@lists.sourceforge.net>
Resent-Message-ID: <55963684-9521-f808-8281-eca2a4117308@...2162...>
From: Steffan Karger <steffan.karger@...1435...>
Date: Tue, 9 May 2017 21:30:09 +0200
Message-ID: <1494358209-4568-3-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1494358209-4568-1-git-send-email-steffan.karger@...1435...>
References: <1494358209-4568-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2 (master)] Drop packets instead of assert
	out if packet id rolls over (CVE-2017-7479)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: security@...515...

Previously, if a mode was selected where packet ids are not allowed to roll
over, but renegotiation does not succeed for some reason (e.g. no password
entered in time, certificate expired or a malicious peer that refuses the
renegotiaion on purpose) we would continue to use the old keys.  Until the
packet ID would roll over and we would ASSERT() out.

Given that this can be triggered on purpose by an authenticated peer, this
is a fix for an authenticated remote DoS vulnerability.  An attack is
rather inefficient though; a peer would need to get us to send 2^32
packets (min-size packet is IP+UDP+OPCODE+PID+TAG (no payload), results in
(20+8+1+4+16)=C3=972^32 bytes, or approx. 196 GB).

This is a fix for finding 5.2 from the OSTIF / Quarkslab audit.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 Changes.rst                               |  4 ++++
 src/openvpn/crypto.c                      | 25 ++++++++++++++++---------
 src/openvpn/packet_id.c                   | 22 ++++++++++++++++------
 src/openvpn/packet_id.h                   |  1 +
 src/openvpn/tls_crypt.c                   |  6 +++++-
 tests/unit_tests/openvpn/test_packet_id.c | 11 +++++++++--
 6 files changed, 51 insertions(+), 18 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 734ef73..5a02ad0 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -335,3 +335,7 @@ Security
   to hit an ASSERT() and stop the process.  If ``--tls-auth`` or ``--tls-c=
rypt``
   is used, only attackers that have the ``--tls-auth`` or ``--tls-crypt`` =
key
   can mount an attack. (OSTIF/Quarkslab audit finding 5.1, CVE-2017-7478)
+- Fix an authenticated remote DoS vulnerability that could be triggered by
+  causing a packet id roll over.  An attack is rather inefficient; a peer
+  would need to get us to send at least about 196 GB of data.
+  (OSTIF/Quarkslab audit finding 5.2, CVE-2017-7479)
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index f5250ac..50e6a73 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -93,7 +93,11 @@ openvpn_encrypt_aead(struct buffer *buf, struct buffer w=
ork,
         buf_set_write(&iv_buffer, iv, iv_len);
=20
         /* IV starts with packet id to make the IV unique for packet */
-        ASSERT(packet_id_write(&opt->packet_id.send, &iv_buffer, false, fa=
lse));
+        if (!packet_id_write(&opt->packet_id.send, &iv_buffer, false, fals=
e))
+        {
+            msg(D_CRYPT_ERRORS, "ENCRYPT ERROR: packet ID roll over");
+            goto err;
+        }
=20
         /* Remainder of IV consists of implicit part (unique per session) =
*/
         ASSERT(buf_write(&iv_buffer, ctx->implicit_iv, ctx->implicit_iv_le=
n));
@@ -191,11 +195,13 @@ openvpn_encrypt_v1(struct buffer *buf, struct buffer =
work,
                 prng_bytes(iv_buf, iv_size);
=20
                 /* Put packet ID in plaintext buffer */
-                if (packet_id_initialized(&opt->packet_id))
+                if (packet_id_initialized(&opt->packet_id)
+                    && !packet_id_write(&opt->packet_id.send, buf,
+                                        opt->flags & CO_PACKET_ID_LONG_FOR=
M,
+                                        true))
                 {
-                    ASSERT(packet_id_write(&opt->packet_id.send, buf,
-                                           opt->flags & CO_PACKET_ID_LONG_=
FORM,
-                                           true));
+                    msg(D_CRYPT_ERRORS, "ENCRYPT ERROR: packet ID roll ove=
r");
+                    goto err;
                 }
             }
             else if (cipher_kt_mode_ofb_cfb(cipher_kt))
@@ -251,11 +257,12 @@ openvpn_encrypt_v1(struct buffer *buf, struct buffer =
work,
         }
         else                            /* No Encryption */
         {
-            if (packet_id_initialized(&opt->packet_id))
+            if (packet_id_initialized(&opt->packet_id)
+                && !packet_id_write(&opt->packet_id.send, buf,
+                                    opt->flags & CO_PACKET_ID_LONG_FORM, t=
rue))
             {
-                ASSERT(packet_id_write(&opt->packet_id.send, buf,
-                        BOOL_CAST(opt->flags & CO_PACKET_ID_LONG_FORM),
-                        true));
+                msg(D_CRYPT_ERRORS, "ENCRYPT ERROR: packet ID roll over");
+                goto err;
             }
             if (ctx->hmac)
             {
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index 5175fb0..10fe402 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -325,27 +325,37 @@ packet_id_read(struct packet_id_net *pin, struct buff=
er *buf, bool long_form)
     return true;
 }
=20
-static void
+static bool
 packet_id_send_update(struct packet_id_send *p, bool long_form)
 {
     if (!p->time)
     {
         p->time =3D now;
     }
-    p->id++;
-    if (!p->id)
+    if (p->id =3D=3D PACKET_ID_MAX)
     {
-        ASSERT(long_form);
+        /* Packet ID only allowed to roll over if using long form and time=
 has
+         * moved forward since last roll over.
+         */
+        if (!long_form || now <=3D p->time)
+        {
+            return false;
+        }
         p->time =3D now;
-        p->id =3D 1;
+        p->id =3D 0;
     }
+    p->id++;
+    return true;
 }
=20
 bool
 packet_id_write(struct packet_id_send *p, struct buffer *buf, bool long_fo=
rm,
         bool prepend)
 {
-    packet_id_send_update(p, long_form);
+    if (!packet_id_send_update(p, long_form))
+    {
+        return false;
+    }
=20
     const packet_id_type net_id =3D htonpid(p->id);
     const net_time_t net_time =3D htontime(p->time);
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index 109e56a..aceacf8 100644
--- a/src/openvpn/packet_id.h
+++ b/src/openvpn/packet_id.h
@@ -50,6 +50,7 @@
  * to for network transmission.
  */
 typedef uint32_t packet_id_type;
+#define PACKET_ID_MAX UINT32_MAX
 typedef uint32_t net_time_t;
=20
 /*
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index e47d25c..7f59b1d 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -98,7 +98,11 @@ tls_crypt_wrap(const struct buffer *src, struct buffer *=
dst,
          format_hex(BPTR(src), BLEN(src), 80, &gc));
=20
     /* Get packet ID */
-    ASSERT(packet_id_write(&opt->packet_id.send, dst, true, false));
+    if (!packet_id_write(&opt->packet_id.send, dst, true, false))
+    {
+        msg(D_CRYPT_ERRORS, "TLS-CRYPT ERROR: packet ID roll over.");
+        goto err;
+    }
=20
     dmsg(D_PACKET_CONTENT, "TLS-CRYPT WRAP AD: %s",
          format_hex(BPTR(dst), BLEN(dst), 0, &gc));
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/o=
penvpn/test_packet_id.c
index 5627a5b..0a785ad 100644
--- a/tests/unit_tests/openvpn/test_packet_id.c
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -129,8 +129,7 @@ test_packet_id_write_short_wrap(void **state)
     struct test_packet_id_write_data *data =3D *state;
=20
     data->pis.id =3D ~0;
-    expect_assert_failure(
-            packet_id_write(&data->pis, &data->test_buf, false, false));
+    assert_false(packet_id_write(&data->pis, &data->test_buf, false, false=
));
 }
=20
 static void
@@ -139,8 +138,16 @@ test_packet_id_write_long_wrap(void **state)
     struct test_packet_id_write_data *data =3D *state;
=20
     data->pis.id =3D ~0;
+    data->pis.time =3D 5006;
+
+    /* Write fails if time did not change */
+    now =3D 5006;
+    assert_false(packet_id_write(&data->pis, &data->test_buf, true, false)=
);
+
+    /* Write succeeds if time moved forward */
     now =3D 5010;
     assert_true(packet_id_write(&data->pis, &data->test_buf, true, false));
+
     assert(data->pis.id =3D=3D 1);
     assert(data->pis.time =3D=3D now);
     assert_true(data->test_buf_data.buf_id =3D=3D htonl(1));
--=20
2.7.4


