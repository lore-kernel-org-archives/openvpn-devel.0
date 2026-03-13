From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 13 Mar 2026 16:39:02 +0000
In-Reply-To: <gerrit.1759939917000.I41b9f7686180f2549bd4984cbbf66059f0ba2b15@...2715...>
References: <gerrit.1759939917000.I41b9f7686180f2549bd4984cbbf66059f0ba2b15@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <5bf885a2b7fdf3c2a6b43dfa9e9ac4c148a1ec35-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Rd1I4CV61to="; charset=UTF-8
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

--Rd1I4CV61to=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

Hello cron2, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1259?usp=3Demail

to look at the new patch set (#15).

The following approvals got outdated and were removed:
Code-Review-1 by cron2


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
1 file changed, 17 insertions(+), 25 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/59/1259/15

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 66a5836..a7c13f9 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -454,11 +454,6 @@
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
@@ -481,7 +476,7 @@
         int i;
         for (i =3D l->len - 1; i > 0; --i)
         {
-            const int j =3D get_random() % (i + 1);
+            const long j =3D get_random() % (i + 1);
             if (i !=3D j)
             {
                 struct connection_entry *tmp;
@@ -841,7 +836,7 @@
     struct timeval tv;
     if (!gettimeofday(&tv, NULL))
     {
-        const unsigned int seed =3D (unsigned int)tv.tv_sec ^ tv.tv_usec;
+        const unsigned int seed =3D (unsigned int)(tv.tv_sec ^ tv.tv_usec);
         srandom(seed);
     }

@@ -2849,7 +2844,7 @@
     }
 }

-static size_t
+static unsigned int
 get_frame_mtu(struct context *c, const struct options *o)
 {
     size_t mtu;
@@ -2870,10 +2865,14 @@

     if (mtu < TUN_MTU_MIN)
     {
-        msg(M_WARN, "TUN MTU value (%zu) must be at least %d", mtu, TUN_MT=
U_MIN);
+        msg(M_WARN, "TUN MTU value (%zu) must be at least %u", mtu, TUN_MT=
U_MIN);
         frame_print(&c->c2.frame, M_FATAL, "MTU is too small");
     }
-    return mtu;
+    if (mtu > UINT_MAX)
+    {
+        mtu =3D UINT_MAX;
+    }
+    return (unsigned int)mtu;
 }

 /*
@@ -2899,7 +2898,7 @@
      * space to allow server to push "baby giant" MTU sizes */
     frame->tun_max_mtu =3D max_int(TUN_MTU_MAX_MIN, frame->tun_max_mtu);

-    size_t payload_size =3D frame->tun_max_mtu;
+    unsigned int payload_size =3D frame->tun_max_mtu;

     /* we need to be also large enough to hold larger control channel pack=
ets
      * if configured */
@@ -2918,7 +2917,7 @@

     /* the space that is reserved before the payload to add extra headers =
to it
      * we always reserve the space for the worst case */
-    size_t headroom =3D 0;
+    unsigned int headroom =3D 0;

     /* includes IV and packet ID */
     headroom +=3D crypto_max_overhead();
@@ -2942,11 +2941,11 @@
     /* the space after the payload, this needs some extra buffer space for
      * encryption so headroom is probably too much but we do not really ca=
re
      * the few extra bytes */
-    size_t tailroom =3D headroom;
+    unsigned int tailroom =3D headroom;

 #ifdef USE_COMP
     msg(D_MTU_DEBUG,
-        "MTU: adding %zu buffer tailroom for compression for %zu "
+        "MTU: adding %u buffer tailroom for compression for %u "
         "bytes of payload",
         COMP_EXTRA_BUFFER(payload_size), payload_size);
     tailroom +=3D COMP_EXTRA_BUFFER(payload_size);
@@ -3288,18 +3287,15 @@
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
@@ -3491,10 +3487,6 @@
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I41b9f7686180f2549bd4984cbbf66059f0ba2b15
Gerrit-Change-Number: 1259
Gerrit-PatchSet: 15
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>

--Rd1I4CV61to=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #15</strong> to this change.</p>=
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1259?usp=3Demail">View =
Change</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">init: Fix conversion warnings<br><b=
r>Can be separated in mostly two classes of issues:<br> - Return type of ge=
t_random is long, but we ensure that value<br>   is in range so we can cast=
 it to whatever we need.<br> - Doing MTU match in size_t even though most o=
f the input<br>   values are int.<br><br>Change-Id: I41b9f7686180f2549bd498=
4cbbf66059f0ba2b15<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...=
&gt;<br>---<br>M src/openvpn/init.c<br>1 file changed, 17 insertions(+), 25=
 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/59/1259/15</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/init=
.c b/src/openvpn/init.c</span><br><span>index 66a5836..a7c13f9 100644</span=
><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.=
c</span><br><span>@@ -454,11 +454,6 @@</span><br><span> }</span><br><span> =
#endif /* ENABLE_MANAGEMENT */</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pus=
h</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnost=
ic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span> /*</span><br><span>  * Initialize and possibly randomize t=
he connection list.</span><br><span>  *</span><br><span>@@ -481,7 +476,7 @@=
</span><br><span>         int i;</span><br><span>         for (i =3D l-&gt;=
len - 1; i &gt; 0; --i)</span><br><span>         {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            const int j =3D get_random() % (i =
+ 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            co=
nst long j =3D get_random() % (i + 1);</span><br><span>             if (i !=
=3D j)</span><br><span>             {</span><br><span>                 stru=
ct connection_entry *tmp;</span><br><span>@@ -841,7 +836,7 @@</span><br><sp=
an>     struct timeval tv;</span><br><span>     if (!gettimeofday(&amp;tv, =
NULL))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        const unsigned int seed =3D (unsigned int)tv.tv_sec ^ tv.tv=
_usec;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const=
 unsigned int seed =3D (unsigned int)(tv.tv_sec ^ tv.tv_usec);</span><br><s=
pan>         srandom(seed);</span><br><span>     }</span><br><span> </span>=
<br><span>@@ -2849,7 +2844,7 @@</span><br><span>     }</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-stati=
c size_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static unsi=
gned int</span><br><span> get_frame_mtu(struct context *c, const struct opt=
ions *o)</span><br><span> {</span><br><span>     size_t mtu;</span><br><spa=
n>@@ -2870,10 +2865,14 @@</span><br><span> </span><br><span>     if (mtu &l=
t; TUN_MTU_MIN)</span><br><span>     {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        msg(M_WARN, &quot;TUN MTU value (%zu) must be at l=
east %d&quot;, mtu, TUN_MTU_MIN);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        msg(M_WARN, &quot;TUN MTU value (%zu) must be at leas=
t %u&quot;, mtu, TUN_MTU_MIN);</span><br><span>         frame_print(&amp;c-=
&gt;c2.frame, M_FATAL, &quot;MTU is too small&quot;);</span><br><span>     =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return mtu;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (mtu &gt; UINT_MA=
X)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        mtu =3D UINT_MAX;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return (unsigned int)mtu;</span><br=
><span> }</span><br><span> </span><br><span> /*</span><br><span>@@ -2899,7 =
+2898,7 @@</span><br><span>      * space to allow server to push &quot;baby=
 giant&quot; MTU sizes */</span><br><span>     frame-&gt;tun_max_mtu =3D ma=
x_int(TUN_MTU_MAX_MIN, frame-&gt;tun_max_mtu);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    size_t payload_size =3D fram=
e-&gt;tun_max_mtu;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   unsigned int payload_size =3D frame-&gt;tun_max_mtu;</span><br><span> </=
span><br><span>     /* we need to be also large enough to hold larger contr=
ol channel packets</span><br><span>      * if configured */</span><br><span=
>@@ -2918,7 +2917,7 @@</span><br><span> </span><br><span>     /* the space =
that is reserved before the payload to add extra headers to it</span><br><s=
pan>      * we always reserve the space for the worst case */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    size_t headroom =3D 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int headroom =
=3D 0;</span><br><span> </span><br><span>     /* includes IV and packet ID =
*/</span><br><span>     headroom +=3D crypto_max_overhead();</span><br><spa=
n>@@ -2942,11 +2941,11 @@</span><br><span>     /* the space after the paylo=
ad, this needs some extra buffer space for</span><br><span>      * encrypti=
on so headroom is probably too much but we do not really care</span><br><sp=
an>      * the few extra bytes */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    size_t tailroom =3D headroom;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    unsigned int tailroom =3D headroom;</span><br=
><span> </span><br><span> #ifdef USE_COMP</span><br><span>     msg(D_MTU_DE=
BUG,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &quot;MTU=
: adding %zu buffer tailroom for compression for %zu &quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        &quot;MTU: adding %u buffer=
 tailroom for compression for %u &quot;</span><br><span>         &quot;byte=
s of payload&quot;,</span><br><span>         COMP_EXTRA_BUFFER(payload_size=
), payload_size);</span><br><span>     tailroom +=3D COMP_EXTRA_BUFFER(payl=
oad_size);</span><br><span>@@ -3288,18 +3287,15 @@</span><br><span>     if =
(options-&gt;renegotiate_seconds_min &lt; 0)</span><br><span>     {</span><=
br><span>         /* Add 10% jitter to reneg-sec by default (server side on=
ly) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int aut=
o_jitter =3D options-&gt;mode !=3D MODE_SERVER</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                              ? 0</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                              : get_ra=
ndom() % max_int(options-&gt;renegotiate_seconds / 10, 1);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        int jitter_max =3D max_int(o=
ptions-&gt;renegotiate_seconds / 10, 1);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        int auto_jitter =3D options-&gt;mode !=3D MODE=
_SERVER ? 0 : (int)(get_random() % jitter_max);</span><br><span>         to=
.renegotiate_seconds =3D options-&gt;renegotiate_seconds - auto_jitter;</sp=
an><br><span>     }</span><br><span>     else</span><br><span>     {</span>=
<br><span>         /* Add user-specified jitter to reneg-sec */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        to.renegotiate_seconds =
=3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            option=
s-&gt;renegotiate_seconds</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            - (get_random()</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-               % max_int(options-&gt;renegotiate_seconds - option=
s-&gt;renegotiate_seconds_min, 1));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        int jitter_max =3D max_int(options-&gt;renegotiate_=
seconds - options-&gt;renegotiate_seconds_min, 1);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        to.renegotiate_seconds =3D options-&=
gt;renegotiate_seconds - (int)(get_random() % jitter_max);</span><br><span>=
     }</span><br><span>     to.single_session =3D options-&gt;single_sessio=
n;</span><br><span>     to.mode =3D options-&gt;mode;</span><br><span>@@ -3=
491,10 +3487,6 @@</span><br><span>     }</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC_=
_) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span> /*</span><br><span>  * No encryption or authentication.</span><b=
r><span>  */</span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1259?usp=3Demail">change 1259</a>. To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemt=
ype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" i=
temtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1259?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I41b9f7686180f2549bd4984cbbf=
66059f0ba2b15 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1259 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 15 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>

</body></html>=

--Rd1I4CV61to=--

