From: Gert Doering <gert@...1296...>
Date: Sun,  3 Aug 2025 16:39:33 +0200
Message-ID: <20250803143939.15335-1-gert@...1296...>
In-Reply-To: <gerrit.1753966620000.Idfe5c615d1109a1038207c1c1b0e0de4da3279f5@...2715...>
References: <gerrit.1753966620000.Idfe5c615d1109a1038207c1c1b0e0de4da3279f5@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Update text of GPL to latest version
 from FSF
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

This mostly removes the postal address of the
FSF.

This was triggered by rpmlint complaining about
that address being outdated.

Change-Id: Idfe5c615d1109a1038207c1c1b0e0de4da3279f5
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1123
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/COPYRIGHT.GPL b/COPYRIGHT.GPL
index 2a591d0..9efa6fb 100644
--- a/COPYRIGHT.GPL
+++ b/COPYRIGHT.GPL
@@ -2,7 +2,7 @@
                        Version 2, June 1991
 
  Copyright (C) 1989, 1991 Free Software Foundation, Inc.,
- 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ <https://fsf.org/>
  Everyone is permitted to copy and distribute verbatim copies
  of this license document, but changing it is not allowed.
 
@@ -294,8 +294,9 @@
     Copyright (C) <year>  <name of author>
 
     This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License version 2
-    as published by the Free Software Foundation.
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
 
     This program is distributed in the hope that it will be useful,
     but WITHOUT ANY WARRANTY; without even the implied warranty of
@@ -303,8 +304,7 @@
     GNU General Public License for more details.
 
     You should have received a copy of the GNU General Public License along
-    with this program; if not, write to the Free Software Foundation, Inc.,
-    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+    with this program; if not, see <https://www.gnu.org/licenses/>.
 
 Also add information on how to contact you by electronic and paper mail.
 
@@ -328,8 +328,8 @@
   Yoyodyne, Inc., hereby disclaims all copyright interest in the program
   `Gnomovision' (which makes passes at compilers) written by James Hacker.
 
-  <signature of Ty Coon>, 1 April 1989
-  Ty Coon, President of Vice
+  <signature of Moe Ghoul>, 1 April 1989
+  Moe Ghoul, President of Vice
 
 This General Public License does not permit incorporating your program into
 proprietary programs.  If your program is a subroutine library, you may
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
index 0c604ff..0981a1a 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -240,7 +240,7 @@
         while (c);
     }
 
-    assert_int_equal(wordcount, 2978);
+    assert_int_equal(wordcount, 2971);
 
     /* remove some words from the table */
     {

