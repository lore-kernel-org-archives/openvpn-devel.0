From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 30 Mar 2026 21:27:24 +0000
References: <gerrit.1774906039000.I1a6dfc175075636bc7a5761215547077a9dc397a@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <3e95a633dbc2e2384e97cca872eca423b9293b4a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zhSgOsZGUhk="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--zhSgOsZGUhk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1594?usp=3Demail

to review the following change.


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
---
M src/openvpn/ssl_ncp.c
M src/openvpn/ssl_ncp.h
2 files changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/94/1594/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1a6dfc175075636bc7a5761215547077a9dc397a
Gerrit-Change-Number: 1594
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--zhSgOsZGUhk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1594?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">ssl_ncp: Fix type of &quot;found&quot; para=
meter of check_pull_client_ncp<br><br>In commit 91fd9614f980b02772e4dfbb091=
44c822ec97df0 type<br>of &quot;found&quot; was changed to uint64_t. But due=
 to -Wconversion<br>not yet enabled in all of init.c one occurence of the o=
ld<br>type was missed.<br><br>Change-Id: I1a6dfc175075636bc7a5761215547077a=
9dc397a<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---=
<br>M src/openvpn/ssl_ncp.c<br>M src/openvpn/ssl_ncp.h<br>2 files changed, =
2 insertions(+), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit.openvpn.net:29418/openvpn refs/changes/94/1594/1</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c</span><br><span>index fdac69=
25..649665a 100644</span><br><span>--- a/src/openvpn/ssl_ncp.c</span><br><s=
pan>+++ b/src/openvpn/ssl_ncp.c</span><br><span>@@ -307,7 +307,7 @@</span><=
br><span> }</span><br><span> </span><br><span> bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-check_pull_client_ncp(struct context *c, co=
nst unsigned int found)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+check_pull_client_ncp(struct context *c, const uint64_t found)</span><b=
r><span> {</span><br><span>     if (found &amp; OPT_P_NCP)</span><br><span>=
     {</span><br><span>diff --git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl=
_ncp.h</span><br><span>index 837f662..dc3a750 100644</span><br><span>--- a/=
src/openvpn/ssl_ncp.h</span><br><span>+++ b/src/openvpn/ssl_ncp.h</span><br=
><span>@@ -49,7 +49,7 @@</span><br><span>  *</span><br><span>  * @return  W=
ether the client NCP process suceeded or failed</span><br><span>  */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-bool check_pull_client_ncp(s=
truct context *c, unsigned int found);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+bool check_pull_client_ncp(struct context *c, uint64_t f=
ound);</span><br><span> </span><br><span> /**</span><br><span>  * Iterates =
through the ciphers in server_list and return the first</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1594?usp=3Demail">change 1594</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3De=
mail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1594?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1a6dfc175075636bc7a57612155=
47077a9dc397a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1594 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--zhSgOsZGUhk=--

