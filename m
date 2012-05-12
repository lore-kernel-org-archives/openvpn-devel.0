Message-ID: <4FAE87C1.6000509@...277...>
Date: Sat, 12 May 2012 11:54:41 -0400
From: Simon Deziel <simon.deziel@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Properly detect OpenSSL version strings
	with numbers only
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

whichopensslcnf failed to return the right cnf for:

$ openssl version
OpenSSL 1.0.1 14 Mar 2012

Signed-off-by: Simon Deziel <simon.deziel@...277...>
---
 easy-rsa/2.0/whichopensslcnf |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/easy-rsa/2.0/whichopensslcnf b/easy-rsa/2.0/whichopensslcnf
index 2226a8e..ccdaf50 100755
--- a/easy-rsa/2.0/whichopensslcnf
+++ b/easy-rsa/2.0/whichopensslcnf
@@ -3,11 +3,11 @@
 cnf="$1/openssl.cnf"

 if [ "$OPENSSL" ]; then
-       if $OPENSSL version | grep -E "0\.9\.6[[:alnum:]]" > /dev/null; then
+       if $OPENSSL version | grep -E "0\.9\.6[[:alnum:]]?" > /dev/null;
then
                cnf="$1/openssl-0.9.6.cnf"
-       elif $OPENSSL version | grep -E "0\.9\.8[[:alnum:]]" >
/dev/null; then
+       elif $OPENSSL version | grep -E "0\.9\.8[[:alnum:]]?" >
/dev/null; then
                cnf="$1/openssl-0.9.8.cnf"
-       elif $OPENSSL version | grep -E "1\.0\.([[:digit:]][[:alnum:]])"
> /dev/null; then
+       elif $OPENSSL version | grep -E "1\.0\.[[:digit:]][[:alnum:]]?"
> /dev/null; then
                 cnf="$1/openssl-1.0.0.cnf"
        else
                cnf="$1/openssl.cnf"
-- 
1.7.5.4

