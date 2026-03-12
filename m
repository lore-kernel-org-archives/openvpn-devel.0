From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 12 Mar 2026 14:28:56 +0000
In-Reply-To: <gerrit.1769789455000.I96b6acffd7e5149d4c9488a06e43c62711b31cfc@...2715...>
References: <gerrit.1769789455000.I96b6acffd7e5149d4c9488a06e43c62711b31cfc@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <04803c650a1ce13a96eab4ae2fc8c69d76d09710-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ggBMFDR7uoo="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: error: Use
 SOCKET_UNDEFINED instead of -1 to avoid sign error on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ggBMFDR7uoo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
01?usp=3Demail )

Change subject: error: Use SOCKET_UNDEFINED instead of -1 to avoid sign err=
or on Windows
......................................................................

error: Use SOCKET_UNDEFINED instead of -1 to avoid sign error on Windows

While here also mark a comparison we know is safe
with an explicit cast.

Change-Id: I96b6acffd7e5149d4c9488a06e43c62711b31cfc
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1501
Message-Id: <20260312074123.30838-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
046.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/error.c
1 file changed, 13 insertions(+), 24 deletions(-)




diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 6fb4f32..2900352 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -97,15 +97,10 @@
     forked =3D true;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 bool
 set_debug_level(const int level, const unsigned int flags)
 {
-    if (level >=3D 0 && level <=3D M_DEBUG_LEVEL)
+    if (level >=3D 0 && (unsigned int)level <=3D M_DEBUG_LEVEL)
     {
         x_debug_level =3D (msglvl_t)level;
         return true;
@@ -118,10 +113,6 @@
     return false;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 bool
 set_mute_cutoff(const int cutoff)
 {
@@ -621,11 +612,6 @@
     x_cs_verbose_level =3D verbose_level;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 /*
  * Called after most socket or tun/tap operations, via the inline
  * function check_status().
@@ -674,15 +660,22 @@
         {
             if (extended_msg)
             {
-                msg(x_cs_info_level, "%s %s [%s]: %s (fd=3D" SOCKET_PRINTF=
 ",code=3D%d)", description,
-                    sock ? proto2ascii(sock->info.proto, sock->info.af, tr=
ue) : "", extended_msg,
-                    openvpn_strerror(my_errno, crt_error, &gc), sock ? soc=
k->sd : -1, my_errno);
+                msg(x_cs_info_level, "%s %s [%s]: %s (fd=3D" SOCKET_PRINTF=
 ",code=3D%d)",
+                    description,
+                    sock ? proto2ascii(sock->info.proto, sock->info.af, tr=
ue) : "",
+                    extended_msg,
+                    openvpn_strerror(my_errno, crt_error, &gc),
+                    sock ? sock->sd : SOCKET_UNDEFINED,
+                    my_errno);
             }
             else
             {
-                msg(x_cs_info_level, "%s %s: %s (fd=3D" SOCKET_PRINTF ",co=
de=3D%d)", description,
+                msg(x_cs_info_level, "%s %s: %s (fd=3D" SOCKET_PRINTF ",co=
de=3D%d)",
+                    description,
                     sock ? proto2ascii(sock->info.proto, sock->info.af, tr=
ue) : "",
-                    openvpn_strerror(my_errno, crt_error, &gc), sock ? soc=
k->sd : -1, my_errno);
+                    openvpn_strerror(my_errno, crt_error, &gc),
+                    sock ? sock->sd : SOCKET_UNDEFINED,
+                    my_errno);
             }

             if (x_cs_err_delay_ms)
@@ -694,10 +687,6 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  * In multiclient mode, put a client-specific prefix
  * before each message.

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1501?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I96b6acffd7e5149d4c9488a06e43c62711b31cfc
Gerrit-Change-Number: 1501
Gerrit-PatchSet: 9
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ggBMFDR7uoo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1501?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">error: Use SOCKET_UNDEFINED instead of -1 to avo=
id sign error on Windows<br><br>While here also mark a comparison we know i=
s safe<br>with an explicit cast.<br><br>Change-Id: I96b6acffd7e5149d4c9488a=
06e43c62711b31cfc<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&=
gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https:=
//gerrit.openvpn.net/c/openvpn/+/1501<br>Message-Id: &lt;20260312074123.308=
38-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel=
@lists.sourceforge.net/msg36046.html<br>Signed-off-by: Gert Doering &lt;ger=
t@...1296...&gt;<br>---<br>M src/openvpn/error.c<br>1 file changed, 13 inse=
rtions(+), 24 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/error.c b/src/openvpn/error.c</span><br><span>i=
ndex 6fb4f32..2900352 100644</span><br><span>--- a/src/openvpn/error.c</spa=
n><br><span>+++ b/src/openvpn/error.c</span><br><span>@@ -97,15 +97,10 @@</=
span><br><span>     forked =3D true;</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) |=
| defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span> bool</span><br><span> set_debug=
_level(const int level, const unsigned int flags)</span><br><span> {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if (level &gt;=3D 0 &amp=
;&amp; level &lt;=3D M_DEBUG_LEVEL)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (level &gt;=3D 0 &amp;&amp; (unsigned int)level &lt;=
=3D M_DEBUG_LEVEL)</span><br><span>     {</span><br><span>         x_debug_=
level =3D (msglvl_t)level;</span><br><span>         return true;</span><br>=
<span>@@ -118,10 +113,6 @@</span><br><span>     return false;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span> bool</span><br><span> set_mute_cutoff(const=
 int cutoff)</span><br><span> {</span><br><span>@@ -621,11 +612,6 @@</span>=
<br><span>     x_cs_verbose_level =3D verbose_level;</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if def=
ined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-compare&qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><s=
pan>  * Called after most socket or tun/tap operations, via the inline</spa=
n><br><span>  * function check_status().</span><br><span>@@ -674,15 +660,22=
 @@</span><br><span>         {</span><br><span>             if (extended_ms=
g)</span><br><span>             {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                msg(x_cs_info_level, &quot;%s %s [%s]: %s (fd=
=3D&quot; SOCKET_PRINTF &quot;,code=3D%d)&quot;, description,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                    sock ? proto2as=
cii(sock-&gt;info.proto, sock-&gt;info.af, true) : &quot;&quot;, extended_m=
sg,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
  openvpn_strerror(my_errno, crt_error, &amp;gc), sock ? sock-&gt;sd : -1, =
my_errno);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       msg(x_cs_info_level, &quot;%s %s [%s]: %s (fd=3D&quot; SOCKET_PRINTF=
 &quot;,code=3D%d)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    description,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    sock ? proto2ascii(sock-&gt;info.pro=
to, sock-&gt;info.af, true) : &quot;&quot;,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                    extended_msg,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                    openvpn_strerror(=
my_errno, crt_error, &amp;gc),</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                    sock ? sock-&gt;sd : SOCKET_UNDEFINED,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    my_er=
rno);</span><br><span>             }</span><br><span>             else</spa=
n><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                msg(x_cs_info_level, &quot;%s %s: %s (fd=3D&quot; SOCK=
ET_PRINTF &quot;,code=3D%d)&quot;, description,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                msg(x_cs_info_level, &quot;%s %=
s: %s (fd=3D&quot; SOCKET_PRINTF &quot;,code=3D%d)&quot;,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                    description,</spa=
n><br><span>                     sock ? proto2ascii(sock-&gt;info.proto, so=
ck-&gt;info.af, true) : &quot;&quot;,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                    openvpn_strerror(my_errno, crt_error, &=
amp;gc), sock ? sock-&gt;sd : -1, my_errno);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                    openvpn_strerror(my_errno, crt=
_error, &amp;gc),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  sock ? sock-&gt;sd : SOCKET_UNDEFINED,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    my_errno);</span><=
br><span>             }</span><br><span> </span><br><span>             if (=
x_cs_err_delay_ms)</span><br><span>@@ -694,10 +687,6 @@</span><br><span>   =
  }</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * In=
 multiclient mode, put a client-specific prefix</span><br><span>  * before =
each message.</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1501?usp=3Demail">change 1501</a>. T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope item=
type=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1501?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I96b6acffd7e5149d4c9488a06e4=
3c62711b31cfc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1501 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--ggBMFDR7uoo=--

