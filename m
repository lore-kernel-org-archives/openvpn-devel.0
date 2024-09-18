From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 18 Sep 2024 17:35:44 +0000
References: <gerrit.1726680937000.Ib8ba2b63ea9fd1944ff07f69c545a880e464680c@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <6c122f07c357a8877ba5259f3f6f01df7199b788-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YvWoyDWz77s="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Refactor methods to
 use the actual state of tun rather the options st...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--YvWoyDWz77s=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/753?usp=3Demail

to review the following change.


Change subject: Refactor methods to use the actual state of tun rather the =
options struct
......................................................................

Refactor methods to use the actual state of tun rather the options struct

Change-Id: Ib8ba2b63ea9fd1944ff07f69c545a880e464680c
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/dco.c
M src/openvpn/forward.c
M src/openvpn/tun.c
M src/openvpn/tun.h
4 files changed, 13 insertions(+), 16 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/53/753/1

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 2f33973..384ffe6 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -476,7 +476,7 @@
 int
 dco_p2p_add_new_peer(struct context *c)
 {
-    if (!dco_enabled(&c->options))
+    if (!tun_dco_enabled(c->c1.tuntap))
     {
         return 0;
     }
@@ -511,7 +511,7 @@
 void
 dco_remove_peer(struct context *c)
 {
-    if (!dco_enabled(&c->options))
+    if (!tun_dco_enabled(c->c1.tuntap))
     {
         return;
     }
@@ -631,7 +631,7 @@
                    struct mroute_addr *addr)
 {
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
-    if (!dco_enabled(&m->top.options))
+    if (tun_dco_enabled(m->top.c1.tuntap))
     {
         return;
     }
@@ -668,7 +668,7 @@
 dco_delete_iroutes(struct multi_context *m, struct multi_instance *mi)
 {
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
-    if (!dco_enabled(&m->top.options))
+    if (!tun_dco_enabled(m->top.c1.tuntap))
     {
         return;
     }
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 9c78adf..4b620ea 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -145,7 +145,7 @@
 check_dco_key_status(struct context *c)
 {
     /* DCO context is not yet initialised or enabled */
-    if (!dco_enabled(&c->options))
+    if (!tun_dco_enabled(c->c1.tuntap))
     {
         return;
     }
@@ -483,7 +483,7 @@
 static void
 check_inactivity_timeout(struct context *c)
 {
-    if (dco_enabled(&c->options) && dco_get_peer_stats(c) =3D=3D 0)
+    if (tun_dco_enabled(c->c1.tuntap) && dco_get_peer_stats(c) =3D=3D 0)
     {
         int64_t tot_bytes =3D c->c2.tun_read_bytes + c->c2.tun_write_bytes;
         int64_t new_bytes =3D tot_bytes - c->c2.inactivity_bytes;
@@ -623,7 +623,7 @@
     const uint8_t *orig_buf =3D c->c2.buf.data;
     struct crypto_options *co =3D NULL;

-    if (dco_enabled(&c->options))
+    if (tun_dco_enabled(c->c1.tuntap))
     {
         msg(M_WARN, "Attempting to send data packet while data channel off=
load is in use. "
             "Dropping packet");
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index ec63bff..e44f2f0 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1872,15 +1872,6 @@
     return has_digit(dev);
 }

-#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
-static bool
-tun_dco_enabled(struct tuntap *tt)
-{
-    return tt->backend_driver =3D=3D DRIVER_DCO;
-}
-#endif
-
-
 #if !(defined(_WIN32) || defined(TARGET_LINUX) || defined(TARGET_SOLARIS))
 static void
 open_tun_generic(const char *dev, const char *dev_type, const char *dev_no=
de,
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index db0b5d7..7e4cb59 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -261,6 +261,12 @@
 #endif
 }

+inline static bool
+tun_dco_enabled(struct tuntap *tt)
+{
+    return tt && tt->backend_driver =3D=3D DRIVER_DCO;
+}
+
 #ifdef _WIN32
 static inline bool
 tuntap_is_wintun(struct tuntap *tt)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/753?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib8ba2b63ea9fd1944ff07f69c545a880e464680c
Gerrit-Change-Number: 753
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--YvWoyDWz77s=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/753?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Refactor methods to use the actual state of tun rather the op=
tions struct<br><br>Change-Id: Ib8ba2b63ea9fd1944ff07f69c545a880e464680c<br=
>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvp=
n/dco.c<br>M src/openvpn/forward.c<br>M src/openvpn/tun.c<br>M src/openvpn/=
tun.h<br>4 files changed, 13 insertions(+), 16 deletions(-)<br><br></pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/53/753/1</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>index 2f33=
973..384ffe6 100644</span><br><span>--- a/src/openvpn/dco.c</span><br><span=
>+++ b/src/openvpn/dco.c</span><br><span>@@ -476,7 +476,7 @@</span><br><spa=
n> int</span><br><span> dco_p2p_add_new_peer(struct context *c)</span><br><=
span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!dco_e=
nabled(&amp;c-&gt;options))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (!tun_dco_enabled(c-&gt;c1.tuntap))</span><br><span>     {</=
span><br><span>         return 0;</span><br><span>     }</span><br><span>@@=
 -511,7 +511,7 @@</span><br><span> void</span><br><span> dco_remove_peer(st=
ruct context *c)</span><br><span> {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (!dco_enabled(&amp;c-&gt;options))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (!tun_dco_enabled(c-&gt;c1.tunta=
p))</span><br><span>     {</span><br><span>         return;</span><br><span=
>     }</span><br><span>@@ -631,7 +631,7 @@</span><br><span>               =
     struct mroute_addr *addr)</span><br><span> {</span><br><span> #if defi=
ned(TARGET_LINUX) || defined(TARGET_FREEBSD)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (!dco_enabled(&amp;m-&gt;top.options))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tun_dco_enabled(m-=
&gt;top.c1.tuntap))</span><br><span>     {</span><br><span>         return;=
</span><br><span>     }</span><br><span>@@ -668,7 +668,7 @@</span><br><span=
> dco_delete_iroutes(struct multi_context *m, struct multi_instance *mi)</s=
pan><br><span> {</span><br><span> #if defined(TARGET_LINUX) || defined(TARG=
ET_FREEBSD)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!d=
co_enabled(&amp;m-&gt;top.options))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (!tun_dco_enabled(m-&gt;top.c1.tuntap))</span><br><s=
pan>     {</span><br><span>         return;</span><br><span>     }</span><b=
r><span>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><b=
r><span>index 9c78adf..4b620ea 100644</span><br><span>--- a/src/openvpn/for=
ward.c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -145,=
7 +145,7 @@</span><br><span> check_dco_key_status(struct context *c)</span>=
<br><span> {</span><br><span>     /* DCO context is not yet initialised or =
enabled */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!dc=
o_enabled(&amp;c-&gt;options))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (!tun_dco_enabled(c-&gt;c1.tuntap))</span><br><span>     =
{</span><br><span>         return;</span><br><span>     }</span><br><span>@=
@ -483,7 +483,7 @@</span><br><span> static void</span><br><span> check_inac=
tivity_timeout(struct context *c)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (dco_enabled(&amp;c-&gt;options) &am=
p;&amp; dco_get_peer_stats(c) =3D=3D 0)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (tun_dco_enabled(c-&gt;c1.tuntap) &amp;&amp; dco=
_get_peer_stats(c) =3D=3D 0)</span><br><span>     {</span><br><span>       =
  int64_t tot_bytes =3D c-&gt;c2.tun_read_bytes + c-&gt;c2.tun_write_bytes;=
</span><br><span>         int64_t new_bytes =3D tot_bytes - c-&gt;c2.inacti=
vity_bytes;</span><br><span>@@ -623,7 +623,7 @@</span><br><span>     const =
uint8_t *orig_buf =3D c-&gt;c2.buf.data;</span><br><span>     struct crypto=
_options *co =3D NULL;</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (dco_enabled(&amp;c-&gt;options))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (tun_dco_enabled(c-&gt;c1.tu=
ntap))</span><br><span>     {</span><br><span>         msg(M_WARN, &quot;At=
tempting to send data packet while data channel offload is in use. &quot;</=
span><br><span>             &quot;Dropping packet&quot;);</span><br><span>d=
iff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index ec6=
3bff..e44f2f0 100644</span><br><span>--- a/src/openvpn/tun.c</span><br><spa=
n>+++ b/src/openvpn/tun.c</span><br><span>@@ -1872,15 +1872,6 @@</span><br>=
<span>     return has_digit(dev);</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_LINUX) =
|| defined(TARGET_FREEBSD)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tun_d=
co_enabled(struct tuntap *tt)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return t=
t-&gt;backend_driver =3D=3D DRIVER_DCO;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
ndif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #if !(defined(_WIN32=
) || defined(TARGET_LINUX) || defined(TARGET_SOLARIS))</span><br><span> sta=
tic void</span><br><span> open_tun_generic(const char *dev, const char *dev=
_type, const char *dev_node,</span><br><span>diff --git a/src/openvpn/tun.h=
 b/src/openvpn/tun.h</span><br><span>index db0b5d7..7e4cb59 100644</span><b=
r><span>--- a/src/openvpn/tun.h</span><br><span>+++ b/src/openvpn/tun.h</sp=
an><br><span>@@ -261,6 +261,12 @@</span><br><span> #endif</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
inline static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+t=
un_dco_enabled(struct tuntap *tt)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return tt &amp;&amp; tt-&gt;backend_driver =3D=3D DRIVER_DCO;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> #ifdef _WIN32</span><br><span> st=
atic inline bool</span><br><span> tuntap_is_wintun(struct tuntap *tt)</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/753?usp=3Demail">change 753</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/753?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib8ba2b63ea9fd1944ff07f69c54=
5a880e464680c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 753 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--YvWoyDWz77s=--

