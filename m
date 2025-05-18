From: Gert Doering <gert@...1296...>
Date: Mon, 19 May 2025 00:02:39 +0200
Message-ID: <20250518220245.24489-1-gert@...1296...>
In-Reply-To: <gerrit.1745405723000.Ica02244c9f0ac9b4690a51f940fda9d900465289@...2715...>
References: <gerrit.1745405723000.Ica02244c9f0ac9b4690a51f940fda9d900465289@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] Make --dh none behaviour default if not
 specified
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

From: Arne Schwabe <arne@...1227...>

Nowadays ciphers that are using still DH and not ECDH are rarely chosen
as best cipher suite. Our man page even indicates that OpenSSL 1.0.1+
supports ECDH cipher suites. So it does not feel useful to force
specifying --dh anymore.

Side note: Custom generated Diffie Hellmann parameters are also
discouraged nowadays. The newest OpenSSL FIPS libraries even flat
out reject them:

   FIPS 186-4 type domain parameters no longer allowed in FIPS mode,
   since the required validation routines were removed from FIPS 186-5

But instead of adding support for loading the well-known curve just make
dh none the default and the recommended option as finite field Diffie
Hellmann is being deprecated anyway
(https://datatracker.ietf.org/doc/draft-ietf-tls-deprecate-obsolete-kex/)
and not supported by TLS 1.3 at all.

Change-Id: Ica02244c9f0ac9b4690a51f940fda9d900465289
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/945
This mail reflects revision 4 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/Changes.rst b/Changes.rst
index a4f5e57..e297334 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -103,6 +103,11 @@
 - ``--x509-username-field`` will no longer automatically convert fieldnames to
   uppercase. This is deprecated since OpenVPN 2.4, and has now been removed.
 
+- ``--dh none`` is now the default if ``--dh`` is not specified. Modern TLS
+  implementations will prefer ECDH and other more modern algorithms anyway.
+  And finite field Diffie Hellman is in the proces of being deprecated
+  (see draft-ietf-tls-deprecate-obsolete-kex)
+
 Overview of changes in 2.6
 ==========================
 
diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst
index 0638d09..012518b 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -171,16 +171,22 @@
 
 
 --dh file
-  File containing Diffie Hellman parameters in .pem format (required for
-  ``--tls-server`` only).
+  File containing finite field Diffie Hellman parameters in .pem format (used
+  by ``--tls-server`` only).
 
-  Set ``file`` to :code:`none` to disable Diffie Hellman key exchange (and
-  use ECDH only). Note that this requires peers to be using an SSL library
-  that supports ECDH TLS cipher suites (e.g. OpenSSL 1.0.1+, or
-  mbed TLS 2.0+).
+  Setting``file`` to :code:`none` to disable fine field Diffie Hellman
+  key exchange (and to only use ECDH or newer hybrid key agreement algorithms
+  like X25519MLKEM768 instead).
+  Note that this requires peers to be using an SSL library that supports
+  ECDH TLS cipher suites (e.g. OpenSSL 1.0.1+, or mbed TLS 2.0+). Starting
+  with 2.7.0, this is the same as not specifying ``--dh`` at all.
 
-  Use ``openssl dhparam -out dh2048.pem 2048`` to generate 2048-bit DH
-  parameters. Diffie Hellman parameters may be considered public.
+  Diffie Hellman parameters can be generated using
+  ``openssl dhparam -out dh2048.pem 2048`` but it is recommended to
+  use ``none`` as finite field Diffie Hellman have been replaced
+  by more modern variants like ECDH.
+
+  Diffie Hellman parameters may be considered public.
 
 --ecdh-curve name
   Specify the curve to use for elliptic curve Diffie Hellman. Available
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3c1632f..1c7b4bc 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3708,8 +3708,6 @@
 
     if (o->tls_server)
     {
-        /* Check that DH file is specified, or explicitly disabled */
-        notnull(o->dh_file, "DH file (--dh)");
         if (streq(o->dh_file, "none"))
         {
             o->dh_file = NULL;

