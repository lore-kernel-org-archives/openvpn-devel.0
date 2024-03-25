From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 25 Mar 2024 15:25:46 +0000
In-Reply-To: <gerrit.1708080342000.Ib5a7f9a978bda5ad58830e43580232660401f66d@...2715...>
References: <gerrit.1708080342000.Ib5a7f9a978bda5ad58830e43580232660401f66d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <69336d4837862b2761771e32bbf6feab9d14e734-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IdzcypE1Qkw="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: documentation: make
 section levels consistent
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--IdzcypE1Qkw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/52=
7?usp=3Demail )

Change subject: documentation: make section levels consistent
......................................................................

documentation: make section levels consistent

Previously the sections "Encryption Options" and
"Data channel cipher negotiation" were on the same
level as "OPTIONS", which makes no sense. Instead
move them and their subsections one level down.

Use ` since that was already in use in section
"Virtual Routing and Forwarding".

Change-Id: Ib5a7f9a978bda5ad58830e43580232660401f66d
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20240325071520.12513-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
453.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/cipher-negotiation.rst
M doc/man-sections/encryption-options.rst
M doc/man-sections/pkcs11-options.rst
M doc/man-sections/renegotiation.rst
M doc/man-sections/tls-options.rst
5 files changed, 14 insertions(+), 14 deletions(-)




diff --git a/doc/man-sections/cipher-negotiation.rst b/doc/man-sections/cip=
her-negotiation.rst
index 949ff86..1285e82 100644
--- a/doc/man-sections/cipher-negotiation.rst
+++ b/doc/man-sections/cipher-negotiation.rst
@@ -1,12 +1,12 @@
 Data channel cipher negotiation
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
+-------------------------------

 OpenVPN 2.4 and higher have the capability to negotiate the data cipher th=
at
 is used to encrypt data packets. This section describes the mechanism in m=
ore detail and the
 different backwards compatibility mechanism with older server and clients.

 OpenVPN 2.5 and later behaviour
---------------------------------
+```````````````````````````````
 When both client and server are at least running OpenVPN 2.5, that the ord=
er of
 the ciphers of the server's ``--data-ciphers`` is used to pick the data ci=
pher.
 That means that the first cipher in that list that is also in the client's
@@ -25,7 +25,7 @@
 ``--cipher`` option to this list.

 OpenVPN 2.4 clients
--------------------
+```````````````````
 The negotiation support in OpenVPN 2.4 was the first iteration of the impl=
ementation
 and still had some quirks. Its main goal was "upgrade to AES-256-GCM when =
possible".
 An OpenVPN 2.4 client that is built against a crypto library that supports=
 AES in GCM
@@ -40,7 +40,7 @@
 options to avoid this behaviour.

 OpenVPN 3 clients
------------------
+`````````````````
 Clients based on the OpenVPN 3.x library (https://github.com/openvpn/openv=
pn3/)
 do not have a configurable ``--ncp-ciphers`` or ``--data-ciphers`` option.=
 Newer
 versions by default disable legacy AES-CBC, BF-CBC, and DES-CBC ciphers.
@@ -52,7 +52,7 @@


 OpenVPN 2.3 and older clients (and clients with ``--ncp-disable``)
-------------------------------------------------------------------
+``````````````````````````````````````````````````````````````````
 When a client without cipher negotiation support connects to a server the
 cipher specified with the ``--cipher`` option in the client configuration
 must be included in the ``--data-ciphers`` option of the server to allow
@@ -65,7 +65,7 @@
 cipher used by the client is necessary.

 OpenVPN 2.4 server
-------------------
+``````````````````
 When a client indicates support for `AES-128-GCM` and `AES-256-GCM`
 (with ``IV_NCP=3D2``) an OpenVPN 2.4 server will send the first
 cipher of the ``--ncp-ciphers`` to the OpenVPN client regardless of what
@@ -76,7 +76,7 @@
 those ciphers are present.

 OpenVPN 2.3 and older servers (and servers with ``--ncp-disable``)
-------------------------------------------------------------------
+``````````````````````````````````````````````````````````````````
 The cipher used by the server must be included in ``--data-ciphers`` to
 allow the client connecting to a server without cipher negotiation
 support.
@@ -89,7 +89,7 @@
 cipher used by the server is necessary.

 Blowfish in CBC mode (BF-CBC) deprecation
-------------------------------------------
+`````````````````````````````````````````
 The ``--cipher`` option defaulted to `BF-CBC` in OpenVPN 2.4 and older
 version. The default was never changed to ensure backwards compatibility.
 In OpenVPN 2.5 this behaviour has now been changed so that if the ``--ciph=
er``
diff --git a/doc/man-sections/encryption-options.rst b/doc/man-sections/enc=
ryption-options.rst
index 3b26782..49385d6 100644
--- a/doc/man-sections/encryption-options.rst
+++ b/doc/man-sections/encryption-options.rst
@@ -1,8 +1,8 @@
 Encryption Options
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+------------------

 SSL Library information
------------------------
+```````````````````````

 --show-ciphers
   (Standalone) Show all cipher algorithms to use with the ``--cipher``
@@ -32,7 +32,7 @@
   ``--ecdh-curve`` and ``tls-groups`` options.

 Generating key material
------------------------
+```````````````````````

 --genkey args
   (Standalone) Generate a key to be used of the type keytype. if keyfile
diff --git a/doc/man-sections/pkcs11-options.rst b/doc/man-sections/pkcs11-=
options.rst
index de1662b..dfc27af 100644
--- a/doc/man-sections/pkcs11-options.rst
+++ b/doc/man-sections/pkcs11-options.rst
@@ -1,5 +1,5 @@
 PKCS#11 / SmartCard options
----------------------------
+```````````````````````````

 --pkcs11-cert-private args
   Set if access to certificate object should be performed after login.
diff --git a/doc/man-sections/renegotiation.rst b/doc/man-sections/renegoti=
ation.rst
index c548440..1e7c340 100644
--- a/doc/man-sections/renegotiation.rst
+++ b/doc/man-sections/renegotiation.rst
@@ -1,5 +1,5 @@
 Data Channel Renegotiation
---------------------------
+``````````````````````````

 When running OpenVPN in client/server mode, the data channel will use a
 separate ephemeral encryption key which is rotated at regular intervals.
diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-option=
s.rst
index 460cecf..de74c0d 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -1,5 +1,5 @@
 TLS Mode Options
-----------------
+````````````````

 TLS mode is the most powerful crypto mode of OpenVPN in both security
 and flexibility. TLS mode works by establishing control and data

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/527?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib5a7f9a978bda5ad58830e43580232660401f66d
Gerrit-Change-Number: 527
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--IdzcypE1Qkw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/527?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">documentation: make section levels consistent<=
br><br>Previously the sections &quot;Encryption Options&quot; and<br>&quot;=
Data channel cipher negotiation&quot; were on the same<br>level as &quot;OP=
TIONS&quot;, which makes no sense. Instead<br>move them and their subsectio=
ns one level down.<br><br>Use ` since that was already in use in section<br=
>&quot;Virtual Routing and Forwarding&quot;.<br><br>Change-Id: Ib5a7f9a978b=
da5ad58830e43580232660401f66d<br>Signed-off-by: Frank Lichtenheld &lt;frank=
@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<b=
r>Message-Id: &lt;20240325071520.12513-1-gert@...1296...&gt;<br>URL: https:=
//www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28453.html<br=
>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M doc/man-se=
ctions/cipher-negotiation.rst<br>M doc/man-sections/encryption-options.rst<=
br>M doc/man-sections/pkcs11-options.rst<br>M doc/man-sections/renegotiatio=
n.rst<br>M doc/man-sections/tls-options.rst<br>5 files changed, 14 insertio=
ns(+), 14 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/doc/man-sections/cipher-negotiation.rst b/doc/man-sections/=
cipher-negotiation.rst</span><br><span>index 949ff86..1285e82 100644</span>=
<br><span>--- a/doc/man-sections/cipher-negotiation.rst</span><br><span>+++=
 b/doc/man-sections/cipher-negotiation.rst</span><br><span>@@ -1,12 +1,12 @=
@</span><br><span> Data channel cipher negotiation</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+-------------------------------</span><br><spa=
n> </span><br><span> OpenVPN 2.4 and higher have the capability to negotiat=
e the data cipher that</span><br><span> is used to encrypt data packets. Th=
is section describes the mechanism in more detail and the</span><br><span> =
different backwards compatibility mechanism with older server and clients.<=
/span><br><span> </span><br><span> OpenVPN 2.5 and later behaviour</span><b=
r><span>---------------------------------</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+```````````````````````````````</span><br><span> When=
 both client and server are at least running OpenVPN 2.5, that the order of=
</span><br><span> the ciphers of the server&#39;s ``--data-ciphers`` is use=
d to pick the data cipher.</span><br><span> That means that the first ciphe=
r in that list that is also in the client&#39;s</span><br><span>@@ -25,7 +2=
5,7 @@</span><br><span> ``--cipher`` option to this list.</span><br><span> =
</span><br><span> OpenVPN 2.4 clients</span><br><span>--------------------<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+```````````````````<=
/span><br><span> The negotiation support in OpenVPN 2.4 was the first itera=
tion of the implementation</span><br><span> and still had some quirks. Its =
main goal was &quot;upgrade to AES-256-GCM when possible&quot;.</span><br><=
span> An OpenVPN 2.4 client that is built against a crypto library that sup=
ports AES in GCM</span><br><span>@@ -40,7 +40,7 @@</span><br><span> options=
 to avoid this behaviour.</span><br><span> </span><br><span> OpenVPN 3 clie=
nts</span><br><span>------------------</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+`````````````````</span><br><span> Clients based on the =
OpenVPN 3.x library (https://github.com/openvpn/openvpn3/)</span><br><span>=
 do not have a configurable ``--ncp-ciphers`` or ``--data-ciphers`` option.=
 Newer</span><br><span> versions by default disable legacy AES-CBC, BF-CBC,=
 and DES-CBC ciphers.</span><br><span>@@ -52,7 +52,7 @@</span><br><span> </=
span><br><span> </span><br><span> OpenVPN 2.3 and older clients (and client=
s with ``--ncp-disable``)</span><br><span>---------------------------------=
----------------------------------</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+````````````````````````````````````````````````````````````=
``````</span><br><span> When a client without cipher negotiation support co=
nnects to a server the</span><br><span> cipher specified with the ``--ciphe=
r`` option in the client configuration</span><br><span> must be included in=
 the ``--data-ciphers`` option of the server to allow</span><br><span>@@ -6=
5,7 +65,7 @@</span><br><span> cipher used by the client is necessary.</span=
><br><span> </span><br><span> OpenVPN 2.4 server</span><br><span>----------=
---------</span><br><span style=3D"color: hsl(120, 100%, 40%);">+``````````=
````````</span><br><span> When a client indicates support for `AES-128-GCM`=
 and `AES-256-GCM`</span><br><span> (with ``IV_NCP=3D2``) an OpenVPN 2.4 se=
rver will send the first</span><br><span> cipher of the ``--ncp-ciphers`` t=
o the OpenVPN client regardless of what</span><br><span>@@ -76,7 +76,7 @@</=
span><br><span> those ciphers are present.</span><br><span> </span><br><spa=
n> OpenVPN 2.3 and older servers (and servers with ``--ncp-disable``)</span=
><br><span>----------------------------------------------------------------=
---</span><br><span style=3D"color: hsl(120, 100%, 40%);">+````````````````=
``````````````````````````````````````````````````</span><br><span> The cip=
her used by the server must be included in ``--data-ciphers`` to</span><br>=
<span> allow the client connecting to a server without cipher negotiation</=
span><br><span> support.</span><br><span>@@ -89,7 +89,7 @@</span><br><span>=
 cipher used by the server is necessary.</span><br><span> </span><br><span>=
 Blowfish in CBC mode (BF-CBC) deprecation</span><br><span>----------------=
---------------------------</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+`````````````````````````````````````````</span><br><span> The ``--=
cipher`` option defaulted to `BF-CBC` in OpenVPN 2.4 and older</span><br><s=
pan> version. The default was never changed to ensure backwards compatibili=
ty.</span><br><span> In OpenVPN 2.5 this behaviour has now been changed so =
that if the ``--cipher``</span><br><span>diff --git a/doc/man-sections/encr=
yption-options.rst b/doc/man-sections/encryption-options.rst</span><br><spa=
n>index 3b26782..49385d6 100644</span><br><span>--- a/doc/man-sections/encr=
yption-options.rst</span><br><span>+++ b/doc/man-sections/encryption-option=
s.rst</span><br><span>@@ -1,8 +1,8 @@</span><br><span> Encryption Options</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+------------------</span><br><span> </span><br><span> SSL Lib=
rary information</span><br><span>------------------------</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+```````````````````````</span><br><sp=
an> </span><br><span> --show-ciphers</span><br><span>   (Standalone) Show a=
ll cipher algorithms to use with the ``--cipher``</span><br><span>@@ -32,7 =
+32,7 @@</span><br><span>   ``--ecdh-curve`` and ``tls-groups`` options.</s=
pan><br><span> </span><br><span> Generating key material</span><br><span>--=
----------------------</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+```````````````````````</span><br><span> </span><br><span> --genkey args=
</span><br><span>   (Standalone) Generate a key to be used of the type keyt=
ype. if keyfile</span><br><span>diff --git a/doc/man-sections/pkcs11-option=
s.rst b/doc/man-sections/pkcs11-options.rst</span><br><span>index de1662b..=
dfc27af 100644</span><br><span>--- a/doc/man-sections/pkcs11-options.rst</s=
pan><br><span>+++ b/doc/man-sections/pkcs11-options.rst</span><br><span>@@ =
-1,5 +1,5 @@</span><br><span> PKCS#11 / SmartCard options</span><br><span>-=
---------------------------</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+```````````````````````````</span><br><span> </span><br><span> --pk=
cs11-cert-private args</span><br><span>   Set if access to certificate obje=
ct should be performed after login.</span><br><span>diff --git a/doc/man-se=
ctions/renegotiation.rst b/doc/man-sections/renegotiation.rst</span><br><sp=
an>index c548440..1e7c340 100644</span><br><span>--- a/doc/man-sections/ren=
egotiation.rst</span><br><span>+++ b/doc/man-sections/renegotiation.rst</sp=
an><br><span>@@ -1,5 +1,5 @@</span><br><span> Data Channel Renegotiation</s=
pan><br><span>---------------------------</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+``````````````````````````</span><br><span> </span><b=
r><span> When running OpenVPN in client/server mode, the data channel will =
use a</span><br><span> separate ephemeral encryption key which is rotated a=
t regular intervals.</span><br><span>diff --git a/doc/man-sections/tls-opti=
ons.rst b/doc/man-sections/tls-options.rst</span><br><span>index 460cecf..d=
e74c0d 100644</span><br><span>--- a/doc/man-sections/tls-options.rst</span>=
<br><span>+++ b/doc/man-sections/tls-options.rst</span><br><span>@@ -1,5 +1=
,5 @@</span><br><span> TLS Mode Options</span><br><span>-----------------</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+````````````````</spa=
n><br><span> </span><br><span> TLS mode is the most powerful crypto mode of=
 OpenVPN in both security</span><br><span> and flexibility. TLS mode works =
by establishing control and data</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/527?usp=3Demail">=
change 527</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/527?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib5a7f9a978bda5ad58830e43580=
232660401f66d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 527 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--IdzcypE1Qkw=--

