From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 29 Oct 2025 07:09:08 +0000
In-Reply-To: <gerrit.1761676579000.I9118333bb65cd5db0836abefa5d45a729f0142cc@...2715...>
References: <gerrit.1761676579000.I9118333bb65cd5db0836abefa5d45a729f0142cc@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <705cbf9e31fb85312054676b304d763413599f6a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bqvIr8P7cC0="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: remove redundant
 PULL_DEFINED() macro definition
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

--bqvIr8P7cC0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1322?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: remove redundant PULL_DEFINED() macro definition
......................................................................

remove redundant PULL_DEFINED() macro definition

this seems to be a leftover of the time when we had conditional
compilation for "--disable-server" or thus.  Commit d6a0cf599
removed PUSH_DEFINED() nearby but overlooked this one.

Change-Id: I9118333bb65cd5db0836abefa5d45a729f0142cc
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1322
Message-Id: <20251028203219.11737-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
984.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/options.h
1 file changed, 0 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/22/1322/2

diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 24253af..125e524 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -769,10 +769,6 @@

 #define PULL_DEFINED(opt) ((opt)->pull)

-#ifndef PULL_DEFINED
-#define PULL_DEFINED(opt) (false)
-#endif
-
 #ifdef _WIN32
 #define ROUTE_OPTION_FLAGS(o) ((o)->route_method & ROUTE_METHOD_MASK)
 #else

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1322?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9118333bb65cd5db0836abefa5d45a729f0142cc
Gerrit-Change-Number: 1322
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--bqvIr8P7cC0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to this change.</p><p><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1322?usp=3Demail">View Change</a></p><p>The followi=
ng approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">remove redundant PULL_DEFINE=
D() macro definition<br><br>this seems to be a leftover of the time when we=
 had conditional<br>compilation for &quot;--disable-server&quot; or thus.  =
Commit d6a0cf599<br>removed PUSH_DEFINED() nearby but overlooked this one.<=
br><br>Change-Id: I9118333bb65cd5db0836abefa5d45a729f0142cc<br>Signed-off-b=
y: Gert Doering &lt;gert@...1296...&gt;<br>Acked-by: Frank Lichtenheld &lt;=
frank@...2641...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/=
1322<br>Message-Id: &lt;20251028203219.11737-1-gert@...1296...&gt;<br>URL: =
https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33984.h=
tml<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/=
openvpn/options.h<br>1 file changed, 0 insertions(+), 4 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/c=
hanges/22/1322/2</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpn/options.h b/src/openvpn/o=
ptions.h</span><br><span>index 24253af..125e524 100644</span><br><span>--- =
a/src/openvpn/options.h</span><br><span>+++ b/src/openvpn/options.h</span><=
br><span>@@ -769,10 +769,6 @@</span><br><span> </span><br><span> #define PU=
LL_DEFINED(opt) ((opt)-&gt;pull)</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#ifndef PULL_DEFINED</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define PULL_DEFINED(opt) (false)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span> #ifdef _WIN32</span><br><span> #=
define ROUTE_OPTION_FLAGS(o) ((o)-&gt;route_method &amp; ROUTE_METHOD_MASK)=
</span><br><span> #else</span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1322?usp=3Demail">change 1=
322</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div item=
scope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1322?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9118333bb65cd5db0836abefa5d=
45a729f0142cc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1322 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--bqvIr8P7cC0=--

