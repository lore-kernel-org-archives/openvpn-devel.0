From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 15 Jan 2025 14:33:08 +0000
In-Reply-To: <gerrit.1736860439000.I1918c43202b87f0c987bfd9155c739da7dd02632@...2715...>
References: <gerrit.1736860439000.I1918c43202b87f0c987bfd9155c739da7dd02632@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <3853e8478d0b24010e4250d3c1aba2c110165382-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3CdRgMsd3pQ="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--3CdRgMsd3pQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/865?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Fix some trivial sign-compare compiler warnings
......................................................................

Fix some trivial sign-compare compiler warnings

Change-Id: I1918c43202b87f0c987bfd9155c739da7dd02632
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250114165206.13187-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
455.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/options.c
M src/openvpn/socket.c
M src/openvpn/tun.c
3 files changed, 6 insertions(+), 10 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/65/865/4

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index eb0d9b5..3ef4d78 100644
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
index f9f2a3b..7765372 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -3132,8 +3132,7 @@
 int
 ascii2proto(const char *proto_name)
 {
-    int i;
-    for (i =3D 0; i < SIZE(proto_names); ++i)
+    for (size_t i =3D 0; i < SIZE(proto_names); ++i)
     {
         if (!strcmp(proto_name, proto_names[i].short_form))
         {
@@ -3146,8 +3145,7 @@
 sa_family_t
 ascii2af(const char *proto_name)
 {
-    int i;
-    for (i =3D 0; i < SIZE(proto_names); ++i)
+    for (size_t i =3D 0; i < SIZE(proto_names); ++i)
     {
         if (!strcmp(proto_name, proto_names[i].short_form))
         {
@@ -3160,8 +3158,7 @@
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
@@ -3183,9 +3180,8 @@
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
index 7fbd6c3..33830fc 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -669,7 +669,7 @@
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
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--3CdRgMsd3pQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/865?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Fix some trivial sign-compare compiler warnings<br><=
br>Change-Id: I1918c43202b87f0c987bfd9155c739da7dd02632<br>Signed-off-by: F=
rank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;ger=
t@...1296...&gt;<br>Message-Id: &lt;20250114165206.13187-1-gert@...1296...&=
gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...475...=
t/msg30455.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>-=
--<br>M src/openvpn/options.c<br>M src/openvpn/socket.c<br>M src/openvpn/tu=
n.c<br>3 files changed, 6 insertions(+), 10 deletions(-)<br><br></pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit.openvpn.net:29418/openvpn refs/changes/65/865/4</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>index=
 eb0d9b5..3ef4d78 100644</span><br><span>--- a/src/openvpn/options.c</span>=
<br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -1448,7 +1448,7 @@=
</span><br><span> </span><br><span>     while (server)</span><br><span>    =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        for (int i =
=3D 0; i &lt; server-&gt;addr_count; ++i)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        for (size_t i =3D 0; i &lt; server-&gt;addr_c=
ount; ++i)</span><br><span>         {</span><br><span>             if (serv=
er-&gt;addr[i].family =3D=3D AF_INET)</span><br><span>             {</span>=
<br><span>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><b=
r><span>index f9f2a3b..7765372 100644</span><br><span>--- a/src/openvpn/soc=
ket.c</span><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -3132,8=
 +3132,7 @@</span><br><span> int</span><br><span> ascii2proto(const char *p=
roto_name)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 for (i =3D 0; i &lt; SIZE(proto_names); ++i)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; SIZE(proto_names)=
; ++i)</span><br><span>     {</span><br><span>         if (!strcmp(proto_na=
me, proto_names[i].short_form))</span><br><span>         {</span><br><span>=
@@ -3146,8 +3145,7 @@</span><br><span> sa_family_t</span><br><span> ascii2a=
f(const char *proto_name)</span><br><span> {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    int i;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    for (i =3D 0; i &lt; SIZE(proto_names); ++i)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; SI=
ZE(proto_names); ++i)</span><br><span>     {</span><br><span>         if (!=
strcmp(proto_name, proto_names[i].short_form))</span><br><span>         {</=
span><br><span>@@ -3160,8 +3158,7 @@</span><br><span> const char *</span><b=
r><span> proto2ascii(int proto, sa_family_t af, bool display_form)</span><b=
r><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigne=
d int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =
=3D 0; i &lt; SIZE(proto_names); ++i)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    for (size_t i =3D 0; i &lt; SIZE(proto_names); ++i)</=
span><br><span>     {</span><br><span>         if (proto_names[i].proto_af =
=3D=3D af &amp;&amp; proto_names[i].proto =3D=3D proto)</span><br><span>   =
      {</span><br><span>@@ -3183,9 +3180,8 @@</span><br><span> proto2ascii_=
all(struct gc_arena *gc)</span><br><span> {</span><br><span>     struct buf=
fer out =3D alloc_buf_gc(256, gc);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    int i;</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    for (i =3D 0; i &lt; SIZE(proto_names); ++i)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i=
 &lt; SIZE(proto_names); ++i)</span><br><span>     {</span><br><span>      =
   if (i)</span><br><span>         {</span><br><span>diff --git a/src/openv=
pn/tun.c b/src/openvpn/tun.c</span><br><span>index 7fbd6c3..33830fc 100644<=
/span><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/openvpn/t=
un.c</span><br><span>@@ -669,7 +669,7 @@</span><br><span> {</span><br><span=
>     struct gc_arena gc =3D gc_new();</span><br><span>     struct route_ga=
teway_info rgi;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    co=
nst int needed =3D (RGI_ADDR_DEFINED|RGI_NETMASK_DEFINED);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const unsigned int needed =3D (R=
GI_ADDR_DEFINED|RGI_NETMASK_DEFINED);</span><br><span> </span><br><span>   =
  get_default_gateway(&amp;rgi, ctx);</span><br><span>     if ((rgi.flags &=
amp; needed) =3D=3D needed)</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/865?usp=3Demail">chang=
e 865</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/865?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1918c43202b87f0c987bfd9155c=
739da7dd02632 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 865 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--3CdRgMsd3pQ=--

