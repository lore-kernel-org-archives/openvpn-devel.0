From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 19 May 2025 09:52:26 +0000
In-Reply-To: <gerrit.1745405723000.Ica02244c9f0ac9b4690a51f940fda9d900465289@...2715...>
References: <gerrit.1745405723000.Ica02244c9f0ac9b4690a51f940fda9d900465289@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1c07b0f6517e687e62b52db9dfddf9ce135bbdc8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jKOofxTeaKE="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--jKOofxTeaKE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/94=
5?usp=3Demail )

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
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250518220245.24489-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
695.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M Changes.rst
M doc/man-sections/tls-options.rst
M src/openvpn/options.c
3 files changed, 19 insertions(+), 10 deletions(-)




diff --git a/Changes.rst b/Changes.rst
index a4f5e57..e297334 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -103,6 +103,11 @@
 - ``--x509-username-field`` will no longer automatically convert fieldname=
s to
   uppercase. This is deprecated since OpenVPN 2.4, and has now been remove=
d.

+- ``--dh none`` is now the default if ``--dh`` is not specified. Modern TLS
+  implementations will prefer ECDH and other more modern algorithms anyway.
+  And finite field Diffie Hellman is in the proces of being deprecated
+  (see draft-ietf-tls-deprecate-obsolete-kex)
+
 Overview of changes in 2.6
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-option=
s.rst
index 0638d09..db107e6 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -171,16 +171,22 @@


 --dh file
-  File containing Diffie Hellman parameters in .pem format (required for
-  ``--tls-server`` only).
+  File containing finite field Diffie Hellman parameters in .pem format (u=
sed
+  by ``--tls-server`` only).

-  Set ``file`` to :code:`none` to disable Diffie Hellman key exchange (and
-  use ECDH only). Note that this requires peers to be using an SSL library
-  that supports ECDH TLS cipher suites (e.g. OpenSSL 1.0.1+, or
-  mbed TLS 2.0+).
+  Set ``file`` to :code:`none` to disable fine field Diffie Hellman
+  key exchange (and to only use ECDH or newer hybrid key agreement algorit=
hms
+  like X25519MLKEM768 instead).
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
index 810bb56..6672b5c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3703,8 +3703,6 @@

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
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--jKOofxTeaKE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/945?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Make --dh none behaviour default if not specif=
ied<br><br>Nowadays ciphers that are using still DH and not ECDH are rarely=
 chosen<br>as best cipher suite. Our man page even indicates that OpenSSL 1=
.0.1+<br>supports ECDH cipher suites. So it does not feel useful to force<b=
r>specifying --dh anymore.<br><br>Side note: Custom generated Diffie Hellma=
nn parameters are also<br>discouraged nowadays. The newest OpenSSL FIPS lib=
raries even flat<br>out reject them:<br><br>   FIPS 186-4 type domain param=
eters no longer allowed in FIPS mode,<br>   since the required validation r=
outines were removed from FIPS 186-5<br><br>But instead of adding support f=
or loading the well-known curve just make<br>dh none the default and the re=
commended option as finite field Diffie<br>Hellmann is being deprecated any=
way<br>(https://datatracker.ietf.org/doc/draft-ietf-tls-deprecate-obsolete-=
kex/)<br>and not supported by TLS 1.3 at all.<br><br>Change-Id: Ica02244c9f=
0ac9b4690a51f940fda9d900465289<br>Signed-off-by: Arne Schwabe &lt;arne-open=
vpn@...1227...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Mes=
sage-Id: &lt;20250518220245.24489-1-gert@...1296...&gt;<br>URL: https://www=
.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31695.html<br>Sign=
ed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M Changes.rst<br>=
M doc/man-sections/tls-options.rst<br>M src/openvpn/options.c<br>3 files ch=
anged, 19 insertions(+), 10 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/Changes.rst b/Changes.rst</span><br><span>index a4f5e57..e2=
97334 100644</span><br><span>--- a/Changes.rst</span><br><span>+++ b/Change=
s.rst</span><br><span>@@ -103,6 +103,11 @@</span><br><span> - ``--x509-user=
name-field`` will no longer automatically convert fieldnames to</span><br><=
span>   uppercase. This is deprecated since OpenVPN 2.4, and has now been r=
emoved.</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+- ``--dh none`` is now the default if ``--dh`` is not specified. Mode=
rn TLS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  implementat=
ions will prefer ECDH and other more modern algorithms anyway.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  And finite field Diffie Hellma=
n is in the proces of being deprecated</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  (see draft-ietf-tls-deprecate-obsolete-kex)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> Overview of =
changes in 2.6</span><br><span> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span> </span><br><span>diff=
 --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rs=
t</span><br><span>index 0638d09..db107e6 100644</span><br><span>--- a/doc/m=
an-sections/tls-options.rst</span><br><span>+++ b/doc/man-sections/tls-opti=
ons.rst</span><br><span>@@ -171,16 +171,22 @@</span><br><span> </span><br><=
span> </span><br><span> --dh file</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  File containing Diffie Hellman parameters in .pem format (req=
uired for</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``--tls-se=
rver`` only).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  File=
 containing finite field Diffie Hellman parameters in .pem format (used</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  by ``--tls-server`` o=
nly).</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-  Set ``file`` to :code:`none` to disable Diffie Hellman key exchange (an=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  use ECDH only). No=
te that this requires peers to be using an SSL library</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-  that supports ECDH TLS cipher suites (e.=
g. OpenSSL 1.0.1+, or</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  mbed TLS 2.0+).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
Set ``file`` to :code:`none` to disable fine field Diffie Hellman</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  key exchange (and to only u=
se ECDH or newer hybrid key agreement algorithms</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  like X25519MLKEM768 instead).</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  Note that this requires peers to=
 be using an SSL library that supports</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  ECDH TLS cipher suites (e.g. OpenSSL 1.0.1+, or mbed T=
LS 2.0+). Starting</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 with 2.7.0, this is the same as not specifying ``--dh`` at all.</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Use ``openss=
l dhparam -out dh2048.pem 2048`` to generate 2048-bit DH</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  parameters. Diffie Hellman parameters =
may be considered public.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  Diffie Hellman parameters can be generated using</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  ``openssl dhparam -out dh2048.pem 20=
48`` but it is recommended to</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  use ``none`` as finite field Diffie Hellman have been replaced<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  by more modern var=
iants like ECDH.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  Diffie Hellman param=
eters may be considered public.</span><br><span> </span><br><span> --ecdh-c=
urve name</span><br><span>   Specify the curve to use for elliptic curve Di=
ffie Hellman. Available</span><br><span>diff --git a/src/openvpn/options.c =
b/src/openvpn/options.c</span><br><span>index 810bb56..6672b5c 100644</span=
><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/op=
tions.c</span><br><span>@@ -3703,8 +3703,6 @@</span><br><span> </span><br><=
span>     if (o-&gt;tls_server)</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        /* Check that DH file is specified=
, or explicitly disabled */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        notnull(o-&gt;dh_file, &quot;DH file (--dh)&quot;);</span><br=
><span>         if (streq(o-&gt;dh_file, &quot;none&quot;))</span><br><span=
>         {</span><br><span>             o-&gt;dh_file =3D NULL;</span><br>=
<span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/945?usp=3Demail">change 945</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings"=
>settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage=
"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/94=
5?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ica02244c9f0ac9b4690a51f940f=
da9d900465289 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 945 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--jKOofxTeaKE=--

