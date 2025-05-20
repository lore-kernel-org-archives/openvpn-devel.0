From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 20 May 2025 12:10:19 +0000
In-Reply-To: <gerrit.1747725275000.Ie3fcd845344fd0c3ce9a2f99612fb19fe5ebb2f1@...2715...>
References: <gerrit.1747725275000.Ie3fcd845344fd0c3ce9a2f99612fb19fe5ebb2f1@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <289259bd5e384c378734ec408339a9a46766314b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bCj8CwIewWw="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: win: fix collecting
 DNS exclude data
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--bCj8CwIewWw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/10=
28?usp=3Demail )

Change subject: win: fix collecting DNS exclude data
......................................................................

win: fix collecting DNS exclude data

The size of the returned MULTI_SZ wide domains string was calculated
wrongly. Instead of adding the size of a WCHAR, only the size of a char
was used. As a result, the domains string was stored too short and was
missing the final string terminator.

DHCP assigned DNS server addresses are separated by space, not comma.
These spaces were not replaced by semicolon, as the spec requires.

Github: fixes OpenVPN/openvpn#747
Change-Id: Ie3fcd845344fd0c3ce9a2f99612fb19fe5ebb2f1
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Message-Id: <20250520085513.28213-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
727.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/interactive.c
1 file changed, 5 insertions(+), 5 deletions(-)




diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index a1581a6..6681b7c 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2226,7 +2226,7 @@
                     {
                         /* This was the last domain */
                         *pos =3D '\0';
-                        *size +=3D 1;
+                        *size +=3D one_glyph;
                         return wcslen(domains) ? NO_ERROR : ERROR_FILE_NOT=
_FOUND;
                     }
                 }
@@ -2248,13 +2248,13 @@
                 memmove(pos + 1, pos, buf_size - converted_size - one_glyp=
h);
                 domains[buf_len - 1] =3D '\0';
                 *pos =3D '.';
-                *size +=3D 1;
+                *size +=3D one_glyph;

                 if (!comma)
                 {
                     /* Conversion is done */
                     *(pos + domain_len) =3D '\0';
-                    *size +=3D 1;
+                    *size +=3D one_glyph;
                     return NO_ERROR;
                 }

@@ -2409,10 +2409,10 @@

         if (v4_addrs_size || v6_addrs_size)
         {
-            /* Replace comma-delimters with semicolons, as required by NRP=
T */
+            /* Replace delimiters with semicolons, as required by NRPT */
             for (int j =3D 0; j < sizeof(data[0].addresses) && data[i].add=
resses[j]; j++)
             {
-                if (data[i].addresses[j] =3D=3D ',')
+                if (data[i].addresses[j] =3D=3D ',' || data[i].addresses[j=
] =3D=3D ' ')
                 {
                     data[i].addresses[j] =3D ';';
                 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1028?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie3fcd845344fd0c3ce9a2f99612fb19fe5ebb2f1
Gerrit-Change-Number: 1028
Gerrit-PatchSet: 4
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--bCj8CwIewWw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1028?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">win: fix collecting DNS exclude data<br><br>T=
he size of the returned MULTI_SZ wide domains string was calculated<br>wron=
gly. Instead of adding the size of a WCHAR, only the size of a char<br>was =
used. As a result, the domains string was stored too short and was<br>missi=
ng the final string terminator.<br><br>DHCP assigned DNS server addresses a=
re separated by space, not comma.<br>These spaces were not replaced by semi=
colon, as the spec requires.<br><br>Github: fixes OpenVPN/openvpn#747<br>Ch=
ange-Id: Ie3fcd845344fd0c3ce9a2f99612fb19fe5ebb2f1<br>Signed-off-by: Heiko =
Hund &lt;heiko@...2662...&gt;<br>Acked-by: Lev Stipakov &lt;lstipakov@...1664...=
7...&gt;<br>Message-Id: &lt;20250520085513.28213-1-gert@...1296...&gt;<br>U=
RL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg317=
27.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M =
src/openvpnserv/interactive.c<br>1 file changed, 5 insertions(+), 5 deletio=
ns(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive=
.c</span><br><span>index a1581a6..6681b7c 100644</span><br><span>--- a/src/=
openvpnserv/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive=
.c</span><br><span>@@ -2226,7 +2226,7 @@</span><br><span>                  =
   {</span><br><span>                         /* This was the last domain *=
/</span><br><span>                         *pos =3D &#39;\0&#39;;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                        *size +=
=3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
           *size +=3D one_glyph;</span><br><span>                         r=
eturn wcslen(domains) ? NO_ERROR : ERROR_FILE_NOT_FOUND;</span><br><span>  =
                   }</span><br><span>                 }</span><br><span>@@ =
-2248,13 +2248,13 @@</span><br><span>                 memmove(pos + 1, pos,=
 buf_size - converted_size - one_glyph);</span><br><span>                 d=
omains[buf_len - 1] =3D &#39;\0&#39;;</span><br><span>                 *pos=
 =3D &#39;.&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            *size +=3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                *size +=3D one_glyph;</span><br><span> </span><br><sp=
an>                 if (!comma)</span><br><span>                 {</span><b=
r><span>                     /* Conversion is done */</span><br><span>     =
                *(pos + domain_len) =3D &#39;\0&#39;;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    *size +=3D 1;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                    *size +=
=3D one_glyph;</span><br><span>                     return NO_ERROR;</span>=
<br><span>                 }</span><br><span> </span><br><span>@@ -2409,10 =
+2409,10 @@</span><br><span> </span><br><span>         if (v4_addrs_size ||=
 v6_addrs_size)</span><br><span>         {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            /* Replace comma-delimters with semicolons=
, as required by NRPT */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            /* Replace delimiters with semicolons, as required by NRPT=
 */</span><br><span>             for (int j =3D 0; j &lt; sizeof(data[0].ad=
dresses) &amp;&amp; data[i].addresses[j]; j++)</span><br><span>            =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                if =
(data[i].addresses[j] =3D=3D &#39;,&#39;)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                if (data[i].addresses[j] =3D=3D &#39;=
,&#39; || data[i].addresses[j] =3D=3D &#39; &#39;)</span><br><span>        =
         {</span><br><span>                     data[i].addresses[j] =3D &#=
39;;&#39;;</span><br><span>                 }</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1028=
?usp=3Demail">change 1028</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1028?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie3fcd845344fd0c3ce9a2f99612=
fb19fe5ebb2f1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1028 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--bCj8CwIewWw=--

