From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 12 Sep 2023 10:52:43 +0000
References: <gerrit.1677676721000.I3bd27a8d34d8cb4896a3b78508b7d16911571543@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <ec53e2f8e78ec5dd7b3b8efd13c1ad46ab45b9ac-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fScbkjg3I0g="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Improve description
 of compat-mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, plaisthos <arne-openvpn@...1227...>

--fScbkjg3I0g=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

plaisthos has uploaded this change for review. ( http://gerrit.openvpn.net/=
c/openvpn/+/34?usp=3Demail )


Change subject: Improve description of compat-mode
......................................................................

Improve description of compat-mode

Explicitly say that the version specified is the one of the peer and not
the version we try to emulate.

Change-Id: I3bd27a8d34d8cb4896a3b78508b7d16911571543
---
M doc/man-sections/generic-options.rst
1 file changed, 16 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/34/34/3

diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generi=
c-options.rst
index c827651..97e1b5a 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -53,10 +53,17 @@
   need for /dev/urandom to be available.

 --compat-mode version
-  This option provides a way to alter the default of OpenVPN to be more
-  compatible with the version ``version`` specified. All of the changes
-  this option does can also be achieved using individual configuration
-  options.
+  This option provides a convenient way to alter the defaults of OpenVPN
+  to be more compatible with the version ``version`` specified. All of
+  the changes this option applies can also be achieved using individual
+  configuration options.
+
+  The version specified with this option is the version of OpenVPN peer
+  OpenVPN should try to be compatible with. In general OpenVPN should be
+  compatible with the last two previous version without this option. E.g.
+  OpenVPN 2.6.0 should be compatible with 2.5.x and 2.4.x without this opt=
ion.
+  However, there might be some edge cases that still require this option e=
ven
+  in these cases.

   Note: Using this option reverts defaults to no longer recommended
   values and should be avoided if possible.
@@ -67,12 +74,15 @@
   - 2.5.x or lower: ``--allow-compression asym`` is automatically added
     to the configuration if no other compression options are present.
   - 2.4.x or lower: The cipher in ``--cipher`` is appended to
-    ``--data-ciphers``
+    ``--data-ciphers``.
   - 2.3.x or lower: ``--data-cipher-fallback`` is automatically added with
-    the same cipher as ``--cipher``
+    the same cipher as ``--cipher``.
   - 2.3.6 or lower: ``--tls-version-min 1.0`` is added to the configuration
     when ``--tls-version-min`` is not explicitly set.

+  If not required, this is option should be avoided. Setting this option c=
an
+  lower security or disable features like data-channel offloading.
+
 --config file
   Load additional config options from ``file`` where each line corresponds
   to one command line option, but with the leading :code:`--` removed.

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/34?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3bd27a8d34d8cb4896a3b78508b7d16911571543
Gerrit-Change-Number: 34
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--fScbkjg3I0g=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>plaisthos has uploaded this change for <strong>review</strong>.</p><p><a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/34?usp=3Demail">View Change<=
/a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Improve description of compat-mode<br><br>Explicitly say that the versi=
on specified is the one of the peer and not<br>the version we try to emulat=
e.<br><br>Change-Id: I3bd27a8d34d8cb4896a3b78508b7d16911571543<br>---<br>M =
doc/man-sections/generic-options.rst<br>1 file changed, 16 insertions(+), 6=
 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/34/34/3</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/doc/man-sections/generic-options.rst=
 b/doc/man-sections/generic-options.rst</span><br><span>index c827651..97e1=
b5a 100644</span><br><span>--- a/doc/man-sections/generic-options.rst</span=
><br><span>+++ b/doc/man-sections/generic-options.rst</span><br><span>@@ -5=
3,10 +53,17 @@</span><br><span>   need for /dev/urandom to be available.</s=
pan><br><span> </span><br><span> --compat-mode version</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-  This option provides a way to alter the =
default of OpenVPN to be more</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-  compatible with the version ``version`` specified. All of the cha=
nges</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  this option doe=
s can also be achieved using individual configuration</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  options.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  This option provides a convenient way to alter the=
 defaults of OpenVPN</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  to be more compatible with the version ``version`` specified. All of</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  the changes this opti=
on applies can also be achieved using individual</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  configuration options.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  The version specified with this option is the version of O=
penVPN peer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  OpenVP=
N should try to be compatible with. In general OpenVPN should be</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  compatible with the last two=
 previous version without this option. E.g.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  OpenVPN 2.6.0 should be compatible with 2.5.x and=
 2.4.x without this option.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  However, there might be some edge cases that still require this o=
ption even</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  in thes=
e cases.</span><br><span> </span><br><span>   Note: Using this option rever=
ts defaults to no longer recommended</span><br><span>   values and should b=
e avoided if possible.</span><br><span>@@ -67,12 +74,15 @@</span><br><span>=
   - 2.5.x or lower: ``--allow-compression asym`` is automatically added</s=
pan><br><span>     to the configuration if no other compression options are=
 present.</span><br><span>   - 2.4.x or lower: The cipher in ``--cipher`` i=
s appended to</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ``--=
data-ciphers``</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    `=
`--data-ciphers``.</span><br><span>   - 2.3.x or lower: ``--data-cipher-fal=
lback`` is automatically added with</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    the same cipher as ``--cipher``</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    the same cipher as ``--cipher``.</span><b=
r><span>   - 2.3.6 or lower: ``--tls-version-min 1.0`` is added to the conf=
iguration</span><br><span>     when ``--tls-version-min`` is not explicitly=
 set.</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  If not required, this is option should be avoided. Setting this optio=
n can</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  lower securi=
ty or disable features like data-channel offloading.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --config file</span><br=
><span>   Load additional config options from ``file`` where each line corr=
esponds</span><br><span>   to one command line option, but with the leading=
 :code:`--` removed.</span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/34?usp=3Demail">change 34</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/34?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3bd27a8d34d8cb4896a3b78508b=
7d16911571543 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 34 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--fScbkjg3I0g=--

