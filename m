From: Gert Doering <gert@...1296...>
Date: Mon, 25 Mar 2024 08:15:20 +0100
Message-ID: <20240325071520.12513-1-gert@...1296...>
In-Reply-To: <gerrit.1708080342000.Ib5a7f9a978bda5ad58830e43580232660401f66d@...2715...>
References: <gerrit.1708080342000.Ib5a7f9a978bda5ad58830e43580232660401f66d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] documentation: make section levels
 consistent
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

Previously the sections "Encryption Options" and
"Data channel cipher negotiation" were on the same
level as "OPTIONS", which makes no sense. Instead
move them and their subsections one level down.

Use ` since that was already in use in section
"Virtual Routing and Forwarding".

Change-Id: Ib5a7f9a978bda5ad58830e43580232660401f66d
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/527
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/doc/man-sections/cipher-negotiation.rst b/doc/man-sections/cipher-negotiation.rst
index 949ff86..1285e82 100644
--- a/doc/man-sections/cipher-negotiation.rst
+++ b/doc/man-sections/cipher-negotiation.rst
@@ -1,12 +1,12 @@
 Data channel cipher negotiation
-===============================
+-------------------------------
 
 OpenVPN 2.4 and higher have the capability to negotiate the data cipher that
 is used to encrypt data packets. This section describes the mechanism in more detail and the
 different backwards compatibility mechanism with older server and clients.
 
 OpenVPN 2.5 and later behaviour
---------------------------------
+```````````````````````````````
 When both client and server are at least running OpenVPN 2.5, that the order of
 the ciphers of the server's ``--data-ciphers`` is used to pick the data cipher.
 That means that the first cipher in that list that is also in the client's
@@ -25,7 +25,7 @@
 ``--cipher`` option to this list.
 
 OpenVPN 2.4 clients
--------------------
+```````````````````
 The negotiation support in OpenVPN 2.4 was the first iteration of the implementation
 and still had some quirks. Its main goal was "upgrade to AES-256-GCM when possible".
 An OpenVPN 2.4 client that is built against a crypto library that supports AES in GCM
@@ -40,7 +40,7 @@
 options to avoid this behaviour.
 
 OpenVPN 3 clients
------------------
+`````````````````
 Clients based on the OpenVPN 3.x library (https://github.com/openvpn/openvpn3/)
 do not have a configurable ``--ncp-ciphers`` or ``--data-ciphers`` option. Newer
 versions by default disable legacy AES-CBC, BF-CBC, and DES-CBC ciphers.
@@ -52,7 +52,7 @@
 
 
 OpenVPN 2.3 and older clients (and clients with ``--ncp-disable``)
-------------------------------------------------------------------
+``````````````````````````````````````````````````````````````````
 When a client without cipher negotiation support connects to a server the
 cipher specified with the ``--cipher`` option in the client configuration
 must be included in the ``--data-ciphers`` option of the server to allow
@@ -65,7 +65,7 @@
 cipher used by the client is necessary.
 
 OpenVPN 2.4 server
-------------------
+``````````````````
 When a client indicates support for `AES-128-GCM` and `AES-256-GCM`
 (with ``IV_NCP=2``) an OpenVPN 2.4 server will send the first
 cipher of the ``--ncp-ciphers`` to the OpenVPN client regardless of what
@@ -76,7 +76,7 @@
 those ciphers are present.
 
 OpenVPN 2.3 and older servers (and servers with ``--ncp-disable``)
-------------------------------------------------------------------
+``````````````````````````````````````````````````````````````````
 The cipher used by the server must be included in ``--data-ciphers`` to
 allow the client connecting to a server without cipher negotiation
 support.
@@ -89,7 +89,7 @@
 cipher used by the server is necessary.
 
 Blowfish in CBC mode (BF-CBC) deprecation
-------------------------------------------
+`````````````````````````````````````````
 The ``--cipher`` option defaulted to `BF-CBC` in OpenVPN 2.4 and older
 version. The default was never changed to ensure backwards compatibility.
 In OpenVPN 2.5 this behaviour has now been changed so that if the ``--cipher``
diff --git a/doc/man-sections/encryption-options.rst b/doc/man-sections/encryption-options.rst
index 3b26782..49385d6 100644
--- a/doc/man-sections/encryption-options.rst
+++ b/doc/man-sections/encryption-options.rst
@@ -1,8 +1,8 @@
 Encryption Options
-==================
+------------------
 
 SSL Library information
------------------------
+```````````````````````
 
 --show-ciphers
   (Standalone) Show all cipher algorithms to use with the ``--cipher``
@@ -32,7 +32,7 @@
   ``--ecdh-curve`` and ``tls-groups`` options.
 
 Generating key material
------------------------
+```````````````````````
 
 --genkey args
   (Standalone) Generate a key to be used of the type keytype. if keyfile
diff --git a/doc/man-sections/pkcs11-options.rst b/doc/man-sections/pkcs11-options.rst
index de1662b..dfc27af 100644
--- a/doc/man-sections/pkcs11-options.rst
+++ b/doc/man-sections/pkcs11-options.rst
@@ -1,5 +1,5 @@
 PKCS#11 / SmartCard options
----------------------------
+```````````````````````````
 
 --pkcs11-cert-private args
   Set if access to certificate object should be performed after login.
diff --git a/doc/man-sections/renegotiation.rst b/doc/man-sections/renegotiation.rst
index c548440..1e7c340 100644
--- a/doc/man-sections/renegotiation.rst
+++ b/doc/man-sections/renegotiation.rst
@@ -1,5 +1,5 @@
 Data Channel Renegotiation
---------------------------
+``````````````````````````
 
 When running OpenVPN in client/server mode, the data channel will use a
 separate ephemeral encryption key which is rotated at regular intervals.
diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst
index 460cecf..de74c0d 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -1,5 +1,5 @@
 TLS Mode Options
-----------------
+````````````````
 
 TLS mode is the most powerful crypto mode of OpenVPN in both security
 and flexibility. TLS mode works by establishing control and data

