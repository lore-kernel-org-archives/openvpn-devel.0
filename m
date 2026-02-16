From: "selvanair (Code Review)" <gerrit@...515...>
Date: Mon, 16 Feb 2026 01:27:36 +0000
References: <gerrit.1771205254000.I76dc80a9d9b29e401b7bbd59e0c46baf751d2e4a@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <8d1990af4fe84f76565f513414780a06552aeabd-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eiT7SpGnYAs="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fixup version
 command on management interface
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

--eiT7SpGnYAs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1528?usp=3Demail

to review the following change.


Change subject: Fixup version command on management interface
......................................................................

Fixup version command on management interface

All commands to the management interface are supposed to be
responded with either a one-line "SUCCESS:/ERROR:" message
or a multi-line reply terminated by "END". But, curently we
silently accept the "version n" command wih no response. This
causes clients like OpenVPN-GUI lock-up if version command is
used, waiting for ever for a reply.

Fix this by adding a SUCCESS/ERROR response.

Change-Id: I76dc80a9d9b29e401b7bbd59e0c46baf751d2e4a
Signed-off-by: Selva Nair <selva.nair@...277...>
---
M src/openvpn/manage.c
1 file changed, 5 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/28/1528/1

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 37ae6b3..bad159f 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1333,6 +1333,11 @@
     if (version)
     {
         man->connection.client_version =3D atoi(version);
+        msg(M_CLIENT, "SUCCESS: Management client version set to %d", atoi=
(version));
+    }
+    else
+    {
+        msg(M_CLIENT, "ERROR: Invalid value sepcified for management clien=
t version");
     }
 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1528?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I76dc80a9d9b29e401b7bbd59e0c46baf751d2e4a
Gerrit-Change-Number: 1528
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--eiT7SpGnYAs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>selvanair would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1528?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Fixup version command on management interfa=
ce<br><br>All commands to the management interface are supposed to be<br>re=
sponded with either a one-line &quot;SUCCESS:/ERROR:&quot; message<br>or a =
multi-line reply terminated by &quot;END&quot;. But, curently we<br>silentl=
y accept the &quot;version n&quot; command wih no response. This<br>causes =
clients like OpenVPN-GUI lock-up if version command is<br>used, waiting for=
 ever for a reply.<br><br>Fix this by adding a SUCCESS/ERROR response.<br><=
br>Change-Id: I76dc80a9d9b29e401b7bbd59e0c46baf751d2e4a<br>Signed-off-by: S=
elva Nair &lt;selva.nair@...277...&gt;<br>---<br>M src/openvpn/manage.c<br>=
1 file changed, 5 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/28/1528/1</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c</span><br><spa=
n>index 37ae6b3..bad159f 100644</span><br><span>--- a/src/openvpn/manage.c<=
/span><br><span>+++ b/src/openvpn/manage.c</span><br><span>@@ -1333,6 +1333=
,11 @@</span><br><span>     if (version)</span><br><span>     {</span><br><=
span>         man-&gt;connection.client_version =3D atoi(version);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;=
SUCCESS: Management client version set to %d&quot;, atoi(version));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        msg(M_CLIENT, &quot;ERROR: Invalid value sepcified for man=
agement client version&quot;);</span><br><span>     }</span><br><span> }</s=
pan><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1528?usp=3Demail">change 1528</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1528?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I76dc80a9d9b29e401b7bbd59e0c=
46baf751d2e4a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1528 </div>
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

--eiT7SpGnYAs=--

