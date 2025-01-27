From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 27 Jan 2025 11:40:10 +0000
In-Reply-To: <gerrit.1737375148000.Ib8adf7b31cae02e2de3d45da23b76a2d79f13e20@...2715...>
References: <gerrit.1737375148000.Ib8adf7b31cae02e2de3d45da23b76a2d79f13e20@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2c9956c27b79e88f6e7b31f25e777850e541a7fe-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="54u1T7Pugyo="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Remove comparing
 username to NULL in tls_lock_username
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

--54u1T7Pugyo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/871?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Remove comparing username to NULL in tls_lock_username
......................................................................

Remove comparing username to NULL in tls_lock_username

tls_lock_username is only called in a single place and that place
calls this is function with up->username, which is always defined.

Change-Id: Ib8adf7b31cae02e2de3d45da23b76a2d79f13e20
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20250121161247.37883-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
520.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_verify.c
1 file changed, 3 insertions(+), 6 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/71/871/3

diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 4c4b58d..e7d7ed6 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -153,11 +153,11 @@
 {
     if (multi->locked_username)
     {
-        if (!username || strcmp(username, multi->locked_username))
+        if (strcmp(username, multi->locked_username) !=3D 0)
         {
             msg(D_TLS_ERRORS, "TLS Auth Error: username attempted to chang=
e from '%s' to '%s' -- tunnel disabled",
                 multi->locked_username,
-                np(username));
+                username);

             /* disable the tunnel */
             tls_deauthenticate(multi);
@@ -166,10 +166,7 @@
     }
     else
     {
-        if (username)
-        {
-            multi->locked_username =3D string_alloc(username, NULL);
-        }
+        multi->locked_username =3D string_alloc(username, NULL);
     }
     return true;
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/871?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib8adf7b31cae02e2de3d45da23b76a2d79f13e20
Gerrit-Change-Number: 871
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--54u1T7Pugyo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #3</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
871?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Remove comparing username to NULL in tls_lock=
_username<br><br>tls_lock_username is only called in a single place and tha=
t place<br>calls this is function with up-&gt;username, which is always def=
ined.<br><br>Change-Id: Ib8adf7b31cae02e2de3d45da23b76a2d79f13e20<br>Signed=
-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Frank Lichtenhel=
d &lt;frank@...2641...&gt;<br>Message-Id: &lt;20250121161247.37883-1-frank@=
...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1885...=
rceforge.net/msg30520.html<br>Signed-off-by: Gert Doering &lt;gert@...1725...=
..&gt;<br>---<br>M src/openvpn/ssl_verify.c<br>1 file changed, 3 insertions=
(+), 6 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openv=
pn refs/changes/71/871/3</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_verify.c b/sr=
c/openvpn/ssl_verify.c</span><br><span>index 4c4b58d..e7d7ed6 100644</span>=
<br><span>--- a/src/openvpn/ssl_verify.c</span><br><span>+++ b/src/openvpn/=
ssl_verify.c</span><br><span>@@ -153,11 +153,11 @@</span><br><span> {</span=
><br><span>     if (multi-&gt;locked_username)</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!username || st=
rcmp(username, multi-&gt;locked_username))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (strcmp(username, multi-&gt;locked_userna=
me) !=3D 0)</span><br><span>         {</span><br><span>             msg(D_T=
LS_ERRORS, &quot;TLS Auth Error: username attempted to change from &#39;%s&=
#39; to &#39;%s&#39; -- tunnel disabled&quot;,</span><br><span>            =
     multi-&gt;locked_username,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                np(username));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                username);</span><br><span> </span><br=
><span>             /* disable the tunnel */</span><br><span>             t=
ls_deauthenticate(multi);</span><br><span>@@ -166,10 +166,7 @@</span><br><s=
pan>     }</span><br><span>     else</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        if (username)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            multi-&gt;locked_username =3D string_=
alloc(username, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m=
ulti-&gt;locked_username =3D string_alloc(username, NULL);</span><br><span>=
     }</span><br><span>     return true;</span><br><span> }</span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/871?usp=3Demail">change 871</a>. To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">sett=
ings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/871?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib8adf7b31cae02e2de3d45da23b=
76a2d79f13e20 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 871 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--54u1T7Pugyo=--

