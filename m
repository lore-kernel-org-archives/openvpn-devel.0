From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 16 Dec 2022 11:07:17 +0200
Message-Id: <20221216090717.1082-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] git-version.py: use tag as branch name
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

Git magic to get branch name

  git rev-parse --symbolic-full-name HEAD

doesn't work when we're on tag, which is the case when
we build releases. In this case, use tag name as branch name
with another git magic:

  git describe --tags

This fixes https://github.com/OpenVPN/openvpn/issues/199.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 build/msvc/msvc-generate/git-version.py | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/build/msvc/msvc-generate/git-version.py b/build/msvc/msvc-generate/git-version.py
index 814dc86a..513f489a 100644
--- a/build/msvc/msvc-generate/git-version.py
+++ b/build/msvc/msvc-generate/git-version.py
@@ -30,9 +30,16 @@ def get_branch_commit_id():
     if not commit_id:
         raise
     l = os.popen("git rev-parse --symbolic-full-name HEAD").read().split("/")[2:]
-    if not l:
-        l = ["none\n"]
-    branch = "/" .join(l)[:-1]
+    if l:
+        branch = "/" .join(l)[:-1]
+    else:
+        # are we on tag?
+        l = os.popen("git describe --tags").read()
+        if l:
+            branch = l[:-1]
+        else:
+            branch = "none"
+
     return branch, commit_id
 
 def main():
-- 
2.38.1.windows.1


