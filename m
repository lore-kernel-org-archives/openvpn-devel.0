From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 11 Dec 2023 16:57:07 +0000
In-Reply-To: <gerrit.1700585996000.I39fb3f05b6245af9ae5dd666bfc53ed07e5cfb24@...2715...>
References: <gerrit.1700585996000.I39fb3f05b6245af9ae5dd666bfc53ed07e5cfb24@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <c6de4a491f8d7b113016811913019e7c0a86b88e-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="y44WXn/K574="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Cache mbed TLS
 dependency and build latest 2.x mbed TLS as well
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

--y44WXn/K574=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/455?usp=3Demail )

Change subject: Cache mbed TLS dependency and build latest 2.x mbed TLS as =
well
......................................................................


Patch Set 4: Code-Review-1

(1 comment)

File .github/workflows/build.yaml:

http://gerrit.openvpn.net/c/openvpn/+/455/comment/d2494521_91393bb9 :
PS4, Line 389:           key: ${{ matrix.build }}-mbedtls-${{matrix.mbedtls=
ver}}-${{matrix.cmakebuild}}
matrix.cmakebuild seems undefined? Did you maybe mean matrix.cc?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/455?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I39fb3f05b6245af9ae5dd666bfc53ed07e5cfb24
Gerrit-Change-Number: 455
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Mon, 11 Dec 2023 16:57:07 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--y44WXn/K574=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 4:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/455?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>File .github/workflows/build.yam=
l:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/455/comment/d2494521_91393bb9">Patch Set #4, Li=
ne 389:</a> <code style=3D"font-family:monospace,monospace">          key: =
${{ matrix.build }}-mbedtls-${{matrix.mbedtlsver}}-${{matrix.cmakebuild}}</=
code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">matrix.=
cmakebuild seems undefined? Did you maybe mean matrix.cc?</p></li></ul></li=
></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/45=
5?usp=3Demail">change 455</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/455?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I39fb3f05b6245af9ae5dd666bfc=
53ed07e5cfb24 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 455 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 11 Dec 2023 16:57:07=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--y44WXn/K574=--

