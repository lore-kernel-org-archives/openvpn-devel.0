From: David Sommerseth <davids@...515...>
Date: Thu, 16 Jul 2020 00:30:03 +0200
Message-Id: <20200715223013.11726-7-davids@...515...>
In-Reply-To: <20200715223013.11726-1-davids@...515...>
References: <20200715223013.11726-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 06/16] doc/man: Move --bind from generic to
 link section
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

This is more related to the configuration of the link, plus --nobind is
already placed in the link section.

Signed-off-by: David Sommerseth <davids@...515...>
---
 doc/man-sections/generic-options.rst | 7 -------
 doc/man-sections/link-options.rst    | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
index cd048fa5..35985afc 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -22,13 +22,6 @@ which mode OpenVPN is configured as.
   This directive does not affect the ``--http-proxy`` username/password.
   It is always cached.
 
---bind keywords
-  Bind to local address and port. This is the default unless any of
-  ``--proto tcp-client`` , ``--http-proxy`` or ``--socks-proxy`` are used.
-
-  If the optional :code:`ipv6only` keyword is present OpenVPN will bind only
-  to IPv6 (as opposed to IPv6 and IPv4) when a IPv6 socket is opened.
-
 --cd dir
   Change directory to ``dir`` prior to reading any files such as
   configuration files, key files, scripts, etc. ``dir`` should be an
diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst
index 595f7f69..ca719c75 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -3,6 +3,13 @@ Link Options
 This link options section covers options related to the connection between
 the local and the remote host.
 
+--bind keywords
+  Bind to local address and port. This is the default unless any of
+  ``--proto tcp-client`` , ``--http-proxy`` or ``--socks-proxy`` are used.
+
+  If the optional :code:`ipv6only` keyword is present OpenVPN will bind only
+  to IPv6 (as opposed to IPv6 and IPv4) when a IPv6 socket is opened.
+
 --float
   Allow remote peer to change its IP address and/or port number, such as
   due to DHCP (this is the default if ``--remote`` is not used).
-- 
2.26.0


