From: selva.nair@...277...
Date: Sun, 27 Sep 2020 14:46:00 -0400
Message-Id: <1601232360-14096-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Improve documentation of
 --username-as-common-name
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

From: Selva Nair <selva.nair@...277...>

Trac #1079

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 doc/man-sections/server-options.rst | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index c0b22a5..4b649b1 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -668,9 +668,15 @@ fast hardware. SSL/TLS authentication must be used in this mode.
   ``--max-routes-per-client``
 
 --username-as-common-name
-  For ``--auth-user-pass-verify`` authentication, use the authenticated
-  username as the common name, rather than the common name from the client
-  cert.
+  Use the authenticated username as the common-name, rather than the
+  common-name from the client certificate. Requires that some form of
+  auth-user-pass verification is in effect. As the replacement happens after
+  auth-user-pass verification, the verification script or plugin will still
+  receive the common-name from the certificate.
+
+  The common_name environment variable passed to scripts and plugins invoked
+  after authentication (e.g, client-connect script) and file names parsed in
+  client-config directory will match the username.
 
 --verify-client-cert mode
   Specify whether the client is required to supply a valid certificate.
-- 
2.1.4


