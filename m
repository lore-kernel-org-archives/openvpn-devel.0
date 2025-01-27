From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 27 Jan 2025 11:40:12 +0000
In-Reply-To: <gerrit.1737375148000.Ib8adf7b31cae02e2de3d45da23b76a2d79f13e20@...2715...>
References: <gerrit.1737375148000.Ib8adf7b31cae02e2de3d45da23b76a2d79f13e20@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <2c9956c27b79e88f6e7b31f25e777850e541a7fe-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="u1EpuWEV7mQ="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--u1EpuWEV7mQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/87=
1?usp=3Demail )

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
Gerrit-MessageType: merged

--u1EpuWEV7mQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/871?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Remove comparing username to NULL in tls_lock_=
username<br><br>tls_lock_username is only called in a single place and that=
 place<br>calls this is function with up-&gt;username, which is always defi=
ned.<br><br>Change-Id: Ib8adf7b31cae02e2de3d45da23b76a2d79f13e20<br>Signed-=
off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Frank Lichtenheld=
 &lt;frank@...2641...&gt;<br>Message-Id: &lt;20250121161247.37883-1-frank@...220...=
..2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1439...=
ceforge.net/msg30520.html<br>Signed-off-by: Gert Doering &lt;gert@...2132...=
.&gt;<br>---<br>M src/openvpn/ssl_verify.c<br>1 file changed, 3 insertions(=
+), 6 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c</span><=
br><span>index 4c4b58d..e7d7ed6 100644</span><br><span>--- a/src/openvpn/ss=
l_verify.c</span><br><span>+++ b/src/openvpn/ssl_verify.c</span><br><span>@=
@ -153,11 +153,11 @@</span><br><span> {</span><br><span>     if (multi-&gt;=
locked_username)</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (!username || strcmp(username, multi-&gt;locke=
d_username))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (strcmp(username, multi-&gt;locked_username) !=3D 0)</span><br><span>  =
       {</span><br><span>             msg(D_TLS_ERRORS, &quot;TLS Auth Erro=
r: username attempted to change from &#39;%s&#39; to &#39;%s&#39; -- tunnel=
 disabled&quot;,</span><br><span>                 multi-&gt;locked_username=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                np(u=
sername));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       username);</span><br><span> </span><br><span>             /* disable=
 the tunnel */</span><br><span>             tls_deauthenticate(multi);</spa=
n><br><span>@@ -166,10 +166,7 @@</span><br><span>     }</span><br><span>   =
  else</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        if (username)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        multi-&gt;locked_username =3D string_alloc(username, NULL);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;locked_username =3D s=
tring_alloc(username, NULL);</span><br><span>     }</span><br><span>     re=
turn true;</span><br><span> }</span><br><span></span><br></pre><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/871?usp=3Demail">cha=
nge 871</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope it=
emtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action=
" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/871?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--u1EpuWEV7mQ=--

