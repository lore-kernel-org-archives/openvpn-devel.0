From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 24 Dec 2024 22:25:01 +0000
In-Reply-To: <gerrit.1735056384000.I87e4593e6a548bacd40b840cd241950019fa457d@...2715...>
References: <gerrit.1735056384000.I87e4593e6a548bacd40b840cd241950019fa457d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <44e94604600beffc36bf8e18e7329df74b354e6c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jHRdSxGQUBw="; charset=UTF-8
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
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--jHRdSxGQUBw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/84=
5?usp=3Demail )

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
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20241224174233.13005-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
195.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/options.c
1 file changed, 1 insertion(+), 1 deletion(-)




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
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--jHRdSxGQUBw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/845?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">repair DNS address option<br><br>Commit<br><br=
>  6f2d222 (&quot;dns: store IPv4 addresses in network byte order&quot;)<br=
><br>changed the internal representation of IPv4 address within DNS<br>sett=
ings to network byte order, however later this value is copied into<br>tunt=
ap_options, where IPv4 addresses are assumed to be in host byte<br>order (s=
ee lots of occurences of &quot;htonl(tt-&gt;&quot; in tun.c). As a<br>conse=
quence, DNS server address is set incorrectly, like 4.4.8.8 instead<br>of 8=
.8.4.4<br><br>Fix by converting address to host byte order when copying fro=
m DNS<br>options to tuntap_options.<br><br>Change-Id: I87e4593e6a548bacd40b=
840cd241950019fa457d<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<b=
r>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;2024122=
4174233.13005-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/op=
envpn-devel@lists.sourceforge.net/msg30195.html<br>Signed-off-by: Gert Doer=
ing &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/options.c<br>1 file cha=
nged, 1 insertion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><sp=
an>index b2a3a8b..20e8d55 100644</span><br><span>--- a/src/openvpn/options.=
c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -1390,7 +1=
390,7 @@</span><br><span>                         overflow =3D true;</span>=
<br><span>                         continue;</span><br><span>              =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
       tt-&gt;dns[tt-&gt;dns_len++] =3D server-&gt;addr[i].in.a4.s_addr;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    tt=
-&gt;dns[tt-&gt;dns_len++] =3D ntohl(server-&gt;addr[i].in.a4.s_addr);</spa=
n><br><span>                 }</span><br><span>                 else</span>=
<br><span>                 {</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/845?usp=3Demail">chan=
ge 845</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/845?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I87e4593e6a548bacd40b840cd24=
1950019fa457d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 845 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--jHRdSxGQUBw=--

