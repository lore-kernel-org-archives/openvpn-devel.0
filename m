From: Patrick Cervicek <patrick.openvpn@...1046...>
Date: Sun, 02 Sep 2007 17:22:52 +0200
Message-ID: <fbeke8$h83$1@...165...>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050308000009000704040909"
Sender: news <news@...165...>
Subject: [Openvpn-devel] [patch] Log serial number of a client certificate
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------050308000009000704040909
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

On July, I asked on the user-list how to obtain the certificate serial 
number of an active client:

http://thread.gmane.org/gmane.network.openvpn.user/19913

just in case sombody needs it, you'll find a two-line-patch underneath. 
I get now in my log:
VERIFY OK: depth=0, serial=79, 
emailAddress=pace/C=DE/ST=BW/L=Esslingen/O=Esslingen/OU=RZ/CN=OpenVPN2

It looks to work with openssl-issued-certificates, but shows always "-1" 
  with MS-certificateservices-issued-certificates (at least at me). The 
reason could be the strange serialnumber (e.g. 
"25:87:30:51:00:03:00:00:1e:e5") given out by MS.

Patrick

--------------050308000009000704040909
Content-Type: text/plain;
 name="openvpn_serial-log.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openvpn_serial-log.diff"

--- ssl.c.orig  2007-09-02 16:42:32.000000000 +0200
+++ ssl.c       2007-09-02 16:32:58.000000000 +0200
@@ -753,8 +753,8 @@
       if (!retval)
        goto err;
     }
-
-  msg (D_HANDSHAKE, "VERIFY OK: depth=%d, %s", ctx->error_depth, subject);
+  long serial = ASN1_INTEGER_get (X509_get_serialNumber (ctx->current_cert));
+  msg (D_HANDSHAKE, "VERIFY OK: depth=%d, serial=%ld, %s", ctx->error_depth, serial, subject);

   session->verified = true;
   return 1;                    /* Accept connection */

--------------050308000009000704040909--


