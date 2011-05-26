From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
Date: Thu, 26 May 2011 16:23:03 +0300
Message-Id: <1306416185-4901-3-git-send-email-samuli@...515...>
In-Reply-To: <1306416185-4901-1-git-send-email-samuli@...515...>
References: <1306416185-4901-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/4] Fix Microsoft Visual Studio
	incompatibility in plugin.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <davids@...1347...>

From: David Sommerseth <davids@...1347...>

MS Visual Studio don't like to have struct members named in the
variable declaration.  Without this fix, Visual Studio is not able
to compile the new v3 plug-in API.

Signed-off-by: David Sommerseth <davids@...1347...>
Tested-by: Samuli Sepp=C3=A4nen <samuli@...515...>
Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 plugin.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/plugin.c b/plugin.c
index 56bd37f..745ea51 100644
--- a/plugin.c
+++ b/plugin.c
@@ -299,9 +299,9 @@ plugin_open_item (struct plugin *p,
        * Call the plugin initialization
        */
       if (p->open3) {
-        struct openvpn_plugin_args_open_in args =3D { .type_mask =3D p->pl=
ugin_type_mask,
-                                                    .argv      =3D o->argv,
-                                                    .envp      =3D envp };
+        struct openvpn_plugin_args_open_in args =3D { p->plugin_type_mask,
+                                                    (const char ** const) =
o->argv,
+                                                    (const char ** const) =
envp };
         struct openvpn_plugin_args_open_return retargs;
=20
         CLEAR(retargs);
@@ -367,13 +367,13 @@ plugin_call_item (const struct plugin *p,
        * Call the plugin work function
        */
       if (p->func3) {
-        struct openvpn_plugin_args_func_in args =3D { .type    =3D type,
-                                                    .argv    =3D (const ch=
ar **) a.argv,
-                                                    .envp    =3D envp,
-                                                    .handle  =3D p->plugin=
_handle,
-						    .per_client_context =3D per_client_context,
-						    .current_cert_depth =3D (current_cert ? certdepth : -1),
-						    .current_cert =3D current_cert };
+        struct openvpn_plugin_args_func_in args =3D { type,
+                                                    (const char ** const) =
a.argv,
+                                                    (const char ** const) =
envp,
+                                                    p->plugin_handle,
+                                                    per_client_context,
+                                                    (current_cert ? certde=
pth : -1),
+                                                    current_cert };
         struct openvpn_plugin_args_func_return retargs;
=20
         CLEAR(retargs);
--=20
1.6.3.3


