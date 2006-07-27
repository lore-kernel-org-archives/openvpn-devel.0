Message-ID: <44C80C25.5020905@...714...>
Date: Wed, 26 Jul 2006 17:43:17 -0700
From: Jason Whitlark <jwhitlark@...714...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070408060909060305040708"
Subject: [Openvpn-devel] patch for revoke-full to deal with missing *.crt
	file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------070408060909060305040708
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all,

I ran into this problem and decided to do something about it.  This
patch checks to ensure that $user.crt exists in the keys directory, and
if it does not, checks the *.pem files, asks the user if  they want to
copy the pem file into the crt file before revoking the certificate.

The patch is against /openvpn/easy-rsa/revoke-full 1.1.2.1 out of cvs.

Please let me know if you think it needs any reworking.

Thanks,

~jwhitlark

--------------070408060909060305040708
Content-Type: text/plain;
 name="revoke-full-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="revoke-full-patch"

--- ../revoke-full	2006-07-25 10:43:47.000000000 -0700
+++ my-revoke-full	2006-07-26 17:26:59.000000000 -0700
@@ -3,6 +3,7 @@
 # revoke a certificate, regenerate CRL,
 # and verify revocation
 
+
 CRL=crl.pem
 RT=revoke-test.pem
 
@@ -14,6 +15,39 @@
 if test $KEY_DIR; then
        cd $KEY_DIR
        rm -f $RT
+       
+       # if $.crt does not exist, see if a *.pem file seems to match
+       # if a match is found, ask the user if they want to use the match
+       # if they want to use the *.pem file, cp it to username.crt
+       # else exit with error
+
+       if ! [ -f $1.crt ]
+           then
+           if userpem=`grep -l $1 *.pem`
+               then 
+               while : ; do
+                   echo "$1.crt does not exist, but $userpem seems to be an archive copy.  Do you want to use $userpem (y or n)"
+                   read ANSWER JUNK
+    
+                   case "$ANSWER" in
+                       [yY]*)
+                       cpPemToCrt=0
+                       break
+                       ;;
+                       [nN]*)
+                       cpPemToCrt=1
+                       break
+                       ;;
+                       *)
+                   esac
+               done
+               
+               if [ $cpPemToCrt = 0 ];
+                   then
+                   cp $userpem $1.crt
+               fi
+           fi
+       fi
 
        # revoke key and generate a new CRL
        openssl ca -revoke $1.crt -config $KEY_CONFIG

--------------070408060909060305040708--

