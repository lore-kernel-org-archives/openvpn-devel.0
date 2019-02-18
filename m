From: Hilko Bengen <bengen@...2496...>
Date: Mon, 18 Feb 2019 16:31:28 +0100
Message-Id: <20190218153129.3818-1-bengen@...2496...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Do not set pkcs11-helper "safe fork mode"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From the pkcs11-helper API documentation about pkcs11h_setForkMode():

> This funciton is releavant if PKCS11H_FEATURE_MASK_THREADING is
> set. If safe mode is on, the child process can use the loaded
> PKCS#11 providers but it cannot use fork(), while it is in one of
> the hooks functions, since locked mutexes cannot be released.

As far as I can tell, pkcs11-helper functionality is not used in a
child process that is created after initialization. Even if OpenVPN is
turned into a daemon, the pkcs11-helper library is only initialized
after calling possibly_become_daemon(), i.e. in the child process. All
other uses of fork() are immediately followed by an exec()

This simple change fixes the symptoms described in both
<https://community.openvpn.net/openvpn/ticket/538> (hang on password
prompt when systemd support is enabled) and
<https://community.openvpn.net/openvpn/ticket/1157> (hang on
initialization with newer versions of pkcs11-helper).

I have successfully tested that this makes the described symptoms go
away. For this, I used a YubiKey NEO on Debian/stable, a rebuild of
OpenVPN 2.4.6 and two versions of libpkcs11-helper:

- libpkcs11-helper 1.21-1 from Debian/stretch
- a backport of libpkcs11-helper 1.25-1 from Debian/buster
---
 src/openvpn/pkcs11.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index 93f8580a..d40ca458 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -312,7 +312,7 @@ pkcs11_initialize(
 
     pkcs11h_setLogLevel(_pkcs11_msg_openvpn2pkcs11(get_debug_level()));
 
-    if ((rv = pkcs11h_setForkMode(TRUE)) != CKR_OK)
+    if ((rv = pkcs11h_setForkMode(FALSE)) != CKR_OK)
     {
         msg(M_FATAL, "PKCS#11: Cannot set fork mode %ld-'%s'", rv, pkcs11h_getMessage(rv));
         goto cleanup;
-- 
2.20.1


