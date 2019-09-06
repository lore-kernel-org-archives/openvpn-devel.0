From: Matthias Andree <matthias.andree@...68...>
Date: Fri,  6 Sep 2019 19:44:59 +0200
Message-Id: <20190906174458.14975-2-matthias.andree@...68...>
In-Reply-To: <20190906174458.14975-1-matthias.andree@...68...>
References: <20190906174458.14975-1-matthias.andree@...68...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] tests/t__lpback.sh: Switch sed(1) to
 POSIX-compatible regex.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net
Cc: kevans@...1376..., Matthias Andree <matthias.andree@...68...>

From: Kyle Evans <kevans@...1376...>

A test run with FreeBSD PR 229925 'Disallow escaping ordinary characters in=
 regex(3)'
reveals one sed expression that uses the GNU-extension "\s".
Given that this is the only occurrence and it's a trivial fix, update it to=
 be POSIX-compatible.

Signed-off-by: Matthias Andree <matthias.andree@...68...>
---
 tests/t_lpback.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/t_lpback.sh b/tests/t_lpback.sh
index 2052c626..bb8a1d51 100755
--- a/tests/t_lpback.sh
+++ b/tests/t_lpback.sh
@@ -26,7 +26,7 @@ trap "rm -f key.$$ log.$$ ; exit 1" 0 3

 # Get list of supported ciphers from openvpn --show-ciphers output
 CIPHERS=3D$(${top_builddir}/src/openvpn/openvpn --show-ciphers | \
-            sed -e '/The following/,/^$/d' -e s'/ .*//' -e '/^\s*$/d')
+            sed -e '/The following/,/^$/d' -e s'/ .*//' -e '/^[[:space:]]*=
$/d')

 # SK, 2014-06-04: currently the DES-EDE3-CFB1 implementation of OpenSSL is
 # broken (see http://rt.openssl.org/Ticket/Display.html?id=3D2867), so exc=
lude
--
2.21.0


