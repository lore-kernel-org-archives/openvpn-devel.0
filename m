Date: Tue, 27 Jan 2009 14:57:10 +0100
From: Jos Vos <jos@...1120...>
Message-ID: <20090127135710.GA28793@...1119...>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
Subject: [Openvpn-devel] OpenVPN 2.1_rc15 GCC 2.96 incompatibility
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

While there were some incompatibilities with older GCC releases
resolved from RC9 to RC15 (I didn't try the releases RC10-RC14),
a new incompatibility was introduced concerning the C preprocessor
in ssl.c: #ifdef's in macro calls do not seem to be allowed with
GCC 2.96.

Attached a brute-force patch to fix that.  This patch was tested
on Red Hat Linux 7.3 with GCC 2.96.

Regards,

-- 
--    Jos Vos <jos@...1120...>
--    X/OS Experts in Open Systems BV   |   Phone: +31 20 6938364
--    Amsterdam, The Netherlands        |     Fax: +31 20 6948204

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="openvpn-2.1_rc15-gcc296.patch"

--- openvpn-2.1_rc15/ssl.c.orig	Tue Nov 18 03:57:27 2008
+++ openvpn-2.1_rc15/ssl.c	Tue Jan 27 14:21:02 2009
@@ -3398,14 +3398,17 @@
 	    
 	  if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME))
 	    set_common_name (session, up->username);
-	  msg (D_HANDSHAKE, "TLS: Username/Password authentication %s for username '%s' %s",
 #ifdef ENABLE_DEF_AUTH
+	  msg (D_HANDSHAKE, "TLS: Username/Password authentication %s for username '%s' %s",
 	       ks->auth_deferred ? "deferred" : "succeeded",
+	       up->username,
+	       (session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME) ? "[CN SET]" : "");
 #else
+	  msg (D_HANDSHAKE, "TLS: Username/Password authentication %s for username '%s' %s",
 	       "succeeded",
-#endif
 	       up->username,
 	       (session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME) ? "[CN SET]" : "");
+#endif
 	}
       else
 	{

--FL5UXtIhxfXey3p5--

