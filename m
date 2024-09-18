From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 18 Sep 2024 11:32:35 +0000
In-Reply-To: <gerrit.1726585476000.I43d84034f3e920a45731c4aab4f851a60921290d@...2715...>
References: <gerrit.1726585476000.I43d84034f3e920a45731c4aab4f851a60921290d@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <d1f194e05caa0b4f8f1b643e0a0d084fbe286899-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mPcjGodj4FU="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add building/testing
 with msbuild and the clang compiler
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mPcjGodj4FU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/751?usp=3Demail )

Change subject: Add building/testing with msbuild and the clang compiler
......................................................................


Patch Set 4:

(2 comments)

File CMakePresets.json:

http://gerrit.openvpn.net/c/openvpn/+/751/comment/b0c7528e_5a22270e :
PS4, Line 145: arm64
> Why no support for ARM64?
iirc when I did try for OpenVPN3, arm64 support was not included with clang=
 toolset in msvc, will check again. But it seems that it is not supported:

error: in triplet arm64-windows-ovpn: Unable to find a valid toolchain for =
requested target architecture arm64.
The selected Visual Studio instance is at: C:\Program Files\Microsoft Visua=
l Studio\2022\Community
The available toolchain combinations are: x86, amd64, x86_amd64, amd64_x86


File src/openvpnmsica/openvpnmsica.h:

http://gerrit.openvpn.net/c/openvpn/+/751/comment/f8f306e1_5157f7ed :
PS4, Line 69: /* Ensure that clang-cl, which does not understand the #pragm=
a comment(linker, ...)
> That comment seems more suited to the changes to openvpnmsica. [=E2=80=A6]
yeah will reword that.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/751?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I43d84034f3e920a45731c4aab4f851a60921290d
Gerrit-Change-Number: 751
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 18 Sep 2024 11:32:35 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--mPcjGodj4FU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/751?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File CMakePresets.json:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/751/comment/b0c7528e_5a22270e">Patch Set #4, Line 145:</a> <c=
ode style=3D"font-family:monospace,monospace">arm64</code></p><p><blockquot=
e style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">W=
hy no support for ARM64?</blockquote></p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">iirc when I did try for OpenVPN3, arm64 support wa=
s not included with clang toolset in msvc, will check again. But it seems t=
hat it is not supported:</p><p style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">error: in triplet arm64-windows-ovpn: Unable to find a valid to=
olchain for requested target architecture arm64.<br>The selected Visual Stu=
dio instance is at: C:\Program Files\Microsoft Visual Studio\2022\Community=
<br>The available toolchain combinations are: x86, amd64, x86_amd64, amd64_=
x86</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/open=
vpnmsica/openvpnmsica.h:</p><ul style=3D"list-style: none; padding: 0;"><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/751/comment/f8f306e1_5157=
f7ed">Patch Set #4, Line 69:</a> <code style=3D"font-family:monospace,monos=
pace">/* Ensure that clang-cl, which does not understand the #pragma commen=
t(linker, ...)</code></p><p><blockquote style=3D"border-left: 1px solid #aa=
a; margin: 10px 0; padding: 0 10px;">That comment seems more suited to the =
changes to openvpnmsica. [=E2=80=A6]</blockquote></p><p style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">yeah will reword that.</p></li></ul></=
li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
751?usp=3Demail">change 751</a>. To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/751?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I43d84034f3e920a45731c4aab4f=
851a60921290d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 751 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 18 Sep 2024 11:32:35=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--mPcjGodj4FU=--

