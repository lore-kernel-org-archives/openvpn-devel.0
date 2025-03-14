From: "d12fk (Code Review)" <gerrit@...515...>
Date: Fri, 14 Mar 2025 04:21:54 +0000
References: <gerrit.1741926089000.I23710b1f5b2122ec1f14465911836c0f0afa9c64@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a929bca5a04378b765103c840b2f5348139303c6-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="f6BAtUTXwHI="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--f6BAtUTXwHI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/908?usp=3Demail

to review the following change.


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
---
M src/openvpnserv/interactive.c
1 file changed, 4 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/08/908/1

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index eb3c867..90af02d 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1866,9 +1866,10 @@
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
@@ -1918,7 +1919,7 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--f6BAtUTXwHI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/908?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">win: calculate address string buffer size<br><br>Instead of m=
aking the string buffer statically sized for a max. of<br>four addresses, c=
alculate it to hold up to the max number of addresses<br>a dns_cfg_message_=
t can hold (currently four as well). Improves the code<br>so that it doesn&=
#39;t rely on the addresses never being more than four in<br>the future.<br=
><br>Change-Id: I23710b1f5b2122ec1f14465911836c0f0afa9c64<br>Signed-off-by:=
 Heiko Hund &lt;heiko@...2662...&gt;<br>---<br>M src/openvpnserv/interactiv=
e.c<br>1 file changed, 4 insertions(+), 3 deletions(-)<br><br></pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull s=
sh://gerrit.openvpn.net:29418/openvpn refs/changes/08/908/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c</span><=
br><span>index eb3c867..90af02d 100644</span><br><span>--- a/src/openvpnser=
v/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive.c</span><=
br><span>@@ -1866,9 +1866,10 @@</span><br><span>     int addr_len =3D msg-&=
gt;addr_len;</span><br><span> </span><br><span>     /* sanity check */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (addr_len &gt; _cou=
ntof(msg-&gt;addr))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const size_t max_addrs =3D _countof(msg-&gt;addr);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (addr_len &gt; max_addrs)</span><=
br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  addr_len =3D _countof(msg-&gt;addr);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        addr_len =3D max_addrs;</span><br><span>     }</=
span><br><span> </span><br><span>     if (!msg-&gt;iface.name[0]) /* interf=
ace name is required */</span><br><span>@@ -1918,7 +1919,7 @@</span><br><sp=
an>     if (msg-&gt;addr_len &gt; 0)</span><br><span>     {</span><br><span=
>         /* prepare the comma separated address list */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        CHAR addrs[256]; /* large enough=
 to hold four IPv4 / IPv6 address strings */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        CHAR addrs[max_addrs * 64]; /* 64 is enoug=
h for one IPv4/6 address */</span><br><span>         size_t offset =3D 0;</=
span><br><span>         for (int i =3D 0; i &lt; addr_len; ++i)</span><br><=
span>         {</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/908?usp=3Demail">change 908</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/908?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I23710b1f5b2122ec1f144659118=
36c0f0afa9c64 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 908 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--f6BAtUTXwHI=--

