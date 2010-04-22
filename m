From: Davide Brini <dave_br@...1278...>
Date: Thu, 22 Apr 2010 22:06:26 +0100
References: <20100422111337.7ABB521DCF7@...1353...>
	<201004221829.13824.dave_br@...1278...>
	<201004222153.28610.dave_br@...1278...>
In-Reply-To: <201004222153.28610.dave_br@...1278...>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_SpL0LCAHmU/aYQK"
Message-Id: <201004222206.26989.dave_br@...1278...>
Subject: Re: [Openvpn-devel] [PATCH-fixed] revocation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

--Boundary-00=_SpL0LCAHmU/aYQK
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit

On Thursday 22 April 2010, Davide Brini wrote:
> (moving to -devel as this is obviously pertains there more than -users)

Sorry, too quick! I posted an incomplete version of the patch. The attached 
one should be better.

The only doubt I have is about error handling; in this case, if the allocation 
of the BIO fails, an error message is logged and nothing is done. Is this the 
right thing to do?

-- 
D.

--Boundary-00=_SpL0LCAHmU/aYQK
Content-Type: text/x-patch; charset="UTF-8"; name="long_serial_numbers.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="long_serial_numbers.patch"

--- openvpn-2.1.1/ssl.c	2010-02-28 22:17:45.000000000 +0000
+++ openvpn-2.1.1-a/ssl.c	2010-04-22 22:03:40.000000000 +0100
@@ -788,9 +788,27 @@ verify_callback (int preverify_ok, X509_
 
   /* export serial number as environmental variable */
   {
-    const int serial = (int) ASN1_INTEGER_get (X509_get_serialNumber (ctx->current_cert));
+    BIO *bio = NULL;
+    char serial[1024] = {0};
+    int n;
+
+    if ((bio = BIO_new (BIO_s_mem ())) == NULL) {
+      msg (M_FATAL, "CALLBACK: Cannot create BIO");
+    }
+    else {
+      /* "prints" the serial number onto the BIO */
+      i2a_ASN1_INTEGER(bio, X509_get_serialNumber (ctx->current_cert));
+      n = BIO_read (bio, serial, sizeof (serial)-1);
+      if (n < 0) {
+        serial[0] = '\x0';
+      }
+      else {
+        serial[n] = 0;
+      }
+    
     openvpn_snprintf (envname, sizeof(envname), "tls_serial_%d", ctx->error_depth);
-    setenv_int (opt->es, envname, serial);
+      setenv_str (opt->es, envname, serial);
+    }
   }
 
   /* export current untrusted IP */

--Boundary-00=_SpL0LCAHmU/aYQK--

