From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 10 Dec 2025 09:19:23 +0000
In-Reply-To: <gerrit.1765292004000.I1d1851eaebe8bf66c92dac3c8c10f68b1ec3ef33@...2715...>
References: <gerrit.1765292004000.I1d1851eaebe8bf66c92dac3c8c10f68b1ec3ef33@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <56aed7e486288cc05db3a896531d972e7ea5ce8c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0p2RSCHqIqw="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Correct
 documentation for --ns-cert-type
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

--0p2RSCHqIqw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
28?usp=3Demail )

Change subject: Correct documentation for --ns-cert-type
......................................................................

Correct documentation for --ns-cert-type

Our documentation claimed this option was removed.
But it was not, for compatiblity reasons. So reflect
the correct status.

Change-Id: I1d1851eaebe8bf66c92dac3c8c10f68b1ec3ef33
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1428
Message-Id: <20251210085625.32174-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
984.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/tls-options.rst
M doc/man-sections/unsupported-options.rst
2 files changed, 11 insertions(+), 6 deletions(-)




diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-option=
s.rst
index 846dfdd..c4aa810 100644
--- a/doc/man-sections/tls-options.rst
+++ b/doc/man-sections/tls-options.rst
@@ -222,6 +222,17 @@
   ``--cert file`` above). URI is supported only when built with OpenSSL 3.0
   or later and any required providers are loaded. (See ``--cert`` for more=
 details).

+--ns-cert-type type
+  **DEPRECATED** The ``--remote-cert-tls`` option should be used instead.
+  The option is still available since it can't be silently ignored and nee=
ds
+  updates to certificates and configs on both sides of the connection.
+  However it should not be used for new clients or servers. It depends on =
the
+  deprecated ``nsCertType`` certificate field.
+
+  Might not work depending on the TLS library used.
+
+  Will be removed in a future release.
+
 --pkcs12 file
   Specify a PKCS #12 file containing local private key, local certificate,
   and root CA certificate. This option can be used instead of ``--ca``,
diff --git a/doc/man-sections/unsupported-options.rst b/doc/man-sections/un=
supported-options.rst
index 6e77333..b646991 100644
--- a/doc/man-sections/unsupported-options.rst
+++ b/doc/man-sections/unsupported-options.rst
@@ -44,12 +44,6 @@
   VPN tunnel security.  Previously we claimed to have removed this in
   OpenVPN 2.5, but this wasn't actually the case.

---ns-cert-type
-  Removed in OpenVPN 2.5.  The ``nsCertType`` field is no longer supported
-  in recent SSL/TLS libraries.  If your certificates does not include *key
-  usage* and *extended key usage* fields, they must be upgraded and the
-  ``--remote-cert-tls`` option should be used instead.
-
 --prng
   Removed in OpenVPN 2.6.  We now always use the PRNG of the SSL library.


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1428?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1d1851eaebe8bf66c92dac3c8c10f68b1ec3ef33
Gerrit-Change-Number: 1428
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0p2RSCHqIqw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1428?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Correct documentation for --ns-cert-type<br><br>=
Our documentation claimed this option was removed.<br>But it was not, for c=
ompatiblity reasons. So reflect<br>the correct status.<br><br>Change-Id: I1=
d1851eaebe8bf66c92dac3c8c10f68b1ec3ef33<br>Signed-off-by: Frank Lichtenheld=
 &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;=
<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1428<br>Message-Id: =
&lt;20251210085625.32174-1-gert@...1296...&gt;<br>URL: https://www.mail-arc=
hive.com/openvpn-devel@lists.sourceforge.net/msg34984.html<br>Signed-off-by=
: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M doc/man-sections/tls-opt=
ions.rst<br>M doc/man-sections/unsupported-options.rst<br>2 files changed, =
11 insertions(+), 6 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-opt=
ions.rst</span><br><span>index 846dfdd..c4aa810 100644</span><br><span>--- =
a/doc/man-sections/tls-options.rst</span><br><span>+++ b/doc/man-sections/t=
ls-options.rst</span><br><span>@@ -222,6 +222,17 @@</span><br><span>   ``--=
cert file`` above). URI is supported only when built with OpenSSL 3.0</span=
><br><span>   or later and any required providers are loaded. (See ``--cert=
`` for more details).</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+--ns-cert-type type</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  **DEPRECATED** The ``--remote-cert-tls`` option shoul=
d be used instead.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 The option is still available since it can&#39;t be silently ignored and n=
eeds</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  updates to ce=
rtificates and configs on both sides of the connection.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  However it should not be used for new=
 clients or servers. It depends on the</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  deprecated ``nsCertType`` certificate field.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  Might not work depending on the TLS library us=
ed.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  Will be removed in a future relea=
se.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> --pkcs12 file</span><br><span>   Specify a PKCS #12 file containing local=
 private key, local certificate,</span><br><span>   and root CA certificate=
. This option can be used instead of ``--ca``,</span><br><span>diff --git a=
/doc/man-sections/unsupported-options.rst b/doc/man-sections/unsupported-op=
tions.rst</span><br><span>index 6e77333..b646991 100644</span><br><span>---=
 a/doc/man-sections/unsupported-options.rst</span><br><span>+++ b/doc/man-s=
ections/unsupported-options.rst</span><br><span>@@ -44,12 +44,6 @@</span><b=
r><span>   VPN tunnel security.  Previously we claimed to have removed this=
 in</span><br><span>   OpenVPN 2.5, but this wasn&#39;t actually the case.<=
/span><br><span> </span><br><span>---ns-cert-type</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-  Removed in OpenVPN 2.5.  The ``nsCertType`` f=
ield is no longer supported</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  in recent SSL/TLS libraries.  If your certificates does not include=
 *key</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  usage* and *ex=
tended key usage* fields, they must be upgraded and the</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-  ``--remote-cert-tls`` option should be =
used instead.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span> --prng</span><br><span>   Removed in OpenVPN 2.6.  We now always =
use the PRNG of the SSL library.</span><br><span> </span><br><span></span><=
br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1428?usp=3Demail">change 1428</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail"=
>settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage=
"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/14=
28?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1d1851eaebe8bf66c92dac3c8c1=
0f68b1ec3ef33 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1428 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--0p2RSCHqIqw=--

