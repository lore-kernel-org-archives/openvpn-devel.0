From: Arne Schwabe <arne@...1227...>
Date: Tue, 16 Feb 2016 13:04:40 +0100
Message-Id: <1455624280-3165-1-git-send-email-arne@...1227...>
In-Reply-To: <1451730139-25563-1-git-send-email-arne@...1227...>
References: <1451730139-25563-1-git-send-email-arne@...1227...>
References: 1451730139-25563-1-git-send-email-arne@...1227...
Subject: [Openvpn-devel] [PATCHv2] Complete push-peer-info documentation and
	allow IV_PLAT_VER for other platforms than Windows if the
	client UI supplies it.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 5a4efc6..d99aaf5 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2952,16 +2952,41 @@ configuration file.  This option will ignore
 options at the global config file level.
 .TP
 .B \-\-push\-peer\-info
-Push additional information about the client to server.  The additional information
-consists of the following data:
+Push additional information about the client to server. The following data is always pushed to
+the server.
 
 IV_VER=<version> -- the client OpenVPN version
 
 IV_PLAT=[linux|solaris|openbsd|mac|netbsd|freebsd|win] -- the client OS platform
 
+IV_LZO_STUB=1 -- if client was built with LZO stub capability
+
+IV_LZ4=1 -- if the client supports LZ4 compressions.
+
+IV_RGI6=1 -- if the client supports
+.B \-\-redirect\-gateway
+for ipv6
+
+IV_PROTO=2 -- if the client supports peer-id floating mechansim
+
+IV_NCP=2 -- negotiable ciphers, client supports
+.B \-\-cipher
+pushed by the server, a value of 2 or greater indidactes additional
+support AES-GCM-128 and AES-GCM-256.
+
+IV_UI_VER=<gui_id> <version> -- the UI version of a UI if one is
+running, for example "de.blinkt.openvpn 0.5.47" for the
+Android app.
+
+When
+.B \-\-push\-peer\-info
+is enabled the additional information consists of the following data:
+
 IV_HWADDR=<mac address> -- the MAC address of clients default gateway
 
-IV_LZO_STUB=1 -- if client was built with LZO stub capability
+IV_SSL=<version string> -- the ssl version used by the client, e.g. "OpenSSL 1.0.2f 28 Jan 2016".
+
+IV_PLAT_VER=x.y - the version of the operating system, e.g. 6.1 for Windows 7.
 
 UV_<name>=<value> -- client environment variables whose names start with "UV_"
 .\"*********************************************************
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index f188558..14da733 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1903,15 +1903,17 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
 #endif
         }
 
-      /* push env vars that begin with UV_ and IV_GUI_VER */
+      /* push env vars that begin with UV_, IV_PLAT_VER and IV_GUI_VER */
       for (e=es->list; e != NULL; e=e->next)
 	{
 	  if (e->string)
 	    {
-	      if (((strncmp(e->string, "UV_", 3)==0 && session->opt->push_peer_info_detail >= 2)
-		   || (strncmp(e->string,"IV_GUI_VER=",sizeof("IV_GUI_VER=")-1)==0))
-		  && buf_safe(&out, strlen(e->string)+1))
-		buf_printf (&out, "%s\n", e->string);
+            if ((((strncmp(e->string, "UV_", 3)==0 ||
+                   strncmp(e->string, "IV_PLAT_VER=", sizeof("IV_PLAT_VER=")-1)==0)
+                  && session->opt->push_peer_info_detail >= 2)
+                 || (strncmp(e->string,"IV_GUI_VER=", sizeof("IV_GUI_VER=")-1)==0))
+                && buf_safe(&out, strlen(e->string)+1))
+                buf_printf (&out, "%s\n", e->string);
 	    }
 	}
 
-- 
2.5.4 (Apple Git-61)


