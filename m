From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 6 Mar 2025 12:41:26 +0000
In-Reply-To: <gerrit.1733989644000.Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10@...2715...>
References: <gerrit.1733989644000.Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <846d2b3562c7e867b71f3c0430a69ec1bebec1fd-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zPod/9e4ROc="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dns: apply settings
 via script on unixoid systems
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--zPod/9e4ROc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/838?usp=3Demail )

Change subject: dns: apply settings via script on unixoid systems
......................................................................


Patch Set 10: Code-Review-1

(4 comments)

Patchset:

PS10:
not all of my comments addressed, but works again


File distro/dns-scripts/systemd-dns-updown.sh:

http://gerrit.openvpn.net/c/openvpn/+/838/comment/b6e04719_5c31cad2 :
PS9, Line 75: "$
> Maybe we could add a comment here like: "Add as a routing-only domain (~ =
prefix) unless already conf [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/838/comment/00a046e5_14744958 :
PS9, Line 75: =3D~
> This broken now. [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/838/comment/97e01f52_40b91b62 :
PS9, Line 116:         [ -n "${!transport_var}" -a "${!transport_var}" =3D =
"DoH" ] || break
> I think this line could use a comment like "skip DoH dns entries", otherw=
ise it takes a while to und [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifbe4ffb44d3bfcaa50adb38cacb3436fcdc71b10
Gerrit-Change-Number: 838
Gerrit-PatchSet: 10
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Thu, 06 Mar 2025 12:41:26 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--zPod/9e4ROc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, plaisthos. </p>
<p>Patch set 10:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/838?usp=3Demail">V=
iew Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/838?tab=3Dcomments">Patch Set #10:</a> </p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">not all of my comments addressed, but works=
 again</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File distr=
o/dns-scripts/systemd-dns-updown.sh:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/838/comment/b=
6e04719_5c31cad2">Patch Set #9, Line 75:</a> <code style=3D"font-family:mon=
ospace,monospace">&quot;$</code></p><p><blockquote style=3D"border-left: 1p=
x solid #aaa; margin: 10px 0; padding: 0 10px;">Maybe we could add a commen=
t here like: &quot;Add as a routing-only domain (~ prefix) unless already c=
onf [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wra=
p: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/838/comment/00a046e5_14744958">Patch Set #9, Line 75:</a> <code styl=
e=3D"font-family:monospace,monospace">=3D~</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This bro=
ken now. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16=
px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/838/comment/97e01f52_40b91b62">Patch Set #9, Line 116:</a> <cod=
e style=3D"font-family:monospace,monospace">        [ -n &quot;${!transport=
_var}&quot; -a &quot;${!transport_var}&quot; =3D &quot;DoH&quot; ] || break=
</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10p=
x 0; padding: 0 10px;">I think this line could use a comment like &quot;ski=
p DoH dns entries&quot;, otherwise it takes a while to und [=E2=80=A6]</blo=
ckquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done=
</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/838?usp=3Demail">change 838</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAct=
ion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/8=
38?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifbe4ffb44d3bfcaa50adb38cacb=
3436fcdc71b10 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 838 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 06 Mar 2025 12:41:26=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--zPod/9e4ROc=--

