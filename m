MIME-Version: 1.0
From: Greg Cox <gcox@...1057...>
Date: Sat, 30 Jun 2018 16:58:09 +0000
Message-ID: <CACDCbPo_kdRDHe7-zJZnELyBGBpLEan=hKv6ScTHzE1KT=inzg@...278...>
Content-Type: multipart/alternative; boundary="0000000000007a95c0056fdedeb4"
Subject: [Openvpn-devel] [PATCH] Remove deprecated plugin functions from
 code samples
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--0000000000007a95c0056fdedeb4
Content-Type: text/plain; charset="UTF-8"

While writing up a plugin, I found that the sample plugin code was using
openvpn_plugin_open_v1.  Since that and openvpn_plugin_func_v1 are listed
as 'deprecated' in openvpn-plugin.h, it made sense to me that you shouldn't
list those functions as sample code for others to clone.

This edits only sample code and since it's my first patch I thought I'd
limit to that.  src/plugins/auth-pam and src/plugins/down-root have similar
'issues', though, and may need the same treatment, if I have the right idea.

Thanks for reading.
-Greg

---
 sample/sample-plugins/defer/simple.c    | 5 +++--
 sample/sample-plugins/defer/simple.def  | 4 ++--
 sample/sample-plugins/log/log.c         | 6 ++++--
 sample/sample-plugins/simple/simple.c   | 6 ++++--
 sample/sample-plugins/simple/simple.def | 4 ++--
 5 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/sample/sample-plugins/defer/simple.c
b/sample/sample-plugins/defer/simple.c
index
d18695b59d6966e5cc84a19e176ea9ec18d0b452..d55e47be01aa346cfc9c70aa24f8722e5a1d67f9
100644
--- a/sample/sample-plugins/defer/simple.c
+++ b/sample/sample-plugins/defer/simple.c
@@ -131,11 +131,12 @@ atoi_null0(const char *str)
 }

 OPENVPN_EXPORT openvpn_plugin_handle_t
-openvpn_plugin_open_v1(unsigned int *type_mask, const char *argv[], const
char *envp[])
+openvpn_plugin_open_v2(unsigned int *type_mask, const char *argv[], const
char *envp[],
+                       struct openvpn_plugin_string_list **return_list)
 {
     struct plugin_context *context;

-    printf("FUNC: openvpn_plugin_open_v1\n");
+    printf("FUNC: openvpn_plugin_open_v2\n");

     /*
      * Allocate our context
diff --git a/sample/sample-plugins/defer/simple.def
b/sample/sample-plugins/defer/simple.def
index
a87507d1fdc0f0bfd0434de577a818ef0cc62afb..556f362308bc6ce81829253f7a7fae9898be221a
100755
--- a/sample/sample-plugins/defer/simple.def
+++ b/sample/sample-plugins/defer/simple.def
@@ -1,6 +1,6 @@
 LIBRARY   OpenVPN_PLUGIN_SAMPLE
 DESCRIPTION "Sample OpenVPN plug-in module."
 EXPORTS
-   openvpn_plugin_open_v1   @1
-   openvpn_plugin_func_v1   @2
+   openvpn_plugin_open_v2   @1
+   openvpn_plugin_func_v2   @2
    openvpn_plugin_close_v1  @3
diff --git a/sample/sample-plugins/log/log.c
b/sample/sample-plugins/log/log.c
index
ecf62c0e653c8ec852ab641e75363747b795c1af..efa8e5184db34f36a311fb61436cdfd61dd02f78
100644
--- a/sample/sample-plugins/log/log.c
+++ b/sample/sample-plugins/log/log.c
@@ -70,7 +70,8 @@ get_env(const char *name, const char *envp[])
 }

 OPENVPN_EXPORT openvpn_plugin_handle_t
-openvpn_plugin_open_v1(unsigned int *type_mask, const char *argv[], const
char *envp[])
+openvpn_plugin_open_v2(unsigned int *type_mask, const char *argv[], const
char *envp[],
+                       struct openvpn_plugin_string_list **return_list)
 {
     struct plugin_context *context;

@@ -164,7 +165,8 @@ show(const int type, const char *argv[], const char
*envp[])
 }

 OPENVPN_EXPORT int
-openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type,
const char *argv[], const char *envp[])
+openvpn_plugin_func_v2(openvpn_plugin_handle_t handle, const int type,
const char *argv[], const char *envp[],
+                       void *per_client_context, struct
openvpn_plugin_string_list **return_list)
 {
     struct plugin_context *context = (struct plugin_context *) handle;

diff --git a/sample/sample-plugins/simple/simple.c
b/sample/sample-plugins/simple/simple.c
index
950c547e22c1d44c59812eb90606fbdb52981021..66695950abfcbc6ebb0a4d4fa621627a6099ba76
100644
--- a/sample/sample-plugins/simple/simple.c
+++ b/sample/sample-plugins/simple/simple.c
@@ -72,7 +72,8 @@ get_env(const char *name, const char *envp[])
 }

 OPENVPN_EXPORT openvpn_plugin_handle_t
-openvpn_plugin_open_v1(unsigned int *type_mask, const char *argv[], const
char *envp[])
+openvpn_plugin_open_v2(unsigned int *type_mask, const char *argv[], const
char *envp[],
+                       struct openvpn_plugin_string_list **return_list)
 {
     struct plugin_context *context;

@@ -97,7 +98,8 @@ openvpn_plugin_open_v1(unsigned int *type_mask, const
char *argv[], const char *
 }

 OPENVPN_EXPORT int
-openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type,
const char *argv[], const char *envp[])
+openvpn_plugin_func_v2(openvpn_plugin_handle_t handle, const int type,
const char *argv[], const char *envp[],
+                       void *per_client_context, struct
openvpn_plugin_string_list **return_list)
 {
     struct plugin_context *context = (struct plugin_context *) handle;

diff --git a/sample/sample-plugins/simple/simple.def
b/sample/sample-plugins/simple/simple.def
index
a87507d1fdc0f0bfd0434de577a818ef0cc62afb..556f362308bc6ce81829253f7a7fae9898be221a
100755
--- a/sample/sample-plugins/simple/simple.def
+++ b/sample/sample-plugins/simple/simple.def
@@ -1,6 +1,6 @@
 LIBRARY   OpenVPN_PLUGIN_SAMPLE
 DESCRIPTION "Sample OpenVPN plug-in module."
 EXPORTS
-   openvpn_plugin_open_v1   @1
-   openvpn_plugin_func_v1   @2
+   openvpn_plugin_open_v2   @1
+   openvpn_plugin_func_v2   @2
    openvpn_plugin_close_v1  @3
--
2.15.2 (Apple Git-101.1)

--0000000000007a95c0056fdedeb4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:courier =
new,monospace">While writing up a plugin, I found that the sample plugin co=
de was using openvpn_plugin_open_v1.=C2=A0 Since that and openvpn_plugin_fu=
nc_v1 are listed as &#39;deprecated&#39; in openvpn-plugin.h, it made sense=
 to me that you shouldn&#39;t list those functions as sample code for other=
s to clone.</div><div class=3D"gmail_default" style=3D"font-family:courier =
new,monospace"><br></div><div class=3D"gmail_default" style=3D"font-family:=
courier new,monospace">This edits only sample code and since it&#39;s my fi=
rst patch I thought I&#39;d limit to that.=C2=A0 src/plugins/auth-pam and s=
rc/plugins/down-root have similar &#39;issues&#39;, though, and may need th=
e same treatment, if I have the right idea.</div><div class=3D"gmail_defaul=
t" style=3D"font-family:courier new,monospace"><br></div><div class=3D"gmai=
l_default" style=3D"font-family:courier new,monospace">Thanks for reading.<=
/div><div class=3D"gmail_default" style=3D"font-family:courier new,monospac=
e">-Greg<br></div><div class=3D"gmail_default" style=3D"font-family:courier=
 new,monospace"><br></div><div class=3D"gmail_default" style=3D"font-family=
:courier new,monospace">---<br>=C2=A0sample/sample-plugins/defer/simple.c=
=C2=A0=C2=A0=C2=A0 | 5 +++--<br>=C2=A0sample/sample-plugins/defer/simple.de=
f=C2=A0 | 4 ++--<br>=C2=A0sample/sample-plugins/log/log.c=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 6 ++++--<br>=C2=A0sample/sample-plugins/si=
mple/simple.c=C2=A0=C2=A0 | 6 ++++--<br>=C2=A0sample/sample-plugins/simple/=
simple.def | 4 ++--<br>=C2=A05 files changed, 15 insertions(+), 10 deletion=
s(-)<br><br>diff --git a/sample/sample-plugins/defer/simple.c b/sample/samp=
le-plugins/defer/simple.c<br>index d18695b59d6966e5cc84a19e176ea9ec18d0b452=
..d55e47be01aa346cfc9c70aa24f8722e5a1d67f9 100644<br>--- a/sample/sample-pl=
ugins/defer/simple.c<br>+++ b/sample/sample-plugins/defer/simple.c<br>@@ -1=
31,11 +131,12 @@ atoi_null0(const char *str)<br>=C2=A0}<br><br>=C2=A0OPENVP=
N_EXPORT openvpn_plugin_handle_t<br>-openvpn_plugin_open_v1(unsigned int *t=
ype_mask, const char *argv[], const char *envp[])<br>+openvpn_plugin_open_v=
2(unsigned int *type_mask, const char *argv[], const char *envp[],<br>+=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct openvpn_plugi=
n_string_list **return_list)<br>=C2=A0{<br>=C2=A0=C2=A0=C2=A0=C2=A0 struct =
plugin_context *context;<br><br>-=C2=A0=C2=A0=C2=A0 printf(&quot;FUNC: open=
vpn_plugin_open_v1\n&quot;);<br>+=C2=A0=C2=A0=C2=A0 printf(&quot;FUNC: open=
vpn_plugin_open_v2\n&quot;);<br><br>=C2=A0=C2=A0=C2=A0=C2=A0 /*<br>=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 * Allocate our context<br>diff --git a/sample/samp=
le-plugins/defer/simple.def b/sample/sample-plugins/defer/simple.def<br>ind=
ex a87507d1fdc0f0bfd0434de577a818ef0cc62afb..556f362308bc6ce81829253f7a7fae=
9898be221a 100755<br>--- a/sample/sample-plugins/defer/simple.def<br>+++ b/=
sample/sample-plugins/defer/simple.def<br>@@ -1,6 +1,6 @@<br>=C2=A0LIBRARY=
=C2=A0=C2=A0 OpenVPN_PLUGIN_SAMPLE<br>=C2=A0DESCRIPTION &quot;Sample OpenVP=
N plug-in module.&quot;<br>=C2=A0EXPORTS<br>-=C2=A0=C2=A0 openvpn_plugin_op=
en_v1=C2=A0=C2=A0 @1<br>-=C2=A0=C2=A0 openvpn_plugin_func_v1=C2=A0=C2=A0 @2=
<br>+=C2=A0=C2=A0 openvpn_plugin_open_v2=C2=A0=C2=A0 @1<br>+=C2=A0=C2=A0 op=
envpn_plugin_func_v2=C2=A0=C2=A0 @2<br>=C2=A0=C2=A0=C2=A0 openvpn_plugin_cl=
ose_v1=C2=A0 @3<br>diff --git a/sample/sample-plugins/log/log.c b/sample/sa=
mple-plugins/log/log.c<br>index ecf62c0e653c8ec852ab641e75363747b795c1af..e=
fa8e5184db34f36a311fb61436cdfd61dd02f78 100644<br>--- a/sample/sample-plugi=
ns/log/log.c<br>+++ b/sample/sample-plugins/log/log.c<br>@@ -70,7 +70,8 @@ =
get_env(const char *name, const char *envp[])<br>=C2=A0}<br><br>=C2=A0OPENV=
PN_EXPORT openvpn_plugin_handle_t<br>-openvpn_plugin_open_v1(unsigned int *=
type_mask, const char *argv[], const char *envp[])<br>+openvpn_plugin_open_=
v2(unsigned int *type_mask, const char *argv[], const char *envp[],<br>+=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct openvpn_plugi=
n_string_list **return_list)<br>=C2=A0{<br>=C2=A0=C2=A0=C2=A0=C2=A0 struct =
plugin_context *context;<br><br>@@ -164,7 +165,8 @@ show(const int type, co=
nst char *argv[], const char *envp[])<br>=C2=A0}<br><br>=C2=A0OPENVPN_EXPOR=
T int<br>-openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int =
type, const char *argv[], const char *envp[])<br>+openvpn_plugin_func_v2(op=
envpn_plugin_handle_t handle, const int type, const char *argv[], const cha=
r *envp[],<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vo=
id *per_client_context, struct openvpn_plugin_string_list **return_list)<br=
>=C2=A0{<br>=C2=A0=C2=A0=C2=A0=C2=A0 struct plugin_context *context =3D (st=
ruct plugin_context *) handle;<br><br>diff --git a/sample/sample-plugins/si=
mple/simple.c b/sample/sample-plugins/simple/simple.c<br>index 950c547e22c1=
d44c59812eb90606fbdb52981021..66695950abfcbc6ebb0a4d4fa621627a6099ba76 1006=
44<br>--- a/sample/sample-plugins/simple/simple.c<br>+++ b/sample/sample-pl=
ugins/simple/simple.c<br>@@ -72,7 +72,8 @@ get_env(const char *name, const =
char *envp[])<br>=C2=A0}<br><br>=C2=A0OPENVPN_EXPORT openvpn_plugin_handle_=
t<br>-openvpn_plugin_open_v1(unsigned int *type_mask, const char *argv[], c=
onst char *envp[])<br>+openvpn_plugin_open_v2(unsigned int *type_mask, cons=
t char *argv[], const char *envp[],<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 struct openvpn_plugin_string_list **return_list)<b=
r>=C2=A0{<br>=C2=A0=C2=A0=C2=A0=C2=A0 struct plugin_context *context;<br><b=
r>@@ -97,7 +98,8 @@ openvpn_plugin_open_v1(unsigned int *type_mask, const c=
har *argv[], const char *<br>=C2=A0}<br><br>=C2=A0OPENVPN_EXPORT int<br>-op=
envpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type, const =
char *argv[], const char *envp[])<br>+openvpn_plugin_func_v2(openvpn_plugin=
_handle_t handle, const int type, const char *argv[], const char *envp[],<b=
r>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *per_clie=
nt_context, struct openvpn_plugin_string_list **return_list)<br>=C2=A0{<br>=
=C2=A0=C2=A0=C2=A0=C2=A0 struct plugin_context *context =3D (struct plugin_=
context *) handle;<br><br>diff --git a/sample/sample-plugins/simple/simple.=
def b/sample/sample-plugins/simple/simple.def<br>index a87507d1fdc0f0bfd043=
4de577a818ef0cc62afb..556f362308bc6ce81829253f7a7fae9898be221a 100755<br>--=
- a/sample/sample-plugins/simple/simple.def<br>+++ b/sample/sample-plugins/=
simple/simple.def<br>@@ -1,6 +1,6 @@<br>=C2=A0LIBRARY=C2=A0=C2=A0 OpenVPN_P=
LUGIN_SAMPLE<br>=C2=A0DESCRIPTION &quot;Sample OpenVPN plug-in module.&quot=
;<br>=C2=A0EXPORTS<br>-=C2=A0=C2=A0 openvpn_plugin_open_v1=C2=A0=C2=A0 @1<b=
r>-=C2=A0=C2=A0 openvpn_plugin_func_v1=C2=A0=C2=A0 @2<br>+=C2=A0=C2=A0 open=
vpn_plugin_open_v2=C2=A0=C2=A0 @1<br>+=C2=A0=C2=A0 openvpn_plugin_func_v2=
=C2=A0=C2=A0 @2<br>=C2=A0=C2=A0=C2=A0 openvpn_plugin_close_v1=C2=A0 @3<br>-=
-<br>2.15.2 (Apple Git-101.1)<br></div><div class=3D"gmail_default" style=
=3D"font-family:courier new,monospace"><br></div></div>

--0000000000007a95c0056fdedeb4--

