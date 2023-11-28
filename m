From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 28 Nov 2023 11:07:08 +0000
In-Reply-To: <gerrit.1700585996000.I39fb3f05b6245af9ae5dd666bfc53ed07e5cfb24@...2715...>
References: <gerrit.1700585996000.I39fb3f05b6245af9ae5dd666bfc53ed07e5cfb24@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <9f0781b46a02cee15451d4c85cacd555a441c82c-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KFaxrdzTyJo="; charset=UTF-8
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

--KFaxrdzTyJo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/455?usp=3Demail )

The change is no longer submittable: Code-Review is unsatisfied now.

Change subject: Cache mbed TLS dependency and build latest 2.x mbed TLS as =
well
......................................................................


Patch Set 1: Code-Review-2

(2 comments)

File .github/workflows/build.yaml:

http://gerrit.openvpn.net/c/openvpn/+/455/comment/7adcde95_0c796ee3 :
PS1, Line 406:           ref: ${{ matrix.mbedtlsver}
Syntax broken:
The workflow is not valid. .github/workflows/build.yaml (Line: 406, Col: 16=
): The expression is not closed. An unescaped ${{ sequence was found, but t=
he closing }} sequence was not found.


Patchset:

PS1:
Actually testing it is better.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/455?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I39fb3f05b6245af9ae5dd666bfc53ed07e5cfb24
Gerrit-Change-Number: 455
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Tue, 28 Nov 2023 11:07:08 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--KFaxrdzTyJo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p>The change is no longer submittable: Code-Review is unsatisfied now.=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/455?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File .github/workflows/build.ya=
ml:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/455/comment/7adcde95_0c796ee3">Patch Set #1, L=
ine 406:</a> <code style=3D"font-family:monospace,monospace">          ref:=
 ${{ matrix.mbedtlsver}</code></p><p style=3D"white-space: pre-wrap; word-w=
rap: break-word;">Syntax broken:<br>The workflow is not valid. .github/work=
flows/build.yaml (Line: 406, Col: 16): The expression is not closed. An une=
scaped ${{ sequence was found, but the closing }} sequence was not found.</=
p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/455?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">Actually testing it is better.</=
p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/455?usp=3Demail">change 455</a>. To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">=
settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/455=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I39fb3f05b6245af9ae5dd666bfc=
53ed07e5cfb24 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 455 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 28 Nov 2023 11:07:08=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--KFaxrdzTyJo=--

