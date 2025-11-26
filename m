From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 26 Nov 2025 11:20:30 +0000
In-Reply-To: <gerrit.1763928247000.I69a6ab59d995fb4a511f57c8535b5ffa4048673c@...2715...>
References: <gerrit.1763928247000.I69a6ab59d995fb4a511f57c8535b5ffa4048673c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <381ee1bcdad6c31b3e67591ccfb5c13498a1039e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1jCRpVttdFI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: iservice: rename
 one_glyph to glyph_size
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

--1jCRpVttdFI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
98?usp=3Demail )

Change subject: iservice: rename one_glyph to glyph_size
......................................................................

iservice: rename one_glyph to glyph_size

Throughout the function variables which deal with byte counts have a
_size postfix. one_glyph is the number of bytes in one character.
Reading the code is easier and more consistent this way.

Change-Id: I69a6ab59d995fb4a511f57c8535b5ffa4048673c
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1398
Message-Id: <20251124170055.16034-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
642.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/interactive.c
1 file changed, 12 insertions(+), 12 deletions(-)




diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 13e303a..220c042 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2156,14 +2156,14 @@

     LSTATUS err =3D ERROR_FILE_NOT_FOUND;
     const DWORD buf_size =3D *size;
-    const size_t one_glyph =3D sizeof(*domains);
+    const size_t glyph_size =3D sizeof(*domains);
     PWSTR values[] =3D { L"SearchList", L"Domain", L"DhcpDomainSearchList"=
, L"DhcpDomain", NULL };

     for (int i =3D 0; values[i]; i++)
     {
         *size =3D buf_size;
         err =3D RegGetValueW(itf, NULL, values[i], RRF_RT_REG_SZ, NULL, (P=
BYTE)domains, size);
-        if (!err && *size > one_glyph && domains[(*size / one_glyph) - 1] =
=3D=3D '\0' && wcschr(domains, '.'))
+        if (!err && *size > glyph_size && domains[(*size / glyph_size) - 1=
] =3D=3D '\0' && wcschr(domains, '.'))
         {
             /*
              * Found domain(s), now convert them:
@@ -2171,7 +2171,7 @@
              *   - convert comma separated list to MULTI_SZ
              */
             PWCHAR pos =3D domains;
-            const DWORD buf_len =3D buf_size / one_glyph;
+            const DWORD buf_len =3D buf_size / glyph_size;
             while (TRUE)
             {
                 /* Terminate the domain at the next comma */
@@ -2182,8 +2182,8 @@
                 }

                 size_t domain_len =3D wcslen(pos);
-                size_t domain_size =3D domain_len * one_glyph;
-                size_t converted_size =3D (pos - domains) * one_glyph;
+                size_t domain_size =3D domain_len * glyph_size;
+                size_t converted_size =3D (pos - domains) * glyph_size;

                 /* Ignore itf domains which match a pushed search domain */
                 if (ListContainsDomain(search_domains, pos, domain_len))
@@ -2192,7 +2192,7 @@
                     {
                         /* Overwrite the ignored domain with remaining one=
(s) */
                         memmove(pos, comma + 1, buf_size - converted_size);
-                        *size -=3D domain_size + one_glyph;
+                        *size -=3D domain_size + glyph_size;
                         continue;
                     }
                     else
@@ -2206,31 +2206,31 @@

                 /* Add space for the leading dot */
                 domain_len +=3D 1;
-                domain_size +=3D one_glyph;
+                domain_size +=3D glyph_size;

                 /* Space for the terminating zeros */
-                size_t extra_size =3D 2 * one_glyph;
+                size_t extra_size =3D 2 * glyph_size;

                 /* Check for enough space to convert this domain */
                 if (converted_size + domain_size + extra_size > buf_size)
                 {
                     /* Domain doesn't fit, bad luck if it's the first one =
*/
                     *pos =3D '\0';
-                    *size =3D converted_size =3D=3D 0 ? 0 : converted_size=
 + one_glyph;
+                    *size =3D converted_size =3D=3D 0 ? 0 : converted_size=
 + glyph_size;
                     return ERROR_MORE_DATA;
                 }

                 /* Prefix domain at pos with the dot */
-                memmove(pos + 1, pos, buf_size - converted_size - one_glyp=
h);
+                memmove(pos + 1, pos, buf_size - converted_size - glyph_si=
ze);
                 domains[buf_len - 1] =3D '\0';
                 *pos =3D '.';
-                *size +=3D one_glyph;
+                *size +=3D glyph_size;

                 if (!comma)
                 {
                     /* Conversion is done */
                     *(pos + domain_len) =3D '\0';
-                    *size +=3D one_glyph;
+                    *size +=3D glyph_size;
                     return NO_ERROR;
                 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1398?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I69a6ab59d995fb4a511f57c8535b5ffa4048673c
Gerrit-Change-Number: 1398
Gerrit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--1jCRpVttdFI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1398?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">iservice: rename one_glyph to glyph_size<br><br>=
Throughout the function variables which deal with byte counts have a<br>_si=
ze postfix. one_glyph is the number of bytes in one character.<br>Reading t=
he code is easier and more consistent this way.<br><br>Change-Id: I69a6ab59=
d995fb4a511f57c8535b5ffa4048673c<br>Signed-off-by: Heiko Hund &lt;heiko@...493...=
2662...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL=
: https://gerrit.openvpn.net/c/openvpn/+/1398<br>Message-Id: &lt;2025112417=
0055.16034-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openv=
pn-devel@lists.sourceforge.net/msg34642.html<br>Signed-off-by: Gert Doering=
 &lt;gert@...1296...&gt;<br>---<br>M src/openvpnserv/interactive.c<br>1 fil=
e changed, 12 insertions(+), 12 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive=
.c</span><br><span>index 13e303a..220c042 100644</span><br><span>--- a/src/=
openvpnserv/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive=
.c</span><br><span>@@ -2156,14 +2156,14 @@</span><br><span> </span><br><spa=
n>     LSTATUS err =3D ERROR_FILE_NOT_FOUND;</span><br><span>     const DWO=
RD buf_size =3D *size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    const size_t one_glyph =3D sizeof(*domains);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const size_t glyph_size =3D sizeof(*domai=
ns);</span><br><span>     PWSTR values[] =3D { L&quot;SearchList&quot;, L&q=
uot;Domain&quot;, L&quot;DhcpDomainSearchList&quot;, L&quot;DhcpDomain&quot=
;, NULL };</span><br><span> </span><br><span>     for (int i =3D 0; values[=
i]; i++)</span><br><span>     {</span><br><span>         *size =3D buf_size=
;</span><br><span>         err =3D RegGetValueW(itf, NULL, values[i], RRF_R=
T_REG_SZ, NULL, (PBYTE)domains, size);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (!err &amp;&amp; *size &gt; one_glyph &amp;&amp=
; domains[(*size / one_glyph) - 1] =3D=3D &#39;\0&#39; &amp;&amp; wcschr(do=
mains, &#39;.&#39;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (!err &amp;&amp; *size &gt; glyph_size &amp;&amp; domains[(*siz=
e / glyph_size) - 1] =3D=3D &#39;\0&#39; &amp;&amp; wcschr(domains, &#39;.&=
#39;))</span><br><span>         {</span><br><span>             /*</span><br=
><span>              * Found domain(s), now convert them:</span><br><span>@=
@ -2171,7 +2171,7 @@</span><br><span>              *   - convert comma sepa=
rated list to MULTI_SZ</span><br><span>              */</span><br><span>   =
          PWCHAR pos =3D domains;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            const DWORD buf_len =3D buf_size / one_glyph;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            const DWORD b=
uf_len =3D buf_size / glyph_size;</span><br><span>             while (TRUE)=
</span><br><span>             {</span><br><span>                 /* Termina=
te the domain at the next comma */</span><br><span>@@ -2182,8 +2182,8 @@</s=
pan><br><span>                 }</span><br><span> </span><br><span>        =
         size_t domain_len =3D wcslen(pos);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                size_t domain_size =3D domain_len * o=
ne_glyph;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    size_t converted_size =3D (pos - domains) * one_glyph;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                size_t domain_size =
=3D domain_len * glyph_size;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                size_t converted_size =3D (pos - domains) * glyph_=
size;</span><br><span> </span><br><span>                 /* Ignore itf doma=
ins which match a pushed search domain */</span><br><span>                 =
if (ListContainsDomain(search_domains, pos, domain_len))</span><br><span>@@=
 -2192,7 +2192,7 @@</span><br><span>                     {</span><br><span>=
                         /* Overwrite the ignored domain with remaining one=
(s) */</span><br><span>                         memmove(pos, comma + 1, buf=
_size - converted_size);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                        *size -=3D domain_size + one_glyph;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                        *size -=
=3D domain_size + glyph_size;</span><br><span>                         cont=
inue;</span><br><span>                     }</span><br><span>              =
       else</span><br><span>@@ -2206,31 +2206,31 @@</span><br><span> </span=
><br><span>                 /* Add space for the leading dot */</span><br><=
span>                 domain_len +=3D 1;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                domain_size +=3D one_glyph;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                domain_size +=3D=
 glyph_size;</span><br><span> </span><br><span>                 /* Space fo=
r the terminating zeros */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                size_t extra_size =3D 2 * one_glyph;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                size_t extra_size =3D=
 2 * glyph_size;</span><br><span> </span><br><span>                 /* Chec=
k for enough space to convert this domain */</span><br><span>              =
   if (converted_size + domain_size + extra_size &gt; buf_size)</span><br><=
span>                 {</span><br><span>                     /* Domain does=
n&#39;t fit, bad luck if it&#39;s the first one */</span><br><span>        =
             *pos =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                    *size =3D converted_size =3D=3D 0 ? 0 : c=
onverted_size + one_glyph;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    *size =3D converted_size =3D=3D 0 ? 0 : converte=
d_size + glyph_size;</span><br><span>                     return ERROR_MORE=
_DATA;</span><br><span>                 }</span><br><span> </span><br><span=
>                 /* Prefix domain at pos with the dot */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                memmove(pos + 1, pos, b=
uf_size - converted_size - one_glyph);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                memmove(pos + 1, pos, buf_size - convert=
ed_size - glyph_size);</span><br><span>                 domains[buf_len - 1=
] =3D &#39;\0&#39;;</span><br><span>                 *pos =3D &#39;.&#39;;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                *size =
+=3D one_glyph;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            *size +=3D glyph_size;</span><br><span> </span><br><span>      =
           if (!comma)</span><br><span>                 {</span><br><span> =
                    /* Conversion is done */</span><br><span>              =
       *(pos + domain_len) =3D &#39;\0&#39;;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                    *size +=3D one_glyph;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    *size +=3D=
 glyph_size;</span><br><span>                     return NO_ERROR;</span><b=
r><span>                 }</span><br><span> </span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1398?=
usp=3Demail">change 1398</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1398?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I69a6ab59d995fb4a511f57c8535=
b5ffa4048673c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1398 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--1jCRpVttdFI=--

