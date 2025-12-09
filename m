From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 9 Dec 2025 14:53:26 +0000
References: <gerrit.1765292004000.I1d1851eaebe8bf66c92dac3c8c10f68b1ec3ef33@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <155e40a3918d395c24b4aa759ff98048be4890b9-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TScWd9kxLcw="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--TScWd9kxLcw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1428?usp=3Demail

to review the following change.


Change subject: Correct documentation for --ns-cert-type
......................................................................

Correct documentation for --ns-cert-type

Our documentation claimed this option was removed.
But it was not, for compatiblity reasons. So reflect
the correct status.

Change-Id: I1d1851eaebe8bf66c92dac3c8c10f68b1ec3ef33
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M doc/man-sections/tls-options.rst
M doc/man-sections/unsupported-options.rst
2 files changed, 11 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/28/1428/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1d1851eaebe8bf66c92dac3c8c10f68b1ec3ef33
Gerrit-Change-Number: 1428
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--TScWd9kxLcw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1428?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Correct documentation for --ns-cert-type<br=
><br>Our documentation claimed this option was removed.<br>But it was not, =
for compatiblity reasons. So reflect<br>the correct status.<br><br>Change-I=
d: I1d1851eaebe8bf66c92dac3c8c10f68b1ec3ef33<br>Signed-off-by: Frank Lichte=
nheld &lt;frank@...2641...&gt;<br>---<br>M doc/man-sections/tls-options.rst=
<br>M doc/man-sections/unsupported-options.rst<br>2 files changed, 11 inser=
tions(+), 6 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.o=
penvpn.net:29418/openvpn refs/changes/28/1428/1</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/ma=
n-sections/tls-options.rst b/doc/man-sections/tls-options.rst</span><br><sp=
an>index 846dfdd..c4aa810 100644</span><br><span>--- a/doc/man-sections/tls=
-options.rst</span><br><span>+++ b/doc/man-sections/tls-options.rst</span><=
br><span>@@ -222,6 +222,17 @@</span><br><span>   ``--cert file`` above). UR=
I is supported only when built with OpenSSL 3.0</span><br><span>   or later=
 and any required providers are loaded. (See ``--cert`` for more details).<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+--=
ns-cert-type type</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
**DEPRECATED** The ``--remote-cert-tls`` option should be used instead.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  The option is still a=
vailable since it can&#39;t be silently ignored and needs</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  updates to certificates and configs=
 on both sides of the connection.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  However it should not be used for new clients or servers. I=
t depends on the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  d=
eprecated ``nsCertType`` certificate field.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  Might not work depending on the TLS library used.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  Will be removed in a future release.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --pkcs12 file</span>=
<br><span>   Specify a PKCS #12 file containing local private key, local ce=
rtificate,</span><br><span>   and root CA certificate. This option can be u=
sed instead of ``--ca``,</span><br><span>diff --git a/doc/man-sections/unsu=
pported-options.rst b/doc/man-sections/unsupported-options.rst</span><br><s=
pan>index 6e77333..b646991 100644</span><br><span>--- a/doc/man-sections/un=
supported-options.rst</span><br><span>+++ b/doc/man-sections/unsupported-op=
tions.rst</span><br><span>@@ -44,12 +44,6 @@</span><br><span>   VPN tunnel =
security.  Previously we claimed to have removed this in</span><br><span>  =
 OpenVPN 2.5, but this wasn&#39;t actually the case.</span><br><span> </spa=
n><br><span>---ns-cert-type</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-  Removed in OpenVPN 2.5.  The ``nsCertType`` field is no longer supp=
orted</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  in recent SSL/=
TLS libraries.  If your certificates does not include *key</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  usage* and *extended key usage* fiel=
ds, they must be upgraded and the</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  ``--remote-cert-tls`` option should be used instead.</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> --prng</span=
><br><span>   Removed in OpenVPN 2.6.  We now always use the PRNG of the SS=
L library.</span><br><span> </span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1428?usp=3Demail">cha=
nge 1428</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1428?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1d1851eaebe8bf66c92dac3c8c1=
0f68b1ec3ef33 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1428 </div>
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

--TScWd9kxLcw=--

