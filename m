From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 28 Oct 2025 19:28:36 +0000
In-Reply-To: <gerrit.1761565272000.I329b407693b97dd048bd3788ecad345d6e25dab2@...2715...>
References: <gerrit.1761565272000.I329b407693b97dd048bd3788ecad345d6e25dab2@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <f55686ddb7a793d4bb2652e6067c6958e6478444-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CRCpINc/AMs="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: iservice: use
 interface index with netsh
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--CRCpINc/AMs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, flichtenheld, plaisthos.

cron2 has posted comments on this change by d12fk. ( http://gerrit.openvpn.=
net/c/openvpn/+/1308?usp=3Demail )

Change subject: iservice: use interface index with netsh
......................................................................


Patch Set 1: Code-Review-2

(1 comment)

Patchset:

PS1:
This fails the integer checks on a windows build

```
oC:\Buildbot\windows-server-2025-latent-ec2-msbuild-x86-clang\build\src\ope=
nvpnserv\interactive.c(3197,47): error : incompatible pointer to integer co=
nversion passing 'LPVOID' (aka 'void *') to parameter of type 'int' [-Wint-=
conversion] [C:\Buildbot\windows-server-2025-latent-ec2-msbuild-x86-clang\b=
uild\out\build\win-x86-clang-release\src\openvpnserv\openvpnserv.vcxproj]
o  C:\Buildbot\windows-server-2025-latent-ec2-msbuild-x86-clang\build\src\o=
penvpnserv\interactive.c(1007,43): note: passing argument to parameter 'if_=
index' here
```



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1308?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I329b407693b97dd048bd3788ecad345d6e25dab2
Gerrit-Change-Number: 1308
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Tue, 28 Oct 2025 19:28:36 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--CRCpINc/AMs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: d12fk, flichtenheld, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1308?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1308?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This fails =
the integer checks on a windows build</p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">```<br>oC:\Buildbot\windows-serve=
r-2025-latent-ec2-msbuild-x86-clang\build\src\openvpnserv\interactive.c(319=
7,47): error : incompatible pointer to integer conversion passing &#39;LPVO=
ID&#39; (aka &#39;void *&#39;) to parameter of type &#39;int&#39; [-Wint-co=
nversion] [C:\Buildbot\windows-server-2025-latent-ec2-msbuild-x86-clang\bui=
ld\out\build\win-x86-clang-release\src\openvpnserv\openvpnserv.vcxproj]<br>=
o  C:\Buildbot\windows-server-2025-latent-ec2-msbuild-x86-clang\build\src\o=
penvpnserv\interactive.c(1007,43): note: passing argument to parameter &#39=
;if_index&#39; here<br>```</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1308?usp=3Demail">change 1308</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1308?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I329b407693b97dd048bd3788eca=
d345d6e25dab2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1308 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 28 Oct 2025 19:28:36=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--CRCpINc/AMs=--

