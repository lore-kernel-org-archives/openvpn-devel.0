From: Gert Doering <gert@...1296...>
Date: Sat, 30 Dec 2023 15:23:48 +0100
Message-ID: <20231230142348.29108-1-gert@...1296...>
In-Reply-To: <gerrit.1702387180000.Ib226079d1543209e08e5fdcf7344cd20850bea9d@...2715...>
References: <gerrit.1702387180000.Ib226079d1543209e08e5fdcf7344cd20850bea9d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] configure: enable silent rules by default
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

The default build log is big and basically
unreadable.

Go the way of other build systems and do not
print compile commands by default. Verbose
output can always be enabled with make V=1.

Change-Id: Ib226079d1543209e08e5fdcf7344cd20850bea9d
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/480
This mail reflects revision 4 of this Change.
Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/configure.ac b/configure.ac
index 2823f04..9bc4d64 100644
--- a/configure.ac
+++ b/configure.ac
@@ -56,6 +56,7 @@
 # This foreign option prevents autoreconf from overriding our COPYING and
 # INSTALL targets:
 AM_INIT_AUTOMAKE(foreign subdir_objects 1.9) dnl NB: Do not [quote] this parameter.
+AM_SILENT_RULES([yes])
 AC_CANONICAL_HOST
 AC_USE_SYSTEM_EXTENSIONS
 

