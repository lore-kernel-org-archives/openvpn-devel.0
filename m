From: Magnus Kroken <mkroken@...277...>
Date: Sat, 15 Aug 2020 14:05:21 +0200
Message-Id: <20200815120522.1404-2-mkroken@...277...>
In-Reply-To: <20200815120522.1404-1-mkroken@...277...>
References: <20200815120522.1404-1-mkroken@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] Changes.rst: fix mistyped option names
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

Signed-off-by: Magnus Kroken <mkroken@...277...>
---
 Changes.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 0aee3603..f67e1d76 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -34,7 +34,7 @@ Improved Data channel cipher negotiation
 Removal of BF-CBC support in default configuration:
     By default OpenVPN 2.5 will only accept AES-256-GCM and AES-128-GCM as
     data ciphers. OpenVPN 2.4 allows AES-256-GCM,AES-128-GCM and BF-CBC when
-    no --cipher and --ncp-cipher options are present. Accepting BF-CBC can be
+    no --cipher and --ncp-ciphers options are present. Accepting BF-CBC can be
     enabled by adding
 
         data-ciphers AES-256-GCM:AES-128-GCM:BF-CBC
@@ -101,7 +101,7 @@ Linux VRF support
 TLS 1.3 support
     TLS 1.3 support has been added to OpenVPN.  Currently, this requires
     OpenSSL 1.1.1+.
-    The options ``--tls-cipher-suites`` and ``--tls-groups`` have been
+    The options ``--tls-ciphersuites`` and ``--tls-groups`` have been
     added to fine tune TLS protocol options.  Most of the improvements
     were also backported to OpenVPN 2.4 as part of the maintainance
     releases.
@@ -112,7 +112,7 @@ Support setting DHCP search domain
     wintun support yet).  Other platforms need to support this via ``--up``
     script (Linux) or GUI (OSX/Tunnelblick).
 
-per-client changing of ``--data-cipher`` or ``data-ciphers-fallback``
+per-client changing of ``--data-ciphers`` or ``data-ciphers-fallback``
     from client-connect script/dir (NOTE: this only changes preference of
     ciphers for NCP, but can not override what the client announces as
     "willing to accept")
@@ -213,9 +213,9 @@ User-visible Changes
   the client configuration almost immediately as result of the
   faster connection setup feature.
 
-- ``--compression`` is nowadays considered risky, because attacks exist
+- ``--compress`` is nowadays considered risky, because attacks exist
   leveraging compression-inside-crypto to reveal plaintext (VORACLE).  So
-  by default, ``--compression xxx`` will now accept incoming compressed
+  by default, ``--compress xxx`` will now accept incoming compressed
   packets (for compatibility with peers that have not been upgraded yet),
   but will not use compression outgoing packets.  This can be controlled with
   the new option ``--allow-compression yes|no|asym``.
-- 
2.20.1


