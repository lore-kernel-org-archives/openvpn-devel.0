From: "selvanair (Code Review)" <gerrit@...515...>
Date: Tue, 31 Mar 2026 18:53:55 +0000
References: <gerrit.1774983232000.I9468811fd434e17645957fc12770aa2b9ed98fb8@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <b4ed50f624f54a5671ebfb35e9afa10bf6d2ba1c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7z7pA0tSLs4="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--7z7pA0tSLs4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1600?usp=3Demail

to review the following change.


Change subject: Log when writing username/password to TLS buffer fails
......................................................................

Log when writing username/password to TLS buffer fails

Currently we get an unhelpful "Key Method #2 failed" error.
Add a more specific warning message.

Change-Id: I9468811fd434e17645957fc12770aa2b9ed98fb8
Signed-off-by: Selva Nair <selva.nair@...277...>
---
M src/openvpn/ssl.c
1 file changed, 2 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/00/1600/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9468811fd434e17645957fc12770aa2b9ed98fb8
Gerrit-Change-Number: 1600
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--7z7pA0tSLs4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>selvanair would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1600?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Log when writing username/password to TLS b=
uffer fails<br><br>Currently we get an unhelpful &quot;Key Method #2 failed=
&quot; error.<br>Add a more specific warning message.<br><br>Change-Id: I94=
68811fd434e17645957fc12770aa2b9ed98fb8<br>Signed-off-by: Selva Nair &lt;sel=
va.nair@...277...&gt;<br>---<br>M src/openvpn/ssl.c<br>1 file changed, 2 in=
sertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t.openvpn.net:29418/openvpn refs/changes/00/1600/1</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index 576157d..5868d53 1=
00644</span><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/ope=
nvpn/ssl.c</span><br><span>@@ -2125,10 +2125,12 @@</span><br><span> </span>=
<br><span>         if (!write_string(buf, up-&gt;username, -1))</span><br><=
span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        msg(M_WARN, &quot;WARNING: Failed to write auth username to TLS buf=
fer&quot;);</span><br><span>             goto error;</span><br><span>      =
   }</span><br><span>         else if (!write_string(buf, up-&gt;password, =
-1))</span><br><span>         {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            msg(M_WARN, &quot;WARNING: Failed to write auth pas=
sword to TLS buffer&quot;);</span><br><span>             goto error;</span>=
<br><span>         }</span><br><span>         /* save username for auth-tok=
en which may get pushed later */</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1600?usp=3Demail"=
>change 1600</a>. To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1600?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9468811fd434e17645957fc1277=
0aa2b9ed98fb8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1600 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--7z7pA0tSLs4=--

