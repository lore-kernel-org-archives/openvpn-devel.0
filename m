Message-ID: <40E18559.8020407@...244...>
From: Jan Kiszka <kiszka@...244...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070607000601090907020700"
Subject: [Openvpn-devel] [Patch] revoke scripts were broken
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
Date: Wed Jun 30 06:45:03 2004
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------070607000601090907020700
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

here is a tiny patch to make revoke-crt and make-crl work seamlessly 
within the easy-rsa environment. Seems that no one used it before ;)

Jan


PS: Has anyone ever thought about some small GUI (taskbar icon with some 
dialogs) for Windows, KDE, etc. to make the handling of multiple 
configurations and the status display easier in a roadwarrior scenario? 
Just a thought, I'm not saying I have the time for doing it - unfortunately.

[If you reply, please add a CC, I'm not on the list]

--------------070607000601090907020700
Content-Type: text/plain;
 name="revoke.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="revoke.patch"

diff -Nur /tmp/openvpn-2.0_beta6/easy-rsa/make-crl openvpn-2.0_beta6/easy-rsa/make-crl
--- /tmp/openvpn-2.0_beta6/easy-rsa/make-crl	2004-06-15 02:01:13.000000000 +0200
+++ openvpn-2.0_beta6/easy-rsa/make-crl	2004-06-29 16:50:09.836098144 +0200
@@ -12,7 +12,7 @@
 
 if test $KEY_DIR; then
        cd $KEY_DIR && \
-       openssl ca -gencrl -out $1
+       openssl ca -gencrl -out $1 -config $KEY_CONFIG
 else
        echo you must define KEY_DIR
 fi
diff -Nur /tmp/openvpn-2.0_beta6/easy-rsa/revoke-crt openvpn-2.0_beta6/easy-rsa/revoke-crt
--- /tmp/openvpn-2.0_beta6/easy-rsa/revoke-crt	2004-06-15 02:01:13.000000000 +0200
+++ openvpn-2.0_beta6/easy-rsa/revoke-crt	2004-06-29 16:50:21.703294056 +0200
@@ -12,7 +12,7 @@
 
 if test $KEY_DIR; then
        cd $KEY_DIR && \
-       openssl ca -revoke $1
+       openssl ca -revoke $1 -config $KEY_CONFIG
 else
        echo you must define KEY_DIR
 fi

--------------070607000601090907020700--

