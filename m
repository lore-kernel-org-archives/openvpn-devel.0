From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 2 May 2025 12:54:43 +0000
In-Reply-To: <gerrit.1745405723000.Ica02244c9f0ac9b4690a51f940fda9d900465289@...2715...>
References: <gerrit.1745405723000.Ica02244c9f0ac9b4690a51f940fda9d900465289@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <d3265f4f08e369d2d81b52e715c18a5081263429-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="C6+hwFCd9rg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Make --dh none
 behaviour default if not specified
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

--C6+hwFCd9rg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/945?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: Make --dh none behaviour default if not specified
......................................................................

Make --dh none behaviour default if not specified

Nowadays ciphers that are using still DH and not ECDH are rarely chosen
as best cipher suite. Our man page even indicates that OpenSSL 1.0.1+
supports ECDH cipher suites. So it does not feel useful to force
specifying --dh anymore.

Side note: Custom generated Diffie Hellmann parameters are also
discouraged nowadays. The newest OpenSSL FIPS libraries even flat
out reject them:

   FIPS 186-4 type domain parameters no longer allowed in FIPS mode,
   since the required validation routines were removed from FIPS 186-5

But instead of adding support for loading the well-known curve just make
dh none the default and the recommended option as finite field Diffie
Hellmann is being deprecated anyway
(https://datatracker.ietf.org/doc/draft-ietf-tls-deprecate-obsolete-kex/)
and not supported by TLS 1.3 at all.

Change-Id: Ica02244c9f0ac9b4690a51f940fda9d900465289
---
M Changes.rst
M doc/man-sections/tls-options.rst
M src/openvpn/options.c
3 files changed, 17 insertions(+), 9 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/45/945/3

diff --git a/Changes.rst b/Changes.rst
index a4f5e57..0b0bbeb 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -103,6 +103,11 @@
 - ``--x509-username-field`` will no longer automatically convert fieldname=
s to
   uppercase. This is deprecated since OpenVPN 2.4, and has now been remove=
d.

+- ``--dh none`` is now the default if ``--dh`` is specified. Modern TLS
+  implementations will prefer ECDH and other more modern algorithm anyway.
+  And finite field Diffie Hellman is in the proces of being deprecated
+  (see draft-ietf-tls-deprecate-obsolete-kex)
+
 Overview of changes in 2.6
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-option=
s.rst
index 0638d09..1ce6424 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -171,16 +171,21 @@


 --dh file
-  File containing Diffie Hellman parameters in .pem format (required for
-  ``--tls-server`` only).
+  File containing finite field Diffie Hellman parameters in .pem format (u=
sed
+  by ``--tls-server`` only).

   Set ``file`` to :code:`none` to disable Diffie Hellman key exchange (and
-  use ECDH only). Note that this requires peers to be using an SSL library
-  that supports ECDH TLS cipher suites (e.g. OpenSSL 1.0.1+, or
-  mbed TLS 2.0+).
+  use ECDH or newer hybrid key agreement algorithms like X25519MLKEM768).
+  Note that this requires peers to be using an SSL library that supports
+  ECDH TLS cipher suites (e.g. OpenSSL 1.0.1+, or mbed TLS 2.0+). Starting
+  with 2.7.0, this is the same as not specifying ``--dh`` at all.

-  Use ``openssl dhparam -out dh2048.pem 2048`` to generate 2048-bit DH
-  parameters. Diffie Hellman parameters may be considered public.
+  Diffie Hellman parameters can be generated using
+  ``openssl dhparam -out dh2048.pem 2048`` but it is recommended to
+  use ``none`` as finite field Diffie Hellman have been replaced
+  by more modern variants like ECDH.
+
+  Diffie Hellman parameters may be considered public.

 --ecdh-curve name
   Specify the curve to use for elliptic curve Diffie Hellman. Available
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 96119c4..f84d5f3 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3711,8 +3711,6 @@

     if (o->tls_server)
     {
-        /* Check that DH file is specified, or explicitly disabled */
-        notnull(o->dh_file, "DH file (--dh)");
         if (streq(o->dh_file, "none"))
         {
             o->dh_file =3D NULL;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/945?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ica02244c9f0ac9b4690a51f940fda9d900465289
Gerrit-Change-Number: 945
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--C6+hwFCd9rg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/945?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Make --dh none behaviour default if not speci=
fied<br><br>Nowadays ciphers that are using still DH and not ECDH are rarel=
y chosen<br>as best cipher suite. Our man page even indicates that OpenSSL =
1.0.1+<br>supports ECDH cipher suites. So it does not feel useful to force<=
br>specifying --dh anymore.<br><br>Side note: Custom generated Diffie Hellm=
ann parameters are also<br>discouraged nowadays. The newest OpenSSL FIPS li=
braries even flat<br>out reject them:<br><br>   FIPS 186-4 type domain para=
meters no longer allowed in FIPS mode,<br>   since the required validation =
routines were removed from FIPS 186-5<br><br>But instead of adding support =
for loading the well-known curve just make<br>dh none the default and the r=
ecommended option as finite field Diffie<br>Hellmann is being deprecated an=
yway<br>(https://datatracker.ietf.org/doc/draft-ietf-tls-deprecate-obsolete=
-kex/)<br>and not supported by TLS 1.3 at all.<br><br>Change-Id: Ica02244c9=
f0ac9b4690a51f940fda9d900465289<br>---<br>M Changes.rst<br>M doc/man-sectio=
ns/tls-options.rst<br>M src/openvpn/options.c<br>3 files changed, 17 insert=
ions(+), 9 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/o=
penvpn refs/changes/45/945/3</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/Changes.rst b/Changes.rst=
</span><br><span>index a4f5e57..0b0bbeb 100644</span><br><span>--- a/Change=
s.rst</span><br><span>+++ b/Changes.rst</span><br><span>@@ -103,6 +103,11 @=
@</span><br><span> - ``--x509-username-field`` will no longer automatically=
 convert fieldnames to</span><br><span>   uppercase. This is deprecated sin=
ce OpenVPN 2.4, and has now been removed.</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+- ``--dh none`` is now the default =
if ``--dh`` is specified. Modern TLS</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  implementations will prefer ECDH and other more modern a=
lgorithm anyway.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  A=
nd finite field Diffie Hellman is in the proces of being deprecated</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  (see draft-ietf-tls-depre=
cate-obsolete-kex)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> Overview of changes in 2.6</span><br><span> =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><b=
r><span> </span><br><span>diff --git a/doc/man-sections/tls-options.rst b/d=
oc/man-sections/tls-options.rst</span><br><span>index 0638d09..1ce6424 1006=
44</span><br><span>--- a/doc/man-sections/tls-options.rst</span><br><span>+=
++ b/doc/man-sections/tls-options.rst</span><br><span>@@ -171,16 +171,21 @@=
</span><br><span> </span><br><span> </span><br><span> --dh file</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  File containing Diffie Hellman =
parameters in .pem format (required for</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-  ``--tls-server`` only).</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  File containing finite field Diffie Hellman param=
eters in .pem format (used</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  by ``--tls-server`` only).</span><br><span> </span><br><span>   Se=
t ``file`` to :code:`none` to disable Diffie Hellman key exchange (and</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-  use ECDH only). Note tha=
t this requires peers to be using an SSL library</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-  that supports ECDH TLS cipher suites (e.g. Ope=
nSSL 1.0.1+, or</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  mbed=
 TLS 2.0+).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  use EC=
DH or newer hybrid key agreement algorithms like X25519MLKEM768).</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  Note that this requires pee=
rs to be using an SSL library that supports</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  ECDH TLS cipher suites (e.g. OpenSSL 1.0.1+, or m=
bed TLS 2.0+). Starting</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  with 2.7.0, this is the same as not specifying ``--dh`` at all.</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Use ``o=
penssl dhparam -out dh2048.pem 2048`` to generate 2048-bit DH</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  parameters. Diffie Hellman parame=
ters may be considered public.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  Diffie Hellman parameters can be generated using</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  ``openssl dhparam -out dh2048.p=
em 2048`` but it is recommended to</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  use ``none`` as finite field Diffie Hellman have been repl=
aced</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  by more moder=
n variants like ECDH.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Diffie Hellman =
parameters may be considered public.</span><br><span> </span><br><span> --e=
cdh-curve name</span><br><span>   Specify the curve to use for elliptic cur=
ve Diffie Hellman. Available</span><br><span>diff --git a/src/openvpn/optio=
ns.c b/src/openvpn/options.c</span><br><span>index 96119c4..f84d5f3 100644<=
/span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openv=
pn/options.c</span><br><span>@@ -3711,8 +3711,6 @@</span><br><span> </span>=
<br><span>     if (o-&gt;tls_server)</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        /* Check that DH file is spec=
ified, or explicitly disabled */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        notnull(o-&gt;dh_file, &quot;DH file (--dh)&quot;);</spa=
n><br><span>         if (streq(o-&gt;dh_file, &quot;none&quot;))</span><br>=
<span>         {</span><br><span>             o-&gt;dh_file =3D NULL;</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/945?usp=3Demail">change 945</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/945?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ica02244c9f0ac9b4690a51f940f=
da9d900465289 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 945 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--C6+hwFCd9rg=--

