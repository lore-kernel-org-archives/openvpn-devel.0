From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 19 Feb 2026 10:00:50 +0000
In-Reply-To: <gerrit.1771414141000.I262705189edfbd9aa9a32bcd712840fffa592435@...2715...>
References: <gerrit.1771414141000.I262705189edfbd9aa9a32bcd712840fffa592435@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <f75e491f8179b133dde6c59762210f1d1e49a712-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6uNMOdBj2Js="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dns: fix discards
 'const' qualifier from pointer target type
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--6uNMOdBj2Js=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
42?usp=3Demail )

Change subject: dns: fix discards 'const' qualifier from pointer target type
......................................................................

dns: fix discards 'const' qualifier from pointer target type

Since glibc-2.43:

For ISO C23, the functions bsearch, memchr, strchr, strpbrk, strrchr,
strstr, wcschr, wcspbrk, wcsrchr, wcsstr and wmemchr that return pointers
into their input arrays now have definitions as macros that return a
pointer to a const-qualified type when the input argument is a pointer
to a const-qualified type.

fixes:
    src/openvpn/dns.c: In function 'dns_server_addr_parse':
    src/openvpn/dns.c:67:25: warning: initialization discards 'const' quali=
fier from pointer target type [-Wdiscarded-qualifiers]
       67 |     char *first_colon =3D strchr(addr, ':');
          |                         ^~~~~~
    src/openvpn/dns.c:68:24: warning: initialization discards 'const' quali=
fier from pointer target type [-Wdiscarded-qualifiers]
       68 |     char *last_colon =3D strrchr(addr, ':');
          |                        ^~~~~~~

Change-Id: I262705189edfbd9aa9a32bcd712840fffa592435
Signed-off-by: Rudi Heitbaum <rudi@...2993...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1542
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20260218214738.27158-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
730.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dns.c
1 file changed, 4 insertions(+), 4 deletions(-)




diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 3d24050..747c0db 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -45,7 +45,7 @@
  * @return              True if parsing was successful
  */
 static bool
-dns_server_port_parse(in_port_t *port, char *port_str)
+dns_server_port_parse(in_port_t *port, const char *port_str)
 {
     char *endptr;
     errno =3D 0;
@@ -71,8 +71,8 @@
     in_port_t port =3D 0;
     sa_family_t af;

-    char *first_colon =3D strchr(addr, ':');
-    char *last_colon =3D strrchr(addr, ':');
+    const char *first_colon =3D strchr(addr, ':');
+    const char *last_colon =3D strrchr(addr, ':');

     if (!first_colon || first_colon =3D=3D last_colon)
     {
@@ -93,7 +93,7 @@
         if (addr[0] =3D=3D '[')
         {
             addr +=3D 1;
-            char *bracket =3D last_colon - 1;
+            const char *bracket =3D last_colon - 1;
             if (*bracket !=3D ']' || bracket =3D=3D addr || !dns_server_po=
rt_parse(&port, last_colon + 1))
             {
                 return false;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1542?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I262705189edfbd9aa9a32bcd712840fffa592435
Gerrit-Change-Number: 1542
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--6uNMOdBj2Js=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1542?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">dns: fix discards &#39;const&#39; qualifier from=
 pointer target type<br><br>Since glibc-2.43:<br><br>For ISO C23, the funct=
ions bsearch, memchr, strchr, strpbrk, strrchr,<br>strstr, wcschr, wcspbrk,=
 wcsrchr, wcsstr and wmemchr that return pointers<br>into their input array=
s now have definitions as macros that return a<br>pointer to a const-qualif=
ied type when the input argument is a pointer<br>to a const-qualified type.=
<br><br>fixes:<br>    src/openvpn/dns.c: In function &#39;dns_server_addr_p=
arse&#39;:<br>    src/openvpn/dns.c:67:25: warning: initialization discards=
 &#39;const&#39; qualifier from pointer target type [-Wdiscarded-qualifiers=
]<br>       67 |     char *first_colon =3D strchr(addr, &#39;:&#39;);<br>  =
        |                         ^~~~~~<br>    src/openvpn/dns.c:68:24: wa=
rning: initialization discards &#39;const&#39; qualifier from pointer targe=
t type [-Wdiscarded-qualifiers]<br>       68 |     char *last_colon =3D str=
rchr(addr, &#39;:&#39;);<br>          |                        ^~~~~~~<br><=
br>Change-Id: I262705189edfbd9aa9a32bcd712840fffa592435<br>Signed-off-by: R=
udi Heitbaum &lt;rudi@...2993...&gt;<br>Acked-by: Gert Doering &lt;gert@...493...=
1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1542<br>A=
cked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;2026=
0218214738.27158-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com=
/openvpn-devel@lists.sourceforge.net/msg35730.html<br>Signed-off-by: Gert D=
oering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/dns.c<br>1 file chan=
ged, 4 insertions(+), 4 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c</span><br><span>index=
 3d24050..747c0db 100644</span><br><span>--- a/src/openvpn/dns.c</span><br>=
<span>+++ b/src/openvpn/dns.c</span><br><span>@@ -45,7 +45,7 @@</span><br><=
span>  * @return              True if parsing was successful</span><br><spa=
n>  */</span><br><span> static bool</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-dns_server_port_parse(in_port_t *port, char *port_str)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+dns_server_port_parse(in_p=
ort_t *port, const char *port_str)</span><br><span> {</span><br><span>     =
char *endptr;</span><br><span>     errno =3D 0;</span><br><span>@@ -71,8 +7=
1,8 @@</span><br><span>     in_port_t port =3D 0;</span><br><span>     sa_f=
amily_t af;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    char *first_colon =3D strchr(addr, &#39;:&#39;);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    char *last_colon =3D strrchr(add=
r, &#39;:&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const char *first_colon =3D strchr(addr, &#39;:&#39;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const char *last_colon =3D strrchr(=
addr, &#39;:&#39;);</span><br><span> </span><br><span>     if (!first_colon=
 || first_colon =3D=3D last_colon)</span><br><span>     {</span><br><span>@=
@ -93,7 +93,7 @@</span><br><span>         if (addr[0] =3D=3D &#39;[&#39;)</=
span><br><span>         {</span><br><span>             addr +=3D 1;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            char *bracket =3D=
 last_colon - 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         const char *bracket =3D last_colon - 1;</span><br><span>          =
   if (*bracket !=3D &#39;]&#39; || bracket =3D=3D addr || !dns_server_port=
_parse(&amp;port, last_colon + 1))</span><br><span>             {</span><br=
><span>                 return false;</span><br><span></span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1542?usp=3De=
mail">change 1542</a>. To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1542?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I262705189edfbd9aa9a32bcd712=
840fffa592435 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1542 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--6uNMOdBj2Js=--

