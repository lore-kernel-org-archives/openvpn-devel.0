From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 8 Oct 2025 16:12:00 +0000
References: <gerrit.1759939917000.I41b9f7686180f2549bd4984cbbf66059f0ba2b15@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <59459c86e0ed39369f7987a568ffeca6f4ef2985-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tAFzV9lhQqg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: init: Fix conversion
 warnings
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

--tAFzV9lhQqg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1259?usp=3Demail

to review the following change.


Change subject: init: Fix conversion warnings
......................................................................

init: Fix conversion warnings

Can be separated in mostly two classes of issues:
 - Return type of get_random is long, but we ensure that value
   is in range so we can cast it to whatever we need.
 - Doing MTU match in size_t even though most of the input
   values are int.

Change-Id: I41b9f7686180f2549bd4984cbbf66059f0ba2b15
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/init.c
1 file changed, 14 insertions(+), 26 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/59/1259/1

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index f8a0fee..81b9ca9 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -455,11 +455,6 @@
 }
 #endif /* ENABLE_MANAGEMENT */

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /*
  * Initialize and possibly randomize the connection list.
  *
@@ -482,7 +477,7 @@
         int i;
         for (i =3D l->len - 1; i > 0; --i)
         {
-            const int j =3D get_random() % (i + 1);
+            const long j =3D get_random() % (i + 1);
             if (i !=3D j)
             {
                 struct connection_entry *tmp;
@@ -842,7 +837,7 @@
     struct timeval tv;
     if (!gettimeofday(&tv, NULL))
     {
-        const unsigned int seed =3D (unsigned int)tv.tv_sec ^ tv.tv_usec;
+        const unsigned int seed =3D (unsigned int)(tv.tv_sec ^ tv.tv_usec);
         srandom(seed);
     }

@@ -2873,17 +2868,17 @@
     }
 }

-static size_t
+static int
 get_frame_mtu(struct context *c, const struct options *o)
 {
-    size_t mtu;
+    int mtu;

     if (o->ce.link_mtu_defined)
     {
         ASSERT(o->ce.link_mtu_defined);
         /* if we have a link mtu defined we calculate what the old code
          * would have come up with as tun-mtu */
-        size_t overhead =3D frame_calculate_protocol_header_size(&c->c1.ks=
.key_type, o, true);
+        int overhead =3D (int)frame_calculate_protocol_header_size(&c->c1.=
ks.key_type, o, true);
         mtu =3D o->ce.link_mtu - overhead;
     }
     else
@@ -2894,7 +2889,7 @@

     if (mtu < TUN_MTU_MIN)
     {
-        msg(M_WARN, "TUN MTU value (%zu) must be at least %d", mtu, TUN_MT=
U_MIN);
+        msg(M_WARN, "TUN MTU value (%d) must be at least %d", mtu, TUN_MTU=
_MIN);
         frame_print(&c->c2.frame, M_FATAL, "MTU is too small");
     }
     return mtu;
@@ -2923,7 +2918,7 @@
      * space to allow server to push "baby giant" MTU sizes */
     frame->tun_max_mtu =3D max_int(TUN_MTU_MAX_MIN, frame->tun_max_mtu);

-    size_t payload_size =3D frame->tun_max_mtu;
+    int payload_size =3D frame->tun_max_mtu;

     /* we need to be also large enough to hold larger control channel pack=
ets
      * if configured */
@@ -2942,7 +2937,7 @@

     /* the space that is reserved before the payload to add extra headers =
to it
      * we always reserve the space for the worst case */
-    size_t headroom =3D 0;
+    int headroom =3D 0;

     /* includes IV and packet ID */
     headroom +=3D crypto_max_overhead();
@@ -2966,11 +2961,11 @@
     /* the space after the payload, this needs some extra buffer space for
      * encryption so headroom is probably too much but we do not really ca=
re
      * the few extra bytes */
-    size_t tailroom =3D headroom;
+    int tailroom =3D headroom;

 #ifdef USE_COMP
     msg(D_MTU_DEBUG,
-        "MTU: adding %zu buffer tailroom for compression for %zu "
+        "MTU: adding %d buffer tailroom for compression for %d "
         "bytes of payload",
         COMP_EXTRA_BUFFER(payload_size), payload_size);
     tailroom +=3D COMP_EXTRA_BUFFER(payload_size);
@@ -3289,18 +3284,15 @@
     if (options->renegotiate_seconds_min < 0)
     {
         /* Add 10% jitter to reneg-sec by default (server side only) */
-        int auto_jitter =3D options->mode !=3D MODE_SERVER
-                              ? 0
-                              : get_random() % max_int(options->renegotiat=
e_seconds / 10, 1);
+        int jitter_max =3D max_int(options->renegotiate_seconds / 10, 1);
+        int auto_jitter =3D options->mode !=3D MODE_SERVER ? 0 : (int)(get=
_random() % jitter_max);
         to.renegotiate_seconds =3D options->renegotiate_seconds - auto_jit=
ter;
     }
     else
     {
         /* Add user-specified jitter to reneg-sec */
-        to.renegotiate_seconds =3D
-            options->renegotiate_seconds
-            - (get_random()
-               % max_int(options->renegotiate_seconds - options->renegotia=
te_seconds_min, 1));
+        int jitter_max =3D max_int(options->renegotiate_seconds - options-=
>renegotiate_seconds_min, 1);
+        to.renegotiate_seconds =3D options->renegotiate_seconds - (int)(ge=
t_random() % jitter_max);
     }
     to.single_session =3D options->single_session;
     to.mode =3D options->mode;
@@ -3495,10 +3487,6 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  * No encryption or authentication.
  */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1259?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I41b9f7686180f2549bd4984cbbf66059f0ba2b15
Gerrit-Change-Number: 1259
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--tAFzV9lhQqg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1259?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">init: Fix conversion warnings<br><br>Can be=
 separated in mostly two classes of issues:<br> - Return type of get_random=
 is long, but we ensure that value<br>   is in range so we can cast it to w=
hatever we need.<br> - Doing MTU match in size_t even though most of the in=
put<br>   values are int.<br><br>Change-Id: I41b9f7686180f2549bd4984cbbf660=
59f0ba2b15<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>=
---<br>M src/openvpn/init.c<br>1 file changed, 14 insertions(+), 26 deletio=
ns(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/op=
envpn refs/changes/59/1259/1</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/src/openvpn/init.c b/src/=
openvpn/init.c</span><br><span>index f8a0fee..81b9ca9 100644</span><br><spa=
n>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><=
br><span>@@ -455,11 +455,6 @@</span><br><span> }</span><br><span> #endif /*=
 ENABLE_MANAGEMENT */</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignore=
d &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span> /*</span><br><span>  * Initialize and possibly randomize the connec=
tion list.</span><br><span>  *</span><br><span>@@ -482,7 +477,7 @@</span><b=
r><span>         int i;</span><br><span>         for (i =3D l-&gt;len - 1; =
i &gt; 0; --i)</span><br><span>         {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            const int j =3D get_random() % (i + 1);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            const long =
j =3D get_random() % (i + 1);</span><br><span>             if (i !=3D j)</s=
pan><br><span>             {</span><br><span>                 struct connec=
tion_entry *tmp;</span><br><span>@@ -842,7 +837,7 @@</span><br><span>     s=
truct timeval tv;</span><br><span>     if (!gettimeofday(&amp;tv, NULL))</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       const unsigned int seed =3D (unsigned int)tv.tv_sec ^ tv.tv_usec;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        const unsigned=
 int seed =3D (unsigned int)(tv.tv_sec ^ tv.tv_usec);</span><br><span>     =
    srandom(seed);</span><br><span>     }</span><br><span> </span><br><span=
>@@ -2873,17 +2868,17 @@</span><br><span>     }</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static size_=
t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><=
br><span> get_frame_mtu(struct context *c, const struct options *o)</span><=
br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t=
 mtu;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int mtu;</=
span><br><span> </span><br><span>     if (o-&gt;ce.link_mtu_defined)</span>=
<br><span>     {</span><br><span>         ASSERT(o-&gt;ce.link_mtu_defined)=
;</span><br><span>         /* if we have a link mtu defined we calculate wh=
at the old code</span><br><span>          * would have come up with as tun-=
mtu */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        size_t =
overhead =3D frame_calculate_protocol_header_size(&amp;c-&gt;c1.ks.key_type=
, o, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
int overhead =3D (int)frame_calculate_protocol_header_size(&amp;c-&gt;c1.ks=
.key_type, o, true);</span><br><span>         mtu =3D o-&gt;ce.link_mtu - o=
verhead;</span><br><span>     }</span><br><span>     else</span><br><span>@=
@ -2894,7 +2889,7 @@</span><br><span> </span><br><span>     if (mtu &lt; TU=
N_MTU_MIN)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        msg(M_WARN, &quot;TUN MTU value (%zu) must be at least =
%d&quot;, mtu, TUN_MTU_MIN);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        msg(M_WARN, &quot;TUN MTU value (%d) must be at least %d&q=
uot;, mtu, TUN_MTU_MIN);</span><br><span>         frame_print(&amp;c-&gt;c2=
.frame, M_FATAL, &quot;MTU is too small&quot;);</span><br><span>     }</spa=
n><br><span>     return mtu;</span><br><span>@@ -2923,7 +2918,7 @@</span><b=
r><span>      * space to allow server to push &quot;baby giant&quot; MTU si=
zes */</span><br><span>     frame-&gt;tun_max_mtu =3D max_int(TUN_MTU_MAX_M=
IN, frame-&gt;tun_max_mtu);</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    size_t payload_size =3D frame-&gt;tun_max_mtu;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int payload_size=
 =3D frame-&gt;tun_max_mtu;</span><br><span> </span><br><span>     /* we ne=
ed to be also large enough to hold larger control channel packets</span><br=
><span>      * if configured */</span><br><span>@@ -2942,7 +2937,7 @@</span=
><br><span> </span><br><span>     /* the space that is reserved before the =
payload to add extra headers to it</span><br><span>      * we always reserv=
e the space for the worst case */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    size_t headroom =3D 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    int headroom =3D 0;</span><br><span> </span><br><spa=
n>     /* includes IV and packet ID */</span><br><span>     headroom +=3D c=
rypto_max_overhead();</span><br><span>@@ -2966,11 +2961,11 @@</span><br><sp=
an>     /* the space after the payload, this needs some extra buffer space =
for</span><br><span>      * encryption so headroom is probably too much but=
 we do not really care</span><br><span>      * the few extra bytes */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t tailroom =3D hea=
droom;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int tailr=
oom =3D headroom;</span><br><span> </span><br><span> #ifdef USE_COMP</span>=
<br><span>     msg(D_MTU_DEBUG,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        &quot;MTU: adding %zu buffer tailroom for compression for=
 %zu &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
&quot;MTU: adding %d buffer tailroom for compression for %d &quot;</span><b=
r><span>         &quot;bytes of payload&quot;,</span><br><span>         COM=
P_EXTRA_BUFFER(payload_size), payload_size);</span><br><span>     tailroom =
+=3D COMP_EXTRA_BUFFER(payload_size);</span><br><span>@@ -3289,18 +3284,15 =
@@</span><br><span>     if (options-&gt;renegotiate_seconds_min &lt; 0)</sp=
an><br><span>     {</span><br><span>         /* Add 10% jitter to reneg-sec=
 by default (server side only) */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        int auto_jitter =3D options-&gt;mode !=3D MODE_SERVER</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
       ? 0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
                   : get_random() % max_int(options-&gt;renegotiate_seconds=
 / 10, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
nt jitter_max =3D max_int(options-&gt;renegotiate_seconds / 10, 1);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        int auto_jitter =3D=
 options-&gt;mode !=3D MODE_SERVER ? 0 : (int)(get_random() % jitter_max);<=
/span><br><span>         to.renegotiate_seconds =3D options-&gt;renegotiate=
_seconds - auto_jitter;</span><br><span>     }</span><br><span>     else</s=
pan><br><span>     {</span><br><span>         /* Add user-specified jitter =
to reneg-sec */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  to.renegotiate_seconds =3D</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            options-&gt;renegotiate_seconds</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            - (get_random()</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-               % max_int(options-&gt;ren=
egotiate_seconds - options-&gt;renegotiate_seconds_min, 1));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        int jitter_max =3D max_int=
(options-&gt;renegotiate_seconds - options-&gt;renegotiate_seconds_min, 1);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        to.renegoti=
ate_seconds =3D options-&gt;renegotiate_seconds - (int)(get_random() % jitt=
er_max);</span><br><span>     }</span><br><span>     to.single_session =3D =
options-&gt;single_session;</span><br><span>     to.mode =3D options-&gt;mo=
de;</span><br><span>@@ -3495,10 +3487,6 @@</span><br><span>     }</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * No encryption or=
 authentication.</span><br><span>  */</span><br><span></span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1259?usp=3De=
mail">change 1259</a>. To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1259?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I41b9f7686180f2549bd4984cbbf=
66059f0ba2b15 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1259 </div>
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

--tAFzV9lhQqg=--

