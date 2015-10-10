From: samuli@...515...
Date: Sat, 10 Oct 2015 16:41:14 +0300
Message-Id: <1444484474-6471-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH: openvpn] Add CONTRIBUTING.rst
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
 CONTRIBUTING.rst | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)
 create mode 100644 CONTRIBUTING.rst

diff --git a/CONTRIBUTING.rst b/CONTRIBUTING.rst
new file mode 100644
index 0000000..5004620
--- /dev/null
+++ b/CONTRIBUTING.rst
@@ -0,0 +1,30 @@
+CONTRIBUTING TO THE OPENVPN PROJECT
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Patches should be written against the Git "master" branch. Some patches ma=
y get=20
+backported to a release branch.
+
+We do not currently accept GitHub pull requests for the core OpenVPN proje=
ct.=20
+Instead, all patches must be sent to "openvpn-devel" mailing list for revi=
ew:
+
+- https://lists.sourceforge.net/lists/listinfo/openvpn-devel
+
+The subject line should preferably be prefixed with [PATCH]. To avoid merg=
ing=20
+issues the patches should be generated with git-format-patch or sent using=
=20
+git-send-email. Try to split large patches into small, atomic pieces to ma=
ke=20
+reviews easier.
+
+If you want quick feedback on a patch before sending it to openvpn-devel m=
ailing=20
+list, you can visit the #openvpn-devel channel on irc.freenode.net. Note t=
hat=20
+you need to be logged in to Freenode to join the channel:
+
+- http://freenode.net/faq.shtml#nicksetup
+
+More detailed contribution instructions are available here:
+
+- https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation
+
+Note that the process for contributing to other OpenVPN projects such as=20
+openvpn-build, openvpn-gui, tap-windows6 and easy-rsa may differ from what=
 was=20
+described above. Please refer to the contribution instructions of each
+respective project.
--=20
2.1.4


