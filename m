Date: Tue, 27 May 2008 13:22:15 +0200
From: Uwe Hermann <uwe@...1102...>
Sender: Uwe Hermann <uwe@...1102...>
Message-ID: <20080527112215.GB18901@...1103...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5p8PegU4iirBW1oA"
Content-Disposition: inline
Subject: [Openvpn-devel] [PATCH] easy-rsa: Make revoke-full work when
	engine_pkcs11 not	installed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--5p8PegU4iirBW1oA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I've been playing a bit with openvpn lately and noticed that the
'revoke-full' script in easy-rsa/2.0 (openvpn 2.1~rc7-2 from Debian,
but current svn BETA21 branch seems to have the same problem) is
not working correctly in the default settings when the user doesn't
have engine_pkcs11 stuff installed.

$ . vars
$ ./revoke-full foo
Using configuration from /etc/openvpn/easy-rsa/openssl.cnf
error on line 282 of config file '/etc/openvpn/easy-rsa/openssl.cnf'
17264:error:0E065068:configuration file routines:STR_COPY:variable has no value:conf_def.c:629:line 282
Using configuration from /etc/openvpn/easy-rsa/openssl.cnf
error on line 282 of config file '/etc/openvpn/easy-rsa/openssl.cnf'
17265:error:0E065068:configuration file routines:STR_COPY:variable has no value:conf_def.c:629:line 282
foo.crt: XXXXXXXX
error 3 at 0 depth lookup:unable to get certificate CRL


After patching openssl.cnf (see below):

$ ./revoke-full foo
Using configuration from /etc/openvpn/easy-rsa/openssl.cnf
Revoking Certificate 02.
Data Base Updated
Using configuration from /etc/openvpn/easy-rsa/openssl.cnf
foo.crt: XXXXXXXX
error 23 at 0 depth lookup:certificate revoked


What I did to work around this problem was to locally comment the following
lines in openssl.cnf (lines 279-284 in svn as of r2835).

# [ pkcs11_section ]
# engine_id = pkcs11
# dynamic_path = /usr/lib/engines/engine_pkcs11.so
# MODULE_PATH = $ENV::PKCS11_MODULE_PATH
# PIN = $ENV::PKCS11_PIN
# init = 0

See also attached patch.


Another issue is the
  error 3 at 0 depth lookup:unable to get certificate CRL
and
  error 23 at 0 depth lookup:certificate revoked
messages. Are those problematic? Looks like the second line
tells me that the key was successfully revoked. If so,
starting the line with "error 23" is really confusing.


Thanks, Uwe.
-- 
http://www.hermann-uwe.de  | http://www.holsham-traders.de
http://www.crazy-hacks.org | http://www.unmaintained-free-software.org

--5p8PegU4iirBW1oA
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="easyrsa_revoke_full.patch"

Index: easy-rsa/2.0/openssl.cnf
===================================================================
--- easy-rsa/2.0/openssl.cnf	(revision 2975)
+++ easy-rsa/2.0/openssl.cnf	(working copy)
@@ -275,11 +275,11 @@
 # verify that dynamic_path points to the correct location
 #
 #pkcs11 = pkcs11_section
+#
+# [ pkcs11_section ]
+# engine_id = pkcs11
+# dynamic_path = /usr/lib/engines/engine_pkcs11.so
+# MODULE_PATH = $ENV::PKCS11_MODULE_PATH
+# PIN = $ENV::PKCS11_PIN
+# init = 0
 
-[ pkcs11_section ]
-engine_id = pkcs11
-dynamic_path = /usr/lib/engines/engine_pkcs11.so
-MODULE_PATH = $ENV::PKCS11_MODULE_PATH
-PIN = $ENV::PKCS11_PIN
-init = 0
-

--5p8PegU4iirBW1oA--

