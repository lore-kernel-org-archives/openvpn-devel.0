From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 31 Jul 2025 15:09:54 +0000
References: <gerrit.1753974592000.I37ca672f05e9d77ec586fa28dadc6dc752e574fb@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b8398a5f828294705a90ae20a46d0b4f539c1e6b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bXvic0POZ94="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix wrong byte
 order of --dns server
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

--bXvic0POZ94=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1125?usp=3Demail

to review the following change.


Change subject: Fix wrong byte order of --dns server
......................................................................

Fix wrong byte order of --dns server

We already fixed it in commit 82fd89a04f, but
the fix got lost in 2dfc4f8.

tuntap_options require host byte order, and we store
dns servers in struct dns_server in network byte order,
what we got from getaddrinfo().

Fix (again) by converting to the host byte order.

Change-Id: I37ca672f05e9d77ec586fa28dadc6dc752e574fb
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/options.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/25/1125/1

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3ceada0..ff9addd 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3573,7 +3573,7 @@
             {
                 if (s->addr[i].family =3D=3D AF_INET && tt->dns_len + 1 < =
N_DHCP_ADDR)
                 {
-                    tt->dns[tt->dns_len++] =3D s->addr[i].in.a4.s_addr;
+                    tt->dns[tt->dns_len++] =3D ntohl(s->addr[i].in.a4.s_ad=
dr);
                 }
                 else if (tt->dns6_len + 1 < N_DHCP_ADDR)
                 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1125?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I37ca672f05e9d77ec586fa28dadc6dc752e574fb
Gerrit-Change-Number: 1125
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--bXvic0POZ94=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1125?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Fix wrong byte order of --dns server<br><br>We already fixed=
 it in commit 82fd89a04f, but<br>the fix got lost in 2dfc4f8.<br><br>tuntap=
_options require host byte order, and we store<br>dns servers in struct dns=
_server in network byte order,<br>what we got from getaddrinfo().<br><br>Fi=
x (again) by converting to the host byte order.<br><br>Change-Id: I37ca672f=
05e9d77ec586fa28dadc6dc752e574fb<br>Signed-off-by: Lev Stipakov &lt;lev@...493...=
515...&gt;<br>---<br>M src/openvpn/options.c<br>1 file changed, 1 insertion=
(+), 1 deletion(-)<br><br></pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvp=
n refs/changes/25/1125/1</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/options.c b/src/o=
penvpn/options.c</span><br><span>index 3ceada0..ff9addd 100644</span><br><s=
pan>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c=
</span><br><span>@@ -3573,7 +3573,7 @@</span><br><span>             {</span=
><br><span>                 if (s-&gt;addr[i].family =3D=3D AF_INET &amp;&a=
mp; tt-&gt;dns_len + 1 &lt; N_DHCP_ADDR)</span><br><span>                 {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    t=
t-&gt;dns[tt-&gt;dns_len++] =3D s-&gt;addr[i].in.a4.s_addr;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                    tt-&gt;dns[tt-&=
gt;dns_len++] =3D ntohl(s-&gt;addr[i].in.a4.s_addr);</span><br><span>      =
           }</span><br><span>                 else if (tt-&gt;dns6_len + 1 =
&lt; N_DHCP_ADDR)</span><br><span>                 {</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1125?usp=3Demail">change 1125</a>. To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings<=
/a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div ite=
mscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1125?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I37ca672f05e9d77ec586fa28dad=
c6dc752e574fb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1125 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
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


--bXvic0POZ94=--

