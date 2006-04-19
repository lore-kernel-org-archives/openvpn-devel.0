From: Philipp =?iso-8859-1?q?G=FChring?= <pg@...621...>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_TylREUwHqdHTtRI"
Message-Id: <200604191751.47736.pg@...621...>
Subject: [Openvpn-devel] PKCS#12+additional CAs
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Apr 19 08:53:04 2006
To: openvpn-devel@lists.sourceforge.net

--Boundary-00=_TylREUwHqdHTtRI
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

At the moment, openVPN is unnecessarily blocking the usage of both PKCS#12=
=20
certificate and additional CA=B4s provided in PEM files.
This is a patch for openVPN, to make it possible to use both PKCS#12 and=20
additonal CA=B4s for verification.

PS: Please CC me on any answers.=20

Best regards,
Philipp G=FChring

--Boundary-00=_TylREUwHqdHTtRI
Content-Type: text/x-diff;
  charset="us-ascii";
  name="pkcs12ca.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pkcs12ca.patch"

--- options.c.orig	2006-01-10 16:46:50.000000000 +0100
+++ options.c	2006-01-10 16:47:11.000000000 +0100
@@ -1582,8 +1582,8 @@
 #endif
       if (options->pkcs12_file)
         {
-          if (options->ca_file)
-	    msg(M_USAGE, "Parameter --ca cannot be used when --pkcs12 is also specified.");
+//          if (options->ca_file)
+//	    msg(M_USAGE, "Parameter --ca cannot be used when --pkcs12 is also specified.");
           if (options->cert_file)
 	    msg(M_USAGE, "Parameter --cert cannot be used when --pkcs12 is also specified.");
           if (options->priv_key_file)
--- ssl.c.orig	2005-11-01 12:06:10.000000000 +0100
+++ ssl.c	2006-01-10 16:48:45.000000000 +0100
@@ -842,6 +842,24 @@
                 msg (M_SSLERR, "Cannot add certificate to client CA list (SSL_CTX_add_client_CA)");
             }
         }
+
+      /* Load CA file for verifying peer supplied certificate */
+      if(options->ca_file)
+      {
+        if (!SSL_CTX_load_verify_locations (ctx, options->ca_file, NULL))
+          msg (M_SSLERR, "Cannot load CA certificate file %s (SSL_CTX_load_verify_locations)", options->ca_file);
+
+        /* Load names of CAs from file and use it as a client CA list */
+        {
+          STACK_OF(X509_NAME) *cert_names;
+          cert_names = SSL_load_client_CA_file (options->ca_file);
+          if (!cert_names)
+            msg (M_SSLERR, "Cannot load CA certificate file %s (SSL_load_client_CA_file)", options->ca_file);
+          SSL_CTX_set_client_CA_list (ctx, cert_names);
+        }
+      }
+
+
     }
   else
     {

--Boundary-00=_TylREUwHqdHTtRI--


