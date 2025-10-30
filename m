From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 30 Oct 2025 07:40:50 +0000
In-Reply-To: <gerrit.1761565272000.I329b407693b97dd048bd3788ecad345d6e25dab2@...2715...>
References: <gerrit.1761565272000.I329b407693b97dd048bd3788ecad345d6e25dab2@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <2e88fb0159de91c1b727a1a64ff1bf7eff550a01-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/+HiyVo119Y="; charset=UTF-8
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

--/+HiyVo119Y=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, flichtenheld, plaisthos.

stipa has posted comments on this change by d12fk. ( http://gerrit.openvpn.=
net/c/openvpn/+/1308?usp=3Demail )

Change subject: iservice: use interface index with netsh
......................................................................


Patch Set 2: Code-Review-2

(1 comment)

File src/openvpnserv/interactive.c:

http://gerrit.openvpn.net/c/openvpn/+/1308/comment/08e6deb9_153f7b37?usp=3D=
email :
PS2, Line 2910:         free(RemoveListItem(&(*lists)[undo_wins], CmpAny, N=
ULL));
Since we removed the only invocation of CmpWString, clang complains that

C:\Users\lev\Projects\openvpn-build\src\openvpn\src\openvpnserv\interactive=
.c(1055,1): error : unused function 'CmpWString' [-Werror,-Wunused-function=
] [C:\Users\lev\Projects\openvpn-build\src\openvpn\out\build\win-amd64-clan=
g-debug\src\openvpnserv\openvpnserv.vcxproj]



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1308?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I329b407693b97dd048bd3788ecad345d6e25dab2
Gerrit-Change-Number: 1308
Gerrit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Thu, 30 Oct 2025 07:40:50 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--/+HiyVo119Y=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: d12fk, flichtenheld, plaisthos. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1308?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/interactiv=
e.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/1308/comment/08e6deb9_153f7b37?usp=3Demail">P=
atch Set #2, Line 2910:</a> <code style=3D"font-family:monospace,monospace"=
>        free(RemoveListItem(&amp;(*lists)[undo_wins], CmpAny, NULL));</cod=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">Since we removed the only invocation of CmpWString, clang complains =
that</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">C:\Users\lev\Projects\openvpn-build\src\openvpn\src\openvpnserv\in=
teractive.c(1055,1): error : unused function &#39;CmpWString&#39; [-Werror,=
-Wunused-function] [C:\Users\lev\Projects\openvpn-build\src\openvpn\out\bui=
ld\win-amd64-clang-debug\src\openvpnserv\openvpnserv.vcxproj]</p></li></ul>=
</li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1308?usp=3Demail">change 1308</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail=
">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAct=
ion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
308?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I329b407693b97dd048bd3788eca=
d345d6e25dab2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1308 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 30 Oct 2025 07:40:50=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--/+HiyVo119Y=--

