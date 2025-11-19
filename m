From: Gert Doering <gert@...1296...>
Date: Wed, 19 Nov 2025 14:52:38 +0100
Message-ID: <20251119135243.30967-1-gert@...1296...>
In-Reply-To: <gerrit.1763474625000.I23ea00dbd62271838aa72e913b743cc679ff2386@...2715...>
References: <gerrit.1763474625000.I23ea00dbd62271838aa72e913b743cc679ff2386@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] doc: Document potential filesystem
 pitfalls of client-config-dir
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

Reported-By: stefan@...2953...
Change-Id: I23ea00dbd62271838aa72e913b743cc679ff2386
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1380
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1380
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index 5243a06..739be22 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -144,6 +144,16 @@
   ``--push-reset``, ``--push-remove``, ``--iroute``, ``--ifconfig-push``,
   ``--vlan-pvid`` and ``--config``.
 
+  **Note:** OpenVPN uses the CN exactly as written in the certificate.
+  But since this is a file access the filesystem might interfere.
+  Importantly OpenVPN will consider two CNs that only differ in case as
+  different names but a case-insensitive filesystem (like you might
+  encounter on Windows or macOS) will treat them as the same. When you
+  generate your certificates make sure that the CNs are sufficiently
+  different to not cause issues. When trusting an external CA note that
+  this is a potential attack vector via maliciously generated
+  certificates that exploit this issue.
+
 --client-to-client
   Because the OpenVPN server mode handles multiple clients through a
   single tun or tap interface, it is effectively a router. The

