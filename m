From: Richard Bonhomme <tincanteksup@...277...>
Date: Tue, 19 Jan 2021 21:56:17 +0000
Message-Id: <20210119215617.116886-1-tincanteksup@...277...>
In-Reply-To: <99e4c953-c5e0-bdf2-7268-c7987952aaed@...277...>
References: <99e4c953-c5e0-bdf2-7268-c7987952aaed@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [openvpn-devel][PATCH] Man page sections corrections
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

Signed-off-by: Richard Bonhomme <tincanteksup@...277...>
---
 doc/man-sections/renegotiation.rst | 2 +-
 doc/man-sections/tls-options.rst   | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/man-sections/renegotiation.rst b/doc/man-sections/renegotiation.rst
index b817cfa8..c5484404 100644
--- a/doc/man-sections/renegotiation.rst
+++ b/doc/man-sections/renegotiation.rst
@@ -35,7 +35,7 @@ separate ephemeral encryption key which is rotated at regular intervals.
   pseudo-uniform-randomized between ``min`` and ``max``.
 
   With the default value of :code:`3600` this results in an effective per
-  session value in the range of :code:`3240`..:code:`3600` seconds for
+  session value in the range of :code:`3240` .. :code:`3600` seconds for
   servers, or just 3600 for clients.
 
   When using dual-factor authentication, note that this default value may
diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst
index 5dd20013..28cf6f1e 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -422,13 +422,13 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
   :code:`DEFAULT:!EXP:!LOW:!MEDIUM:!kDH:!kECDH:!DSS:!PSK:!SRP:!kRSA` when
   using OpenSSL.
 
-  The default for `--tls-ciphersuites` is to use the crypto library's
-  default.
-
 --tls-ciphersuites l
   Same as ``--tls-cipher`` but for TLS 1.3 and up. mbed TLS has no
   TLS 1.3 support yet and only the ``--tls-cipher`` setting is used.
 
+  The default for `--tls-ciphersuites` is to use the crypto library's
+  default.
+
 --tls-client
   Enable TLS and assume client role during TLS handshake.
 
-- 
2.25.1


