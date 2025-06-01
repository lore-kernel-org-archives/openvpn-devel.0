From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 1 Jun 2025 14:49:08 +0000
In-Reply-To: <gerrit.1747746380000.If5e832866b312a2f8a1ce6b4e00d40e3dcf63681@...2715...>
References: <gerrit.1747746380000.If5e832866b312a2f8a1ce6b4e00d40e3dcf63681@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <f50689508c46e0924eea54f98e7d244baa652507-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SgnmRjgMi/k="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mbedtls: Allow TLS
 1.3 if available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: MaxF <max@...2606...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--SgnmRjgMi/k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1042?usp=3Demail )

Change subject: mbedtls: Allow TLS 1.3 if available
......................................................................


Patch Set 3: Code-Review-1

(2 comments)

Patchset:

PS3:
I'm confused about exact mbedTLS version numbers that I should test this ag=
ainst


File README.mbedtls:

http://gerrit.openvpn.net/c/openvpn/+/1042/comment/eb36c616_51198042 :
PS3, Line 32: (mbedtls-3.6 or development branch).
this 3.6 here does not look right.  FreeBSD ships 3.6.2 in ports, and it do=
es not have `mbedtls_ssl_export_keying_material()` (says our configure), an=
d I downloaded `mbedtls-3.6.3.1.tar.bz2` which also does not have it (says =
"grep -R").



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1042?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If5e832866b312a2f8a1ce6b4e00d40e3dcf63681
Gerrit-Change-Number: 1042
Gerrit-PatchSet: 3
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-Comment-Date: Sun, 01 Jun 2025 14:49:08 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--SgnmRjgMi/k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: MaxF. </p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1042?usp=3Demail">V=
iew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1042?tab=3Dcomments">Patch Set #3:</a> </p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">I&#39;m confused about exact mbedTLS versio=
n numbers that I should test this against</p></li></ul></li><li style=3D"ma=
rgin: 0; padding: 0;"><p>File README.mbedtls:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1042=
/comment/eb36c616_51198042">Patch Set #3, Line 32:</a> <code style=3D"font-=
family:monospace,monospace">(mbedtls-3.6 or development branch).</code></p>=
<p style=3D"white-space: pre-wrap; word-wrap: break-word;">this 3.6 here do=
es not look right.  FreeBSD ships 3.6.2 in ports, and it does not have `mbe=
dtls_ssl_export_keying_material()` (says our configure), and I downloaded `=
mbedtls-3.6.3.1.tar.bz2` which also does not have it (says &quot;grep -R&qu=
ot;).</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1042?usp=3Demail">change 1042</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1042?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If5e832866b312a2f8a1ce6b4e00=
d40e3dcf63681 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1042 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 01 Jun 2025 14:49:08=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--SgnmRjgMi/k=--

