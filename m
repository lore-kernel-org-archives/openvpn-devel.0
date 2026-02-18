From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 18 Feb 2026 11:49:16 +0000
References: <gerrit.1771415352000.I262705189edfbd9aa9a32bcd712840fffa592435@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e08b3957115070dfdaa066c10c0bdf0166e4c82f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="A89455Xhva0="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.6]: dns: fix
 discards 'const' qualifier from pointer target type
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

--A89455Xhva0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1544?usp=3Demail

to review the following change.


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
---
M src/openvpn/dns.c
1 file changed, 4 insertions(+), 4 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/44/1544/1

diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 7de3991..66ac32f 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -38,7 +38,7 @@
  * @return              True if parsing was successful
  */
 static bool
-dns_server_port_parse(in_port_t *port, char *port_str)
+dns_server_port_parse(in_port_t *port, const char *port_str)
 {
     char *endptr;
     errno =3D 0;
@@ -64,8 +64,8 @@
     in_port_t port =3D 0;
     sa_family_t af;

-    char *first_colon =3D strchr(addr, ':');
-    char *last_colon =3D strrchr(addr, ':');
+    const char *first_colon =3D strchr(addr, ':');
+    const char *last_colon =3D strrchr(addr, ':');

     if (!first_colon || first_colon =3D=3D last_colon)
     {
@@ -86,7 +86,7 @@
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
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1544?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I262705189edfbd9aa9a32bcd712840fffa592435
Gerrit-Change-Number: 1544
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--A89455Xhva0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1544?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">dns: fix discards &#39;const&#39; qualifier=
 from pointer target type<br><br>Since glibc-2.43:<br><br>For ISO C23, the =
functions bsearch, memchr, strchr, strpbrk, strrchr,<br>strstr, wcschr, wcs=
pbrk, wcsrchr, wcsstr and wmemchr that return pointers<br>into their input =
arrays now have definitions as macros that return a<br>pointer to a const-q=
ualified type when the input argument is a pointer<br>to a const-qualified =
type.<br><br>fixes:<br>    src/openvpn/dns.c: In function &#39;dns_server_a=
ddr_parse&#39;:<br>    src/openvpn/dns.c:67:25: warning: initialization dis=
cards &#39;const&#39; qualifier from pointer target type [-Wdiscarded-quali=
fiers]<br>       67 |     char *first_colon =3D strchr(addr, &#39;:&#39;);<=
br>          |                         ^~~~~~<br>    src/openvpn/dns.c:68:2=
4: warning: initialization discards &#39;const&#39; qualifier from pointer =
target type [-Wdiscarded-qualifiers]<br>       68 |     char *last_colon =
=3D strrchr(addr, &#39;:&#39;);<br>          |                        ^~~~~=
~~<br><br>Change-Id: I262705189edfbd9aa9a32bcd712840fffa592435<br>Signed-of=
f-by: Rudi Heitbaum &lt;rudi@...2993...&gt;<br>---<br>M src/openvpn/dns.c<b=
r>1 file changed, 4 insertions(+), 4 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/44/1544/1<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c</span><br><span>=
index 7de3991..66ac32f 100644</span><br><span>--- a/src/openvpn/dns.c</span=
><br><span>+++ b/src/openvpn/dns.c</span><br><span>@@ -38,7 +38,7 @@</span>=
<br><span>  * @return              True if parsing was successful</span><br=
><span>  */</span><br><span> static bool</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-dns_server_port_parse(in_port_t *port, char *port_str)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+dns_server_port_parse=
(in_port_t *port, const char *port_str)</span><br><span> {</span><br><span>=
     char *endptr;</span><br><span>     errno =3D 0;</span><br><span>@@ -64=
,8 +64,8 @@</span><br><span>     in_port_t port =3D 0;</span><br><span>    =
 sa_family_t af;</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    char *first_colon =3D strchr(addr, &#39;:&#39;);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    char *last_colon =3D strrch=
r(addr, &#39;:&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const char *first_colon =3D strchr(addr, &#39;:&#39;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    const char *last_colon =3D str=
rchr(addr, &#39;:&#39;);</span><br><span> </span><br><span>     if (!first_=
colon || first_colon =3D=3D last_colon)</span><br><span>     {</span><br><s=
pan>@@ -86,7 +86,7 @@</span><br><span>         if (addr[0] =3D=3D &#39;[&#3=
9;)</span><br><span>         {</span><br><span>             addr +=3D 1;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            char *bracke=
t =3D last_colon - 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            const char *bracket =3D last_colon - 1;</span><br><span>     =
        if (*bracket !=3D &#39;]&#39; || bracket =3D=3D addr || !dns_server=
_port_parse(&amp;port, last_colon + 1))</span><br><span>             {</spa=
n><br><span>                 return false;</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1544?us=
p=3Demail">change 1544</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1544?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I262705189edfbd9aa9a32bcd712=
840fffa592435 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1544 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--A89455Xhva0=--

