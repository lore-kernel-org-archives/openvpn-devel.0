From: Nir Yeffet <nir@...336...>
Message-ID: <Pine.LNX.4.50.0501101115400.14482-100000@...336...>
MIME-Version: 1.0
Subject: [Openvpn-devel] bugfix: easy-rsa/build-key-server
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
Date: Mon Jan 10 01:23:07 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

The extension nsCertType "server" is only working if the -extensions 
server is specified when creating the csr and key.

diff -urN build-key-server.orig build-key-server 
--- build-key-server.orig       2005-01-10 11:08:20.000000000 +0200
+++ build-key-server    2005-01-10 11:09:19.000000000 +0200
@@ -14,7 +14,7 @@
 
 if test $KEY_DIR; then
        cd $KEY_DIR && \
-       openssl req -days 3650 -nodes -new -keyout $1.key -out $1.csr -config $KEY_CONFIG && \
+       openssl req -days 3650 -nodes -new -keyout $1.key -out $1.csr -extensions server -config $KEY_CONFIG && \
        openssl ca -days 3650 -out $1.crt -in $1.csr -extensions server -config $KEY_CONFIG
 else
        echo you must define KEY_DIR

Cheers,
-- 
Nir

