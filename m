From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 19 Nov 2025 13:31:39 +0000
In-Reply-To: <gerrit.1762900407000.I032a573df6deaa44b4afce3c2d2fd54f69df6e7a@...2715...>
References: <gerrit.1762900407000.I032a573df6deaa44b4afce3c2d2fd54f69df6e7a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <ffcd901095ac45f37652cd3726372eba3a5aa1f1-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="g27uqHwhFYk="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]:
 vcpkg-ports/pkcs11-helper: bump version to 1.31
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selvanair <selva.nair@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--g27uqHwhFYk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
68?usp=3Demail )

Change subject: vcpkg-ports/pkcs11-helper: bump version to 1.31
......................................................................

vcpkg-ports/pkcs11-helper: bump version to 1.31

RFC7512 patch for pkcs11-uri is rebased to current master,
fixing minor conflicts.

Change-Id: I032a573df6deaa44b4afce3c2d2fd54f69df6e7a
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1368
Message-Id: <20251119110231.13999-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
527.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch
M contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
M contrib/vcpkg-ports/pkcs11-helper/vcpkg.json
3 files changed, 15 insertions(+), 16 deletions(-)




diff --git a/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.pa=
tch b/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch
index 56e3486..65b159c 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch
+++ b/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch
@@ -1,5 +1,7 @@
 upstream PR: https://github.com/OpenSC/pkcs11-helper/pull/4

+Rebased to 1.31.0 by selva.nair@...277...
+
 commit 90590b02085edc3830bdfe0942a46c4e7bf3f1ab (HEAD -> master)
 Author: David Woodhouse <David.Woodhouse@...753...>
 Date:   Thu Apr 30 14:58:24 2015 +0100
@@ -596,9 +598,9 @@
 +	}
 +	certificate_id->attrCKA_ID_size =3D id_hex_len/2;

- 	if (
- 		(rv =3D _pkcs11h_mem_malloc (
-@@ -430,21 +596,64 @@ pkcs11h_certificate_deserializeCertificateId (
+ 	if (certificate_id->attrCKA_ID_size =3D=3D 0) {
+ 		rv =3D CKR_ATTRIBUTE_VALUE_INVALID;
+@@ -434,21 +600,64 @@ pkcs11h_certificate_deserializeCertificateId (
  		goto cleanup;
  	}

@@ -669,20 +671,17 @@
  		PKCS11H_LOG_DEBUG2,
  		"PKCS#11: pkcs11h_certificate_deserializeCertificateId return rv=3D%lu-=
'%s'",
 diff --git a/lib/pkcs11h-util.c b/lib/pkcs11h-util.c
-index 0743fd1..f90e443 100644
+index 1fcadfc..a304642 100644
 --- a/lib/pkcs11h-util.c
 +++ b/lib/pkcs11h-util.c
-@@ -110,12 +110,7 @@ _pkcs11h_util_hexToBinary (
- 		p++;
+@@ -123,10 +123,6 @@ _pkcs11h_util_hexToBinary (
+ 		(*p_target_size)++;
  	}

 -	if (*p !=3D '\x0') {
--		return CKR_ATTRIBUTE_VALUE_INVALID;
+-		goto cleanup;
 -	}
--	else {
--		return CKR_OK;
--	}
-+	return CKR_OK;
- }
+-
+ 	ret =3D CKR_OK;

- CK_RV
+ cleanup:
diff --git a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake b/contrib/vcp=
kg-ports/pkcs11-helper/portfile.cmake
index db9a5ab..af19831 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
+++ b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
@@ -1,9 +1,9 @@
-set(VERSION 1.30.0)
+set(VERSION 1.31.0)

 vcpkg_download_distfile(ARCHIVE
     URLS "https://github.com/OpenSC/pkcs11-helper/releases/download/pkcs11=
-helper-${VERSION}/pkcs11-helper-${VERSION}.tar.bz2"
     FILENAME "pkcs11-helper-${VERSION}.tar.bz2"
-    SHA512 19fba76e41210cc17f9efa4501d0214d4a5c777ab7b2671888fd280b150bae4=
a6b190c7f47fb783015f9aa40d409fd6087264e531d6f28d0bed4293dcbf8bdd5
+    SHA512 0833efc59e9093dd398a54640d858b01a830ef7adfb40321c1e0ed0afa00450=
0fc1259cc66bc49c5263935adeda0a3bfe658de538eefd66888685a71f731c484
 )

 vcpkg_extract_source_archive_ex(
diff --git a/contrib/vcpkg-ports/pkcs11-helper/vcpkg.json b/contrib/vcpkg-p=
orts/pkcs11-helper/vcpkg.json
index 521f754..382a3d3 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/vcpkg.json
+++ b/contrib/vcpkg-ports/pkcs11-helper/vcpkg.json
@@ -1,6 +1,6 @@
 {
     "name": "pkcs11-helper",
-    "version": "1.30.0",
+    "version": "1.31.0",
     "description": "pkcs11-helper is a library that simplifies the interac=
tion with PKCS#11 providers for end-user applications.",
     "homepage": "https://github.com/OpenSC/pkcs11-helper",
     "license": "BSD-3-Clause OR GPL-2.0-only"

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1368?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I032a573df6deaa44b4afce3c2d2fd54f69df6e7a
Gerrit-Change-Number: 1368
Gerrit-PatchSet: 3
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--g27uqHwhFYk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1368?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">vcpkg-ports/pkcs11-helper: bump version to 1.31<=
br><br>RFC7512 patch for pkcs11-uri is rebased to current master,<br>fixing=
 minor conflicts.<br><br>Change-Id: I032a573df6deaa44b4afce3c2d2fd54f69df6e=
7a<br>Signed-off-by: Selva Nair &lt;selva.nair@...277...&gt;<br>Acked-by: F=
rank Lichtenheld &lt;frank@...2641...&gt;<br>Gerrit URL: https://gerrit.ope=
nvpn.net/c/openvpn/+/1368<br>Message-Id: &lt;20251119110231.13999-1-gert@...1186...=
.1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1011...=
eforge.net/msg34527.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...=
&gt;<br>---<br>M contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC751=
2.patch<br>M contrib/vcpkg-ports/pkcs11-helper/portfile.cmake<br>M contrib/=
vcpkg-ports/pkcs11-helper/vcpkg.json<br>3 files changed, 15 insertions(+), =
16 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512=
.patch b/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch<=
/span><br><span>index 56e3486..65b159c 100644</span><br><span>--- a/contrib=
/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch</span><br><span>=
+++ b/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch</sp=
an><br><span>@@ -1,5 +1,7 @@</span><br><span> upstream PR: https://github.c=
om/OpenSC/pkcs11-helper/pull/4</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+Rebased to 1.31.0 by selva.nair@...277...</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> commit=
 90590b02085edc3830bdfe0942a46c4e7bf3f1ab (HEAD -&gt; master)</span><br><sp=
an> Author: David Woodhouse &lt;David.Woodhouse@...753...&gt;</span><br><sp=
an> Date:   Thu Apr 30 14:58:24 2015 +0100</span><br><span>@@ -596,9 +598,9=
 @@</span><br><span> +	}</span><br><span> +	certificate_id-&gt;attrCKA_ID_s=
ize =3D id_hex_len/2;</span><br><span>  </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- 	if (</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- 		(rv =3D _pkcs11h_mem_malloc (</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-@@ -430,21 +596,64 @@ pkcs11h_certificate_deserializeCertifi=
cateId (</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ 	if (certi=
ficate_id-&gt;attrCKA_ID_size =3D=3D 0) {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ 		rv =3D CKR_ATTRIBUTE_VALUE_INVALID;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+@@ -434,21 +600,64 @@ pkcs11h_cert=
ificate_deserializeCertificateId (</span><br><span>  		goto cleanup;</span>=
<br><span>  	}</span><br><span>  </span><br><span>@@ -669,20 +671,17 @@</sp=
an><br><span>  		PKCS11H_LOG_DEBUG2,</span><br><span>  		&quot;PKCS#11: pkc=
s11h_certificate_deserializeCertificateId return rv=3D%lu-&#39;%s&#39;&quot=
;,</span><br><span> diff --git a/lib/pkcs11h-util.c b/lib/pkcs11h-util.c</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-index 0743fd1..f90e443 1=
00644</span><br><span style=3D"color: hsl(120, 100%, 40%);">+index 1fcadfc.=
.a304642 100644</span><br><span> --- a/lib/pkcs11h-util.c</span><br><span> =
+++ b/lib/pkcs11h-util.c</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-@@ -110,12 +110,7 @@ _pkcs11h_util_hexToBinary (</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- 		p++;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+@@ -123,10 +123,6 @@ _pkcs11h_util_hexToBinary (</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ 		(*p_target_size)++;</sp=
an><br><span>  	}</span><br><span>  </span><br><span> -	if (*p !=3D &#39;\x=
0&#39;) {</span><br><span style=3D"color: hsl(0, 100%, 40%);">--		return CK=
R_ATTRIBUTE_VALUE_INVALID;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+-		goto cleanup;</span><br><span> -	}</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">--	else {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">--		return CKR_OK;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">--	}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-+	return CKR=
_OK;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+-</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ 	ret =3D CKR_OK;</span><br><span>  </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- CK_RV</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ cleanup:</span><br><span>diff --git a/contrib/vcp=
kg-ports/pkcs11-helper/portfile.cmake b/contrib/vcpkg-ports/pkcs11-helper/p=
ortfile.cmake</span><br><span>index db9a5ab..af19831 100644</span><br><span=
>--- a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake</span><br><span>+++=
 b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake</span><br><span>@@ -1,9=
 +1,9 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-set(VERSION 1=
.30.0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+set(VERSION 1=
.31.0)</span><br><span> </span><br><span> vcpkg_download_distfile(ARCHIVE</=
span><br><span>     URLS &quot;https://github.com/OpenSC/pkcs11-helper/rele=
ases/download/pkcs11-helper-${VERSION}/pkcs11-helper-${VERSION}.tar.bz2&quo=
t;</span><br><span>     FILENAME &quot;pkcs11-helper-${VERSION}.tar.bz2&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHA512 19fba76e=
41210cc17f9efa4501d0214d4a5c777ab7b2671888fd280b150bae4a6b190c7f47fb783015f=
9aa40d409fd6087264e531d6f28d0bed4293dcbf8bdd5</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    SHA512 0833efc59e9093dd398a54640d858b01a830ef=
7adfb40321c1e0ed0afa004500fc1259cc66bc49c5263935adeda0a3bfe658de538eefd6688=
8685a71f731c484</span><br><span> )</span><br><span> </span><br><span> vcpkg=
_extract_source_archive_ex(</span><br><span>diff --git a/contrib/vcpkg-port=
s/pkcs11-helper/vcpkg.json b/contrib/vcpkg-ports/pkcs11-helper/vcpkg.json</=
span><br><span>index 521f754..382a3d3 100644</span><br><span>--- a/contrib/=
vcpkg-ports/pkcs11-helper/vcpkg.json</span><br><span>+++ b/contrib/vcpkg-po=
rts/pkcs11-helper/vcpkg.json</span><br><span>@@ -1,6 +1,6 @@</span><br><spa=
n> {</span><br><span>     &quot;name&quot;: &quot;pkcs11-helper&quot;,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;version&quot;: &=
quot;1.30.0&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   &quot;version&quot;: &quot;1.31.0&quot;,</span><br><span>     &quot;desc=
ription&quot;: &quot;pkcs11-helper is a library that simplifies the interac=
tion with PKCS#11 providers for end-user applications.&quot;,</span><br><sp=
an>     &quot;homepage&quot;: &quot;https://github.com/OpenSC/pkcs11-helper=
&quot;,</span><br><span>     &quot;license&quot;: &quot;BSD-3-Clause OR GPL=
-2.0-only&quot;</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1368?usp=3Demail">change 1368</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1368?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I032a573df6deaa44b4afce3c2d2=
fd54f69df6e7a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1368 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--g27uqHwhFYk=--

