From: Arne Schwabe <arne@...1227...>
Date: Wed, 26 Apr 2023 11:49:31 +0200
Message-Id: <20230426094931.1168078-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Add Apache2 linking with for new commits
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

After first round of mailing people with more than 10 commits we have
almost all committers have agreed. This put this license in the realm
of having a realistic change to work. Had any of these contributers
disagreed, rewriting all their code might have been not feasible.

The rationale of adding this exception now is to avoid having to
have a second round of agreement for new contributers and ensure
that all new code will include the exemption.

patch v2: add explaination and use exception rather than excemption
patch v3: actually send v3

Change-Id: Ide83f914f383b53ef37ddf628e4da5a78e241bf0
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 COPYING | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/COPYING b/COPYING
index e12c51414..a6f8a6f5f 100644
--- a/COPYING
+++ b/COPYING
@@ -31,6 +31,53 @@ OpenVPN license:
   file, but you are not obligated to do so.  If you do not wish to
   do so, delete this exception statement from your version.
 
+Apache2 linking exception:
+---------------------------
+OpenVPN is currently undergoing a license change to add an exception for
+Apache 2 linking. The following exception is only valid for new contributions
+after COMMITDATE and past contribution where the authors have already agreed
+to the exception.
+
+  In addition, as a special exception, OpenVPN Inc and the
+  contributors give permission to link the code of this program to
+  libraries (the "Libraries") licensed under the Apache License
+  version 2.0 (this work and any linked library the "Combined Work")
+  and copy and distribute the Combined Work without an obligation to
+  license the Libraries under the GNU General Public License v2
+  (GPL-2.0) as required by Section 2 of the GPL-2.0, and without an
+  obligation to refrain from imposing any additional restrictions in
+  the Apache License version 2 that are not in the GPL-2.0, as
+  required by Section 6 of the GPL-2.0.  You must comply with the`
+  GPL-2.0 in all other respects for the Combined Work, including
+  the obligation to provide source code.  If you modify this file, you
+  may extend this exception to your version of the file, but you are
+  not obligated to do so.  If you do not wish to do so, delete this
+  exception statement from your version.
+
+For better understanding, in plain non-legalese English this basically says:
+
+ * The intention for this license exception is to allow OpenVPN to be
+   linked against APL-2 licensed libraries, even where the GPL-2.0 and
+   APL-2 licenses conflict from a legal perspective.
+
+ * OpenVPN itself will stay GPL-2.0 and the code belonging to the
+   OpenVPN project must comply to the GPL-2.0 license.  This is NOT
+   dual-licensing of the OpenVPN code base.
+
+ * This license exception DOES NOT require NOR expect a license change
+   of the APL-2 based library.  This exception allows using the APL-2
+   library as-is.  However, when distributing a compiled OpenVPN binary
+   linking against APL-2 libraries ("Combined Work"), the REQUIREMENT is
+   that the APL-2 library MUST also be available on similar terms as in
+   GPL-2.0, like providing the source code of the library upon request,
+   except in the two specific ways mentioned.
+
+ * If the APL-2 based library forbids such linking and distribution,
+   this license exception DOES NOT overrule the restriction of the APL-2
+   based library.  If the APL-2 library cannot satisfy the requirements
+   in this license exception, you CANNOT distribute an OpenVPN binary
+   linked with this library.
+
 LZO license:
 ------------
 
-- 
2.39.2 (Apple Git-143)


