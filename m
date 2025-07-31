From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 31 Jul 2025 10:55:41 +0000
In-Reply-To: <gerrit.1753953375000.Id95cd14095a03afb3140a03ae96e9f5679e4fe89@...2715...>
References: <gerrit.1753953375000.Id95cd14095a03afb3140a03ae96e9f5679e4fe89@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <cb36a94298e18ae1ca0315a8b47dbad16e65b527-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JcmkiFCyDwI="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix --dns options
 for TAP adapter
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

--JcmkiFCyDwI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
20?usp=3Demail )

Change subject: Fix --dns options for TAP adapter
......................................................................

Fix --dns options for TAP adapter

Commit

    2dfc4f ("dns: deal with --dhcp-options when --dns is active")

has accidentally removed setting of the DHCP_OPTIONS_DHCP_OPTIONAL
flag when copying --dns options. This flag is required to apply options
via DHCP string, which we do for TAP adapter. As a result, --dns options
stopped working for TAP.

Fix by setting this flag when copying --dns options to tuntap_options.

Change-Id: Id95cd14095a03afb3140a03ae96e9f5679e4fe89
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250731104833.23305-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
436.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/options.c
1 file changed, 1 insertion(+), 0 deletions(-)




diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 53be6f5..3753810 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3579,6 +3579,7 @@
             {
                 msg(M_WARN, "WARNING: couldn't copy all --dns server addre=
sses to TUN/TAP");
             }
+            tt->dhcp_options |=3D DHCP_OPTIONS_DHCP_OPTIONAL;
             return;
         }
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1120?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id95cd14095a03afb3140a03ae96e9f5679e4fe89
Gerrit-Change-Number: 1120
Gerrit-PatchSet: 3
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--JcmkiFCyDwI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1120?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Fix --dns options for TAP adapter<br><br>Comm=
it<br><br>    2dfc4f (&quot;dns: deal with --dhcp-options when --dns is act=
ive&quot;)<br><br>has accidentally removed setting of the DHCP_OPTIONS_DHCP=
_OPTIONAL<br>flag when copying --dns options. This flag is required to appl=
y options<br>via DHCP string, which we do for TAP adapter. As a result, --d=
ns options<br>stopped working for TAP.<br><br>Fix by setting this flag when=
 copying --dns options to tuntap_options.<br><br>Change-Id: Id95cd14095a03a=
fb3140a03ae96e9f5679e4fe89<br>Signed-off-by: Lev Stipakov &lt;lev@...515...=
&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;2=
0250731104833.23305-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.=
com/openvpn-devel@lists.sourceforge.net/msg32436.html<br>Signed-off-by: Ger=
t Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/options.c<br>1 fi=
le changed, 1 insertion(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><sp=
an>index 53be6f5..3753810 100644</span><br><span>--- a/src/openvpn/options.=
c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -3579,6 +3=
579,7 @@</span><br><span>             {</span><br><span>                 ms=
g(M_WARN, &quot;WARNING: couldn&#39;t copy all --dns server addresses to TU=
N/TAP&quot;);</span><br><span>             }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            tt-&gt;dhcp_options |=3D DHCP_OPTIONS_=
DHCP_OPTIONAL;</span><br><span>             return;</span><br><span>       =
  }</span><br><span>     }</span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1120?usp=3Demail">chang=
e 1120</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1120?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id95cd14095a03afb3140a03ae96=
e9f5679e4fe89 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1120 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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


--JcmkiFCyDwI=--

