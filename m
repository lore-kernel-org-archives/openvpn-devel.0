From: Gert Doering <gert@...1296...>
Date: Mon, 13 Oct 2025 18:03:39 +0200
Message-ID: <20251013160346.32741-1-gert@...1296...>
In-Reply-To: <gerrit.1760364129000.I77a59b9b74a13793782fbfbff6bd2ec581f86be0@...2715...>
References: <gerrit.1760364129000.I77a59b9b74a13793782fbfbff6bd2ec581f86be0@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] CONTRIBUTING: Update outdated/obsolete
 information
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

- uncrustify -> clang-format
- add Gerrit
- update Wiki links

Change-Id: I77a59b9b74a13793782fbfbff6bd2ec581f86be0
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1271
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1271
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):

        
diff --git a/CONTRIBUTING.rst b/CONTRIBUTING.rst
index 67baa4e..bd76f7a 100644
--- a/CONTRIBUTING.rst
+++ b/CONTRIBUTING.rst
@@ -4,27 +4,32 @@
 Patches should be written against the Git "master" branch. Some patches may get
 backported to a release branch.
 
-The preferred procedure to send patches to the "openvpn-devel" mailing list:
+The preferred procedure is to send patches to the "openvpn-devel" mailing list:
 
 - https://lists.sourceforge.net/lists/listinfo/openvpn-devel
 
+Instead of directly sending patches to the list you can also create an account
+in our instance of the Gerrit review tool: https://gerrit.openvpn.net/
+See https://community.openvpn.net/Development/GerritBestPractices.
+
 While we do not merge GitHub pull requests as-is, we do allow their use for code
 review purposes. After the patch has been ACKed (reviewed and accepted), it must
 be sent to the mailing list. This last step does not necessarily need to be done
 by the patch author, although that is definitely recommended.
 
 When sending patches to "openvpn-devel" the subject line should be prefixed with
-[PATCH]. To avoid merging issues the patches should be generated with
+``[PATCH]``. To avoid merging issues the patches should be generated with
 git-format-patch or sent using git-send-email. Try to split large patches into
 small, atomic pieces to make reviews easier.
 
 Please make sure that the source code formatting follows the guidelines at
-https://community.openvpn.net/openvpn/wiki/CodeStyle. Automated checking can be
-done with uncrustify (https://uncrustify.sourceforge.net/) and the configuration
-file which can be found in the git repository at dev-tools/uncrustify.conf.
-There is also a git pre-commit hook script, which runs uncrustify automatically
+https://community.openvpn.net/Development/CodeStyle. Automated checking can be
+done with clang-format (https://community.openvpn.net/Development/CodeStyle)
+and the configuration file which can be found in the git repository at ``.clang-format``.
+
+There is also a git pre-commit hook script, which runs clang-format automatically
 each time you commit and lets you format your code conveniently, if needed.
-To install the hook simply run: dev-tools/git-pre-commit-uncrustify.sh install
+To install the hook simply run: ``dev-tools/git-pre-commit-format.sh install``
 
 If you want quick feedback on a patch before sending it to openvpn-devel mailing
 list, you can visit the #openvpn-devel channel on irc.libera.chat. Note that
@@ -34,7 +39,7 @@
 
 More detailed contribution instructions are available here:
 
-- https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation
+- https://community.openvpn.net/Development/DeveloperDocumentation
 
 Note that the process for contributing to other OpenVPN projects such as
 openvpn-build, openvpn-gui, tap-windows6 and easy-rsa may differ from what was

