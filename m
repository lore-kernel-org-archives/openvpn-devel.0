From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 31 Jul 2025 09:48:16 +0000
In-Reply-To: <gerrit.1753953375000.Id95cd14095a03afb3140a03ae96e9f5679e4fe89@...2715...>
References: <gerrit.1753953375000.Id95cd14095a03afb3140a03ae96e9f5679e4fe89@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <b4b111975afd7e026d7d0ca1afe6ce3b191a9dc0-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tlD36K4zFGI="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--tlD36K4zFGI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos, stipa.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1120?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by cron2


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
---
M src/openvpn/options.c
1 file changed, 1 insertion(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/20/1120/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--tlD36K4zFGI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos, s=
tipa. </p>
<p>stipa <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1120?usp=3Demail">View Change</=
a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Fix --dns options for TAP adapter<br><br>Commit<br><=
br>    2dfc4f (&quot;dns: deal with --dhcp-options when --dns is active&quo=
t;)<br><br>has accidentally removed setting of the DHCP_OPTIONS_DHCP_OPTION=
AL<br>flag when copying --dns options. This flag is required to apply optio=
ns<br>via DHCP string, which we do for TAP adapter. As a result, --dns opti=
ons<br>stopped working for TAP.<br><br>Fix by setting this flag when copyin=
g --dns options to tuntap_options.<br><br>Change-Id: Id95cd14095a03afb3140a=
03ae96e9f5679e4fe89<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br=
>---<br>M src/openvpn/options.c<br>1 file changed, 1 insertion(+), 0 deleti=
ons(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chang=
es/20/1120/2</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/options.c b/src/openvpn/optio=
ns.c</span><br><span>index 53be6f5..3753810 100644</span><br><span>--- a/sr=
c/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><=
span>@@ -3579,6 +3579,7 @@</span><br><span>             {</span><br><span> =
                msg(M_WARN, &quot;WARNING: couldn&#39;t copy all --dns serv=
er addresses to TUN/TAP&quot;);</span><br><span>             }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            tt-&gt;dhcp_options =
|=3D DHCP_OPTIONS_DHCP_OPTIONAL;</span><br><span>             return;</span=
><br><span>         }</span><br><span>     }</span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1120?=
usp=3Demail">change 1120</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1120?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id95cd14095a03afb3140a03ae96=
e9f5679e4fe89 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1120 </div>
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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--tlD36K4zFGI=--

