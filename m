From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 17 Jun 2025 09:18:31 +0000
In-Reply-To: <gerrit.1750145305000.I0e17d9aea32eab7f44ed95037f077ae6dec52053@...2715...>
References: <gerrit.1750145305000.I0e17d9aea32eab7f44ed95037f077ae6dec52053@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 ralf@...2726..., frank@...2641...
Message-ID: <b17f1308e9d4f43aa65747de82b4625c94ef64bb-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="q0vYFPcvh/A="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Preserve socket
 protocol during float processing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ralf_lici <ralf@...2726...>
Cc: its_Giaan <gianmarco@...2726...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--q0vYFPcvh/A=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/10=
63?usp=3Demail )

Change subject: Preserve socket protocol during float processing
......................................................................

Preserve socket protocol during float processing

During a float operation, we remove the old `mroute` object
corresponding to the current multi instance from the hash table and
insert a new one. With the introduction of the multi-socket feature, the
`mroute` structure gained a `proto` field, which must also be set in the
new instance, otherwise, hash table lookups will fail.

This commit ensures that the `proto` field is propagated from the
original to the new `mroute` object during float processing.

Change-Id: I0e17d9aea32eab7f44ed95037f077ae6dec52053
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Gianmarco De Gregori <gianmarco@...2726...>
Message-Id: <20250617084136.10215-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
902.html
URL: https://gerrit.openvpn.net/c/openvpn/+/1063
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/multi.c
1 file changed, 6 insertions(+), 0 deletions(-)




diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 169af43..a760e07 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3217,6 +3217,12 @@
     struct hash *hash =3D m->hash;
     struct gc_arena gc =3D gc_new();

+    if (mi->real.type & MR_WITH_PROTO)
+    {
+        real.type |=3D MR_WITH_PROTO;
+        real.proto =3D sock->info.proto;
+    }
+
     if (!mroute_extract_openvpn_sockaddr(&real, &m->top.c2.from.dest, true=
))
     {
         goto done;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1063?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0e17d9aea32eab7f44ed95037f077ae6dec52053
Gerrit-Change-Number: 1063
Gerrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--q0vYFPcvh/A=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1063?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Preserve socket protocol during float process=
ing<br><br>During a float operation, we remove the old `mroute` object<br>c=
orresponding to the current multi instance from the hash table and<br>inser=
t a new one. With the introduction of the multi-socket feature, the<br>`mro=
ute` structure gained a `proto` field, which must also be set in the<br>new=
 instance, otherwise, hash table lookups will fail.<br><br>This commit ensu=
res that the `proto` field is propagated from the<br>original to the new `m=
route` object during float processing.<br><br>Change-Id: I0e17d9aea32eab7f4=
4ed95037f077ae6dec52053<br>Signed-off-by: Ralf Lici &lt;ralf@...2726...&gt;=
<br>Acked-by: Gianmarco De Gregori &lt;gianmarco@...2726...&gt;<br>Message-=
Id: &lt;20250617084136.10215-1-gert@...1296...&gt;<br>URL: https://www.mail=
-archive.com/openvpn-devel@lists.sourceforge.net/msg31902.html<br>URL: http=
s://gerrit.openvpn.net/c/openvpn/+/1063<br>Signed-off-by: Gert Doering &lt;=
gert@...1296...&gt;<br>---<br>M src/openvpn/multi.c<br>1 file changed, 6 in=
sertions(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>i=
ndex 169af43..a760e07 100644</span><br><span>--- a/src/openvpn/multi.c</spa=
n><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -3217,6 +3217,12 @=
@</span><br><span>     struct hash *hash =3D m-&gt;hash;</span><br><span>  =
   struct gc_arena gc =3D gc_new();</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (mi-&gt;real.type &amp; MR_WITH_PR=
OTO)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        real.type |=3D MR_WIT=
H_PROTO;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        rea=
l.proto =3D sock-&gt;info.proto;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span>     if (!mroute_extract_openvpn_sockaddr(&amp;real, &amp;m=
-&gt;top.c2.from.dest, true))</span><br><span>     {</span><br><span>      =
   goto done;</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1063?usp=3Demail">change 1063</a>. T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http=
://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1063?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0e17d9aea32eab7f44ed95037f0=
77ae6dec52053 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1063 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: its_Giaan &lt;gianmarco@...1664...=
26...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--q0vYFPcvh/A=--

