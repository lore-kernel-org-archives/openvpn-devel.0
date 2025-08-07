From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 7 Aug 2025 17:02:46 +0000
References: <gerrit.1754586150000.Id565ec17856444b580dd89edab92e9fe18d39b77@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <10f02bae8b2e1e510a1f8244fac51334689989a4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CH5lon0Psr4="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Collect trivial
 conversion fixes
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

--CH5lon0Psr4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1140?usp=3Demail

to review the following change.


Change subject: Collect trivial conversion fixes
......................................................................

Collect trivial conversion fixes

These are very local, simple fixes that do not
warrant their own commit.

Change-Id: Id565ec17856444b580dd89edab92e9fe18d39b77
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/crypto.c
M src/openvpn/init.c
M src/openvpn/options.c
M src/openvpn/pool.c
4 files changed, 4 insertions(+), 4 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/40/1140/1

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index e128bb8..f7a0206 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1901,7 +1901,7 @@
     const char *seed =3D "tls1-prf-test";
     const char *secret =3D "tls1-prf-test-secret";
     uint8_t out[8];
-    uint8_t expected_out[] =3D { 'q', 'D', '\xfe', '%', '@', 's', 'u', '\x=
95' };
+    uint8_t expected_out[] =3D { 'q', 'D', 0xfe, '%', '@', 's', 'u', 0x95 =
};

     int ret =3D ssl_tls1_PRF((uint8_t *)seed, strlen(seed), (uint8_t *)sec=
ret,
                            strlen(secret), out, sizeof(out));
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 2d6dacd..3cbdcf8 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -343,7 +343,7 @@
         const char *status =3D (ce->flags & CE_DISABLED) ? "disabled" : "e=
nabled";

         /* space for output including 3 commas and a nul */
-        int len =3D
+        size_t len =3D
             strlen(ce->remote) + strlen(ce->remote_port) + strlen(proto) +=
 strlen(status) + 3 + 1;
         char *out =3D malloc(len);
         check_malloc_return(out);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2fffa65..670718f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4960,7 +4960,7 @@
 #endif

 static inline bool
-space(unsigned char c)
+space(char c)
 {
     return c =3D=3D '\0' || isspace(c);
 }
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index abbad8f..cd1c768 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -158,7 +158,7 @@
         switch (pool->ipv4.type)
         {
             case IFCONFIG_POOL_30NET:
-                pool->ipv4.base =3D start & ~3;
+                pool->ipv4.base =3D start & ~3u;
                 pool_ipv4_size =3D (((end | 3) + 1) - pool->ipv4.base) >> =
2;
                 break;


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1140?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id565ec17856444b580dd89edab92e9fe18d39b77
Gerrit-Change-Number: 1140
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--CH5lon0Psr4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1140?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Collect trivial conversion fixes<br><br>These are very local=
, simple fixes that do not<br>warrant their own commit.<br><br>Change-Id: I=
d565ec17856444b580dd89edab92e9fe18d39b77<br>Signed-off-by: Frank Lichtenhel=
d &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/crypto.c<br>M src/openvp=
n/init.c<br>M src/openvpn/options.c<br>M src/openvpn/pool.c<br>4 files chan=
ged, 4 insertions(+), 4 deletions(-)<br><br></pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvp=
n.net:29418/openvpn refs/changes/40/1140/1</pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn=
/crypto.c b/src/openvpn/crypto.c</span><br><span>index e128bb8..f7a0206 100=
644</span><br><span>--- a/src/openvpn/crypto.c</span><br><span>+++ b/src/op=
envpn/crypto.c</span><br><span>@@ -1901,7 +1901,7 @@</span><br><span>     c=
onst char *seed =3D &quot;tls1-prf-test&quot;;</span><br><span>     const c=
har *secret =3D &quot;tls1-prf-test-secret&quot;;</span><br><span>     uint=
8_t out[8];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_=
t expected_out[] =3D { &#39;q&#39;, &#39;D&#39;, &#39;\xfe&#39;, &#39;%&#39=
;, &#39;@&#39;, &#39;s&#39;, &#39;u&#39;, &#39;\x95&#39; };</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    uint8_t expected_out[] =3D { &#=
39;q&#39;, &#39;D&#39;, 0xfe, &#39;%&#39;, &#39;@&#39;, &#39;s&#39;, &#39;u=
&#39;, 0x95 };</span><br><span> </span><br><span>     int ret =3D ssl_tls1_=
PRF((uint8_t *)seed, strlen(seed), (uint8_t *)secret,</span><br><span>     =
                       strlen(secret), out, sizeof(out));</span><br><span>d=
iff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>index 2=
d6dacd..3cbdcf8 100644</span><br><span>--- a/src/openvpn/init.c</span><br><=
span>+++ b/src/openvpn/init.c</span><br><span>@@ -343,7 +343,7 @@</span><br=
><span>         const char *status =3D (ce-&gt;flags &amp; CE_DISABLED) ? &=
quot;disabled&quot; : &quot;enabled&quot;;</span><br><span> </span><br><spa=
n>         /* space for output including 3 commas and a nul */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        int len =3D</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        size_t len =3D</span><br><=
span>             strlen(ce-&gt;remote) + strlen(ce-&gt;remote_port) + strl=
en(proto) + strlen(status) + 3 + 1;</span><br><span>         char *out =3D =
malloc(len);</span><br><span>         check_malloc_return(out);</span><br><=
span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><=
span>index 2fffa65..670718f 100644</span><br><span>--- a/src/openvpn/option=
s.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -4960,7 =
+4960,7 @@</span><br><span> #endif</span><br><span> </span><br><span> stati=
c inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-space(un=
signed char c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+space=
(char c)</span><br><span> {</span><br><span>     return c =3D=3D &#39;\0&#3=
9; || isspace(c);</span><br><span> }</span><br><span>diff --git a/src/openv=
pn/pool.c b/src/openvpn/pool.c</span><br><span>index abbad8f..cd1c768 10064=
4</span><br><span>--- a/src/openvpn/pool.c</span><br><span>+++ b/src/openvp=
n/pool.c</span><br><span>@@ -158,7 +158,7 @@</span><br><span>         switc=
h (pool-&gt;ipv4.type)</span><br><span>         {</span><br><span>         =
    case IFCONFIG_POOL_30NET:</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                pool-&gt;ipv4.base =3D start &amp; ~3;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                pool-&gt;ipv4.ba=
se =3D start &amp; ~3u;</span><br><span>                 pool_ipv4_size =3D=
 (((end | 3) + 1) - pool-&gt;ipv4.base) &gt;&gt; 2;</span><br><span>       =
          break;</span><br><span> </span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1140?usp=3Demai=
l">change 1140</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div items=
cope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1140?usp=3Demail"/><meta itemp=
rop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id565ec17856444b580dd89edab9=
2e9fe18d39b77 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1140 </div>
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


--CH5lon0Psr4=--

