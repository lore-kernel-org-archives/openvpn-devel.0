From: Michal Soltys <soltys@...2503...>
Date: Tue,  9 Apr 2019 16:34:38 +0200
Message-Id: <20190409143438.25348-2-soltys@...2503...>
In-Reply-To: <20190409143438.25348-1-soltys@...2503...>
References: <20190409143438.25348-1-soltys@...2503...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/1] man: correct the description of
 --capath and --crl-verify regarding CRLs
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

The man page states that when using --capath, the user is required to
provide CRLs for CAs. This is not true and providing CRLs is optional -
both in case of --capath as well as --crl-verify options. When relevant
CRL is not found OpenVPN simply logs the warning in the logs while
allowing the connection, e.g.:

VERIFY WARNING: depth=0, unable to get certificate CRL

This patch clarifies the behavior.

Signed-off-by: Michal Soltys <soltys@...2503...>
---
 doc/openvpn.8 | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index ce440447..a77866c7 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4598,11 +4598,8 @@ they are distributed with OpenVPN, they are totally insecure.
 Directory containing trusted certificates (CAs and CRLs).
 Not available with mbed TLS.
 
-When using the
-.B \-\-capath
-option, you are required to supply valid CRLs for the CAs too.  CAs in the
-capath directory are expected to be named <hash>.<n>.  CRLs are expected to
-be named <hash>.r<n>.  See the
+CAs in the capath directory are expected to be named hash>.<n>. CRLs are
+expected to be named <hash>.r<n>. See the
 .B \-CApath
 option of
 .B openssl verify
@@ -4613,6 +4610,11 @@ option of
 and
 .B openssl crl
 for more information.
+
+Similarly to the
+.B \-\-crl\-verify
+option CRLs are not mandatory \- OpenVPN will log the usual warning in the logs
+if the relevant CRL is missing, but the connection will be allowed.
 .\"*********************************************************
 .TP
 .B \-\-dh file
@@ -5685,6 +5687,10 @@ overall integrity of the PKI.
 The only time when it would be necessary to rebuild the entire PKI from scratch would be
 if the root certificate key itself was compromised.
 
+The option is not mandatory \- if the relevant CRL is missing, OpenVPN will log
+a warning in the logs \- e.g. "\fIVERIFY WARNING: depth=0, unable to get
+certificate CRL\fR" \- but the connection will be allowed.
+
 If the optional
 .B dir
 flag is specified, enable a different mode where
-- 
2.21.0


