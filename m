From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 20 Jan 2025 12:12:36 +0000
References: <gerrit.1737375148000.Ib8adf7b31cae02e2de3d45da23b76a2d79f13e20@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <7d0f973d08473c99b498bb8467de800cd950a154-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZmTJJLrJv4k="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZmTJJLrJv4k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/871?usp=3Demail

to review the following change.


Change subject: Remove comparing username to NULL in tls_lock_username
......................................................................

Remove comparing username to NULL in tls_lock_username

tls_lock_username is only called in a single place and that place
calls this is function with up->username, which is always defined.

Change-Id: Ib8adf7b31cae02e2de3d45da23b76a2d79f13e20
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/ssl_verify.c
1 file changed, 3 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/71/871/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--ZmTJJLrJv4k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/871?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Remove comparing username to NULL in tls_lock_username<br><br=
>tls_lock_username is only called in a single place and that place<br>calls=
 this is function with up-&gt;username, which is always defined.<br><br>Cha=
nge-Id: Ib8adf7b31cae02e2de3d45da23b76a2d79f13e20<br>Signed-off-by: Arne Sc=
hwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/ssl_verify.c<br>1 fil=
e changed, 3 insertions(+), 6 deletions(-)<br><br></pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.=
openvpn.net:29418/openvpn refs/changes/71/871/1</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/ssl_verify.c b/src/openvpn/ssl_verify.c</span><br><span>index 4c4b58d=
..e7d7ed6 100644</span><br><span>--- a/src/openvpn/ssl_verify.c</span><br><=
span>+++ b/src/openvpn/ssl_verify.c</span><br><span>@@ -153,11 +153,11 @@</=
span><br><span> {</span><br><span>     if (multi-&gt;locked_username)</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (!username || strcmp(username, multi-&gt;locked_username))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (strcmp(username, =
multi-&gt;locked_username) !=3D 0)</span><br><span>         {</span><br><sp=
an>             msg(D_TLS_ERRORS, &quot;TLS Auth Error: username attempted =
to change from &#39;%s&#39; to &#39;%s&#39; -- tunnel disabled&quot;,</span=
><br><span>                 multi-&gt;locked_username,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                np(username));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                username);</spa=
n><br><span> </span><br><span>             /* disable the tunnel */</span><=
br><span>             tls_deauthenticate(multi);</span><br><span>@@ -166,10=
 +166,7 @@</span><br><span>     }</span><br><span>     else</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (us=
ername)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            multi-&gt;lock=
ed_username =3D string_alloc(username, NULL);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        multi-&gt;locked_username =3D string_alloc(username, =
NULL);</span><br><span>     }</span><br><span>     return true;</span><br><=
span> }</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/871?usp=3Demail">change 871</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/871?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib8adf7b31cae02e2de3d45da23b=
76a2d79f13e20 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 871 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--ZmTJJLrJv4k=--

