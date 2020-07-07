From: Arne Schwabe <arne@...1227...>
Date: Tue,  7 Jul 2020 14:16:11 +0200
Message-Id: <20200707121615.15736-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Add file to ignore reformatting changes
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

This allows git blame to ignore reformatting changes and instead
shows the previous commit that changed the line.

To avoid manually building the list of commits this commit
adds a file with a list of reformatting commits. I might have
missed a few but this should be a good start. To use the file
use:

   git blame --ignore-revs-file=.git-blame-ignore-revs file

or to automatically always use the file

   git config blame.ignoreRevsFile .git-blame-ignore-revs

Naming the file .git-blame-ignore-revs is a convention.

Some more details in this random blog post:

https://www.moxio.com/blog/43/ignoring-bulk-change-commits-with-git-blame

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 .git-blame-ignore-revs                        | 29 +++++++++++++++++++
 .../managent-demo/management-demo-server.py   |  0
 contrib/ovpnkeys.py                           |  0
 3 files changed, 29 insertions(+)
 create mode 100644 .git-blame-ignore-revs
 create mode 100644 contrib/managent-demo/management-demo-server.py
 create mode 100644 contrib/ovpnkeys.py

diff --git a/.git-blame-ignore-revs b/.git-blame-ignore-revs
new file mode 100644
index 00000000..3cc811cf
--- /dev/null
+++ b/.git-blame-ignore-revs
@@ -0,0 +1,29 @@
+# Uncrustify the tests/unit_tests/ part of our tree. 
+da1574ef7826d73f01e120cbd1ba40ce39a305b7
+
+# Another round of uncrustify code cleanup.
+9cf7b4925a54d93fbea1cadcf3dc0e11f3ce358f
+
+# networking_sitnl.c: uncrustify file
+2c45d268ca65c522fbabb7c4dab5e721296b4623
+
+# Uncrustify tapctl and openvpnmsica
+6280d3d5536174934ee22d3840457d61896e0e3a
+# tun.c: uncrustify
+baef44fc8769bbd99f4d699ce9f63180c29a5455
+
+# networking_sitnl.c: uncrustify file
+2c45d268ca65c522fbabb7c4dab5e721296b4623
+
+# uncrustify openvpn sources
+f57431cdc88f22fa4d7962946f0d3187fe058539
+
+# More broadly enforce Allman style and braces-around-conditionals
+4cd4899e8e80efae03c584a760fd107251735723
+
+# Merge 'reformatting' branch into master
+1f004b2f06e987d73e48f7fd7b96b0b248274f58
+
+# The Great Reformatting - first phase
+81d882d5302b8b647202a6893b57dfdc61fd6df2
+
diff --git a/contrib/managent-demo/management-demo-server.py b/contrib/managent-demo/management-demo-server.py
new file mode 100644
index 00000000..e69de29b
diff --git a/contrib/ovpnkeys.py b/contrib/ovpnkeys.py
new file mode 100644
index 00000000..e69de29b
-- 
2.26.0


