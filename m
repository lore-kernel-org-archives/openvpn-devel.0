From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 30 Jan 2026 16:11:05 +0000
References: <gerrit.1769789455000.I96b6acffd7e5149d4c9488a06e43c62711b31cfc@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <4500403236333562b750a87d6f9824eb0088fe13-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="J3qnaFAUBHY="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--J3qnaFAUBHY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1501?usp=3Demail

to review the following change.


Change subject: error: Use SOCKET_UNDEFINED instead of -1 to avoid sign err=
or on Windows
......................................................................

error: Use SOCKET_UNDEFINED instead of -1 to avoid sign error on Windows

While here also mark a comparison we know is safe
with an explicit cast.

Change-Id: I96b6acffd7e5149d4c9488a06e43c62711b31cfc
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/error.c
1 file changed, 13 insertions(+), 24 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/01/1501/1

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
=20
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I96b6acffd7e5149d4c9488a06e43c62711b31cfc
Gerrit-Change-Number: 1501
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--J3qnaFAUBHY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1501?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">error: Use SOCKET_UNDEFINED instead of -1 t=
o avoid sign error on Windows<br><br>While here also mark a comparison we k=
now is safe<br>with an explicit cast.<br><br>Change-Id: I96b6acffd7e5149d4c=
9488a06e43c62711b31cfc<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2716...=
1...&gt;<br>---<br>M src/openvpn/error.c<br>1 file changed, 13 insertions(+=
), 24 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn=
.net:29418/openvpn refs/changes/01/1501/1</pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/=
error.c b/src/openvpn/error.c</span><br><span>index 6fb4f32..2900352 100644=
</span><br><span>--- a/src/openvpn/error.c</span><br><span>+++ b/src/openvp=
n/error.c</span><br><span>@@ -97,15 +97,10 @@</span><br><span>     forked =
=3D true;</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic=
 ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span> bool</span><br><span> set_debug_level(const int level, con=
st unsigned int flags)</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (level &gt;=3D 0 &amp;&amp; level &lt;=3D M_DEBU=
G_LEVEL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (lev=
el &gt;=3D 0 &amp;&amp; (unsigned int)level &lt;=3D M_DEBUG_LEVEL)</span><b=
r><span>     {</span><br><span>         x_debug_level =3D (msglvl_t)level;<=
/span><br><span>         return true;</span><br><span>@@ -118,10 +113,6 @@<=
/span><br><span>     return false;</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || =
defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pr=
agma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan> bool</span><br><span> set_mute_cutoff(const int cutoff)</span><br><spa=
n> {</span><br><span>@@ -621,11 +612,6 @@</span><br><span>     x_cs_verbose=
_level =3D verbose_level;</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(_=
_clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC =
diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragm=
a GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * Called after most=
 socket or tun/tap operations, via the inline</span><br><span>  * function =
check_status().</span><br><span>@@ -674,15 +660,22 @@</span><br><span>     =
    {</span><br><span>             if (extended_msg)</span><br><span>      =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   msg(x_cs_info_level, &quot;%s %s [%s]: %s (fd=3D&quot; SOCKET_PRINTF &qu=
ot;,code=3D%d)&quot;, description,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                    sock ? proto2ascii(sock-&gt;info.proto, so=
ck-&gt;info.af, true) : &quot;&quot;, extended_msg,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    openvpn_strerror(my_err=
no, crt_error, &amp;gc), sock ? sock-&gt;sd : -1, my_errno);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                msg(x_cs_info_leve=
l, &quot;%s %s [%s]: %s (fd=3D&quot; SOCKET_PRINTF &quot;,code=3D%d)&quot;,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 description,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              sock ? proto2ascii(sock-&gt;info.proto, sock-&gt;info.af, tru=
e) : &quot;&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                   extended_msg,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                    openvpn_strerror(my_errno, crt_error, &amp=
;gc),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
      sock ? sock-&gt;sd : SOCKET_UNDEFINED,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                    my_errno);</span><br><span>   =
          }</span><br><span>             else</span><br><span>             =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(=
x_cs_info_level, &quot;%s %s: %s (fd=3D&quot; SOCKET_PRINTF &quot;,code=3D%=
d)&quot;, description,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                msg(x_cs_info_level, &quot;%s %s: %s (fd=3D&quot; SOCKET=
_PRINTF &quot;,code=3D%d)&quot;,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                    description,</span><br><span>             =
        sock ? proto2ascii(sock-&gt;info.proto, sock-&gt;info.af, true) : &=
quot;&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
           openvpn_strerror(my_errno, crt_error, &amp;gc), sock ? sock-&gt;=
sd : -1, my_errno);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    openvpn_strerror(my_errno, crt_error, &amp;gc),</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                    sock ? =
sock-&gt;sd : SOCKET_UNDEFINED,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    my_errno);</span><br><span>             }</=
span><br><span> </span><br><span>             if (x_cs_err_delay_ms)</span>=
<br><span>@@ -694,10 +687,6 @@</span><br><span>     }</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if de=
fined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span> /*</span><br><span>  * In multiclient mode, put a c=
lient-specific prefix</span><br><span>  * before each message.</span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1501?usp=3Demail">change 1501</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?=
usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1501?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I96b6acffd7e5149d4c9488a06e4=
3c62711b31cfc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1501 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--J3qnaFAUBHY=--

