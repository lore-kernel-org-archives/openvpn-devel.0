From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 22 May 2025 13:08:05 +0000
In-Reply-To: <gerrit.1747746380000.I1204bc2ff85952160a86f0b9d1caae90e5065bc4@...2715...>
References: <gerrit.1747746380000.I1204bc2ff85952160a86f0b9d1caae90e5065bc4@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., max@...2606...
Message-ID: <82d946ca2caca0e03dac6009921709e075bd30bf-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wc5T0EQaDA8="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Use
 mbedtls_ssl_export_keying_material()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: MaxF <max@...2606...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--wc5T0EQaDA8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/1041?usp=3Demail )

Change subject: Use mbedtls_ssl_export_keying_material()
......................................................................


Patch Set 2: Code-Review-1

(2 comments)

Patchset:

PS2:
the cmake detection didn't work properly for me but we should also not use =
that (see other comment)

So I tested with replacing !HAVE_MBEDTLS_SSL_EXPORT_KEYING_MATERIAL
defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT) in the source code to test this.

I can confirm that the patch otherwise works.


File CMakeLists.txt:

http://gerrit.openvpn.net/c/openvpn/+/1041/comment/93bf1992_f65e7263 :
PS2, Line 305:     check_symbol_exists(mbedtls_ssl_export_keying_material m=
bedtls/ssl.h HAVE_MBEDTLS_SSL_EXPORT_KEYING_MATERIAL)
shouldn't we rather rely on the mbed TLS configuration define MBEDTLS_SSL_K=
EYING_MATERIAL_EXPORT to detect this?

We have to do this cmake/configure.ac dance for the old apis since mbed TLS=
 doesn't have a proper define but to detect if the API is available using M=
BEDTLS_SSL_KEYING_MATERIAL_EXPORT should work unless I am overlooking somet=
hing.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1041?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1204bc2ff85952160a86f0b9d1caae90e5065bc4
Gerrit-Change-Number: 1041
Gerrit-PatchSet: 2
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-Comment-Date: Thu, 22 May 2025 13:08:05 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--wc5T0EQaDA8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: MaxF, flichtenheld. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1041?usp=3Demail">V=
iew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1041?tab=3Dcomments">Patch Set #2:</a> </p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">the cmake detection didn&#39;t work properl=
y for me but we should also not use that (see other comment) </p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">So I tested with replaci=
ng !HAVE_MBEDTLS_SSL_EXPORT_KEYING_MATERIAL <br>defined(MBEDTLS_SSL_KEYING_=
MATERIAL_EXPORT) in the source code to test this.</p><p style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">I can confirm that the patch otherwise=
 works.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File CMak=
eLists.txt:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1041/comment/93bf1992_f65e7263">Patch =
Set #2, Line 305:</a> <code style=3D"font-family:monospace,monospace">    c=
heck_symbol_exists(mbedtls_ssl_export_keying_material mbedtls/ssl.h HAVE_MB=
EDTLS_SSL_EXPORT_KEYING_MATERIAL)</code></p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">shouldn&#39;t we rather rely on the mbed TLS co=
nfiguration define MBEDTLS_SSL_KEYING_MATERIAL_EXPORT to detect this?</p><p=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">We have to do this=
 cmake/configure.ac dance for the old apis since mbed TLS doesn&#39;t have =
a proper define but to detect if the API is available using MBEDTLS_SSL_KEY=
ING_MATERIAL_EXPORT should work unless I am overlooking something.</p></li>=
</ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1041?usp=3Demail">change 1041</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1041?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1204bc2ff85952160a86f0b9d1c=
aae90e5065bc4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1041 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 22 May 2025 13:08:05=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--wc5T0EQaDA8=--

