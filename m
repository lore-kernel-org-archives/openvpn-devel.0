From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 20 Nov 2023 11:17:16 +0000
References: <gerrit.1700479034000.I93afff2372c4150d6bddc8c07fd4ebc8bfb0cc3e@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <a1bf80443338441974ace210af06709901293179-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ODVlJGs3yt0="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Deprecate tls-exit
 option
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

--ODVlJGs3yt0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/447?usp=3Demail

to review the following change.


Change subject: Deprecate tls-exit option
......................................................................

Deprecate tls-exit option

This option is questionable and I cannot see any reason to actually use it.

Change-Id: I93afff2372c4150d6bddc8c07fd4ebc8bfb0cc3e
---
M Changes.rst
M doc/man-sections/tls-options.rst
M src/openvpn/options.c
3 files changed, 7 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/47/447/1

diff --git a/Changes.rst b/Changes.rst
index 3676dce..922f78d 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -10,6 +10,10 @@
     ``--allow-deprecated-insecure-static-crypto`` but will be removed in
     OpenVPN 2.8.

+```tls-exit``` has been deprecated since it is unclear what the use case
+    for this option is. If you have a valid use case, please reach out sin=
ce
+    the will otherwise be removed in the future.
+
 Overview of changes in 2.6
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-option=
s.rst
index 908a42a..da5f362 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -553,7 +553,7 @@
   code.

 --tls-exit
-  Exit on TLS negotiation failure.
+  **DEPRECATED** Exit on TLS negotiation failure.

 --tls-export-cert directory
   Store the certificates the clients use upon connection to this
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2594b66..5eb1a45 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -608,7 +608,7 @@
     "--tran-window n : Transition window -- old key can live this many sec=
onds\n"
     "                  after new key renegotiation begins (default=3D%d).\=
n"
     "--single-session: Allow only one session (reset state on restart).\n"
-    "--tls-exit      : Exit on TLS negotiation failure.\n"
+    "--tls-exit      : (DEPRECATED) Exit on TLS negotiation failure.\n"
     "--tls-auth f [d]: Add an additional layer of authentication on top of=
 the TLS\n"
     "                  control channel to protect against attacks on the T=
LS stack\n"
     "                  and DoS attacks.\n"
@@ -8960,6 +8960,7 @@
     }
     else if (streq(p[0], "tls-exit") && !p[1])
     {
+        msg(M_WARN, "DEPRECATED OPTION: The option --tls-exit is deprecate=
d.");
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->tls_exit =3D true;
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/447?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I93afff2372c4150d6bddc8c07fd4ebc8bfb0cc3e
Gerrit-Change-Number: 447
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--ODVlJGs3yt0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/447?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Deprecate tls-exit option<br><br>This option is questionable =
and I cannot see any reason to actually use it.<br><br>Change-Id: I93afff23=
72c4150d6bddc8c07fd4ebc8bfb0cc3e<br>---<br>M Changes.rst<br>M doc/man-secti=
ons/tls-options.rst<br>M src/openvpn/options.c<br>3 files changed, 7 insert=
ions(+), 2 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/o=
penvpn refs/changes/47/447/1</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/Changes.rst b/Changes.rst=
</span><br><span>index 3676dce..922f78d 100644</span><br><span>--- a/Change=
s.rst</span><br><span>+++ b/Changes.rst</span><br><span>@@ -10,6 +10,10 @@<=
/span><br><span>     ``--allow-deprecated-insecure-static-crypto`` but will=
 be removed in</span><br><span>     OpenVPN 2.8.</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+```tls-exit``` has been depr=
ecated since it is unclear what the use case</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    for this option is. If you have a valid use ca=
se, please reach out since</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    the will otherwise be removed in the future.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> Overview of changes i=
n 2.6</span><br><span> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span> </span><br><span>diff --git a/=
doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst</span><=
br><span>index 908a42a..da5f362 100644</span><br><span>--- a/doc/man-sectio=
ns/tls-options.rst</span><br><span>+++ b/doc/man-sections/tls-options.rst</=
span><br><span>@@ -553,7 +553,7 @@</span><br><span>   code.</span><br><span=
> </span><br><span> --tls-exit</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-  Exit on TLS negotiation failure.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  **DEPRECATED** Exit on TLS negotiation failure.</=
span><br><span> </span><br><span> --tls-export-cert directory</span><br><sp=
an>   Store the certificates the clients use upon connection to this</span>=
<br><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span>=
<br><span>index 2594b66..5eb1a45 100644</span><br><span>--- a/src/openvpn/o=
ptions.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -60=
8,7 +608,7 @@</span><br><span>     &quot;--tran-window n : Transition windo=
w -- old key can live this many seconds\n&quot;</span><br><span>     &quot;=
                  after new key renegotiation begins (default=3D%d).\n&quot=
;</span><br><span>     &quot;--single-session: Allow only one session (rese=
t state on restart).\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    &quot;--tls-exit      : Exit on TLS negotiation failure.\n&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--tls-exi=
t      : (DEPRECATED) Exit on TLS negotiation failure.\n&quot;</span><br><s=
pan>     &quot;--tls-auth f [d]: Add an additional layer of authentication =
on top of the TLS\n&quot;</span><br><span>     &quot;                  cont=
rol channel to protect against attacks on the TLS stack\n&quot;</span><br><=
span>     &quot;                  and DoS attacks.\n&quot;</span><br><span>=
@@ -8960,6 +8960,7 @@</span><br><span>     }</span><br><span>     else if (=
streq(p[0], &quot;tls-exit&quot;) &amp;&amp; !p[1])</span><br><span>     {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, =
&quot;DEPRECATED OPTION: The option --tls-exit is deprecated.&quot;);</span=
><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>     =
    options-&gt;tls_exit =3D true;</span><br><span>     }</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/447?usp=3Demail">change 447</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settin=
gs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/447?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I93afff2372c4150d6bddc8c07fd=
4ebc8bfb0cc3e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 447 </div>
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


--ODVlJGs3yt0=--

