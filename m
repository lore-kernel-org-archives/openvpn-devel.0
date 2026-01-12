From: Gert Doering <gert@...1296...>
Date: Mon, 12 Jan 2026 18:11:12 +0100
Message-ID: <20260112171122.3994-1-gert@...1296...>
In-Reply-To: <gerrit.1768227561000.I0aca7e7d9aa190541f11745cf72193cb6b39540a@...2715...>
References: <gerrit.1768227561000.I0aca7e7d9aa190541f11745cf72193cb6b39540a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] socks: Replace magic "10" for socks
 header with macro
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

From: Frank Lichtenheld <frank@...2641...>

So that it is easier to check that we indeed
have reserved this prior to assuming we have.

Github: openvpn-private-issues#4
Change-Id: I0aca7e7d9aa190541f11745cf72193cb6b39540a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1467
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1467
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index b690dff..4c23170 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2927,7 +2927,7 @@
     headroom += 4;
 
     /* socks proxy header */
-    headroom += 10;
+    headroom += SOCKS_UDPv4_HEADROOM;
 
     /* compression header and fragment header (part of the encrypted payload) */
     headroom += 1 + 1;
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 67ae67f..e5db8ab 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -66,11 +66,11 @@
 
     bool tlsmode = options->tls_server || options->tls_client;
 
-    /* A socks proxy adds 10 byte of extra header to each packet
+    /* A socks proxy adds extra header to each packet
      * (we only support Socks with IPv4, this value is different for IPv6) */
     if (options->ce.socks_proxy_server && proto_is_udp(options->ce.proto))
     {
-        header_size += 10;
+        header_size += SOCKS_UDPv4_HEADROOM;
     }
 
     /* TCP stream based packets have a 16 bit length field */
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index 29a7d04..ca8109c 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -94,6 +94,11 @@
  */
 #define PAYLOAD_ALIGN 4
 
+/*
+ * How many bytes we prepend for a SOCKS UDP proxy.
+ * This only handles IPv4 right now.
+ */
+#define SOCKS_UDPv4_HEADROOM 10
 
 /**************************************************************************/
 /**
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 1e99c9a..078b4e1 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -434,7 +434,7 @@
 }
 
 /*
- * Remove the 10 byte socks5 header from an incoming
+ * Remove the socks5 header from an incoming
  * UDP packet, setting *from to the source address.
  *
  * Run after UDP read.
@@ -444,7 +444,7 @@
 {
     int atyp;
 
-    if (BLEN(buf) < 10)
+    if (BLEN(buf) < SOCKS_UDPv4_HEADROOM)
     {
         goto error;
     }
@@ -471,7 +471,7 @@
 }
 
 /*
- * Add a 10 byte socks header prior to UDP write.
+ * Add a socks header prior to UDP write.
  * *to is the destination address.
  *
  * Run before UDP write.
@@ -481,11 +481,11 @@
 socks_process_outgoing_udp(struct buffer *buf, const struct link_socket_actual *to)
 {
     /*
-     * Get a 10 byte subset buffer prepended to buf --
+     * Get a subset buffer prepended to buf --
      * we expect these bytes will be here because
      * we always allocate space for these bytes
      */
-    struct buffer head = buf_sub(buf, 10, true);
+    struct buffer head = buf_sub(buf, SOCKS_UDPv4_HEADROOM, true);
 
     /* crash if not enough headroom in buf */
     ASSERT(buf_defined(&head));
@@ -496,5 +496,5 @@
     buf_write(&head, &to->dest.addr.in4.sin_addr, sizeof(to->dest.addr.in4.sin_addr));
     buf_write(&head, &to->dest.addr.in4.sin_port, sizeof(to->dest.addr.in4.sin_port));
 
-    return 10;
+    return SOCKS_UDPv4_HEADROOM;
 }

