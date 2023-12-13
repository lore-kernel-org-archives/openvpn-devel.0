From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 13 Dec 2023 15:33:24 +0100
Message-Id: <20231213143324.226443-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] documentation: improve documentation of
 --x509-track
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

In the current state it was completely unclear to me how you
would use this. Extended the description based on reading the
code and experimentation.

Change-Id: Ibf728f9d624e64ecda094d66fa562bd3916829d2
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 doc/man-sections/script-options.rst |  3 +++
 doc/man-sections/tls-options.rst    | 23 +++++++++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-options.rst
index ba700a04..0e60ab5a 100644
--- a/doc/man-sections/script-options.rst
+++ b/doc/man-sections/script-options.rst
@@ -934,6 +934,9 @@ instances.
     verification level is 0 for the client certificate and 1 for the CA
     certificate.
 
+    You can use the ``--x509-track`` option to export more or less information
+    from the certificates.
+
     ::
 
        X509_0_emailAddress=me@...430...
diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst
index 266167f2..4c45b10f 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -695,10 +695,29 @@ If the option is inlined, ``algo`` is always :code:`SHA256`.
 --x509-track attribute
   Save peer X509 **attribute** value in environment for use by plugins and
   management interface. Prepend a :code:`+` to ``attribute`` to save values
-  from full cert chain. Values will be encoded as
-  :code:`X509_<depth>_<attribute>=<value>`. Multiple ``--x509-track``
+  from full cert chain. Otherwise the attribute will only be exported for
+  the leaf cert (i.e. depth :code:`0` of the cert chain). Values will be
+  encoded as :code:`X509_<depth>_<attribute>=<value>`. Multiple ``--x509-track``
   options can be defined to track multiple attributes.
 
+  ``attribute`` can be any part of the X509 Subject field or any X509v3
+  extension (RFC 3280). X509v3 extensions might not be supported when
+  not using the default TLS backend library (OpenSSL). You can also
+  request the ``SHA1`` and ``SHA256`` fingerprints of the cert,
+  but that is always exported as :code:`tls_digest_{n}` and
+  :code:`tls_digest_sha256_{n}` anyway.
+
+  Note that by default **all** parts of the X509 Subject field are exported in
+  the environment for the whole cert chain. If you use ``--x509-track`` at least
+  once **only** the attributes specified by these options are exported.
+
+  Examples::
+
+    x509-track CN               # exports only X509_0_CN
+    x509-track +CN              # exports X509_{n}_CN for chain
+    x509-track basicConstraints # exports value of "X509v3 Basic Constraints"
+    x509-track SHA256           # exports SHA256 fingerprint
+
 --x509-username-field args
   Fields in the X.509 certificate subject to be used as the username
   (default :code:`CN`). If multiple fields are specified their values
-- 
2.34.1


