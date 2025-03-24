From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 24 Mar 2025 14:00:22 +0000
In-Reply-To: <gerrit.1742821192000.Ifc7443974345042ab9945d6a10e1d1b4525e5e05@...2715...>
References: <gerrit.1742821192000.Ifc7443974345042ab9945d6a10e1d1b4525e5e05@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <87428eab7bfa2a4f3361af55f3d95e3059309753-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wBqbhauh/dU="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--wBqbhauh/dU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/914?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


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
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20250324135441.26725-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
210.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/server-options.rst
1 file changed, 10 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/14/914/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--wBqbhauh/dU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
914?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Improve documentation for override-username<b=
r><br>- Mention that pushing auth-token-user only happens when OpenVPN also=
<br>  generates the auth-token.<br>- mention that OpenVPN will only accept =
the original and overridden username<br>  from a client<br>- suggest to use=
 auth-token-user when a user generates the auth-token<br><br>Change-Id: Ifc=
7443974345042ab9945d6a10e1d1b4525e5e05<br>Signed-off-by: Arne Schwabe &lt;a=
rne@...1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<=
br>Message-Id: &lt;20250324135441.26725-1-gert@...1296...&gt;<br>URL: https=
://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31210.html<b=
r>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M doc/man-s=
ections/server-options.rst<br>1 file changed, 10 insertions(+), 1 deletion(=
-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/1=
4/914/2</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/doc/man-sections/server-options.rst b/doc/man-=
sections/server-options.rst</span><br><span>index e93b04d..ccc1374 100644</=
span><br><span>--- a/doc/man-sections/server-options.rst</span><br><span>++=
+ b/doc/man-sections/server-options.rst</span><br><span>@@ -432,7 +432,12 @=
@</span><br><span> </span><br><span>   The changed username will be picked =
up by the status output and also by</span><br><span>   the ``--auth-gen-tok=
en`` option. It will also be pushed to the client</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-  using ``--auth-token-user``.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  using ``--auth-token-user`` if ``-=
-auth-gen-token`` is enabled.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Interna=
lly on all subsequent renegotiations the client provided username</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  will be replaced by the use=
rname provided by ``--override-username``.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  If the client changes to a username that is differ=
ent from both the initial</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  and the overridden username, the client will be rejected.</span><br=
><span> </span><br><span>   Special care should be taken that both the init=
ial username of the client</span><br><span>   and the overridden username a=
re handled correctly when using</span><br><span>@@ -444,6 +449,10 @@</span>=
<br><span>   can be used for ``--auth-gen-token`` to allow providing a user=
name in</span><br><span>   these scenarios.</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  If the ``--auth-token`` directi=
ve is pushed by another script/plugin or</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  management interface, consider also generating and p=
ushing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--auth-to=
ken-user``.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> --port-share args</span><br><span>   Share OpenVPN TCP with anoth=
er service</span><br><span> </span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/914?usp=3Demail">chan=
ge 914</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/914?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifc7443974345042ab9945d6a10e=
1d1b4525e5e05 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 914 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--wBqbhauh/dU=--

