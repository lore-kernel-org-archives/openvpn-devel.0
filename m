From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 24 Mar 2025 14:00:25 +0000
In-Reply-To: <gerrit.1742821192000.Ifc7443974345042ab9945d6a10e1d1b4525e5e05@...2715...>
References: <gerrit.1742821192000.Ifc7443974345042ab9945d6a10e1d1b4525e5e05@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <87428eab7bfa2a4f3361af55f3d95e3059309753-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WuiDEAXElPc="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--WuiDEAXElPc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/91=
4?usp=3Demail )

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
Gerrit-MessageType: merged

--WuiDEAXElPc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/914?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Improve documentation for override-username<br=
><br>- Mention that pushing auth-token-user only happens when OpenVPN also<=
br>  generates the auth-token.<br>- mention that OpenVPN will only accept t=
he original and overridden username<br>  from a client<br>- suggest to use =
auth-token-user when a user generates the auth-token<br><br>Change-Id: Ifc7=
443974345042ab9945d6a10e1d1b4525e5e05<br>Signed-off-by: Arne Schwabe &lt;ar=
ne@...1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<b=
r>Message-Id: &lt;20250324135441.26725-1-gert@...1296...&gt;<br>URL: https:=
//www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31210.html<br=
>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M doc/man-se=
ctions/server-options.rst<br>1 file changed, 10 insertions(+), 1 deletion(-=
)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/serv=
er-options.rst</span><br><span>index e93b04d..ccc1374 100644</span><br><spa=
n>--- a/doc/man-sections/server-options.rst</span><br><span>+++ b/doc/man-s=
ections/server-options.rst</span><br><span>@@ -432,7 +432,12 @@</span><br><=
span> </span><br><span>   The changed username will be picked up by the sta=
tus output and also by</span><br><span>   the ``--auth-gen-token`` option. =
It will also be pushed to the client</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-  using ``--auth-token-user``.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  using ``--auth-token-user`` if ``--auth-gen-tok=
en`` is enabled.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  Internally on all su=
bsequent renegotiations the client provided username</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  will be replaced by the username provid=
ed by ``--override-username``.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  If the client changes to a username that is different from bot=
h the initial</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  and =
the overridden username, the client will be rejected.</span><br><span> </sp=
an><br><span>   Special care should be taken that both the initial username=
 of the client</span><br><span>   and the overridden username are handled c=
orrectly when using</span><br><span>@@ -444,6 +449,10 @@</span><br><span>  =
 can be used for ``--auth-gen-token`` to allow providing a username in</spa=
n><br><span>   these scenarios.</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  If the ``--auth-token`` directive is pushed=
 by another script/plugin or</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  management interface, consider also generating and pushing</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--auth-token-user``.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --=
port-share args</span><br><span>   Share OpenVPN TCP with another service</=
span><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/914?usp=3Demail">change 914</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/914?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--WuiDEAXElPc=--

