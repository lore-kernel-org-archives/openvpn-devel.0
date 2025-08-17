From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 17 Aug 2025 14:44:31 +0000
In-Reply-To: <gerrit.1754586150000.Id565ec17856444b580dd89edab92e9fe18d39b77@...2715...>
References: <gerrit.1754586150000.Id565ec17856444b580dd89edab92e9fe18d39b77@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0480e8595f45c3bf5741d4bccfb8a1672d0093b8-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="47hvxVrQqkQ="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--47hvxVrQqkQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1140?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Collect trivial conversion fixes
......................................................................

Collect trivial conversion fixes

These are very local, simple fixes that do not
warrant their own commit.

Change-Id: Id565ec17856444b580dd89edab92e9fe18d39b77
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250817143922.17988-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
611.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto.c
M src/openvpn/init.c
M src/openvpn/options.c
M src/openvpn/pool.c
4 files changed, 4 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/40/1140/4

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index af7583a..a63e543 100644
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

     int ret =3D ssl_tls1_PRF((uint8_t *)seed, (int)strlen(seed), (uint8_t =
*)secret,
                            (int)strlen(secret), out, sizeof(out));
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 40ae2c8..5583274 100644
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
index c54032d..5f9971c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4957,7 +4957,7 @@
 #endif

 static inline bool
-space(unsigned char c)
+space(char c)
 {
     return c =3D=3D '\0' || isspace(c);
 }
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index 898a045..a41364a 100644
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
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--47hvxVrQqkQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1140?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Collect trivial conversion fixes<br><br>These are ve=
ry local, simple fixes that do not<br>warrant their own commit.<br><br>Chan=
ge-Id: Id565ec17856444b580dd89edab92e9fe18d39b77<br>Signed-off-by: Frank Li=
chtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1711...=
96...&gt;<br>Message-Id: &lt;20250817143922.17988-1-gert@...1296...&gt;<br>=
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
611.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M=
 src/openvpn/crypto.c<br>M src/openvpn/init.c<br>M src/openvpn/options.c<br=
>M src/openvpn/pool.c<br>4 files changed, 4 insertions(+), 4 deletions(-)<b=
r><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/40/11=
40/4</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</span=
><br><span>index af7583a..a63e543 100644</span><br><span>--- a/src/openvpn/=
crypto.c</span><br><span>+++ b/src/openvpn/crypto.c</span><br><span>@@ -190=
1,7 +1901,7 @@</span><br><span>     const char *seed =3D &quot;tls1-prf-tes=
t&quot;;</span><br><span>     const char *secret =3D &quot;tls1-prf-test-se=
cret&quot;;</span><br><span>     uint8_t out[8];</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    uint8_t expected_out[] =3D { &#39;q&#39;, &#=
39;D&#39;, &#39;\xfe&#39;, &#39;%&#39;, &#39;@&#39;, &#39;s&#39;, &#39;u&#3=
9;, &#39;\x95&#39; };</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    uint8_t expected_out[] =3D { &#39;q&#39;, &#39;D&#39;, 0xfe, &#39;%&#=
39;, &#39;@&#39;, &#39;s&#39;, &#39;u&#39;, 0x95 };</span><br><span> </span=
><br><span>     int ret =3D ssl_tls1_PRF((uint8_t *)seed, (int)strlen(seed)=
, (uint8_t *)secret,</span><br><span>                            (int)strle=
n(secret), out, sizeof(out));</span><br><span>diff --git a/src/openvpn/init=
.c b/src/openvpn/init.c</span><br><span>index 40ae2c8..5583274 100644</span=
><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.=
c</span><br><span>@@ -343,7 +343,7 @@</span><br><span>         const char *=
status =3D (ce-&gt;flags &amp; CE_DISABLED) ? &quot;disabled&quot; : &quot;=
enabled&quot;;</span><br><span> </span><br><span>         /* space for outp=
ut including 3 commas and a nul */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        int len =3D</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        size_t len =3D</span><br><span>             strlen(ce-=
&gt;remote) + strlen(ce-&gt;remote_port) + strlen(proto) + strlen(status) +=
 3 + 1;</span><br><span>         char *out =3D malloc(len);</span><br><span=
>         check_malloc_return(out);</span><br><span>diff --git a/src/openvp=
n/options.c b/src/openvpn/options.c</span><br><span>index c54032d..5f9971c =
100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/sr=
c/openvpn/options.c</span><br><span>@@ -4957,7 +4957,7 @@</span><br><span> =
#endif</span><br><span> </span><br><span> static inline bool</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-space(unsigned char c)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+space(char c)</span><br><span> {<=
/span><br><span>     return c =3D=3D &#39;\0&#39; || isspace(c);</span><br>=
<span> }</span><br><span>diff --git a/src/openvpn/pool.c b/src/openvpn/pool=
.c</span><br><span>index 898a045..a41364a 100644</span><br><span>--- a/src/=
openvpn/pool.c</span><br><span>+++ b/src/openvpn/pool.c</span><br><span>@@ =
-158,7 +158,7 @@</span><br><span>         switch (pool-&gt;ipv4.type)</span=
><br><span>         {</span><br><span>             case IFCONFIG_POOL_30NET=
:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                pool=
-&gt;ipv4.base =3D start &amp; ~3;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                pool-&gt;ipv4.base =3D start &amp; ~3u;</spa=
n><br><span>                 pool_ipv4_size =3D (((end | 3) + 1) - pool-&gt=
;ipv4.base) &gt;&gt; 2;</span><br><span>                 break;</span><br><=
span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1140?usp=3Demail">change 1140</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1140?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id565ec17856444b580dd89edab9=
2e9fe18d39b77 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1140 </div>
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


--47hvxVrQqkQ=--

