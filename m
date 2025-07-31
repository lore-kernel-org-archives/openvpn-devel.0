From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 31 Jul 2025 09:16:17 +0000
References: <gerrit.1753953375000.Id95cd14095a03afb3140a03ae96e9f5679e4fe89@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6942f09a1207c0a0a1ae6c30bca4439ac2d8c456-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lOP/FvRmKT4="; charset=UTF-8
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

--lOP/FvRmKT4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1120?usp=3Demail

to review the following change.


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
1 file changed, 3 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/20/1120/1

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 53be6f5..fde3e73 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3579,6 +3579,9 @@
             {
                 msg(M_WARN, "WARNING: couldn't copy all --dns server addre=
sses to TUN/TAP");
             }
+#if defined(_WIN32)
+            tt->dhcp_options |=3D DHCP_OPTIONS_DHCP_OPTIONAL;
+#endif
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
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--lOP/FvRmKT4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1120?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Fix --dns options for TAP adapter<br><br>Commit<br><br>    2=
dfc4f (&quot;dns: deal with --dhcp-options when --dns is active&quot;)<br><=
br>has accidentally removed setting of the DHCP_OPTIONS_DHCP_OPTIONAL<br>fl=
ag when copying --dns options. This flag is required to apply options<br>vi=
a DHCP string, which we do for TAP adapter. As a result, --dns options<br>s=
topped working for TAP.<br><br>Fix by setting this flag when copying --dns =
options to tuntap_options.<br><br>Change-Id: Id95cd14095a03afb3140a03ae96e9=
f5679e4fe89<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>---<br>=
M src/openvpn/options.c<br>1 file changed, 3 insertions(+), 0 deletions(-)<=
br><br></pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/20/1=
120/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</s=
pan><br><span>index 53be6f5..fde3e73 100644</span><br><span>--- a/src/openv=
pn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@=
 -3579,6 +3579,9 @@</span><br><span>             {</span><br><span>        =
         msg(M_WARN, &quot;WARNING: couldn&#39;t copy all --dns server addr=
esses to TUN/TAP&quot;);</span><br><span>             }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            tt-&gt;dhcp_options |=3D DH=
CP_OPTIONS_DHCP_OPTIONAL;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#endif</span><br><span>             return;</span><br><span>         =
}</span><br><span>     }</span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1120?usp=3Demail">change =
1120</a>. To unsubscribe, or for help writing mail filters, visit <a href=
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


--lOP/FvRmKT4=--

