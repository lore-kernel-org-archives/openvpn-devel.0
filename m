From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 26 Dec 2024 11:01:39 +0000
In-Reply-To: <gerrit.1726585476000.I43d84034f3e920a45731c4aab4f851a60921290d@...2715...>
References: <gerrit.1726585476000.I43d84034f3e920a45731c4aab4f851a60921290d@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <00db06e8c2db206a562cfdb88cafbd677acfb3da-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mWejcjRIVd4="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mWejcjRIVd4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

stipa has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/751?usp=3Demail )

Change subject: Add building/testing with msbuild and the clang compiler
......................................................................


Patch Set 5:

(1 comment)

Patchset:

PS5:
C:\Users\lev\Projects\openvpn-build\src\openvpn\tests\unit_tests\openvpn\te=
st_buffer.c(408,11): error : 'snprintf' will always be truncated; specified=
 size is 10, but format string expands to at least 16 [-Werror,-Wformat-tru=
ncation] [C:\Users\lev\Projects\openvpn-build\src\openvpn\out\build\win-amd=
64-clang-debug\test_buffer.vcxproj]

c:\Program Files\Microsoft Visual Studio\2022\Community\VC\Tools\Llvm\bin>c=
lang-cl.exe --version
clang version 18.1.8
Target: i686-pc-windows-msvc
Thread model: posix
InstalledDir: c:\Program Files\Microsoft Visual Studio\2022\Community\VC\To=
ols\Llvm\bin



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/751?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I43d84034f3e920a45731c4aab4f851a60921290d
Gerrit-Change-Number: 751
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Thu, 26 Dec 2024 11:01:39 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--mWejcjRIVd4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/751?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/7=
51?tab=3Dcomments">Patch Set #5:</a> </p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">C:\Users\lev\Projects\openvpn-build\src\openvpn\te=
sts\unit_tests\openvpn\test_buffer.c(408,11): error : &#39;snprintf&#39; wi=
ll always be truncated; specified size is 10, but format string expands to =
at least 16 [-Werror,-Wformat-truncation] [C:\Users\lev\Projects\openvpn-bu=
ild\src\openvpn\out\build\win-amd64-clang-debug\test_buffer.vcxproj]</p><p =
style=3D"white-space: pre-wrap; word-wrap: break-word;">c:\Program Files\Mi=
crosoft Visual Studio\2022\Community\VC\Tools\Llvm\bin&gt;clang-cl.exe --ve=
rsion<br>clang version 18.1.8<br>Target: i686-pc-windows-msvc<br>Thread mod=
el: posix<br>InstalledDir: c:\Program Files\Microsoft Visual Studio\2022\Co=
mmunity\VC\Tools\Llvm\bin</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/751?usp=3Demail">change 751</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/751?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I43d84034f3e920a45731c4aab4f=
851a60921290d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 751 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@...277...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 26 Dec 2024 11:01:39=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--mWejcjRIVd4=--

