From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 14 Apr 2026 16:31:17 +0000
In-Reply-To: <gerrit.1774983232000.I9468811fd434e17645957fc12770aa2b9ed98fb8@...2715...>
References: <gerrit.1774983232000.I9468811fd434e17645957fc12770aa2b9ed98fb8@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <5b528ed955946661a44b5bedc9f1748130fde21f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EW4imPORq0U="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Log when writing
 username/password to TLS buffer fails
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selvanair <selva.nair@...277...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--EW4imPORq0U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 selvanair. ( http://gerrit.openvpn.net/c/openvpn/+/1600?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: Log when writing username/password to TLS buffer fails
......................................................................

Log when writing username/password to TLS buffer fails

Currently we get an unhelpful "Key Method #2 failed" error.
Add a more specific warning message.

Change-Id: I9468811fd434e17645957fc12770aa2b9ed98fb8
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1600
Message-Id: <20260414055721.16857-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
604.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl.c
1 file changed, 2 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/00/1600/2

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 576157d..5868d53 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2125,10 +2125,12 @@

         if (!write_string(buf, up->username, -1))
         {
+            msg(M_WARN, "WARNING: Failed to write auth username to TLS buf=
fer");
             goto error;
         }
         else if (!write_string(buf, up->password, -1))
         {
+            msg(M_WARN, "WARNING: Failed to write auth password to TLS buf=
fer");
             goto error;
         }
         /* save username for auth-token which may get pushed later */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1600?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9468811fd434e17645957fc12770aa2b9ed98fb8
Gerrit-Change-Number: 1600
Gerrit-PatchSet: 2
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--EW4imPORq0U=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by selvanair.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1600?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">Log when writing username/passw=
ord to TLS buffer fails<br><br>Currently we get an unhelpful &quot;Key Meth=
od #2 failed&quot; error.<br>Add a more specific warning message.<br><br>Ch=
ange-Id: I9468811fd434e17645957fc12770aa2b9ed98fb8<br>Signed-off-by: Selva =
Nair &lt;selva.nair@...277...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvp=
n@...1227...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1600=
<br>Message-Id: &lt;20260414055721.16857-1-gert@...1296...&gt;<br>URL: http=
s://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36604.html<=
br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/open=
vpn/ssl.c<br>1 file changed, 2 insertions(+), 0 deletions(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/0=
0/1600/2</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><=
br><span>index 576157d..5868d53 100644</span><br><span>--- a/src/openvpn/ss=
l.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -2125,10 +21=
25,12 @@</span><br><span> </span><br><span>         if (!write_string(buf, =
up-&gt;username, -1))</span><br><span>         {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;WARNING: Failed =
to write auth username to TLS buffer&quot;);</span><br><span>             g=
oto error;</span><br><span>         }</span><br><span>         else if (!wr=
ite_string(buf, up-&gt;password, -1))</span><br><span>         {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;=
WARNING: Failed to write auth password to TLS buffer&quot;);</span><br><spa=
n>             goto error;</span><br><span>         }</span><br><span>     =
    /* save username for auth-token which may get pushed later */</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1600?usp=3Demail">change 1600</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1600?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9468811fd434e17645957fc1277=
0aa2b9ed98fb8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1600 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--EW4imPORq0U=--

