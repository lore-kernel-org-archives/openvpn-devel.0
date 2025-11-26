From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 26 Nov 2025 11:01:27 +0000
In-Reply-To: <gerrit.1763880426000.I16f9426e57f4802ba038ab51f5b70161464b9428@...2715...>
References: <gerrit.1763880426000.I16f9426e57f4802ba038ab51f5b70161464b9428@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <c258464969e1e9c504e6b4b836a18d76542ec417-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="x1dvFZL9MdA="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: iservice: fix
 calculation of converted domains size
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--x1dvFZL9MdA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 d12fk. ( http://gerrit.openvpn.net/c/openvpn/+/1390?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: iservice: fix calculation of converted domains size
......................................................................

iservice: fix calculation of converted domains size

To keep track of how much of the buffer is already used, the difference
of the current position and the start of the buffer needs to be
multiplied with the size of a character / glyph to bet the byte count,
with which calculations are done further down below.

Reported-by: Marc Heuse <marc@...2953...>
Reported-by: stephan@...2953...
Change-Id: I16f9426e57f4802ba038ab51f5b70161464b9428
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1390
Message-Id: <20251126103427.4085-1-gert@...1296...>
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/interactive.c
1 file changed, 11 insertions(+), 5 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/90/1390/3

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index dbb5a4b..ed3c928 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2181,8 +2181,11 @@
                     *comma =3D '\0';
                 }

-                /* Ignore itf domains which match a pushed search domain */
                 size_t domain_len =3D wcslen(pos);
+                size_t domain_size =3D domain_len * one_glyph;
+                size_t converted_size =3D (pos - domains) * one_glyph;
+
+                /* Ignore itf domains which match a pushed search domain */
                 if (ListContainsDomain(search_domains, pos, domain_len))
                 {
                     if (comma)
@@ -2199,11 +2202,14 @@
                     }
                 }

-                /* Check for enough space to convert this domain */
-                domain_len +=3D 1; /* leading dot */
-                size_t converted_size =3D pos - domains;
-                size_t domain_size =3D domain_len * one_glyph;
+                /* Add space for the leading dot */
+                domain_len +=3D 1;
+                domain_size +=3D one_glyph;
+
+                /* Space for the terminating zeros */
                 size_t extra_size =3D 2 * one_glyph;
+
+                /* Check for enough space to convert this domain */
                 if (converted_size + domain_size + extra_size > buf_size)
                 {
                     /* Domain doesn't fit, bad luck if it's the first one =
*/

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1390?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I16f9426e57f4802ba038ab51f5b70161464b9428
Gerrit-Change-Number: 1390
Gerrit-PatchSet: 3
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--x1dvFZL9MdA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by d12fk.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1390?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">iservice: fix calculation of conver=
ted domains size<br><br>To keep track of how much of the buffer is already =
used, the difference<br>of the current position and the start of the buffer=
 needs to be<br>multiplied with the size of a character / glyph to bet the =
byte count,<br>with which calculations are done further down below.<br><br>=
Reported-by: Marc Heuse &lt;marc@...2953...&gt;<br>Reported-by: stephan@...493...=
2953...<br>Change-Id: I16f9426e57f4802ba038ab51f5b70161464b9428<br>Signed-o=
ff-by: Heiko Hund &lt;heiko@...2662...&gt;<br>Acked-by: Gert Doering &lt;ge=
rt@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/139=
0<br>Message-Id: &lt;20251126103427.4085-1-gert@...1296...&gt;<br>Signed-of=
f-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpnserv/inte=
ractive.c<br>1 file changed, 11 insertions(+), 5 deletions(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/=
90/1390/3</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpnserv/interactive.c b/src/openvpns=
erv/interactive.c</span><br><span>index dbb5a4b..ed3c928 100644</span><br><=
span>--- a/src/openvpnserv/interactive.c</span><br><span>+++ b/src/openvpns=
erv/interactive.c</span><br><span>@@ -2181,8 +2181,11 @@</span><br><span>  =
                   *comma =3D &#39;\0&#39;;</span><br><span>               =
  }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                /* Ignore itf domains which match a pushed search domain */=
</span><br><span>                 size_t domain_len =3D wcslen(pos);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                size_t dom=
ain_size =3D domain_len * one_glyph;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                size_t converted_size =3D (pos - domains) =
* one_glyph;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                /* Ignore =
itf domains which match a pushed search domain */</span><br><span>         =
        if (ListContainsDomain(search_domains, pos, domain_len))</span><br>=
<span>                 {</span><br><span>                     if (comma)</s=
pan><br><span>@@ -2199,11 +2202,14 @@</span><br><span>                     =
}</span><br><span>                 }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                /* Check for enough space =
to convert this domain */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                domain_len +=3D 1; /* leading dot */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                size_t converted_size =
=3D pos - domains;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             size_t domain_size =3D domain_len * one_glyph;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                /* Add space for th=
e leading dot */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             domain_len +=3D 1;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                domain_size +=3D one_glyph;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                /* Space for the terminating zeros */</spa=
n><br><span>                 size_t extra_size =3D 2 * one_glyph;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                /* Check for enough space to con=
vert this domain */</span><br><span>                 if (converted_size + d=
omain_size + extra_size &gt; buf_size)</span><br><span>                 {</=
span><br><span>                     /* Domain doesn&#39;t fit, bad luck if =
it&#39;s the first one */</span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1390?usp=3Demail">change=
 1390</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1390?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I16f9426e57f4802ba038ab51f5b=
70161464b9428 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1390 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--x1dvFZL9MdA=--

