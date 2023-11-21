From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 21 Nov 2023 11:39:30 +0100
Message-Id: <20231121103930.15175-1-frank@...2641...>
In-Reply-To: <gerrit.1700479678000.I6bdab3028c9bd679c31d4177a746a3ea505dcbbf@...2715...>
References: <gerrit.1700479678000.I6bdab3028c9bd679c31d4177a746a3ea505dcbbf@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Log SSL alerts more prominently
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

When we receive an SSL alert from a server we currently only log a
very cryptic OpenSSL error message:

   OpenSSL: error:0A00042E:SSL routines::tlsv1 alert protocol version:SSL alert number 70

This also enables logging the much more readable SSL error message:

   Received fatal SSL alert: protocol version

which previously needed --verb 8 to be displayed (now verb 3). Also rework the
message to be better readable.

Change-Id: I6bdab3028c9bd679c31d4177a746a3ea505dcbbf
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/448
This mail reflects revision 3 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 23e7623..82872bf 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -196,8 +196,8 @@
     }
     else if (where & SSL_CB_ALERT)
     {
-        dmsg(D_HANDSHAKE_VERBOSE, "SSL alert (%s): %s: %s",
-             where & SSL_CB_READ ? "read" : "write",
+        dmsg(D_TLS_DEBUG_LOW, "%s %s SSL alert: %s",
+             where & SSL_CB_READ ? "Received" : "Sent",
              SSL_alert_type_string_long(ret),
              SSL_alert_desc_string_long(ret));
     }

