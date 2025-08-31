From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 31 Aug 2025 16:50:43 +0000
In-Reply-To: <gerrit.1756402061000.Id3b8719ee6b457ce2d85156b39e0cea771a97e74@...2715...>
References: <gerrit.1756402061000.Id3b8719ee6b457ce2d85156b39e0cea771a97e74@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <f02218a826c9e21a322cd1ed30c6f2947125dd98-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gc1CxKhMFTM="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gc1CxKhMFTM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1161?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: socket_util: Clean up conversion warnings in add_in6_addr
......................................................................

socket_util: Clean up conversion warnings in add_in6_addr

Change-Id: Id3b8719ee6b457ce2d85156b39e0cea771a97e74
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250831151259.25788-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
725.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/socket_util.c
1 file changed, 3 insertions(+), 5 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/61/1161/5

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
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--gc1CxKhMFTM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #5</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1161?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">socket_util: Clean up conversion warnings in add_in6=
_addr<br><br>Change-Id: Id3b8719ee6b457ce2d85156b39e0cea771a97e74<br>Signed=
-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doeri=
ng &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250831151259.25788-1-gert@...220...=
..1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1439...=
ceforge.net/msg32725.html<br>Signed-off-by: Gert Doering &lt;gert@...2132...=
.&gt;<br>---<br>M src/openvpn/socket_util.c<br>1 file changed, 3 insertions=
(+), 5 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openv=
pn refs/changes/61/1161/5</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpn/socket_util.c b/=
src/openvpn/socket_util.c</span><br><span>index 13f8c32..9b7312d 100644</sp=
an><br><span>--- a/src/openvpn/socket_util.c</span><br><span>+++ b/src/open=
vpn/socket_util.c</span><br><span>@@ -241,14 +241,12 @@</span><br><span> st=
ruct in6_addr</span><br><span> add_in6_addr(struct in6_addr base, uint32_t =
add)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 15; i &gt;=3D 0=
 &amp;&amp; add &gt; 0; i--)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    for (int i =3D 15; i &gt;=3D 0 &amp;&amp; add &gt; 0; i--)</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      register int carry;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        register uint32_t carry;</span><br><span>         register ui=
nt32_t h;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        h =3D (unsigned char)base.s6_addr[i];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        h =3D base.s6_addr[i];</span><br>=
<span>         base.s6_addr[i] =3D (h + add) &amp; UINT8_MAX;</span><br><sp=
an> </span><br><span>         /* using explicit carry for the 8-bit additio=
ns will catch</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1161?usp=3Demail">change 1161</a>. T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http=
://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1161?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id3b8719ee6b457ce2d85156b39e=
0cea771a97e74 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1161 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--gc1CxKhMFTM=--

