From: Eric Toombs <storehouse@...2805...>
Date: Tue, 30 Jul 2024 17:00:21 +0000
Message-ID: <20240730170021.1101321-1-storehouse@...2805...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] examples: Switched to ed25519,
 nodes -> noenc
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

From: Eric Toombs <not@...2806...>

I switched the curve to ed25519, a generally more trustworthy curve and the default in openssh.
As a bonus, it *really* simplifies what is already a complicated command.
The old command wouldn't even run in all shells because it used process substitution.

'nodes' is deprecated in favour of 'noenc', so I switched that too.
---
 doc/man-sections/example-fingerprint.rst | 4 ++--
 doc/man-sections/examples.rst            | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/doc/man-sections/example-fingerprint.rst b/doc/man-sections/example-fingerprint.rst
index 7cdda190..e2360dd0 100644
--- a/doc/man-sections/example-fingerprint.rst
+++ b/doc/man-sections/example-fingerprint.rst
@@ -18,7 +18,7 @@ Server setup
 2. Generate a self-signed certificate for the server:
    ::
 
-    openssl req -x509 -newkey ec:<(openssl ecparam -name secp384r1) -keyout server.key -out server.crt -nodes -sha256 -days 3650 -subj '/CN=server'
+    openssl req -x509 -newkey ed25519 -keyout server.key -out server.crt -noenc -sha256 -days 3650 -subj '/CN=server'
 
 3. Generate SHA256 fingerprint of the server certificate
 
@@ -85,7 +85,7 @@ Adding a client
    different name for each client.
    ::
 
-      openssl req -x509 -newkey ec:<(openssl ecparam -name secp384r1) -nodes -sha256 -days 3650 -subj '/CN=alice'
+      openssl req -x509 -newkey ed25519 -noenc -sha256 -days 3650 -subj '/CN=alice'
 
    This generate a certificate and a key for the client. The output of the command will look
    something like this:
diff --git a/doc/man-sections/examples.rst b/doc/man-sections/examples.rst
index 94cc726a..ced81621 100644
--- a/doc/man-sections/examples.rst
+++ b/doc/man-sections/examples.rst
@@ -95,12 +95,12 @@ First build a self-signed certificate on bob and display its fingerprint.
 
 ::
 
-   openssl req -x509 -newkey ec:<(openssl ecparam -name secp384r1) -keyout bob.pem -out bob.pem -nodes -sha256 -days 3650 -subj '/CN=bob'
+   openssl req -x509 -newkey ed25519 -keyout bob.pem -out bob.pem -noenc -sha256 -days 3650 -subj '/CN=bob'
    openssl x509 -noout -sha256 -fingerprint -in bob.pem
 
 and the same on alice::
 
-   openssl req -x509 -newkey ec:<(openssl ecparam -name secp384r1) -keyout alice.pem -out alice.pem -nodes -sha256 -days 3650 -subj '/CN=alice'
+   openssl req -x509 -newkey ed25519 -keyout alice.pem -out alice.pem -noenc -sha256 -days 3650 -subj '/CN=alice'
    openssl x509 -noout -sha256 -fingerprint -in alice.pem
 
 
@@ -132,7 +132,7 @@ On alice::
 
    ping 10.4.0.1
 
-Note: This example use a elliptic curve (`secp384`), which allows
+Note: This example use a elliptic curve (`ed25519`), which allows
 ``--dh`` to be set to ``none``.
 
 Example 3: A tunnel with full PKI and TLS-based security
-- 
2.45.2


