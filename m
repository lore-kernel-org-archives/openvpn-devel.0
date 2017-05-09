Resent-To: "openvpn-devel@lists.sourceforge.net"
	<openvpn-devel@lists.sourceforge.net>
Resent-Message-ID: <48c4450b-6b37-fe09-ba55-7c91dfd33599@...2162...>
From: Steffan Karger <steffan.karger@...1435...>
Date: Tue, 9 May 2017 21:30:07 +0200
Message-ID: <1494358209-4568-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH (release/2.3)] Drop packets instead of
	assert out if packet id rolls over (CVE-2017-7479)
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
 Changes.rst                               | 10 ++++++++++
 src/openvpn/crypto.c                      | 18 +++++++++++++-----
 src/openvpn/packet_id.c                   | 22 ++++++++++++++++------
 src/openvpn/packet_id.h                   |  1 +
 tests/unit_tests/openvpn/test_packet_id.c | 11 +++++++++--
 5 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 1c0154c..183e9fa 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -104,6 +104,16 @@ Behavioral changes
=20
 - Do not randomize resolving of IP addresses in getaddr()
=20
+Version 2.3.15
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Security fixes
+--------------
+- Fix an authenticated remote DoS vulnerability that could be triggered by
+  causing a packet id roll over.  An attack is rather inefficient; a peer
+  would need to get us to send at least about 196 GB of data.
+  (OSTIF/Quarkslab audit finding 5.2, CVE-2017-7479)
+
 Version 2.3.14
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index f153367..a2e213f 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -112,9 +112,11 @@ openvpn_encrypt (struct buffer *buf, struct buffer wor=
k,
 		prng_bytes (iv_buf, iv_size);
=20
 	      /* Put packet ID in plaintext buffer or IV, depending on cipher mod=
e */
-	      if (opt->packet_id)
+	      if (opt->packet_id
+		  && !packet_id_write (&opt->packet_id->send, buf, BOOL_CAST (opt->flags=
 & CO_PACKET_ID_LONG_FORM), true))
 		{
-		  ASSERT (packet_id_write (&opt->packet_id->send, buf, BOOL_CAST (opt->f=
lags & CO_PACKET_ID_LONG_FORM), true));
+		  msg (D_CRYPT_ERRORS, "ENCRYPT ERROR: packet ID roll over");
+		  goto err;
 		}
 	    }
 	  else if (cipher_kt_mode_ofb_cfb(cipher_kt))
@@ -126,7 +128,11 @@ openvpn_encrypt (struct buffer *buf, struct buffer wor=
k,
=20
 	      memset (iv_buf, 0, iv_size);
 	      buf_set_write (&b, iv_buf, iv_size);
-	      ASSERT (packet_id_write (&opt->packet_id->send, &b, true, false));
+	      if (!packet_id_write (&opt->packet_id->send, &b, true, false))
+		{
+		  msg (D_CRYPT_ERRORS, "ENCRYPT ERROR: packet ID roll over");
+		  goto err;
+		}
 	    }
 	  else /* We only support CBC, CFB, or OFB modes right now */
 	    {
@@ -185,9 +191,11 @@ openvpn_encrypt (struct buffer *buf, struct buffer wor=
k,
 	}
       else				/* No Encryption */
 	{
-	  if (opt->packet_id)
+	  if (opt->packet_id
+	      && !packet_id_write (&opt->packet_id->send, buf, BOOL_CAST (opt->fl=
ags & CO_PACKET_ID_LONG_FORM), true))
 	    {
-	      ASSERT (packet_id_write (&opt->packet_id->send, buf, BOOL_CAST (opt=
->flags & CO_PACKET_ID_LONG_FORM), true));
+	      msg (D_CRYPT_ERRORS, "ENCRYPT ERROR: packet ID roll over");
+	      goto err;
 	    }
 	  work =3D *buf;
 	}
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index c637be6..9af74a1 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -294,27 +294,37 @@ packet_id_read (struct packet_id_net *pin, struct buf=
fer *buf, bool long_form)
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
-  p->id++;
-  if (!p->id)
+  if (p->id =3D=3D PACKET_ID_MAX)
     {
-      ASSERT(long_form);
+      /* Packet ID only allowed to roll over if using long form and time h=
as
+       * moved forward since last roll over.
+       */
+      if (!long_form || now <=3D p->time)
+        {
+            return false;
+        }
       p->time =3D now;
-      p->id =3D 1;
+      p->id =3D 0;
     }
+    p->id++;
+    return true;
 }
=20
 bool
 packet_id_write (struct packet_id_send *p, struct buffer *buf, bool long_f=
orm,
         bool prepend)
 {
-  packet_id_send_update(p, long_form);
+  if (!packet_id_send_update(p, long_form))
+    {
+      return false;
+    }
=20
   const packet_id_type net_id =3D htonpid(p->id);
   const net_time_t net_time =3D htontime(p->time);
diff --git a/src/openvpn/packet_id.h b/src/openvpn/packet_id.h
index f6fa9bd..bfdfb77 100644
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
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/o=
penvpn/test_packet_id.c
index 3662e17..1ab3fd8 100644
--- a/tests/unit_tests/openvpn/test_packet_id.c
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -130,8 +130,7 @@ test_packet_id_write_short_wrap(void **state)
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
@@ -140,8 +139,16 @@ test_packet_id_write_long_wrap(void **state)
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


