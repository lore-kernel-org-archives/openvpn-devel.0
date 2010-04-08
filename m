Message-ID: <4BBE2D0E.4010106@...1114...>
Date: Thu, 08 Apr 2010 21:22:54 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020906010303050205010204"
Subject: [Openvpn-devel] [PATCH] Make use of counter_type instead of int
 when counting bytes and network packets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------020906010303050205010204
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This is in response to a reported Debian bug, where the connection
counter overflows.
<http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=576827>

Signed-off-by: David Sommerseth <dazo@...384...>
- ---
 ssl.c |    3 ++-
 ssl.h |    4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAku+LQ4ACgkQDC186MBRfrpafwCfTukA6Sck9ya7N9+miRq8vD7e
+1cAoJEnTjfdrEJAy+KDDq4pgWqTKkeW
=a8Yb
-----END PGP SIGNATURE-----

--------------020906010303050205010204
Content-Type: text/plain;
	name="0001-Make-use-of-counter_type-instead-of-int-when-countin.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-Make-use-of-counter_type-instead-of-int-when-countin.pa";
	filename*1="tch"

From 5c383c4445598cddaaf9b0568065e07dc1275c4e Mon Sep 17 00:00:00 2001
From: David Sommerseth <dazo@...384...>
Date: Thu, 8 Apr 2010 21:18:42 +0200
Subject: [PATCH] Make use of counter_type instead of int when counting bytes and network packets

This is in response to a reported Debian bug, where the connection counter overflows.
<http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=576827>

Signed-off-by: David Sommerseth <dazo@...384...>
---
 ssl.c |    3 ++-
 ssl.h |    4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/ssl.c b/ssl.c
index 1b275af..ddd5ee7 100644
--- a/ssl.c
+++ b/ssl.c
@@ -3747,7 +3747,8 @@ tls_process (struct tls_multi *multi,
 	   && ks->n_packets >= session->opt->renegotiate_packets)
        || (packet_id_close_to_wrapping (&ks->packet_id.send))))
     {
-      msg (D_TLS_DEBUG_LOW, "TLS: soft reset sec=%d bytes=%d/%d pkts=%d/%d",
+      msg (D_TLS_DEBUG_LOW,
+           "TLS: soft reset sec=%d bytes=" counter_format "/%d pkts=" counter_format "/%d",
 	   (int)(ks->established + session->opt->renegotiate_seconds - now),
 	   ks->n_bytes, session->opt->renegotiate_bytes,
 	   ks->n_packets, session->opt->renegotiate_packets);
diff --git a/ssl.h b/ssl.h
index 9737f26..f3f76c4 100644
--- a/ssl.h
+++ b/ssl.h
@@ -376,8 +376,8 @@ struct key_state
   struct reliable *rec_reliable;  /* order incoming ciphertext packets before we pass to TLS */
   struct reliable_ack *rec_ack;	  /* buffers all packet IDs we want to ACK back to sender */
 
-  int n_bytes;			 /* how many bytes sent/recvd since last key exchange */
-  int n_packets;		 /* how many packets sent/recvd since last key exchange */
+  counter_type n_bytes;		 /* how many bytes sent/recvd since last key exchange */
+  counter_type n_packets;	 /* how many packets sent/recvd since last key exchange */
 
   /*
    * If bad username/password, TLS connection will come up but 'authenticated' will be false.
-- 
1.6.6.1


--------------020906010303050205010204
Content-Type: application/pgp-signature;
	name="0001-Make-use-of-counter_type-instead-of-int-when-countin.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename*0="0001-Make-use-of-counter_type-instead-of-int-when-countin.pa";
	filename*1="tch.sig"

iEYEABECAAYFAku+LQ4ACgkQDC186MBRfro7VQCfQexF4ah2P+5layFcJNAxtJmbz9AAoJnP
xZr4NzEkEwQ9Tkx8hXmHBb+i
--------------020906010303050205010204--

