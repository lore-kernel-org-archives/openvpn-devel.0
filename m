From: samuli@...515...
Date: Sat, 10 Oct 2015 16:38:36 +0300
Message-Id: <1444484316-6329-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH: openvpn-build] Added CONTRIBUTING.rst
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

From: Samuli Sepp=C3=A4nen <samuli@...515...>

Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 CONTRIBUTING.rst | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 CONTRIBUTING.rst

diff --git a/CONTRIBUTING.rst b/CONTRIBUTING.rst
new file mode 100644
index 0000000..70f4d15
--- /dev/null
+++ b/CONTRIBUTING.rst
@@ -0,0 +1,25 @@
+CONTRIBUTING TO OPENVPN-BUILD
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+
+The suggested way to contribute is to fork the repo and issue a pull reque=
st on=20
+GitHub. Alternatively you can send your patch to openvpn-devel mailing lis=
t:
+
+- https://lists.sourceforge.net/lists/listinfo/openvpn-devel
+
+The subject line should look like this:
+
+  [PATCH: openvpn-build] summary of the patch
+
+To avoid merging issues patches should be created with git-format-patch or=
 sent=20
+using git-send-email. The easiest way to add the subject line prefix is to=
 use=20
+this option:
+
+  --subject-prefix=3D'PATCH: openvpn-build'
+
+Please try to split large patches into small, atomic pieces to make review=
s=20
+easier.
+
+If you want quick feedback on a patch, you can visit the #openvpn-devel ch=
annel=20
+on Freenode. Note that you need to be logged in to join the channel:
+
+- http://freenode.net/faq.shtml#nicksetup
--=20
2.1.4


