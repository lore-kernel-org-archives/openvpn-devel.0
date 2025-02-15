Message-ID: <cb8317eb-bfb6-47e8-9bc3-ae5cc603ff21@...68...>
Date: Sat, 15 Feb 2025 20:00:33 +0100
MIME-Version: 1.0
Content-Language: de-CH
From: corubba <corubba@...68...>
References: <951b0ff7-9fb7-405b-bf6e-ef4ebf12afaf@...68...>
In-Reply-To: <951b0ff7-9fb7-405b-bf6e-ef4ebf12afaf@...68...>
Subject: [Openvpn-devel] [PATCH 1/2] Remove x509-username-fields uppercasing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

The uppercasing was first introduced together with the
x509-username-field option in commit 935c62be, and first released with
v2.2.0 in 2011. The uppercasing was later deprecated with commit
f4e0ad82 and release v2.4.0 in 2016. It think it is time to finally
remove it.

This deprecated feature prevents you from using non-extension
all-lowercase fieldnames like `name`, because these are converted to
uppercase and then cause an error. The deprecation warning is also shown
in cases where there is no actual uppercasing happening, for example
with numerical forms (aka oids) like `2.5.4.41` (oid of `name`).

Signed-off-by: Corubba Smith <corubba@...68...>
---
 Changes.rst                      |  5 +++++
 doc/man-sections/tls-options.rst |  6 ------
 src/openvpn/options.c            | 27 +--------------------------
 3 files changed, 6 insertions(+), 32 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index e0118111..bcc64fca 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -92,6 +92,11 @@ Compression on send
     ``--allow-compression yes`` is now an alias for
     ``--allow-compression asym``.

+User-visible Changes
+--------------------
+- ``--x509-username-field`` will no longer automatically convert fieldname=
s to
+  uppercase. This is deprecated since OpenVPN 2.4, and has now been remove=
d.
+
 Overview of changes in 2.6
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-option=
s.rst
index cdb85716..7882e924 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -763,12 +763,6 @@ If the option is inlined, ``algo`` is always :code:`SH=
A256`.
   Only the :code:`subjectAltName` and :code:`issuerAltName` X.509
   extensions and :code:`serialNumber` X.509 attribute are supported.

-  **Please note:** This option has a feature which will convert an
-  all-lowercase ``fieldname`` to uppercase characters, e.g.,
-  :code:`ou` -> :code:`OU`. A mixed-case ``fieldname`` or one having the
-  :code:`ext:` prefix will be left as-is. This automatic upcasing feature =
is
-  deprecated and will be removed in a future release.
-
   Non-compliant symbols are being replaced with the :code:`_` symbol, same=
 as
   the field separator, so concatenating multiple fields with such or :code=
:`_`
   symbols can potentially lead to username collisions.
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3ae44dbe..6b2dfa58 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -9395,37 +9395,12 @@ add_option(struct options *options,
 #ifdef ENABLE_X509ALTUSERNAME
     else if (streq(p[0], "x509-username-field") && p[1])
     {
-        /* This option used to automatically upcase the fieldnames passed =
as the
-         * option arguments, e.g., "ou" became "OU". Now, this "helpfulnes=
s" is
-         * fine-tuned by only upcasing Subject field attribute names which=
 consist
-         * of all lower-case characters. Mixed-case attributes such as
-         * "emailAddress" are left as-is. An option parameter having the "=
ext:"
-         * prefix for matching X.509v3 extended fields will also remain un=
changed.
-         */
         VERIFY_PERMISSION(OPT_P_GENERAL);
         for (size_t j =3D 1; j < MAX_PARMS && p[j] !=3D NULL; ++j)
         {
             char *s =3D p[j];

-            if (strncmp("ext:", s, 4) !=3D 0)
-            {
-                size_t i =3D 0;
-                while (s[i] && !isupper(s[i]))
-                {
-                    i++;
-                }
-                if (strlen(s) =3D=3D i)
-                {
-                    while ((*s =3D toupper(*s)) !=3D '\0')
-                    {
-                        s++;
-                    }
-                    msg(M_WARN, "DEPRECATED FEATURE: automatically upcased=
 the "
-                        "--x509-username-field parameter to '%s'; please u=
pdate your "
-                        "configuration", p[j]);
-                }
-            }
-            else if (!x509_username_field_ext_supported(s+4))
+            if (strncmp("ext:", s, 4) =3D=3D 0 && !x509_username_field_ext=
_supported(s+4))
             {
                 msg(msglevel, "Unsupported x509-username-field extension: =
%s", s);
             }
--
2.48.1


