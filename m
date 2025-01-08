From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 8 Jan 2025 14:56:05 +0000
In-Reply-To: <gerrit.1732208116000.Ie63f302402f469c3aa48ac146ca6b8c029f0d250@...2715...>
References: <gerrit.1732208116000.Ie63f302402f469c3aa48ac146ca6b8c029f0d250@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., samuli@...515...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <e2278a8d24d64ca346e36a08692d7c84db01a769-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GJ84D6tF/cI="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add lwip support to
 t_server_null
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mattock <samuli@...515...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--GJ84D6tF/cI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: mattock, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/811?usp=3Demail )

Change subject: Add lwip support to t_server_null
......................................................................


Patch Set 4: Code-Review-2

(3 comments)

File doc/t_server_null.rst:

http://gerrit.openvpn.net/c/openvpn/+/811/comment/cfcc4062_edab2a5a :
PS4, Line 129: Note that all ovpnlwip test names need to include a "_lwip" =
suffix: without if
"without it"


File tests/lwip_client_up.sh:

http://gerrit.openvpn.net/c/openvpn/+/811/comment/a46c4c72_23d0241a :
PS4, Line 4: if ! grep "$ifconfig_local" ./$test_name.ips; then
Should use grep -q


File tests/t_server_null_default.rc:

http://gerrit.openvpn.net/c/openvpn/+/811/comment/d4f73210_6228eae2 :
PS4, Line 22: LWIPOVPN_PATH=3D"${LWIPOVPN_PATH:-lwipovpn}"
This is extremely misleading. This seems to indicate that you can override =
`LWIPOVPN_PATH`. However you can definitely not do so in t_server_null.rc s=
ince that is loaded after t_server_null_default.rc and it is too late. Even=
 more when you set LWIPOVPN_PATH in t_server_null.rc it actually allows to =
start the lwip tests since the test whether lwipovpn is available does use =
the updated LWIPOVPN_PATH.

We either need to clearly define that LWIPOVPN_PATH can not be overridden o=
r we need to fix it so that it can.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/811?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie63f302402f469c3aa48ac146ca6b8c029f0d250
Gerrit-Change-Number: 811
Gerrit-PatchSet: 4
Gerrit-Owner: mattock <samuli@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: mattock <samuli@...515...>
Gerrit-Comment-Date: Wed, 08 Jan 2025 14:56:05 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--GJ84D6tF/cI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: mattock, plaisthos. </p>
<p>Patch set 4:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/811?usp=3Demail">Vi=
ew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File doc/t_server_null.rst:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/811/comment/cfcc4062_edab2a5a">Patch Set #4, Line 129=
:</a> <code style=3D"font-family:monospace,monospace">Note that all ovpnlwi=
p test names need to include a &quot;_lwip&quot; suffix: without if</code><=
/p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;without=
 it&quot;</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File te=
sts/lwip_client_up.sh:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/811/comment/a46c4c72_23d024=
1a">Patch Set #4, Line 4:</a> <code style=3D"font-family:monospace,monospac=
e">if ! grep &quot;$ifconfig_local&quot; ./$test_name.ips; then</code></p><=
p style=3D"white-space: pre-wrap; word-wrap: break-word;">Should use grep -=
q</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/t_se=
rver_null_default.rc:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/811/comment/d4f73210_6228eae=
2">Patch Set #4, Line 22:</a> <code style=3D"font-family:monospace,monospac=
e">LWIPOVPN_PATH=3D&quot;${LWIPOVPN_PATH:-lwipovpn}&quot;</code></p><p styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">This is extremely misle=
ading. This seems to indicate that you can override `LWIPOVPN_PATH`. Howeve=
r you can definitely not do so in t_server_null.rc since that is loaded aft=
er t_server_null_default.rc and it is too late. Even more when you set LWIP=
OVPN_PATH in t_server_null.rc it actually allows to start the lwip tests si=
nce the test whether lwipovpn is available does use the updated LWIPOVPN_PA=
TH.</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">We either=
 need to clearly define that LWIPOVPN_PATH can not be overridden or we need=
 to fix it so that it can.</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/811?usp=3Demail">change 811</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/811?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie63f302402f469c3aa48ac146ca=
6b8c029f0d250 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 811 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: mattock &lt;samuli@...515...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mattock &lt;samuli@...515...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 08 Jan 2025 14:56:05=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--GJ84D6tF/cI=--

