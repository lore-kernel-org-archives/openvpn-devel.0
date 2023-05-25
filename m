From: Frank Lichtenheld <frank@...2641...>
Date: Thu, 25 May 2023 16:46:57 +0200
Message-Id: <20230525144657.40732-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] options: remove --key-method from usage
 message
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

Commit 36bef1b52b49ebbc3790635be230e2f30f0532a7 removed
the option but did not delete it from usage text.

Change-Id: I68d3c90c2bdf6f426a9eef81f852fcae2ea47ce9
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 src/openvpn/options.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 26337680..117660b0 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -567,8 +567,6 @@ static const char usage_message[] =
     "(These options are meaningful only for TLS-mode)\n"
     "--tls-server    : Enable TLS and assume server role during TLS handshake.\n"
     "--tls-client    : Enable TLS and assume client role during TLS handshake.\n"
-    "--key-method m  : (DEPRECATED) Data channel key exchange method.  m should be a method\n"
-    "                  number, such as 1 (default), 2, etc.\n"
     "--ca file       : Certificate authority file in .pem format containing\n"
     "                  root certificate.\n"
 #ifndef ENABLE_CRYPTO_MBEDTLS
-- 
2.34.1


