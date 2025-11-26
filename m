From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 26 Nov 2025 11:01:30 +0000
In-Reply-To: <gerrit.1763880426000.I16f9426e57f4802ba038ab51f5b70161464b9428@...2715...>
References: <gerrit.1763880426000.I16f9426e57f4802ba038ab51f5b70161464b9428@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <c258464969e1e9c504e6b4b836a18d76542ec417-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YdgE+UJhbUI="; charset=UTF-8
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
To: d12fk <heiko@...515...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--YdgE+UJhbUI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
90?usp=3Demail )

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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I16f9426e57f4802ba038ab51f5b70161464b9428
Gerrit-Change-Number: 1390
Gerrit-PatchSet: 3
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--YdgE+UJhbUI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1390?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">iservice: fix calculation of converted domains s=
ize<br><br>To keep track of how much of the buffer is already used, the dif=
ference<br>of the current position and the start of the buffer needs to be<=
br>multiplied with the size of a character / glyph to bet the byte count,<b=
r>with which calculations are done further down below.<br><br>Reported-by: =
Marc Heuse &lt;marc@...2953...&gt;<br>Reported-by: stephan@...2953...<br>Ch=
ange-Id: I16f9426e57f4802ba038ab51f5b70161464b9428<br>Signed-off-by: Heiko =
Hund &lt;heiko@...2662...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...=
&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1390<br>Message-=
Id: &lt;20251126103427.4085-1-gert@...1296...&gt;<br>Signed-off-by: Gert Do=
ering &lt;gert@...1296...&gt;<br>---<br>M src/openvpnserv/interactive.c<br>=
1 file changed, 11 insertions(+), 5 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive=
.c</span><br><span>index dbb5a4b..ed3c928 100644</span><br><span>--- a/src/=
openvpnserv/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive=
.c</span><br><span>@@ -2181,8 +2181,11 @@</span><br><span>                 =
    *comma =3D &#39;\0&#39;;</span><br><span>                 }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 /* Ignore itf domains which match a pushed search domain */</span><br><spa=
n>                 size_t domain_len =3D wcslen(pos);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                size_t domain_size =3D do=
main_len * one_glyph;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                size_t converted_size =3D (pos - domains) * one_glyph;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                /* Ignore itf domains whi=
ch match a pushed search domain */</span><br><span>                 if (Lis=
tContainsDomain(search_domains, pos, domain_len))</span><br><span>         =
        {</span><br><span>                     if (comma)</span><br><span>@=
@ -2199,11 +2202,14 @@</span><br><span>                     }</span><br><sp=
an>                 }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                /* Check for enough space to convert this=
 domain */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     domain_len +=3D 1; /* leading dot */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                size_t converted_size =3D pos - domains=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                size=
_t domain_size =3D domain_len * one_glyph;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                /* Add space for the leading dot */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                doma=
in_len +=3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           domain_size +=3D one_glyph;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                /* Space for the terminating zeros */</span><br><span>     =
            size_t extra_size =3D 2 * one_glyph;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                /* Check for enough space to convert this domain =
*/</span><br><span>                 if (converted_size + domain_size + extr=
a_size &gt; buf_size)</span><br><span>                 {</span><br><span>  =
                   /* Domain doesn&#39;t fit, bad luck if it&#39;s the firs=
t one */</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1390?usp=3Demail">change 1390</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1390?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--YdgE+UJhbUI=--

