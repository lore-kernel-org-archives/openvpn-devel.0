From: Joachim Schipper <joachim.schipper@...1435...>
Date: Mon, 26 Nov 2012 15:12:06 +0100
Message-ID: <1CED409804E2164C8104F9E623B08B901323D0B158@...1436...>
Content-Language: en-US
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Properly require --key even if
 defined(MANAGMENT_EXTERNAL_KEY)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

When specifying --tls-client --cert ... without a --key (or --pkcs11) optio=
n,
OpenVPN should complain: "You must define private key file (--key)...". Ens=
ure
that this works even when compiling with MANAGMENT_EXTERNAL_KEY.

Signed-off-by: Joachim Schipper <joachim.schipper@...1435...>
---
 src/openvpn/options.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9baa4ff..caa9d17 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2274,7 +2274,7 @@ options_postprocess_verify_ce (const struct options *=
options, const struct conne
 	    {
 	      notnull (options->cert_file, "certificate file (--cert) or PKCS#12 =
file (--pkcs12)");
 #ifdef MANAGMENT_EXTERNAL_KEY
-          if (!options->management_flags & MF_EXTERNAL_KEY)
+          if (!(options->management_flags & MF_EXTERNAL_KEY))
 #endif
 	      notnull (options->priv_key_file, "private key file (--key) or PKCS#=
12 file (--pkcs12)");
 	    }
--=20
1.7.9.5


