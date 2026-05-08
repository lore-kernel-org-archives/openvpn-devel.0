From: Gert Doering <gert@...1296...>
Date: Fri,  8 May 2026 17:31:02 +0200
Message-ID: <20260508153108.13488-1-gert@...1296...>
In-Reply-To: <gerrit.1778239616000.Ia688ec12e642de699811ced8668b40be9fbb6155@...2715...>
References: <gerrit.1778239616000.Ia688ec12e642de699811ced8668b40be9fbb6155@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Fix some msg() calls with wrong number
 of arguments in Windows-only code
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

For some reason neither MSVC nor MinGW complained?
cppcheck did (once told that msg is a printf-style
function).

Change-Id: Ia688ec12e642de699811ced8668b40be9fbb6155
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1672
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1672
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpnmsica/msiex.c b/src/openvpnmsica/msiex.c
index f8bf6ae..4d48f06 100644
--- a/src/openvpnmsica/msiex.c
+++ b/src/openvpnmsica/msiex.c
@@ -51,7 +51,7 @@
         *pszValue = (LPWSTR)malloc(++dwLength * sizeof(WCHAR));
         if (*pszValue == NULL)
         {
-            msg(M_FATAL, "%s: malloc(%u) failed", dwLength * sizeof(WCHAR));
+            msg(M_FATAL, "%s: malloc(%u) failed", __FUNCTION__, dwLength * sizeof(WCHAR));
             return ERROR_OUTOFMEMORY;
         }
 
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index 6ed395d..cccc0e1 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -487,8 +487,8 @@
         }
 
         default:
-            msg(M_NONFATAL, "%s: \"%ls\" registry value is not string (type %u)", __FUNCTION__,
-                dwValueType);
+            msg(M_NONFATAL, "%s: \"%ls\" registry value is not string (type %u)",
+                __FUNCTION__, szName, dwValueType);
             return ERROR_UNSUPPORTED_TYPE;
     }
 }

