From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 31 Mar 2026 08:00:14 +0000
In-Reply-To: <gerrit.1774906039000.I1a6dfc175075636bc7a5761215547077a9dc397a@...2715...>
References: <gerrit.1774906039000.I1a6dfc175075636bc7a5761215547077a9dc397a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <87462bce0994662d079888b9f12969894c59586b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mVJpuiG1mcI="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_ncp: Fix type
 of "found" parameter of check_pull_client_ncp
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mVJpuiG1mcI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1594?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: ssl_ncp: Fix type of "found" parameter of check_pull_client=
_ncp
......................................................................

ssl_ncp: Fix type of "found" parameter of check_pull_client_ncp

In commit 91fd9614f980b02772e4dfbb09144c822ec97df0 type
of "found" was changed to uint64_t. But due to -Wconversion
not yet enabled in all of init.c one occurence of the old
type was missed.

Change-Id: I1a6dfc175075636bc7a5761215547077a9dc397a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1594
Message-Id: <20260331060112.5195-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
364.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_ncp.c
M src/openvpn/ssl_ncp.h
2 files changed, 2 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/94/1594/2

diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index fdac6925..649665a 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -307,7 +307,7 @@
 }

 bool
-check_pull_client_ncp(struct context *c, const unsigned int found)
+check_pull_client_ncp(struct context *c, const uint64_t found)
 {
     if (found & OPT_P_NCP)
     {
diff --git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h
index 837f662..dc3a750 100644
--- a/src/openvpn/ssl_ncp.h
+++ b/src/openvpn/ssl_ncp.h
@@ -49,7 +49,7 @@
  *
  * @return  Wether the client NCP process suceeded or failed
  */
-bool check_pull_client_ncp(struct context *c, unsigned int found);
+bool check_pull_client_ncp(struct context *c, uint64_t found);

 /**
  * Iterates through the ciphers in server_list and return the first

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1594?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1a6dfc175075636bc7a5761215547077a9dc397a
Gerrit-Change-Number: 1594
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mVJpuiG1mcI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1594?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">ssl_ncp: Fix type of &quot;foun=
d&quot; parameter of check_pull_client_ncp<br><br>In commit 91fd9614f980b02=
772e4dfbb09144c822ec97df0 type<br>of &quot;found&quot; was changed to uint6=
4_t. But due to -Wconversion<br>not yet enabled in all of init.c one occure=
nce of the old<br>type was missed.<br><br>Change-Id: I1a6dfc175075636bc7a57=
61215547077a9dc397a<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2723...=
.&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Gerrit U=
RL: https://gerrit.openvpn.net/c/openvpn/+/1594<br>Message-Id: &lt;20260331=
060112.5195-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/open=
vpn-devel@lists.sourceforge.net/msg36364.html<br>Signed-off-by: Gert Doerin=
g &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/ssl_ncp.c<br>M src/openvp=
n/ssl_ncp.h<br>2 files changed, 2 insertions(+), 2 deletions(-)<br><br></pr=
e><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/change=
s/94/1594/2</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_nc=
p.c</span><br><span>index fdac6925..649665a 100644</span><br><span>--- a/sr=
c/openvpn/ssl_ncp.c</span><br><span>+++ b/src/openvpn/ssl_ncp.c</span><br><=
span>@@ -307,7 +307,7 @@</span><br><span> }</span><br><span> </span><br><sp=
an> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_pull_cl=
ient_ncp(struct context *c, const unsigned int found)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+check_pull_client_ncp(struct context *c, =
const uint64_t found)</span><br><span> {</span><br><span>     if (found &am=
p; OPT_P_NCP)</span><br><span>     {</span><br><span>diff --git a/src/openv=
pn/ssl_ncp.h b/src/openvpn/ssl_ncp.h</span><br><span>index 837f662..dc3a750=
 100644</span><br><span>--- a/src/openvpn/ssl_ncp.h</span><br><span>+++ b/s=
rc/openvpn/ssl_ncp.h</span><br><span>@@ -49,7 +49,7 @@</span><br><span>  *<=
/span><br><span>  * @return  Wether the client NCP process suceeded or fail=
ed</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-bool check_pull_client_ncp(struct context *c, unsigned int found);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+bool check_pull_client_ncp=
(struct context *c, uint64_t found);</span><br><span> </span><br><span> /**=
</span><br><span>  * Iterates through the ciphers in server_list and return=
 the first</span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1594?usp=3Demail">change 1594</a>. To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtyp=
e=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" ite=
mtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1594?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1a6dfc175075636bc7a57612155=
47077a9dc397a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1594 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--mVJpuiG1mcI=--

