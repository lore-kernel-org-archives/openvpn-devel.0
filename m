From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 24 Mar 2025 12:59:57 +0000
References: <gerrit.1742821192000.Ifc7443974345042ab9945d6a10e1d1b4525e5e05@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <432a8e1b666c3eb230dd4faa41fea134a3e59f0b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5xvOoH7+xM0="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Improve
 documentation for override-username
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

--5xvOoH7+xM0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/914?usp=3Demail

to review the following change.


Change subject: Improve documentation for override-username
......................................................................

Improve documentation for override-username

- Mention that pushing auth-token-user only happens when OpenVPN also
  generates the auth-token.
- mention that OpenVPN will only accept the original and overridden username
  from a client
- suggest to use auth-token-user when a user generates the auth-token

Change-Id: Ifc7443974345042ab9945d6a10e1d1b4525e5e05
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M doc/man-sections/server-options.rst
1 file changed, 10 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/14/914/1

diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-=
options.rst
index e93b04d..ccc1374 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -432,7 +432,12 @@

   The changed username will be picked up by the status output and also by
   the ``--auth-gen-token`` option. It will also be pushed to the client
-  using ``--auth-token-user``.
+  using ``--auth-token-user`` if ``--auth-gen-token`` is enabled.
+
+  Internally on all subsequent renegotiations the client provided username
+  will be replaced by the username provided by ``--override-username``.
+  If the client changes to a username that is different from both the init=
ial
+  and the overridden username, the client will be rejected.

   Special care should be taken that both the initial username of the client
   and the overridden username are handled correctly when using
@@ -444,6 +449,10 @@
   can be used for ``--auth-gen-token`` to allow providing a username in
   these scenarios.

+  If the ``--auth-token`` directive is pushed by another script/plugin or
+  management interface, consider also generating and pushing
+  ``--auth-token-user``.
+
 --port-share args
   Share OpenVPN TCP with another service


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/914?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifc7443974345042ab9945d6a10e1d1b4525e5e05
Gerrit-Change-Number: 914
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--5xvOoH7+xM0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/914?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Improve documentation for override-username<br><br>- Mention =
that pushing auth-token-user only happens when OpenVPN also<br>  generates =
the auth-token.<br>- mention that OpenVPN will only accept the original and=
 overridden username<br>  from a client<br>- suggest to use auth-token-user=
 when a user generates the auth-token<br><br>Change-Id: Ifc7443974345042ab9=
945d6a10e1d1b4525e5e05<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&g=
t;<br>---<br>M doc/man-sections/server-options.rst<br>1 file changed, 10 in=
sertions(+), 1 deletion(-)<br><br></pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2941=
8/openvpn refs/changes/14/914/1</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/serve=
r-options.rst b/doc/man-sections/server-options.rst</span><br><span>index e=
93b04d..ccc1374 100644</span><br><span>--- a/doc/man-sections/server-option=
s.rst</span><br><span>+++ b/doc/man-sections/server-options.rst</span><br><=
span>@@ -432,7 +432,12 @@</span><br><span> </span><br><span>   The changed =
username will be picked up by the status output and also by</span><br><span=
>   the ``--auth-gen-token`` option. It will also be pushed to the client</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  using ``--auth-token-=
user``.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  using ``--=
auth-token-user`` if ``--auth-gen-token`` is enabled.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  Internally on all subsequent renegotiations the client pro=
vided username</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  wil=
l be replaced by the username provided by ``--override-username``.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  If the client changes to a=
 username that is different from both the initial</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  and the overridden username, the client wil=
l be rejected.</span><br><span> </span><br><span>   Special care should be =
taken that both the initial username of the client</span><br><span>   and t=
he overridden username are handled correctly when using</span><br><span>@@ =
-444,6 +449,10 @@</span><br><span>   can be used for ``--auth-gen-token`` t=
o allow providing a username in</span><br><span>   these scenarios.</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  If the =
``--auth-token`` directive is pushed by another script/plugin or</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  management interface, consid=
er also generating and pushing</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  ``--auth-token-user``.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> --port-share args</span><br><span>   Shar=
e OpenVPN TCP with another service</span><br><span> </span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/914?usp=3Demail">change 914</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/914?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifc7443974345042ab9945d6a10e=
1d1b4525e5e05 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 914 </div>
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


--5xvOoH7+xM0=--

