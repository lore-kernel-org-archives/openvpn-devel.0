From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 2 Apr 2026 10:41:47 +0000
References: <gerrit.1775126506000.Ieaaf3a79642c8f7914f9bfc6762ad601c4f5695b@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <af028ccbda2db5bc48670b1353219a2aeac3c7c8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Q7t5F2TeOjE="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Q7t5F2TeOjE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1603?usp=3Demail

to review the following change.


Change subject: doc: Remove some explanations for pre-2.3 configurations
......................................................................

doc: Remove some explanations for pre-2.3 configurations

Just streamline the documentation a bit.

Change-Id: Ieaaf3a79642c8f7914f9bfc6762ad601c4f5695b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M doc/man-sections/generic-options.rst
1 file changed, 7 insertions(+), 19 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/03/1603/1

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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1603?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ieaaf3a79642c8f7914f9bfc6762ad601c4f5695b
Gerrit-Change-Number: 1603
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--Q7t5F2TeOjE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1603?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">doc: Remove some explanations for pre-2.3 c=
onfigurations<br><br>Just streamline the documentation a bit.<br><br>Change=
-Id: Ieaaf3a79642c8f7914f9bfc6762ad601c4f5695b<br>Signed-off-by: Frank Lich=
tenheld &lt;frank@...2641...&gt;<br>---<br>M doc/man-sections/generic-optio=
ns.rst<br>1 file changed, 7 insertions(+), 19 deletions(-)<br><br></pre><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/03/=
1603/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/doc/man-sections/generic-options.rst b/doc/man-=
sections/generic-options.rst</span><br><span>index 8132b48..415b81f 100644<=
/span><br><span>--- a/doc/man-sections/generic-options.rst</span><br><span>=
+++ b/doc/man-sections/generic-options.rst</span><br><span>@@ -43,11 +43,11=
 @@</span><br><span>   however complications can result when scripts or res=
tarts are executed</span><br><span>   after the chroot operation.</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Note: The S=
SL library will probably need /dev/urandom to be available</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  Note: The SSL library will probabl=
y need ``/dev/urandom`` to be available</span><br><span>   inside the chroo=
t directory ``dir``. This is because SSL libraries</span><br><span>   occas=
ionally need to collect fresh randomness. Newer linux kernels and some</spa=
n><br><span>   BSDs implement a getrandom() or getentropy() syscall that re=
moves the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  need for /=
dev/urandom to be available.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  need for ``/dev/urandom`` to be available.</span><br><span> </sp=
an><br><span> --compat-mode version</span><br><span>   This option provides=
 a convenient way to alter the defaults of OpenVPN</span><br><span>@@ -170,=
9 +170,7 @@</span><br><span>   Note: as soon as OpenVPN has daemonized, it =
can not ask for usernames,</span><br><span>   passwords, or key pass phrase=
s anymore. This has certain consequences,</span><br><span>   namely that us=
ing a password-protected private key will fail unless the</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-  ``--askpass`` option is used to tell =
OpenVPN to ask for the pass phrase</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-  (this requirement is new in v2.3.7, and is a consequence of =
calling</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  daemon() bef=
ore initializing the crypto layer).</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  ``--askpass`` option is used to tell OpenVPN to ask for t=
he pass phrase.</span><br><span> </span><br><span>   Further, using ``--dae=
mon`` together with ``--auth-user-pass`` (entered</span><br><span>   on con=
sole) and ``--auth-nocache`` will fail as soon as key</span><br><span>@@ -3=
30,32 +328,22 @@</span><br><span>   OpenVPN releases before v2.3 also suppo=
rted a ``method`` flag which</span><br><span>   indicated how OpenVPN shoul=
d call external commands and scripts. This</span><br><span>   could be eith=
er :code:`execve` or :code:`system`. As of OpenVPN 2.3, this</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  flag is no longer accepted. In mos=
t \*nix environments the execve()</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  approach has been used without any issues.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  flag is no longer accepted.</span><b=
r><span> </span><br><span>   Some directives such as ``--up`` allow options=
 to be passed to the</span><br><span>   external script. In these cases mak=
e sure the script name does not</span><br><span>   contain any spaces or th=
e configuration parser will choke because it</span><br><span>   can&#39;t d=
etermine where the script name ends and script options start.</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  To run scripts =
in Windows in earlier OpenVPN versions you needed to</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  either add a full path to the script inte=
rpreter which can parse the</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  script or use the ``system`` flag to run these scripts. As of OpenV=
PN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  2.3 it is now a s=
trict requirement to have full path to the script</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  On Windoes it is a strict requirement to ha=
ve the full path to the script</span><br><span>   interpreter when running =
non-executables files. This is not needed for</span><br><span>   executable=
 files, such as .exe, .com, .bat or .cmd files. For example,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  if you have a Visual Basic script,=
 you must use this syntax now:</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ::</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  if you have a Visual Basi=
c script, you must use this syntax::</span><br><span> </span><br><span>    =
  --up &#39;C:\\Windows\\System32\\wscript.exe C:\\Program\ Files\\OpenVPN\=
\config\\my-up-script.vbs&#39;</span><br><span> </span><br><span>   Please =
note the single quote marks and the escaping of the backslashes</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  (\\) and the space character.</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  The reason the support for the :code:`sys=
tem` flag was removed is due to</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-  the security implications with shell expansions when executing =
scripts</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  via the :cod=
e:`system()` call.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 (``\\``) and the space character.</span><br><span> </span><br><span> --set=
con context</span><br><span>   Apply SELinux ``context`` after initializati=
on. This essentially</span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/1603?usp=3Demail">change 1603=
</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tp://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemsco=
pe itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1603?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ieaaf3a79642c8f7914f9bfc6762=
ad601c4f5695b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1603 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--Q7t5F2TeOjE=--

