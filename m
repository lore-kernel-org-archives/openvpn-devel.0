From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 14 Jan 2025 13:14:17 +0000
References: <gerrit.1736860439000.I1918c43202b87f0c987bfd9155c739da7dd02632@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e708ea5de292eede6ec49bef5edf41f10178b645-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="B+2PlXg0qe8="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix some trivial
 sign-compare compiler warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--B+2PlXg0qe8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/865?usp=3Demail

to review the following change.


Change subject: Fix some trivial sign-compare compiler warnings
......................................................................

Fix some trivial sign-compare compiler warnings

Change-Id: I1918c43202b87f0c987bfd9155c739da7dd02632
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/options.c
M src/openvpn/socket.c
M src/openvpn/tun.c
3 files changed, 6 insertions(+), 10 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/65/865/1

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 1113663..b594b09 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1448,7 +1448,7 @@

     while (server)
     {
-        for (int i =3D 0; i < server->addr_count; ++i)
+        for (size_t i =3D 0; i < server->addr_count; ++i)
         {
             if (server->addr[i].family =3D=3D AF_INET)
             {
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 234d590..4aeb613 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -3131,8 +3131,7 @@
 int
 ascii2proto(const char *proto_name)
 {
-    int i;
-    for (i =3D 0; i < SIZE(proto_names); ++i)
+    for (size_t i =3D 0; i < SIZE(proto_names); ++i)
     {
         if (!strcmp(proto_name, proto_names[i].short_form))
         {
@@ -3145,8 +3144,7 @@
 sa_family_t
 ascii2af(const char *proto_name)
 {
-    int i;
-    for (i =3D 0; i < SIZE(proto_names); ++i)
+    for (size_t i =3D 0; i < SIZE(proto_names); ++i)
     {
         if (!strcmp(proto_name, proto_names[i].short_form))
         {
@@ -3159,8 +3157,7 @@
 const char *
 proto2ascii(int proto, sa_family_t af, bool display_form)
 {
-    unsigned int i;
-    for (i =3D 0; i < SIZE(proto_names); ++i)
+    for (size_t i =3D 0; i < SIZE(proto_names); ++i)
     {
         if (proto_names[i].proto_af =3D=3D af && proto_names[i].proto =3D=
=3D proto)
         {
@@ -3182,9 +3179,8 @@
 proto2ascii_all(struct gc_arena *gc)
 {
     struct buffer out =3D alloc_buf_gc(256, gc);
-    int i;

-    for (i =3D 0; i < SIZE(proto_names); ++i)
+    for (size_t i =3D 0; i < SIZE(proto_names); ++i)
     {
         if (i)
         {
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 3f2ec4a..22706f3 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -631,7 +631,7 @@
 {
     struct gc_arena gc =3D gc_new();
     struct route_gateway_info rgi;
-    const int needed =3D (RGI_ADDR_DEFINED|RGI_NETMASK_DEFINED);
+    const unsigned int needed =3D (RGI_ADDR_DEFINED|RGI_NETMASK_DEFINED);

     get_default_gateway(&rgi, ctx);
     if ((rgi.flags & needed) =3D=3D needed)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/865?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1918c43202b87f0c987bfd9155c739da7dd02632
Gerrit-Change-Number: 865
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--B+2PlXg0qe8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/865?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Fix some trivial sign-compare compiler warnings<br><br>Change=
-Id: I1918c43202b87f0c987bfd9155c739da7dd02632<br>Signed-off-by: Frank Lich=
tenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/options.c<br>M src=
/openvpn/socket.c<br>M src/openvpn/tun.c<br>3 files changed, 6 insertions(+=
), 10 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvp=
n refs/changes/65/865/1</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/src/openvpn/options.c b/src/op=
envpn/options.c</span><br><span>index 1113663..b594b09 100644</span><br><sp=
an>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c<=
/span><br><span>@@ -1448,7 +1448,7 @@</span><br><span> </span><br><span>   =
  while (server)</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        for (int i =3D 0; i &lt; server-&gt;addr_count; +=
+i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (siz=
e_t i =3D 0; i &lt; server-&gt;addr_count; ++i)</span><br><span>         {<=
/span><br><span>             if (server-&gt;addr[i].family =3D=3D AF_INET)<=
/span><br><span>             {</span><br><span>diff --git a/src/openvpn/soc=
ket.c b/src/openvpn/socket.c</span><br><span>index 234d590..4aeb613 100644<=
/span><br><span>--- a/src/openvpn/socket.c</span><br><span>+++ b/src/openvp=
n/socket.c</span><br><span>@@ -3131,8 +3131,7 @@</span><br><span> int</span=
><br><span> ascii2proto(const char *proto_name)</span><br><span> {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; SIZE(proto_names=
); ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (siz=
e_t i =3D 0; i &lt; SIZE(proto_names); ++i)</span><br><span>     {</span><b=
r><span>         if (!strcmp(proto_name, proto_names[i].short_form))</span>=
<br><span>         {</span><br><span>@@ -3145,8 +3144,7 @@</span><br><span>=
 sa_family_t</span><br><span> ascii2af(const char *proto_name)</span><br><s=
pan> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; S=
IZE(proto_names); ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    for (size_t i =3D 0; i &lt; SIZE(proto_names); ++i)</span><br><span>=
     {</span><br><span>         if (!strcmp(proto_name, proto_names[i].shor=
t_form))</span><br><span>         {</span><br><span>@@ -3159,8 +3157,7 @@</=
span><br><span> const char *</span><br><span> proto2ascii(int proto, sa_fam=
ily_t af, bool display_form)</span><br><span> {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    unsigned int i;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; SIZE(proto_names); ++i)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D =
0; i &lt; SIZE(proto_names); ++i)</span><br><span>     {</span><br><span>  =
       if (proto_names[i].proto_af =3D=3D af &amp;&amp; proto_names[i].prot=
o =3D=3D proto)</span><br><span>         {</span><br><span>@@ -3182,9 +3179=
,8 @@</span><br><span> proto2ascii_all(struct gc_arena *gc)</span><br><span=
> {</span><br><span>     struct buffer out =3D alloc_buf_gc(256, gc);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i =
&lt; SIZE(proto_names); ++i)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    for (size_t i =3D 0; i &lt; SIZE(proto_names); ++i)</span><br>=
<span>     {</span><br><span>         if (i)</span><br><span>         {</sp=
an><br><span>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><=
span>index 3f2ec4a..22706f3 100644</span><br><span>--- a/src/openvpn/tun.c<=
/span><br><span>+++ b/src/openvpn/tun.c</span><br><span>@@ -631,7 +631,7 @@=
</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</=
span><br><span>     struct route_gateway_info rgi;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    const int needed =3D (RGI_ADDR_DEFINED|RGI=
_NETMASK_DEFINED);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const unsigned int needed =3D (RGI_ADDR_DEFINED|RGI_NETMASK_DEFINED);</s=
pan><br><span> </span><br><span>     get_default_gateway(&amp;rgi, ctx);</s=
pan><br><span>     if ((rgi.flags &amp; needed) =3D=3D needed)</span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/865?usp=3Demail">change 865</a>. To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">s=
ettings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/865?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1918c43202b87f0c987bfd9155c=
739da7dd02632 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 865 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--B+2PlXg0qe8=--

