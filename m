From: Waldemar Brodkorb <wbx@...270...>
Message-ID: <20050218200021.GA13369@...352...>
Mime-Version: 1.0
Subject: [Openvpn-devel] small issue
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
Date: Fri Feb 18 12:01:16 2005
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi,

small patch for rc14. If you use a stripped down version of openssl
and openvpn without support for MD4 and NTML you need this patch
to successfully compile. Needed for some embedded hardware.

--- openvpn-2.0_rc14/crypto.h 2005-01-10 01:46:08.000000000 +0100
+++ openvpn-2.0_rc14.patched/crypto.h 2005-02-18 20:06:20.000000000
+0100
@@ -42,7 +42,9 @@
 #include <openssl/hmac.h>
 #include <openssl/des.h>
 #include <openssl/md5.h>
+#if NTML
 #include <openssl/md4.h>
+#endif
 #include <openssl/sha.h>
 #include <openssl/err.h>


bye
    Waldemar

-- 
blog your mind!
http://openbsd-geek.de/

