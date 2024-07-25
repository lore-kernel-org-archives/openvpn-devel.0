From: Gert Doering <gert@...1296...>
Date: Thu, 25 Jul 2024 13:22:48 +0200
Message-ID: <20240725112248.21075-1-gert@...1296...>
In-Reply-To: <gerrit.1721830475000.I975057c20c1457ef88111f8d142ca3fd2039d5ff@...2715...>
References: <gerrit.1721830475000.I975057c20c1457ef88111f8d142ca3fd2039d5ff@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] add and send IV_PROTO_DNS_OPTION_V2 flag
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

From: Heiko Hund <heiko@...2662...>

Incompatible changes to the --dns server address and --dns server
exclude-domains options were introduced after the code for handling them
was released. Add and send a new IV_PROTO flag, so servers which act on
the flags set can differentiate between clients which have implemented
--dns and those which just support the new option. This enables them to
decide which variant of options to send to the client.

Change-Id: I975057c20c1457ef88111f8d142ca3fd2039d5ff
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/680
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e0e9591..14c38cf 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1900,8 +1900,8 @@
         /* support for P_DATA_V2 */
         int iv_proto = IV_PROTO_DATA_V2;
 
-        /* support for the --dns option */
-        iv_proto |= IV_PROTO_DNS_OPTION;
+        /* support for the latest --dns option */
+        iv_proto |= IV_PROTO_DNS_OPTION_V2;
 
         /* support for exit notify via control channel */
         iv_proto |= IV_PROTO_CC_EXIT_NOTIFY;
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 1a45048..6c2bfc3 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -94,7 +94,7 @@
  * result. */
 #define IV_PROTO_NCP_P2P         (1<<5)
 
-/** Supports the --dns option introduced in version 2.6 */
+/** Supports the --dns option introduced in version 2.6. Not sent anymore. */
 #define IV_PROTO_DNS_OPTION      (1<<6)
 
 /** Support for explicit exit notify via control channel
@@ -107,6 +107,9 @@
 /** Support to dynamic tls-crypt (renegotiation with TLS-EKM derived tls-crypt key) */
 #define IV_PROTO_DYN_TLS_CRYPT   (1<<9)
 
+/** Supports the --dns option after all the incompatible changes */
+#define IV_PROTO_DNS_OPTION_V2   (1<<11)
+
 /* Default field in X509 to be username */
 #define X509_USERNAME_FIELD_DEFAULT "CN"
 

