From: Gert Doering <gert@...1296...>
Date: Tue, 10 Feb 2026 17:20:33 +0100
Message-ID: <20260210162038.7915-1-gert@...1296...>
In-Reply-To: <gerrit.1770740212000.Idd079f42fac1189c08c6cf42ea84fa8c0383e1a8@...2715...>
References: <gerrit.1770740212000.Idd079f42fac1189c08c6cf42ea84fa8c0383e1a8@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Review Changes.rst for 2.7.0 release
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

From: Frank Lichtenheld <frank@...2641...>

Fixes various issues, either errors or things
that got outdated during development.

Change-Id: Idd079f42fac1189c08c6cf42ea84fa8c0383e1a8
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1515
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1515
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/Changes.rst b/Changes.rst
index d2c6716..7de5f10 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -116,9 +116,9 @@
     `lwipovpn on Github <https://github.com/OpenVPN/lwipovpn>`_.
 
 Allow overriding username with ``--override-username``
-    This is intended to allow using auth-gen-token in scenarios where the
+    This is intended to allow using ``--auth-gen-token`` in scenarios where the
     clients use certificates and multi-factor authentication.  This will
-    also generate a 'push "auth-token-user newusername"' directives in
+    also generate a ``push "auth-token-user newusername"`` directive in
     push replies.
 
 ``--port-share`` now properly supports IPv6
@@ -127,20 +127,18 @@
 
 Support for Haiku OS
 
-TLS1.3 support with mbedTLS (very recent mbedTLS development versions only)
+TLS1.3 support with mbedTLS (requires mbedTLS >= 3.6.4)
 
 PUSH_UPDATE client support
     It is now possible to update parts of the client-side configuration
     (IP address, routes, MTU, DNS) by sending a new server-to-client
-    control message, PUSH_UPDATE,<options>.  Server-side support is
-    currently only supported by OpenVPN Inc commercial offerings, the
-    implementation for OpenVPN 2.x is still under development.
+    control message, ``PUSH_UPDATE,<options>``.
     See also: https://openvpn.github.io/openvpn-rfc/openvpn-wire-protocol.html
     NOTE: PUSH_UPDATE client support is currently disabled if DCO
     is active (on all platforms).
 
 PUSH_UPDATE server support (minimal)
-    new management interface commands ``push-update-broad`` and
+    New management interface commands ``push-update-broad`` and
     ``push-update-cid`` to send PUSH_UPDATE option updates to all
     clients ("there is a new DNS server") or only a specific client ID
     ("privileges have changed, here's a new IP address").  See
@@ -149,7 +147,7 @@
     is active (on all platforms).
 
 Support for user-defined routing tables on Linux
-    see the ``--route-table`` option in the manpage
+    See the ``--route-table`` option in the manpage
 
 PQE support for WolfSSL
 
@@ -166,7 +164,7 @@
    use policies that direct "everything that is not OpenVPN" into the
    tunnel, and have IP packets to the VPN server address arrive as
    expected (no such policies are currently installed by OpenVPN)
-   (github #669).
+   (GH: OpenVPN/openvpn#669).
 
 COPYING: license details only relevant to our Windows installers have
    been updated and moved to the openvpn-build repo
@@ -181,9 +179,10 @@
    (When a client is older than n days or has no timestamp, the server
     will reject it)
 
-mbedTLS 4 support has been added.  Algorithms need to be translated to
-   mbedTLS 4 internal IDs, and these tables are only very basic right now
-   (but AES-GCM and ChaCha-Poly are in).
+mbedTLS 4 support has been added.
+   Note that with mbedTLS 4 algorithms need to be translated to
+   mbedTLS 4 internal IDs by OpenVPN, and some names might be
+   missing.
 
 
 Deprecated features
@@ -234,7 +233,7 @@
     ``--allow-compression asym``.
 
 ``--memstats`` feature removed
-    The ``--mememstat`` was largely undocumented and there is no known
+    The ``--memstats`` option was largely undocumented and there is no known
     user of this feature.  This feature provided very limited statistics
     (number of users, link bytes read/written) and we do not except any
     usage because of this.
@@ -263,7 +262,7 @@
   By default ``--topology`` is pushed from server to client.
 
 - ``--x509-username-field`` will no longer automatically convert fieldnames to
-  uppercase. This is deprecated since OpenVPN 2.4, and has now been removed.
+  uppercase. This was deprecated since OpenVPN 2.4, and has now been removed.
 
 - ``--dh none`` is now the default if ``--dh`` is not specified. Modern TLS
   implementations will prefer ECDH and other more modern algorithms anyway.
@@ -286,7 +285,7 @@
 - ``--cryptoapicert`` now supports issuer name as well as Windows CA template
   name or OID as selector string.
 
-- TLS handshake debugging information contains much more details  now when
+- TLS handshake debugging information contains much more details now when
   using recent versions of OpenSSL.
 
 - The ``IV_PLAT_VER`` variable sent by Windows clients now contains the
@@ -308,18 +307,16 @@
   (Github: OpenVPN/openvpn#704).
 
 - Use of ``--dh dh2048.pem`` in all sample configs has been replaced
-  with ``--dh none``.  The ``dh2048.pem`` file has been removed, and
-  has been replaced with ``ffdhe2048.pem`` for the benefit of the
-  t_server_null test (to test all variants of ``--dh``).
+  with ``--dh none``.  The ``dh2048.pem`` file has been removed.
 
-- the startup delay in ``t_client.sh`` has been reduced from 3s to 1s,
+- The startup delay in ``t_client.sh`` has been reduced from 3s to 1s,
   making a noticeable difference for setups with many tests.
 
-- changed from using ``uncrustify`` for code formatting and pre-commit checks
+- Changed from using ``uncrustify`` for code formatting and pre-commit checks
   to ``clang-format``.  This reformatted quite a bit of code, and requires
   that regular committers change their pre-commit checks accordingly.
 
-- on Linux, on interfaces where applicable, OpenVPN explicitly configures
+- On Linux, on interfaces where applicable, OpenVPN explicitly configures
   the broadcast address again.  This was dropped for 2.6.0 "because
   computers are smart and can do it themselves", but the kernel netlink
   interface isn't, and will install "0.0.0.0".  This does not normally
@@ -339,7 +336,7 @@
   Win-DCO as well), add printing of the hwid to all adapter outputs, and
   change the default adapter type created to ``ovpn-dco``.
 
-- the default for ``multihome`` egress interface handling has changed.
+- The default for ``multihome`` egress interface handling has changed.
   2.7.0 will default to ipi_ifindex=0, that is, leave the decision to the
   routing/policy setup of the operating system.  The pre-2.7 behaviour
   (force egress = ingress interface) can be achieved with the new
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index 370c670..03ce651 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -90,7 +90,7 @@
   password from a script).
 
   **Note:** the username for ``--auth-gen-token`` can be overridden by
-  ``--override-user``. In this case the client will be pushed also the
+  ``--override-username``. In this case the client will be pushed also the
   ``--auth-token-user`` option and an auth token that is valid for that
   username instead of the original username that the client authenticated
   with.
diff --git a/tests/t_server_null_default.rc b/tests/t_server_null_default.rc
index bba77aa..c6540cb 100755
--- a/tests/t_server_null_default.rc
+++ b/tests/t_server_null_default.rc
@@ -13,7 +13,6 @@
 top_builddir="${top_builddir:-..}"
 sample_keys="${srcdir}/../sample/sample-keys"
 
-DH="${sample_keys}/ffdhe2048.pem"
 CA="${sample_keys}/ca.crt"
 CLIENT_CERT="${sample_keys}/client.crt"
 CLIENT_KEY="${sample_keys}/client.key"

