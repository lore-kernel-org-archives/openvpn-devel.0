From: Heiko Hund <heiko.hund@...1489...>
Date: Mon, 29 Oct 2012 14:16:37 +0100
Message-ID: <1351516597-11128-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] support UTF-8 --client-config-dir
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

If a common name (or user name, when used in conjunction with
--username-as-common-name) contains UTF-8 encoded characters their
octets get replaced by underscores. This becomes problematic when
user "M=C3=BCller" and "M=C3=B6ller" need to have a CCD files and both would
be receive options from the file "M__ller". The situation is even
worse for non-latin alphabets, where CCD file names consist of
underscores entirely.

This patch removes that limitation and also allows the file names
to contain any punctuation characters besided the resevered ones.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 src/openvpn/buffer.c |   10 ++++++++++
 src/openvpn/buffer.h |    5 +++++
 src/openvpn/misc.c   |    8 +++++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 5eee3ee..56d14b1 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -782,6 +782,16 @@ char_class (const unsigned char c, const unsigned int =
flags)
     return true;
   if ((flags & CC_EQUAL) && c =3D=3D '=3D')
     return true;
+  if ((flags & CC_LESS_THAN) && c =3D=3D '<')
+    return true;
+  if ((flags & CC_GREATER_THAN) && c =3D=3D '>')
+    return true;
+  if ((flags & CC_PIPE) && c =3D=3D '|')
+    return true;
+  if ((flags & CC_QUESTION_MARK) && c =3D=3D '?')
+    return true;
+  if ((flags & CC_ASTERISK) && c =3D=3D '*')
+    return true;
=20
   return false;
 }
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 9bc33db..5e11de0 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -736,6 +736,11 @@ const char *np (const char *str);
 #define CC_REVERSE_QUOTE      (1<<23)
 #define CC_AT                 (1<<24)
 #define CC_EQUAL              (1<<25)
+#define CC_LESS_THAN          (1<<26)
+#define CC_GREATER_THAN       (1<<27)
+#define CC_PIPE               (1<<28)
+#define CC_QUESTION_MARK      (1<<29)
+#define CC_ASTERISK           (1<<30)
=20
 /* macro classes */
 #define CC_NAME               (CC_ALNUM|CC_UNDERBAR)
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index d2882d8..d33db20 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1056,7 +1056,13 @@ hostname_randomize(const char *hostname, struct gc_a=
rena *gc)
 const char *
 gen_path (const char *directory, const char *filename, struct gc_arena *gc)
 {
-  const char *safe_filename =3D string_mod_const (filename, CC_ALNUM|CC_UN=
DERBAR|CC_DASH|CC_DOT|CC_AT, 0, '_', gc);
+#if WIN32
+  const int CC_PATH_RESERVED =3D CC_LESS_THAN|CC_GREATER_THAN|CC_COLON|
+    CC_DOUBLE_QUOTE|CC_SLASH|CC_BACKSLASH|CC_PIPE|CC_QUESTION_MARK|CC_ASTE=
RISK;
+#else
+  const int CC_PATH_RESERVED =3D CC_SLASH;
+#endif
+  const char *safe_filename =3D string_mod_const (filename, CC_PRINT, CC_P=
ATH_RESERVED, '_', gc);
=20
   if (safe_filename
       && strcmp (safe_filename, ".")
--=20
1.7.9.5


