From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 19 Feb 2026 10:00:40 +0000
In-Reply-To: <gerrit.1771414141000.I262705189edfbd9aa9a32bcd712840fffa592435@...2715...>
References: <gerrit.1771414141000.I262705189edfbd9aa9a32bcd712840fffa592435@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <f75e491f8179b133dde6c59762210f1d1e49a712-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="n9mW0gS/tGY="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--n9mW0gS/tGY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1542?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/42/1542/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I262705189edfbd9aa9a32bcd712840fffa592435
Gerrit-Change-Number: 1542
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--n9mW0gS/tGY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1542?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">dns: fix discards &#39;const&#39; q=
ualifier from pointer target type<br><br>Since glibc-2.43:<br><br>For ISO C=
23, the functions bsearch, memchr, strchr, strpbrk, strrchr,<br>strstr, wcs=
chr, wcspbrk, wcsrchr, wcsstr and wmemchr that return pointers<br>into thei=
r input arrays now have definitions as macros that return a<br>pointer to a=
 const-qualified type when the input argument is a pointer<br>to a const-qu=
alified type.<br><br>fixes:<br>    src/openvpn/dns.c: In function &#39;dns_=
server_addr_parse&#39;:<br>    src/openvpn/dns.c:67:25: warning: initializa=
tion discards &#39;const&#39; qualifier from pointer target type [-Wdiscard=
ed-qualifiers]<br>       67 |     char *first_colon =3D strchr(addr, &#39;:=
&#39;);<br>          |                         ^~~~~~<br>    src/openvpn/dn=
s.c:68:24: warning: initialization discards &#39;const&#39; qualifier from =
pointer target type [-Wdiscarded-qualifiers]<br>       68 |     char *last_=
colon =3D strrchr(addr, &#39;:&#39;);<br>          |                       =
 ^~~~~~~<br><br>Change-Id: I262705189edfbd9aa9a32bcd712840fffa592435<br>Sig=
ned-off-by: Rudi Heitbaum &lt;rudi@...2993...&gt;<br>Acked-by: Gert Doering=
 &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvp=
n/+/1542<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Message=
-Id: &lt;20260218214738.27158-1-gert@...1296...&gt;<br>URL: https://www.mai=
l-archive.com/openvpn-devel@lists.sourceforge.net/msg35730.html<br>Signed-o=
ff-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/dns.c<b=
r>1 file changed, 4 insertions(+), 4 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/42/1542/2<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c</span><br><span>=
index 3d24050..747c0db 100644</span><br><span>--- a/src/openvpn/dns.c</span=
><br><span>+++ b/src/openvpn/dns.c</span><br><span>@@ -45,7 +45,7 @@</span>=
<br><span>  * @return              True if parsing was successful</span><br=
><span>  */</span><br><span> static bool</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-dns_server_port_parse(in_port_t *port, char *port_str)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+dns_server_port_parse=
(in_port_t *port, const char *port_str)</span><br><span> {</span><br><span>=
     char *endptr;</span><br><span>     errno =3D 0;</span><br><span>@@ -71=
,8 +71,8 @@</span><br><span>     in_port_t port =3D 0;</span><br><span>    =
 sa_family_t af;</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    char *first_colon =3D strchr(addr, &#39;:&#39;);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    char *last_colon =3D strrch=
r(addr, &#39;:&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const char *first_colon =3D strchr(addr, &#39;:&#39;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    const char *last_colon =3D str=
rchr(addr, &#39;:&#39;);</span><br><span> </span><br><span>     if (!first_=
colon || first_colon =3D=3D last_colon)</span><br><span>     {</span><br><s=
pan>@@ -93,7 +93,7 @@</span><br><span>         if (addr[0] =3D=3D &#39;[&#3=
9;)</span><br><span>         {</span><br><span>             addr +=3D 1;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            char *bracke=
t =3D last_colon - 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            const char *bracket =3D last_colon - 1;</span><br><span>     =
        if (*bracket !=3D &#39;]&#39; || bracket =3D=3D addr || !dns_server=
_port_parse(&amp;port, last_colon + 1))</span><br><span>             {</spa=
n><br><span>                 return false;</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1542?us=
p=3Demail">change 1542</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1542?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--n9mW0gS/tGY=--

