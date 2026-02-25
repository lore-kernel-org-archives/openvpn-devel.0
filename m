From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 25 Feb 2026 08:42:57 +0000
In-Reply-To: <gerrit.1771205254000.I76dc80a9d9b29e401b7bbd59e0c46baf751d2e4a@...2715...>
References: <gerrit.1771205254000.I76dc80a9d9b29e401b7bbd59e0c46baf751d2e4a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e0240adba7315163a66d8679df82c109e21717fc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mRAbyGGLDYQ="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fixup version
 command on management interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selvanair <selva.nair@...277...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mRAbyGGLDYQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
28?usp=3Demail )

Change subject: Fixup version command on management interface
......................................................................

Fixup version command on management interface

All commands to the management interface are supposed to be
responded with either a one-line "SUCCESS:/ERROR:" message
or a multi-line reply terminated by "END". But, curently we
silently accept the "version n" command wih no response. This
causes clients like OpenVPN-GUI lock-up if version command is
used, waiting for ever for a reply.

Fix this by adding a SUCCESS response if client version
is set to a value >=3D 4. As the highest client version in use
until now is 3, this should not affect any work-arounds in
existing clients. ERROR response is generated if the version
parameter is null which never happens in practice.

Change-Id: I76dc80a9d9b29e401b7bbd59e0c46baf751d2e4a
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1528
Message-Id: <20260224213036.31845-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
782.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/management-notes.txt
M src/openvpn/manage.c
2 files changed, 13 insertions(+), 0 deletions(-)




diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 1a5c311..86b74f3 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -492,6 +492,10 @@
   version 2  -- Change management version of client to 2 (default =3D 1)
   version    -- Show the version of OpenVPN and its Management Interface

+Note: Until version 3, no response was generated when client sets its
+version. This was fixed starting version 4: clients should expect
+"SUCCESS: .. " message only when setting the version to >=3D 4.
+
 COMMAND -- auth-retry
 ---------------------

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 37ae6b3..03ff5b3 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1333,6 +1333,15 @@
     if (version)
     {
         man->connection.client_version =3D atoi(version);
+        /* Prior to version 3, we missed to respond to this command. Ackno=
wledge only if version >=3D 4 */
+        if (man->connection.client_version >=3D 4)
+        {
+            msg(M_CLIENT, "SUCCESS: Management client version set to %d", =
man->connection.client_version);
+        }
+    }
+    else
+    {
+        msg(M_CLIENT, "ERROR: Invalid value specified for management clien=
t version");
     }
 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1528?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I76dc80a9d9b29e401b7bbd59e0c46baf751d2e4a
Gerrit-Change-Number: 1528
Gerrit-PatchSet: 6
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mRAbyGGLDYQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1528?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Fixup version command on management interface<br=
><br>All commands to the management interface are supposed to be<br>respond=
ed with either a one-line &quot;SUCCESS:/ERROR:&quot; message<br>or a multi=
-line reply terminated by &quot;END&quot;. But, curently we<br>silently acc=
ept the &quot;version n&quot; command wih no response. This<br>causes clien=
ts like OpenVPN-GUI lock-up if version command is<br>used, waiting for ever=
 for a reply.<br><br>Fix this by adding a SUCCESS response if client versio=
n<br>is set to a value &gt;=3D 4. As the highest client version in use<br>u=
ntil now is 3, this should not affect any work-arounds in<br>existing clien=
ts. ERROR response is generated if the version<br>parameter is null which n=
ever happens in practice.<br><br>Change-Id: I76dc80a9d9b29e401b7bbd59e0c46b=
af751d2e4a<br>Signed-off-by: Selva Nair &lt;selva.nair@...277...&gt;<br>Ack=
ed-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.o=
penvpn.net/c/openvpn/+/1528<br>Message-Id: &lt;20260224213036.31845-1-gert@=
...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1885...=
rceforge.net/msg35782.html<br>Signed-off-by: Gert Doering &lt;gert@...1725...=
..&gt;<br>---<br>M doc/management-notes.txt<br>M src/openvpn/manage.c<br>2 =
files changed, 13 insertions(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/doc/management-notes.txt b/doc/management-notes.txt</span><=
br><span>index 1a5c311..86b74f3 100644</span><br><span>--- a/doc/management=
-notes.txt</span><br><span>+++ b/doc/management-notes.txt</span><br><span>@=
@ -492,6 +492,10 @@</span><br><span>   version 2  -- Change management vers=
ion of client to 2 (default =3D 1)</span><br><span>   version    -- Show th=
e version of OpenVPN and its Management Interface</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+Note: Until version 3, no r=
esponse was generated when client sets its</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+version. This was fixed starting version 4: clients =
should expect</span><br><span style=3D"color: hsl(120, 100%, 40%);">+&quot;=
SUCCESS: .. &quot; message only when setting the version to &gt;=3D 4.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> COMMAN=
D -- auth-retry</span><br><span> ---------------------</span><br><span> </s=
pan><br><span>diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c</spa=
n><br><span>index 37ae6b3..03ff5b3 100644</span><br><span>--- a/src/openvpn=
/manage.c</span><br><span>+++ b/src/openvpn/manage.c</span><br><span>@@ -13=
33,6 +1333,15 @@</span><br><span>     if (version)</span><br><span>     {</=
span><br><span>         man-&gt;connection.client_version =3D atoi(version)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Prior t=
o version 3, we missed to respond to this command. Acknowledge only if vers=
ion &gt;=3D 4 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (man-&gt;connection.client_version &gt;=3D 4)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;SUCCESS: Management=
 client version set to %d&quot;, man-&gt;connection.client_version);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        msg(M_CLIENT, &quot;ERROR: Invalid value specified for management c=
lient version&quot;);</span><br><span>     }</span><br><span> }</span><br><=
span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1528?usp=3Demail">change 1528</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1528?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I76dc80a9d9b29e401b7bbd59e0c=
46baf751d2e4a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1528 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--mRAbyGGLDYQ=--

