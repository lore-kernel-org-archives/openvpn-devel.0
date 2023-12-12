From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 12 Dec 2023 12:13:28 +0000
In-Reply-To: <gerrit.1700585996000.I39fb3f05b6245af9ae5dd666bfc53ed07e5cfb24@...2715...>
References: <gerrit.1700585996000.I39fb3f05b6245af9ae5dd666bfc53ed07e5cfb24@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <c0cbb9c7144f7f36d9e30fe4d274c652cf241b1a-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZGC74PwM0S4="; charset=UTF-8
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
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZGC74PwM0S4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/455?usp=3Demail )

Change subject: Cache mbed TLS dependency and build latest 2.x mbed TLS as =
well
......................................................................


Patch Set 4:

(1 comment)

File .github/workflows/build.yaml:

http://gerrit.openvpn.net/c/openvpn/+/455/comment/5076711d_e7be7ada :
PS4, Line 389:           key: ${{ matrix.build }}-mbedtls-${{matrix.mbedtls=
ver}}-${{matrix.cmakebuild}}
> matrix.cmakebuild seems undefined? Did you maybe mean matrix. [=E2=80=A6]
That is a leftover of my own patch. I built mbed TLS with cmake instead of =
configure/make and then would pick either debug or asan for mbed TLS as wel=
l. But it seems not to be possible to pick that with configure/make. Will j=
ust remove it.



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
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 12 Dec 2023 12:13:28 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--ZGC74PwM0S4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/455?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File .github/workflows/build.yaml:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/455/comment/5076711d_e7be7ada">Patch Set #4, Line 3=
89:</a> <code style=3D"font-family:monospace,monospace">          key: ${{ =
matrix.build }}-mbedtls-${{matrix.mbedtlsver}}-${{matrix.cmakebuild}}</code=
></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; p=
adding: 0 10px;">matrix.cmakebuild seems undefined? Did you maybe mean matr=
ix. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wra=
p: break-word;">That is a leftover of my own patch. I built mbed TLS with c=
make instead of configure/make and then would pick either debug or asan for=
 mbed TLS as well. But it seems not to be possible to pick that with config=
ure/make. Will just remove it.</p></li></ul></li></ul><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/455?usp=3Demail">change 455</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/455?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 12 Dec 2023 12:13:28=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--ZGC74PwM0S4=--

