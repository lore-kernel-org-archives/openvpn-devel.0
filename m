From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 31 Mar 2026 08:00:16 +0000
In-Reply-To: <gerrit.1774906039000.I1a6dfc175075636bc7a5761215547077a9dc397a@...2715...>
References: <gerrit.1774906039000.I1a6dfc175075636bc7a5761215547077a9dc397a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <87462bce0994662d079888b9f12969894c59586b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="r7wFE3tfbeY="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--r7wFE3tfbeY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
94?usp=3Demail )

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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1a6dfc175075636bc7a5761215547077a9dc397a
Gerrit-Change-Number: 1594
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--r7wFE3tfbeY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1594?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">ssl_ncp: Fix type of &quot;found&quot; parameter=
 of check_pull_client_ncp<br><br>In commit 91fd9614f980b02772e4dfbb09144c82=
2ec97df0 type<br>of &quot;found&quot; was changed to uint64_t. But due to -=
Wconversion<br>not yet enabled in all of init.c one occurence of the old<br=
>type was missed.<br><br>Change-Id: I1a6dfc175075636bc7a5761215547077a9dc39=
7a<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by=
: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Gerrit URL: https://gerri=
t.openvpn.net/c/openvpn/+/1594<br>Message-Id: &lt;20260331060112.5195-1-ger=
t@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1096...=
ourceforge.net/msg36364.html<br>Signed-off-by: Gert Doering &lt;gert@...1826...=
6...&gt;<br>---<br>M src/openvpn/ssl_ncp.c<br>M src/openvpn/ssl_ncp.h<br>2 =
files changed, 2 insertions(+), 2 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c</span><br><sp=
an>index fdac6925..649665a 100644</span><br><span>--- a/src/openvpn/ssl_ncp=
.c</span><br><span>+++ b/src/openvpn/ssl_ncp.c</span><br><span>@@ -307,7 +3=
07,7 @@</span><br><span> }</span><br><span> </span><br><span> bool</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-check_pull_client_ncp(struct c=
ontext *c, const unsigned int found)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+check_pull_client_ncp(struct context *c, const uint64_t fo=
und)</span><br><span> {</span><br><span>     if (found &amp; OPT_P_NCP)</sp=
an><br><span>     {</span><br><span>diff --git a/src/openvpn/ssl_ncp.h b/sr=
c/openvpn/ssl_ncp.h</span><br><span>index 837f662..dc3a750 100644</span><br=
><span>--- a/src/openvpn/ssl_ncp.h</span><br><span>+++ b/src/openvpn/ssl_nc=
p.h</span><br><span>@@ -49,7 +49,7 @@</span><br><span>  *</span><br><span> =
 * @return  Wether the client NCP process suceeded or failed</span><br><spa=
n>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool check_pull=
_client_ncp(struct context *c, unsigned int found);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool check_pull_client_ncp(struct context=
 *c, uint64_t found);</span><br><span> </span><br><span> /**</span><br><spa=
n>  * Iterates through the ciphers in server_list and return the first</spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1594?usp=3Demail">change 1594</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sch=
ema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1594?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vie=
w Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--r7wFE3tfbeY=--

