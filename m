From: "stipa (Code Review)" <gerrit@...515...>
Date: Tue, 24 Dec 2024 16:06:27 +0000
References: <gerrit.1735056384000.I87e4593e6a548bacd40b840cd241950019fa457d@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ed2fe9e4bb773ae60f69b9f30963a3083104de02-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/pLJ22qOGvk="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: repair DNS address
 option
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

--/pLJ22qOGvk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/845?usp=3Demail

to review the following change.


Change subject: repair DNS address option
......................................................................

repair DNS address option

Commit

  6f2d222 ("dns: store IPv4 addresses in network byte order")

changed the internal representation of IPv4 address within DNS
settings to network byte order, however later this value is copied into
tuntap_options, where IPv4 addresses are assumed to be in host byte
order (see lots of occurences of "htonl(tt->" in tun.c). As a
consequence, DNS server address is set incorrectly, like 4.4.8.8 instead
of 8.8.4.4

Fix by converting address to host byte order when copying from DNS
options to tuntap_options.

Change-Id: I87e4593e6a548bacd40b840cd241950019fa457d
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/options.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/45/845/1

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index b2a3a8b..20e8d55 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1390,7 +1390,7 @@
                         overflow =3D true;
                         continue;
                     }
-                    tt->dns[tt->dns_len++] =3D server->addr[i].in.a4.s_add=
r;
+                    tt->dns[tt->dns_len++] =3D ntohl(server->addr[i].in.a4=
.s_addr);
                 }
                 else
                 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/845?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I87e4593e6a548bacd40b840cd241950019fa457d
Gerrit-Change-Number: 845
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--/pLJ22qOGvk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/845?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">repair DNS address option<br><br>Commit<br><br>  6f2d222 (&qu=
ot;dns: store IPv4 addresses in network byte order&quot;)<br><br>changed th=
e internal representation of IPv4 address within DNS<br>settings to network=
 byte order, however later this value is copied into<br>tuntap_options, whe=
re IPv4 addresses are assumed to be in host byte<br>order (see lots of occu=
rences of &quot;htonl(tt-&gt;&quot; in tun.c). As a<br>consequence, DNS ser=
ver address is set incorrectly, like 4.4.8.8 instead<br>of 8.8.4.4<br><br>F=
ix by converting address to host byte order when copying from DNS<br>option=
s to tuntap_options.<br><br>Change-Id: I87e4593e6a548bacd40b840cd241950019f=
a457d<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>---<br>M src/=
openvpn/options.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br><=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/45/845/1</pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><=
span>index b2a3a8b..20e8d55 100644</span><br><span>--- a/src/openvpn/option=
s.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -1390,7 =
+1390,7 @@</span><br><span>                         overflow =3D true;</spa=
n><br><span>                         continue;</span><br><span>            =
         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         tt-&gt;dns[tt-&gt;dns_len++] =3D server-&gt;addr[i].in.a4.s_addr;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
tt-&gt;dns[tt-&gt;dns_len++] =3D ntohl(server-&gt;addr[i].in.a4.s_addr);</s=
pan><br><span>                 }</span><br><span>                 else</spa=
n><br><span>                 {</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/845?usp=3Demail">ch=
ange 845</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/845?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I87e4593e6a548bacd40b840cd24=
1950019fa457d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 845 </div>
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


--/pLJ22qOGvk=--

