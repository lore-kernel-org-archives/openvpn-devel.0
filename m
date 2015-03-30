From: Matthias Andree <matthias.andree@...68...>
Date: Mon, 30 Mar 2015 21:54:54 +0200
Message-Id: <1427745294-31041-1-git-send-email-matthias.andree@...68...>
Subject: [Openvpn-devel] [PATCH] Manual page update for Re-enabled TLS
	version negotiation.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Matthias Andree <matthias.andree@...68...>

Signed-off-by: Matthias Andree <matthias.andree@...68...>
---
 doc/openvpn.8 | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index a95d353..1420bdd 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4286,16 +4286,19 @@ include "1.0", "1.1", or "1.2".  If 'or-highest' is specified
 and version is not recognized, we will only accept the highest TLS
 version supported by the local SSL implementation.
 
-If this options is not set, the code in OpenVPN 2.3.4 will default
-to using TLS 1.0 only, without any version negotiation.  This reverts
-the beaviour to what OpenVPN versions up to 2.3.2 did, as it turned
-out that TLS version negotiation can lead to handshake problems due
-to new signature algorithms in TLS 1.2.
+Also see
+.B \-\-tls-version-max
+below, for information on compatibility.
 .\"*********************************************************
 .TP
 .B \-\-tls-version-max version
 Set the maximum TLS version we will use (default is the highest version
 supported).  Examples for version include "1.0", "1.1", or "1.2".
+
+If and only if this is set to 1.0, and OpenSSL is used (not PolarSSL),
+then OpenVPN will set up OpenSSL to use a fixed TLSv1 handshake. All
+other configurations will autonegotiate in the given limits, and the
+choice of handshake versions is left to the SSL implementation.
 .\"*********************************************************
 .TP
 .B \-\-pkcs12 file
-- 
1.9.1


