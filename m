From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 28 Aug 2025 17:27:44 +0000
References: <gerrit.1756402061000.Id3b8719ee6b457ce2d85156b39e0cea771a97e74@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <dc5c5407ff1f8310ae54e81dee44be231ab50e4a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="u51D/MTgeRM="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: socket_util: Clean
 up conversion warnings in add_in6_addr
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

--u51D/MTgeRM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1161?usp=3Demail

to review the following change.


Change subject: socket_util: Clean up conversion warnings in add_in6_addr
......................................................................

socket_util: Clean up conversion warnings in add_in6_addr

Change-Id: Id3b8719ee6b457ce2d85156b39e0cea771a97e74
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/socket_util.c
1 file changed, 3 insertions(+), 5 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/61/1161/1

diff --git a/src/openvpn/socket_util.c b/src/openvpn/socket_util.c
index 13f8c32..9b7312d 100644
--- a/src/openvpn/socket_util.c
+++ b/src/openvpn/socket_util.c
@@ -241,14 +241,12 @@
 struct in6_addr
 add_in6_addr(struct in6_addr base, uint32_t add)
 {
-    int i;
-
-    for (i =3D 15; i >=3D 0 && add > 0; i--)
+    for (int i =3D 15; i >=3D 0 && add > 0; i--)
     {
-        register int carry;
+        register uint32_t carry;
         register uint32_t h;

-        h =3D (unsigned char)base.s6_addr[i];
+        h =3D base.s6_addr[i];
         base.s6_addr[i] =3D (h + add) & UINT8_MAX;

         /* using explicit carry for the 8-bit additions will catch

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1161?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id3b8719ee6b457ce2d85156b39e0cea771a97e74
Gerrit-Change-Number: 1161
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--u51D/MTgeRM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1161?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">socket_util: Clean up conversion warnings in add_in6_addr<br=
><br>Change-Id: Id3b8719ee6b457ce2d85156b39e0cea771a97e74<br>Signed-off-by:=
 Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/socket_=
util.c<br>1 file changed, 3 insertions(+), 5 deletions(-)<br><br></pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit.openvpn.net:29418/openvpn refs/changes/61/1161/1</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/socket_util.c b/src/openvpn/socket_util.c</span><br><=
span>index 13f8c32..9b7312d 100644</span><br><span>--- a/src/openvpn/socket=
_util.c</span><br><span>+++ b/src/openvpn/socket_util.c</span><br><span>@@ =
-241,14 +241,12 @@</span><br><span> struct in6_addr</span><br><span> add_in=
6_addr(struct in6_addr base, uint32_t add)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    for (i =3D 15; i &gt;=3D 0 &amp;&amp; add &gt; 0; i--)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 15; i &gt=
;=3D 0 &amp;&amp; add &gt; 0; i--)</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        register int carry;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        register uint32_t carry=
;</span><br><span>         register uint32_t h;</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        h =3D (unsigned char)ba=
se.s6_addr[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   h =3D base.s6_addr[i];</span><br><span>         base.s6_addr[i] =3D (h +=
 add) &amp; UINT8_MAX;</span><br><span> </span><br><span>         /* using =
explicit carry for the 8-bit additions will catch</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1161?usp=3Demail">change 1161</a>. To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1161?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id3b8719ee6b457ce2d85156b39e=
0cea771a97e74 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1161 </div>
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


--u51D/MTgeRM=--

