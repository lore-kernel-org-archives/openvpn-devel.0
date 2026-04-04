From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 4 Apr 2026 15:53:54 +0000
In-Reply-To: <gerrit.1775126506000.Ieaaf3a79642c8f7914f9bfc6762ad601c4f5695b@...2715...>
References: <gerrit.1775126506000.Ieaaf3a79642c8f7914f9bfc6762ad601c4f5695b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1583c139ad6d1f93c022b5ff56c49d26aa80a03b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dHmZWyOcxDI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: doc: Remove some
 explanations for pre-2.3 configurations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--dHmZWyOcxDI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1603?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: doc: Remove some explanations for pre-2.3 configurations
......................................................................

doc: Remove some explanations for pre-2.3 configurations

Just streamline the documentation a bit.

Change-Id: Ieaaf3a79642c8f7914f9bfc6762ad601c4f5695b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1603
Message-Id: <20260402120435.39983-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
434.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/generic-options.rst
1 file changed, 7 insertions(+), 19 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/03/1603/2

diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generi=
c-options.rst
index 8132b48..415b81f 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -43,11 +43,11 @@
   however complications can result when scripts or restarts are executed
   after the chroot operation.

-  Note: The SSL library will probably need /dev/urandom to be available
+  Note: The SSL library will probably need ``/dev/urandom`` to be available
   inside the chroot directory ``dir``. This is because SSL libraries
   occasionally need to collect fresh randomness. Newer linux kernels and s=
ome
   BSDs implement a getrandom() or getentropy() syscall that removes the
-  need for /dev/urandom to be available.
+  need for ``/dev/urandom`` to be available.

 --compat-mode version
   This option provides a convenient way to alter the defaults of OpenVPN
@@ -170,9 +170,7 @@
   Note: as soon as OpenVPN has daemonized, it can not ask for usernames,
   passwords, or key pass phrases anymore. This has certain consequences,
   namely that using a password-protected private key will fail unless the
-  ``--askpass`` option is used to tell OpenVPN to ask for the pass phrase
-  (this requirement is new in v2.3.7, and is a consequence of calling
-  daemon() before initializing the crypto layer).
+  ``--askpass`` option is used to tell OpenVPN to ask for the pass phrase.

   Further, using ``--daemon`` together with ``--auth-user-pass`` (entered
   on console) and ``--auth-nocache`` will fail as soon as key
@@ -330,32 +328,22 @@
   OpenVPN releases before v2.3 also supported a ``method`` flag which
   indicated how OpenVPN should call external commands and scripts. This
   could be either :code:`execve` or :code:`system`. As of OpenVPN 2.3, this
-  flag is no longer accepted. In most \*nix environments the execve()
-  approach has been used without any issues.
+  flag is no longer accepted.

   Some directives such as ``--up`` allow options to be passed to the
   external script. In these cases make sure the script name does not
   contain any spaces or the configuration parser will choke because it
   can't determine where the script name ends and script options start.

-  To run scripts in Windows in earlier OpenVPN versions you needed to
-  either add a full path to the script interpreter which can parse the
-  script or use the ``system`` flag to run these scripts. As of OpenVPN
-  2.3 it is now a strict requirement to have full path to the script
+  On Windoes it is a strict requirement to have the full path to the script
   interpreter when running non-executables files. This is not needed for
   executable files, such as .exe, .com, .bat or .cmd files. For example,
-  if you have a Visual Basic script, you must use this syntax now:
-
-  ::
+  if you have a Visual Basic script, you must use this syntax::

      --up 'C:\\Windows\\System32\\wscript.exe C:\\Program\ Files\\OpenVPN\=
\config\\my-up-script.vbs'

   Please note the single quote marks and the escaping of the backslashes
-  (\\) and the space character.
-
-  The reason the support for the :code:`system` flag was removed is due to
-  the security implications with shell expansions when executing scripts
-  via the :code:`system()` call.
+  (``\\``) and the space character.

 --setcon context
   Apply SELinux ``context`` after initialization. This essentially

--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1603?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ieaaf3a79642c8f7914f9bfc6762ad601c4f5695b
Gerrit-Change-Number: 1603
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--dHmZWyOcxDI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1603?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">doc: Remove some explanations f=
or pre-2.3 configurations<br><br>Just streamline the documentation a bit.<b=
r><br>Change-Id: Ieaaf3a79642c8f7914f9bfc6762ad601c4f5695b<br>Signed-off-by=
: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;=
arne-openvpn@...1227...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/ope=
nvpn/+/1603<br>Message-Id: &lt;20260402120435.39983-1-frank@...2641...&gt;<=
br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/ms=
g36434.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<b=
r>M doc/man-sections/generic-options.rst<br>1 file changed, 7 insertions(+)=
, 19 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.=
net:29418/openvpn refs/changes/03/1603/2</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-secti=
ons/generic-options.rst b/doc/man-sections/generic-options.rst</span><br><s=
pan>index 8132b48..415b81f 100644</span><br><span>--- a/doc/man-sections/ge=
neric-options.rst</span><br><span>+++ b/doc/man-sections/generic-options.rs=
t</span><br><span>@@ -43,11 +43,11 @@</span><br><span>   however complicati=
ons can result when scripts or restarts are executed</span><br><span>   aft=
er the chroot operation.</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  Note: The SSL library will probably need /dev/urando=
m to be available</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
Note: The SSL library will probably need ``/dev/urandom`` to be available</=
span><br><span>   inside the chroot directory ``dir``. This is because SSL =
libraries</span><br><span>   occasionally need to collect fresh randomness.=
 Newer linux kernels and some</span><br><span>   BSDs implement a getrandom=
() or getentropy() syscall that removes the</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  need for /dev/urandom to be available.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  need for ``/dev/urandom`` to b=
e available.</span><br><span> </span><br><span> --compat-mode version</span=
><br><span>   This option provides a convenient way to alter the defaults o=
f OpenVPN</span><br><span>@@ -170,9 +170,7 @@</span><br><span>   Note: as s=
oon as OpenVPN has daemonized, it can not ask for usernames,</span><br><spa=
n>   passwords, or key pass phrases anymore. This has certain consequences,=
</span><br><span>   namely that using a password-protected private key will=
 fail unless the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``-=
-askpass`` option is used to tell OpenVPN to ask for the pass phrase</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-  (this requirement is new i=
n v2.3.7, and is a consequence of calling</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  daemon() before initializing the crypto layer).</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--askpass`` option is=
 used to tell OpenVPN to ask for the pass phrase.</span><br><span> </span><=
br><span>   Further, using ``--daemon`` together with ``--auth-user-pass`` =
(entered</span><br><span>   on console) and ``--auth-nocache`` will fail as=
 soon as key</span><br><span>@@ -330,32 +328,22 @@</span><br><span>   OpenV=
PN releases before v2.3 also supported a ``method`` flag which</span><br><s=
pan>   indicated how OpenVPN should call external commands and scripts. Thi=
s</span><br><span>   could be either :code:`execve` or :code:`system`. As o=
f OpenVPN 2.3, this</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
flag is no longer accepted. In most \*nix environments the execve()</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  approach has been used with=
out any issues.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  fl=
ag is no longer accepted.</span><br><span> </span><br><span>   Some directi=
ves such as ``--up`` allow options to be passed to the</span><br><span>   e=
xternal script. In these cases make sure the script name does not</span><br=
><span>   contain any spaces or the configuration parser will choke because=
 it</span><br><span>   can&#39;t determine where the script name ends and s=
cript options start.</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-  To run scripts in Windows in earlier OpenVPN versions yo=
u needed to</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  either a=
dd a full path to the script interpreter which can parse the</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  script or use the ``system`` flag =
to run these scripts. As of OpenVPN</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-  2.3 it is now a strict requirement to have full path to the=
 script</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  On Windoes=
 it is a strict requirement to have the full path to the script</span><br><=
span>   interpreter when running non-executables files. This is not needed =
for</span><br><span>   executable files, such as .exe, .com, .bat or .cmd f=
iles. For example,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  i=
f you have a Visual Basic script, you must use this syntax now:</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  ::</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  if you have a Visual Basic script, you must use this syntax::</span=
><br><span> </span><br><span>      --up &#39;C:\\Windows\\System32\\wscript=
.exe C:\\Program\ Files\\OpenVPN\\config\\my-up-script.vbs&#39;</span><br><=
span> </span><br><span>   Please note the single quote marks and the escapi=
ng of the backslashes</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  (\\) and the space character.</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  The reaso=
n the support for the :code:`system` flag was removed is due to</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  the security implications with =
shell expansions when executing scripts</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-  via the :code:`system()` call.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  (``\\``) and the space character.</span><b=
r><span> </span><br><span> --setcon context</span><br><span>   Apply SELinu=
x ``context`` after initialization. This essentially</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1603?usp=3Demail">change 1603</a>. To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demai=
l">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAc=
tion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1603?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ieaaf3a79642c8f7914f9bfc6762=
ad601c4f5695b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1603 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--dHmZWyOcxDI=--

