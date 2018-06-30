MIME-Version: 1.0
In-Reply-To: <1ba4b18f-1861-f211-42ef-9ee23cb92563@...2181...>
References: <CACDCbPo_kdRDHe7-zJZnELyBGBpLEan=hKv6ScTHzE1KT=inzg@...278...>
 <1ba4b18f-1861-f211-42ef-9ee23cb92563@...2181...>
From: Greg Cox <gcox@...1057...>
Date: Sat, 30 Jun 2018 21:08:19 +0000
Message-ID: <CACDCbPq44YQzeGRwvSAaQARKk6GPWZOvDP_UmQ+LxvOyRs9bUQ@...278...>
Content-Type: multipart/alternative; boundary="00000000000031e866056fe25d16"
Subject: Re: [Openvpn-devel] [PATCH] Remove deprecated plugin functions from
 code samples
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--00000000000031e866056fe25d16
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 30, 2018 at 5:49 PM, Antonio Quartulli <a@...2181...> wrote:

> I'd remove the last paragraph and the greetings from the commit message.
> But this might be done at commit time.
>

=E2=80=8BIt was unclear how to handle "explain what I'm wanting" in one mai=
l.
Sorry.
=E2=80=8B

> did you concatenate two patches? or what happened? It seems that the
> part after this is not recognised as proper patch.
>

I think I dropped a few lines from `git format-patch HEAD~1 --stdout`=E2=80=
=8B on
accident.  Take two:



From 2f221fe6111572dc897dc91cfd9ad4929df478ec Mon Sep 17 00:00:00 2001
From: Greg Cox <gcox@...1057...>
Date: Fri, 29 Jun 2018 21:53:54 +0000
Subject: [PATCH] Remove deprecated plugin functions from code samples

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
d18695b59d6966e5cc84a19e176ea9ec18d0b452..d55e47be01aa346cfc9c70aa24f8722e5=
a1d67f9
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
a87507d1fdc0f0bfd0434de577a818ef0cc62afb..556f362308bc6ce81829253f7a7fae989=
8be221a
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
ecf62c0e653c8ec852ab641e75363747b795c1af..efa8e5184db34f36a311fb61436cdfd61=
dd02f78
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
     struct plugin_context *context =3D (struct plugin_context *) handle;

diff --git a/sample/sample-plugins/simple/simple.c
b/sample/sample-plugins/simple/simple.c
index
950c547e22c1d44c59812eb90606fbdb52981021..66695950abfcbc6ebb0a4d4fa621627a6=
099ba76
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
     struct plugin_context *context =3D (struct plugin_context *) handle;

diff --git a/sample/sample-plugins/simple/simple.def
b/sample/sample-plugins/simple/simple.def
index
a87507d1fdc0f0bfd0434de577a818ef0cc62afb..556f362308bc6ce81829253f7a7fae989=
8be221a
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

--00000000000031e866056fe25d16
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sat, Jun 30, 2018 at 5:49 PM, Antonio Quartulli <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:a@...2181..." target=3D"_blank">a@...2181...</a>&gt;</span>=
 wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">I&#39;d remove=
 the last paragraph and the greetings from the commit message.<br>
But this might be done at commit time.<br></blockquote><div><br></div><div =
style=3D"font-family:courier new,monospace" class=3D"gmail_default">=E2=80=
=8BIt was unclear how to handle &quot;explain what I&#39;m wanting&quot; in=
 one mail.=C2=A0 Sorry.<br></div><div style=3D"font-family:courier new,mono=
space" class=3D"gmail_default">=E2=80=8B</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">did you concatenate two patches? or what happened? It =
seems that the<br>
part after this is not recognised as proper patch.<br></blockquote><div>=C2=
=A0</div><div style=3D"font-family:courier new,monospace" class=3D"gmail_de=
fault">I think I dropped a few lines from `git format-patch HEAD~1 --stdout=
`=E2=80=8B on accident.=C2=A0 Take two:</div><div style=3D"font-family:cour=
ier new,monospace" class=3D"gmail_default"><br></div><div style=3D"font-fam=
ily:courier new,monospace" class=3D"gmail_default"><br></div><div style=3D"=
font-family:courier new,monospace" class=3D"gmail_default"><br></div><div s=
tyle=3D"font-family:courier new,monospace" class=3D"gmail_default">From 2f2=
21fe6111572dc897dc91cfd9ad4929df478ec Mon Sep 17 00:00:00 2001<br>From: Gre=
g Cox &lt;<a href=3D"mailto:gcox@...1057...">gcox@...1057...</a>&gt;<br>Dat=
e: Fri, 29 Jun 2018 21:53:54 +0000<br>Subject: [PATCH] Remove deprecated pl=
ugin functions from code samples<br><br>---<br>=C2=A0sample/sample-plugins/=
defer/simple.c=C2=A0=C2=A0=C2=A0 | 5 +++--<br>=C2=A0sample/sample-plugins/d=
efer/simple.def=C2=A0 | 4 ++--<br>=C2=A0sample/sample-plugins/log/log.c=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 6 ++++--<br>=C2=A0sample/sa=
mple-plugins/simple/simple.c=C2=A0=C2=A0 | 6 ++++--<br>=C2=A0sample/sample-=
plugins/simple/simple.def | 4 ++--<br>=C2=A05 files changed, 15 insertions(=
+), 10 deletions(-)<br><br>diff --git a/sample/sample-plugins/defer/simple.=
c b/sample/sample-plugins/defer/simple.c<br>index d18695b59d6966e5cc84a19e1=
76ea9ec18d0b452..d55e47be01aa346cfc9c70aa24f8722e5a1d67f9 100644<br>--- a/s=
ample/sample-plugins/defer/simple.c<br>+++ b/sample/sample-plugins/defer/si=
mple.c<br>@@ -131,11 +131,12 @@ atoi_null0(const char *str)<br>=C2=A0}<br><=
br>=C2=A0OPENVPN_EXPORT openvpn_plugin_handle_t<br>-openvpn_plugin_open_v1(=
unsigned int *type_mask, const char *argv[], const char *envp[])<br>+openvp=
n_plugin_open_v2(unsigned int *type_mask, const char *argv[], const char *e=
nvp[],<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struc=
t openvpn_plugin_string_list **return_list)<br>=C2=A0{<br>=C2=A0=C2=A0=C2=
=A0=C2=A0 struct plugin_context *context;<br><br>-=C2=A0=C2=A0=C2=A0 printf=
(&quot;FUNC: openvpn_plugin_open_v1\n&quot;);<br>+=C2=A0=C2=A0=C2=A0 printf=
(&quot;FUNC: openvpn_plugin_open_v2\n&quot;);<br><br>=C2=A0=C2=A0=C2=A0=C2=
=A0 /*<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Allocate our context<br>diff --g=
it a/sample/sample-plugins/defer/simple.def b/sample/sample-plugins/defer/s=
imple.def<br>index a87507d1fdc0f0bfd0434de577a818ef0cc62afb..556f362308bc6c=
e81829253f7a7fae9898be221a 100755<br>--- a/sample/sample-plugins/defer/simp=
le.def<br>+++ b/sample/sample-plugins/defer/simple.def<br>@@ -1,6 +1,6 @@<b=
r>=C2=A0LIBRARY=C2=A0=C2=A0 OpenVPN_PLUGIN_SAMPLE<br>=C2=A0DESCRIPTION &quo=
t;Sample OpenVPN plug-in module.&quot;<br>=C2=A0EXPORTS<br>-=C2=A0=C2=A0 op=
envpn_plugin_open_v1=C2=A0=C2=A0 @1<br>-=C2=A0=C2=A0 openvpn_plugin_func_v1=
=C2=A0=C2=A0 @2<br>+=C2=A0=C2=A0 openvpn_plugin_open_v2=C2=A0=C2=A0 @1<br>+=
=C2=A0=C2=A0 openvpn_plugin_func_v2=C2=A0=C2=A0 @2<br>=C2=A0=C2=A0=C2=A0 op=
envpn_plugin_close_v1=C2=A0 @3<br>diff --git a/sample/sample-plugins/log/lo=
g.c b/sample/sample-plugins/log/log.c<br>index ecf62c0e653c8ec852ab641e7536=
3747b795c1af..efa8e5184db34f36a311fb61436cdfd61dd02f78 100644<br>--- a/samp=
le/sample-plugins/log/log.c<br>+++ b/sample/sample-plugins/log/log.c<br>@@ =
-70,7 +70,8 @@ get_env(const char *name, const char *envp[])<br>=C2=A0}<br>=
<br>=C2=A0OPENVPN_EXPORT openvpn_plugin_handle_t<br>-openvpn_plugin_open_v1=
(unsigned int *type_mask, const char *argv[], const char *envp[])<br>+openv=
pn_plugin_open_v2(unsigned int *type_mask, const char *argv[], const char *=
envp[],<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struc=
t openvpn_plugin_string_list **return_list)<br>=C2=A0{<br>=C2=A0=C2=A0=C2=
=A0=C2=A0 struct plugin_context *context;<br><br>@@ -164,7 +165,8 @@ show(c=
onst int type, const char *argv[], const char *envp[])<br>=C2=A0}<br><br>=
=C2=A0OPENVPN_EXPORT int<br>-openvpn_plugin_func_v1(openvpn_plugin_handle_t=
 handle, const int type, const char *argv[], const char *envp[])<br>+openvp=
n_plugin_func_v2(openvpn_plugin_handle_t handle, const int type, const char=
 *argv[], const char *envp[],<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 void *per_client_context, struct openvpn_plugin_string_l=
ist **return_list)<br>=C2=A0{<br>=C2=A0=C2=A0=C2=A0=C2=A0 struct plugin_con=
text *context =3D (struct plugin_context *) handle;<br><br>diff --git a/sam=
ple/sample-plugins/simple/simple.c b/sample/sample-plugins/simple/simple.c<=
br>index 950c547e22c1d44c59812eb90606fbdb52981021..66695950abfcbc6ebb0a4d4f=
a621627a6099ba76 100644<br>--- a/sample/sample-plugins/simple/simple.c<br>+=
++ b/sample/sample-plugins/simple/simple.c<br>@@ -72,7 +72,8 @@ get_env(con=
st char *name, const char *envp[])<br>=C2=A0}<br><br>=C2=A0OPENVPN_EXPORT o=
penvpn_plugin_handle_t<br>-openvpn_plugin_open_v1(unsigned int *type_mask, =
const char *argv[], const char *envp[])<br>+openvpn_plugin_open_v2(unsigned=
 int *type_mask, const char *argv[], const char *envp[],<br>+=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct openvpn_plugin_string_=
list **return_list)<br>=C2=A0{<br>=C2=A0=C2=A0=C2=A0=C2=A0 struct plugin_co=
ntext *context;<br><br>@@ -97,7 +98,8 @@ openvpn_plugin_open_v1(unsigned in=
t *type_mask, const char *argv[], const char *<br>=C2=A0}<br><br>=C2=A0OPEN=
VPN_EXPORT int<br>-openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, c=
onst int type, const char *argv[], const char *envp[])<br>+openvpn_plugin_f=
unc_v2(openvpn_plugin_handle_t handle, const int type, const char *argv[], =
const char *envp[],<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 void *per_client_context, struct openvpn_plugin_string_list **return=
_list)<br>=C2=A0{<br>=C2=A0=C2=A0=C2=A0=C2=A0 struct plugin_context *contex=
t =3D (struct plugin_context *) handle;<br><br>diff --git a/sample/sample-p=
lugins/simple/simple.def b/sample/sample-plugins/simple/simple.def<br>index=
 a87507d1fdc0f0bfd0434de577a818ef0cc62afb..556f362308bc6ce81829253f7a7fae98=
98be221a 100755<br>--- a/sample/sample-plugins/simple/simple.def<br>+++ b/s=
ample/sample-plugins/simple/simple.def<br>@@ -1,6 +1,6 @@<br>=C2=A0LIBRARY=
=C2=A0=C2=A0 OpenVPN_PLUGIN_SAMPLE<br>=C2=A0DESCRIPTION &quot;Sample OpenVP=
N plug-in module.&quot;<br>=C2=A0EXPORTS<br>-=C2=A0=C2=A0 openvpn_plugin_op=
en_v1=C2=A0=C2=A0 @1<br>-=C2=A0=C2=A0 openvpn_plugin_func_v1=C2=A0=C2=A0 @2=
<br>+=C2=A0=C2=A0 openvpn_plugin_open_v2=C2=A0=C2=A0 @1<br>+=C2=A0=C2=A0 op=
envpn_plugin_func_v2=C2=A0=C2=A0 @2<br>=C2=A0=C2=A0=C2=A0 openvpn_plugin_cl=
ose_v1=C2=A0 @3<br>--<br>2.15.2 (Apple Git-101.1)<br><br></div><br></div></=
div></div>

--00000000000031e866056fe25d16--

