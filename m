From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 19 Dec 2022 17:02:26 +0200
Message-Id: <20221219150226.467-1-lstipakov@...277...>
In-Reply-To: <Y5xOXLbRtka5Z81+@flichtenheld-TUXEDO-InfinityBook-S-15-17-Gen7>
References: <Y5xOXLbRtka5Z81+@flichtenheld-TUXEDO-InfinityBook-S-15-17-Gen7>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] git-version.py: proper support for tags
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
we build releases.

First, try to get tag name with

   git describe --exact-match

and if this fails, get branch name as before.

Use subprocess.Popen() to suppress stdout/stderr output.

This fixes https://github.com/OpenVPN/openvpn/issues/199.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 v2: 
  - try to get tag name before branch
  - use "git describe --exact-match" instead of "git describe --tags"
  - use subprocess.Popen() instead of os.popen() to suppress output

 build/msvc/msvc-generate/git-version.py | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/build/msvc/msvc-generate/git-version.py b/build/msvc/msvc-generate/git-version.py
index 814dc86a..89fd44f2 100644
--- a/build/msvc/msvc-generate/git-version.py
+++ b/build/msvc/msvc-generate/git-version.py
@@ -24,15 +24,22 @@
 
 import os
 import sys
+import subprocess
+
+def run_command(args):
+    sp = subprocess.Popen(args, stdout=subprocess.PIPE, stderr=subprocess.DEVNULL)
+    o, _ = sp.communicate()
+    return o.decode("utf-8")[:-1]
 
 def get_branch_commit_id():
-    commit_id = os.popen("git rev-parse --short=16 HEAD").read()[:-1]
+    commit_id = run_command(["git", "rev-parse", "--short=16", "HEAD"])
     if not commit_id:
         raise
-    l = os.popen("git rev-parse --symbolic-full-name HEAD").read().split("/")[2:]
-    if not l:
-        l = ["none\n"]
-    branch = "/" .join(l)[:-1]
+    branch = run_command(["git", "describe", "--exact-match"])
+    if not branch:
+        branch = run_command(["git", "rev-parse", "--symbolic-full-name", "HEAD"]).split("/")[2:]
+        branch = "/" .join(branch) # handle cases like release/2.6
+
     return branch, commit_id
 
 def main():
-- 
2.23.0.windows.1


