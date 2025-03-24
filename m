From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 24 Mar 2025 09:21:34 +0000
In-Reply-To: <gerrit.1741926089000.I23710b1f5b2122ec1f14465911836c0f0afa9c64@...2715...>
References: <gerrit.1741926089000.I23710b1f5b2122ec1f14465911836c0f0afa9c64@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <3ef90c690c73dacc79f86a8f80be266cf3fa82f5-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="06Z5+fQYeBI="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: win: calculate
 address string buffer size
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--06Z5+fQYeBI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/90=
8?usp=3Demail )

Change subject: win: calculate address string buffer size
......................................................................

win: calculate address string buffer size

Instead of making the string buffer statically sized for a max. of
four addresses, calculate it to hold up to the max number of addresses
a dns_cfg_message_t can hold (currently four as well). Improves the code
so that it doesn't rely on the addresses never being more than four in
the future.

Change-Id: I23710b1f5b2122ec1f14465911836c0f0afa9c64
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20250324083350.4019-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
196.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/interactive.c
1 file changed, 4 insertions(+), 3 deletions(-)




diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 50363b6..e64ac30 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1848,9 +1848,10 @@
     int addr_len =3D msg->addr_len;

     /* sanity check */
-    if (addr_len > _countof(msg->addr))
+    const size_t max_addrs =3D _countof(msg->addr);
+    if (addr_len > max_addrs)
     {
-        addr_len =3D _countof(msg->addr);
+        addr_len =3D max_addrs;
     }

     if (!msg->iface.name[0]) /* interface name is required */
@@ -1900,7 +1901,7 @@
     if (msg->addr_len > 0)
     {
         /* prepare the comma separated address list */
-        CHAR addrs[256]; /* large enough to hold four IPv4 / IPv6 address =
strings */
+        CHAR addrs[max_addrs * 64]; /* 64 is enough for one IPv4/6 address=
 */
         size_t offset =3D 0;
         for (int i =3D 0; i < addr_len; ++i)
         {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/908?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I23710b1f5b2122ec1f14465911836c0f0afa9c64
Gerrit-Change-Number: 908
Gerrit-PatchSet: 7
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--06Z5+fQYeBI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/908?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">win: calculate address string buffer size<br><=
br>Instead of making the string buffer statically sized for a max. of<br>fo=
ur addresses, calculate it to hold up to the max number of addresses<br>a d=
ns_cfg_message_t can hold (currently four as well). Improves the code<br>so=
 that it doesn&#39;t rely on the addresses never being more than four in<br=
>the future.<br><br>Change-Id: I23710b1f5b2122ec1f14465911836c0f0afa9c64<br=
>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>Acked-by: Frank Lich=
tenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;20250324083350.4019-1-g=
ert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1697...=
.sourceforge.net/msg31196.html<br>Signed-off-by: Gert Doering &lt;gert@...1386...=
296...&gt;<br>---<br>M src/openvpnserv/interactive.c<br>1 file changed, 4 i=
nsertions(+), 3 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive=
.c</span><br><span>index 50363b6..e64ac30 100644</span><br><span>--- a/src/=
openvpnserv/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive=
.c</span><br><span>@@ -1848,9 +1848,10 @@</span><br><span>     int addr_len=
 =3D msg-&gt;addr_len;</span><br><span> </span><br><span>     /* sanity che=
ck */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (addr_len=
 &gt; _countof(msg-&gt;addr))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const size_t max_addrs =3D _countof(msg-&gt;addr);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (addr_len &gt; max_addr=
s)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        addr_len =3D _countof(msg-&gt;addr);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        addr_len =3D max_addrs;</span><br><spa=
n>     }</span><br><span> </span><br><span>     if (!msg-&gt;iface.name[0])=
 /* interface name is required */</span><br><span>@@ -1900,7 +1901,7 @@</sp=
an><br><span>     if (msg-&gt;addr_len &gt; 0)</span><br><span>     {</span=
><br><span>         /* prepare the comma separated address list */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        CHAR addrs[256]; /* la=
rge enough to hold four IPv4 / IPv6 address strings */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        CHAR addrs[max_addrs * 64]; /* 6=
4 is enough for one IPv4/6 address */</span><br><span>         size_t offse=
t =3D 0;</span><br><span>         for (int i =3D 0; i &lt; addr_len; ++i)</=
span><br><span>         {</span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/908?usp=3Demail">change =
908</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/908?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I23710b1f5b2122ec1f144659118=
36c0f0afa9c64 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 908 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--06Z5+fQYeBI=--

