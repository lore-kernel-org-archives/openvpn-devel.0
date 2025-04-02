From: Gert Doering <gert@...1296...>
Date: Wed,  2 Apr 2025 16:08:51 +0200
Message-ID: <20250402140901.18218-1-gert@...1296...>
In-Reply-To: <gerrit.1743087987000.I8d981a66932a5424ed959b12ee0cdddf881de91e@...2715...>
References: <gerrit.1743087987000.I8d981a66932a5424ed959b12ee0cdddf881de91e@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] manpage: fix HTML format for --local
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

From: Gianmarco De Gregori <gianmarco@...2726...>

Fix the HTML format for --local directive
to match the manpage structure.

Change-Id: I8d981a66932a5424ed959b12ee0cdddf881de91e
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Samuli Seppänen <sasepp@...2783...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/922
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Samuli Seppänen <sasepp@...2783...>

        
diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst
index 287473e..8334d16 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -106,7 +106,13 @@
   is not reliable. It is recommended to set tun-mtu with enough headroom
   instead.
 
---local host|* [port] [protocol]
+--local args
+
+  Valid syntax:
+  ::
+
+     local host|* [port] [protocol]
+
   Local host name or IP address and port for bind. If specified, OpenVPN will bind
   to this address. If unspecified, OpenVPN will bind to all interfaces.
   '*' can be used as hostname and means 'any host' (OpenVPN will listen on what

