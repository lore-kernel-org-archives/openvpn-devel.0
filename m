From: Alexander Pyhalov <alp@...1937...>
Message-ID: <656ee057-b8a6-69b5-9b7f-e61e3590855b@...1937...>
Date: Fri, 9 Dec 2016 13:35:15 +0300
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------AE3EB985F9D1D0AD36BAE5C4"
Subject: [Openvpn-devel] [PATCH] Use getpassphrase on Solaris/illumos
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------AE3EB985F9D1D0AD36BAE5C4
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable


--=20
=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,
=D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B0=D0=BD=D0=B4=D1=80 =D0=9F=D1=8B=D1=85=
=D0=B0=D0=BB=D0=BE=D0=B2,
=D0=BF=D1=80=D0=BE=D0=B3=D1=80=D0=B0=D0=BC=D0=BC=D0=B8=D1=81=D1=82 =D0=BE=
=D1=82=D0=B4=D0=B5=D0=BB=D0=B0 =D1=82=D0=B5=D0=BB=D0=B5=D0=BA=D0=BE=D0=BC=
=D0=BC=D1=83=D0=BD=D0=B8=D0=BA=D0=B0=D1=86=D0=B8=D0=BE=D0=BD=D0=BD=D0=BE=D0=
=B9 =D0=B8=D0=BD=D1=84=D1=80=D0=B0=D1=81=D1=82=D1=80=D1=83=D0=BA=D1=82=D1=
=83=D1=80=D1=8B
=D1=83=D0=BF=D1=80=D0=B0=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D1=8F =D0=B8=D0=BD=
=D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D0=BE=D0=BD=D0=BD=D0=BE-=D0=BA=
=D0=BE=D0=BC=D0=BC=D1=83=D0=BD=D0=B8=D0=BA=D0=B0=D1=86=D0=B8=D0=BE=D0=BD=D0=
=BD=D0=BE=D0=B9 =D0=B8=D0=BD=D1=84=D1=80=D0=B0=D1=81=D1=82=D1=80=D1=83=D0=
=BA=D1=82=D1=83=D1=80=D1=8B =D0=AE=D0=A4=D0=A3

--------------AE3EB985F9D1D0AD36BAE5C4
Content-Type: text/x-patch;
	name="0001-Use-getpassphrase-on-Solaris-illumos.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-Use-getpassphrase-on-Solaris-illumos.patch"

From 971d1d5e66ba714fc8f74b8da0672e7da47dc557 Mon Sep 17 00:00:00 2001
From: Alexander Pyhalov <apyhalov@...277...>
Date: Fri, 9 Dec 2016 13:16:01 +0300
Subject: [PATCH] Use getpassphrase on Solaris/illumos

---
 src/openvpn/console_builtin.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
index 06994fd..98257b6 100644
--- a/src/openvpn/console_builtin.c
+++ b/src/openvpn/console_builtin.c
@@ -214,7 +214,12 @@ static bool get_console_input (const char *prompt, const bool echo, char *input,
         }
         close_tty (fp);
     } else {
+#ifdef __sun
+        /* On Solaris/illumos getpass() returns up to 8 symbols */
+        char *gp = getpassphrase (prompt);
+#else
         char *gp = getpass (prompt);
+#endif
         if (gp)
         {
             strncpynt (input, gp, capacity);
-- 
2.9.2


--------------AE3EB985F9D1D0AD36BAE5C4--

