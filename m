From: samuli@...515...
Date: Thu, 19 May 2016 11:51:49 +0300
Message-Id: <1463647909-18383-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Update CONTRIBUTING.rst to allow GitHub PRs
	for code review purposes
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
 CONTRIBUTING.rst | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/CONTRIBUTING.rst b/CONTRIBUTING.rst
index 6033097..f87293c 100644
--- a/CONTRIBUTING.rst
+++ b/CONTRIBUTING.rst
@@ -4,15 +4,19 @@ CONTRIBUTING TO THE OPENVPN PROJECT
 Patches should be written against the Git "master" branch. Some patches ma=
y get
 backported to a release branch.
=20
-We do not currently accept GitHub pull requests for the core OpenVPN proje=
ct.
-Instead, all patches must be sent to "openvpn-devel" mailing list for revi=
ew:
+The preferred procedure to send patches to the "openvpn-devel" mailing lis=
t:
=20
 - https://lists.sourceforge.net/lists/listinfo/openvpn-devel
=20
-The subject line should preferably be prefixed with [PATCH]. To avoid merg=
ing
-issues the patches should be generated with git-format-patch or sent using
-git-send-email. Try to split large patches into small, atomic pieces to ma=
ke
-reviews easier.
+While we do not merge GitHub pull requests as-is, we do allow their use fo=
r code
+review purposes. After the patch has been ACKed (reviewed and accepted), i=
t must
+be sent to the mailing list. This last step does not necessarily need to b=
e done
+by the patch author, although that is definitely recommended.
+
+When sending patches to "openvpn-devel" the subject line should be prefixe=
d with
+[PATCH]. To avoid merging issues the patches should be generated with
+git-format-patch or sent using git-send-email. Try to split large patches =
into
+small, atomic pieces to make reviews easier.
=20
 If you want quick feedback on a patch before sending it to openvpn-devel m=
ailing
 list, you can visit the #openvpn-devel channel on irc.freenode.net. Note t=
hat
--=20
2.5.5


