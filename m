From: "ordex (Code Review)" <gerrit@...515...>
Date: Tue, 22 Jul 2025 20:22:20 +0000
References: <gerrit.1753215725000.I18df6ef659cab9525dd7847b7dd3950fc1895dd5@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <49d8fe13260b98759c6cf22471b881369fb3f20f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tkIQ0wfSalE="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco_linux: fix case
 statement by using proper error value
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

--tkIQ0wfSalE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1095?usp=3Demail

to review the following change.


Change subject: dco_linux: fix case statement by using proper error value
......................................................................

dco_linux: fix case statement by using proper error value

A M_ERR constant accidentally slipped in as possible
netlink error value.

Substitute it with the actual code matching the following
error message.

Change-Id: I18df6ef659cab9525dd7847b7dd3950fc1895dd5
Signed-off-by: Antonio Quartulli <antonio@...2726...>
---
M src/openvpn/dco_linux.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/95/1095/1

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index c92c196..58051f5 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -143,7 +143,7 @@
             msg(M_ERR, "%s: netlink out of memory error", prefix);
             break;

-        case -M_ERR:
+        case -NLE_AGAIN:
             msg(M_WARN, "%s: netlink reports blocking read - aborting wait=
", prefix);
             break;


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1095?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I18df6ef659cab9525dd7847b7dd3950fc1895dd5
Gerrit-Change-Number: 1095
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--tkIQ0wfSalE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ordex would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1095?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">dco_linux: fix case statement by using proper error value<br=
><br>A M_ERR constant accidentally slipped in as possible<br>netlink error =
value.<br><br>Substitute it with the actual code matching the following<br>=
error message.<br><br>Change-Id: I18df6ef659cab9525dd7847b7dd3950fc1895dd5<=
br>Signed-off-by: Antonio Quartulli &lt;antonio@...2726...&gt;<br>---<br>M =
src/openvpn/dco_linux.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<br=
><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/95/109=
5/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c<=
/span><br><span>index c92c196..58051f5 100644</span><br><span>--- a/src/ope=
nvpn/dco_linux.c</span><br><span>+++ b/src/openvpn/dco_linux.c</span><br><s=
pan>@@ -143,7 +143,7 @@</span><br><span>             msg(M_ERR, &quot;%s: n=
etlink out of memory error&quot;, prefix);</span><br><span>             bre=
ak;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        case -M_ERR:</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        case -NLE_AGAIN:</span><br><span>             msg(M_WARN, &quot;%s=
: netlink reports blocking read - aborting wait&quot;, prefix);</span><br><=
span>             break;</span><br><span> </span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1095?us=
p=3Demail">change 1095</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><d=
iv itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1095?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I18df6ef659cab9525dd7847b7dd=
3950fc1895dd5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1095 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
 </div>
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


--tkIQ0wfSalE=--

