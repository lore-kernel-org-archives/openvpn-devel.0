From: "stipa (Code Review)" <gerrit@...515...>
Date: Mon, 24 Nov 2025 08:02:41 +0000
In-Reply-To: <gerrit.1763922943000.Ie66a142751354e421d48b273784fc79bcb9f7208@...2715...>
References: <gerrit.1763922943000.Ie66a142751354e421d48b273784fc79bcb9f7208@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <a3c56ec7b1e1fc9b4728861fac572b1299ad83b4-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cycgM48UoCQ="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Harden interactive
 service pipe
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selvanair <selva.nair@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--cycgM48UoCQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, selvanair.

stipa has posted comments on this change by selvanair. ( http://gerrit.open=
vpn.net/c/openvpn/+/1396?usp=3Demail )

Change subject: Harden interactive service pipe
......................................................................


Patch Set 1: Code-Review+2

(1 comment)

Patchset:

PS1:
Code looks good and it works:

PS C:\Users\lev\Projects\openvpn-build\src\openvpn> Get-ChildItem \\.\pipe\=
 | Where-Object Name -like '*openvpn*'


    Directorio: \\.\pipe\openvpn


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
------        01/01/1601      2:00              2 openvpn\service
------        01/01/1601      2:00              1 openvpn\service_31012_97a=
67dbf-1f64-44d5-8bec-332bbdc1a277



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1396?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie66a142751354e421d48b273784fc79bcb9f7208
Gerrit-Change-Number: 1396
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: selvanair <selva.nair@...277...>
Gerrit-Comment-Date: Mon, 24 Nov 2025 08:02:41 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--cycgM48UoCQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, selvanair. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1396?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1396?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Code looks =
good and it works:</p><p class=3D"blocks" style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">PS C:\Users\lev\Projects\openvpn-build\src\openvpn&g=
t; Get-ChildItem \\.\pipe\ | Where-Object Name -like &#39;*openvpn*&#39;</p=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><br>    Directorio: \\.\pipe\openvpn</pre><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;"><br>Mode         =
        LastWriteTime         Length Name<br>----                 ---------=
----         ------ ----<br>------        01/01/1601      2:00             =
 2 openvpn\service<br>------        01/01/1601      2:00              1 ope=
nvpn\service_31012_97a67dbf-1f64-44d5-8bec-332bbdc1a277</p></li></ul></li><=
/ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1396=
?usp=3Demail">change 1396</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">sett=
ings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1396?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie66a142751354e421d48b273784=
fc79bcb9f7208 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1396 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: selvanair &lt;selva.nair@...493...=
277...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 24 Nov 2025 08:02:41=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--cycgM48UoCQ=--

