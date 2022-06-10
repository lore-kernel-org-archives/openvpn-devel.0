Date: Fri, 10 Jun 2022 12:04:05 +0000
From: =?utf-8?Q?Martin_Jan=C5=AF?= <martin.janu@...2282...>
Reply-To: =?utf-8?Q?Martin_Jan=C5=AF?= <martin.janu@...2282...>
Message-ID: <SVrvuTydxR6Qs_mvwvG7mqT8iLV0inlcCMXoenZTMI8M0LkosV4pZsH9m_XCTwcRWAPN5H8Zdro0ubhJrnSp6v5KC2ZNAL9So0Y2SKiSe7g=@protonmail.com>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Update the replay-window backtrack log
 message
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

The man pages reference a logging message which has been rephrased
in ac1310528a248c99e039e7afaf48724ad1b7f10e. This commit updates the
man page message to reflect the change for improved grep-ability.

Signed-off-by: Martin Jan=C5=AF <martin.janu@...2282...>
---
 doc/man-sections/link-options.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-opti=
ons.rst
index 6473ad42..373193aa 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -378,7 +378,7 @@ the local and the remote host.
   value for ``n``. Satellite links in particular often require this.

   If you run OpenVPN at ``--verb 4``, you will see the message
-  "Replay-window backtrack occurred [x]" every time the maximum sequence
+  "PID_ERR replay-window backtrack occurred [x]" every time the maximum se=
quence
   number backtrack seen thus far increases. This can be used to calibrate
   ``n``.

--
2.36.1


