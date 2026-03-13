From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 13 Mar 2026 11:46:15 +0100
Message-ID: <20260313104615.15951-1-frank@...2641...>
In-Reply-To: <gerrit.1773352679000.Ie502c982bda67d55ee74e4f2f66c26ea82698e60@...2715...>
References: <gerrit.1773352679000.Ie502c982bda67d55ee74e4f2f66c26ea82698e60@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] doc: fix typo with
 --ingore-unknown-option
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

From: Heiko Hund <heiko@...2662...>

Change-Id: Ie502c982bda67d55ee74e4f2f66c26ea82698e60
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1575
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1575
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
index f46dfec..8132b48 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -219,7 +219,7 @@
   Valid syntax:
   ::
 
-     ignore-unknown-options opt1 opt2 opt3 ... optN
+     ignore-unknown-option opt1 opt2 opt3 ... optN
 
   When one of options ``opt1 ... optN`` is encountered in the configuration
   file the configuration file parsing does not fail if this OpenVPN version

