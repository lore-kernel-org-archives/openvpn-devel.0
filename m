MIME-Version: 1.0
Sender: adriaan@...1475...
Date: Sun, 16 Oct 2011 15:50:43 +0200
Message-ID: <CAHyOtRnJxa0iPUcQUdPYM3NKmfHeuVnu21+YMP+FKErRQ1KY9g@...278...>
From: Adriaan de Jong <openvpn@...1475...>
Content-Type: multipart/alternative; boundary=bcaec544ecdecfcf4004af6ac61f
Subject: [Openvpn-devel] Rebased SSL patches
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--bcaec544ecdecfcf4004af6ac61f
Content-Type: text/plain; charset=ISO-8859-1

As promised, I've rebased the patches on the current master branch. They're
available here:

https://github.com/andj/openvpn-ssl-refactoring/commits/rebasedmaster  (i.e.
in the rebasedmaster branch of the openvpn-ssl-refactoring tree).

No major changes were necessary. I've skipped the unacked white-space patch,
as it was unacked :).

The changes that were made, other than
git-auto-fixed trailing white-space stuff:

 - base64_encode became openvpn_base64_encode at
https://github.com/andj/openvpn-ssl-refactoring/commit/61218d729e5190dddb27d4ff69da87910e095cee#L2L1497
(fix
for new code)
 - the new tls_username function was moved to the correct place:
https://github.com/andj/openvpn-ssl-refactoring/commit/a76d8c8dfb1b4aa22b08c254fa9f2f91baf7b770#L3R151
 - a new patch to fix a compiler warning:
https://github.com/andj/openvpn-ssl-refactoring/commit/f2ca3bf675c500b839c22d2db828a7a73a7054cc

If someone can ack these last few changes, then David can start merging!

Kind regards,
Adriaan de Jong

--bcaec544ecdecfcf4004af6ac61f
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<div style=3D"color: rgb(34, 34, 34); font-family: arial, sans-serif; font-=
size: 13px; background-color: rgb(255, 255, 255); ">As promised, I&#39;ve r=
ebased the patches on the current master branch. They&#39;re available here=
:</div>
<div style=3D"color: rgb(34, 34, 34); font-family: arial, sans-serif; font-=
size: 13px; background-color: rgb(255, 255, 255); "><br></div><div style=3D=
"color: rgb(34, 34, 34); font-family: arial, sans-serif; font-size: 13px; b=
ackground-color: rgb(255, 255, 255); ">
<a href=3D"https://github.com/andj/openvpn-ssl-refactoring/commits/rebasedm=
aster" target=3D"_blank" style=3D"color: rgb(17, 85, 204); ">https://github=
.com/andj/openvpn-ssl-refactoring/commits/rebasedmaster</a>=A0 (i.e. in the=
 rebasedmaster branch of the openvpn-ssl-refactoring tree).</div>
<div style=3D"color: rgb(34, 34, 34); font-family: arial, sans-serif; font-=
size: 13px; background-color: rgb(255, 255, 255); "><br></div><div style=3D=
"color: rgb(34, 34, 34); font-family: arial, sans-serif; font-size: 13px; b=
ackground-color: rgb(255, 255, 255); ">
No major changes were necessary. I&#39;ve skipped the unacked=A0white-space=
=A0patch, as it was unacked :).</div><div style=3D"color: rgb(34, 34, 34); =
font-family: arial, sans-serif; font-size: 13px; background-color: rgb(255,=
 255, 255); ">
<br></div><div style=3D"color: rgb(34, 34, 34); font-family: arial, sans-se=
rif; font-size: 13px; background-color: rgb(255, 255, 255); ">The changes t=
hat were made, other than git-auto-fixed=A0trailing=A0white-space=A0stuff:<=
/div>
<div style=3D"color: rgb(34, 34, 34); font-family: arial, sans-serif; font-=
size: 13px; background-color: rgb(255, 255, 255); "><br></div><div style=3D=
"color: rgb(34, 34, 34); font-family: arial, sans-serif; font-size: 13px; b=
ackground-color: rgb(255, 255, 255); ">
=A0- base64_encode became openvpn_base64_encode at=A0<a href=3D"https://git=
hub.com/andj/openvpn-ssl-refactoring/commit/61218d729e5190dddb27d4ff69da879=
10e095cee#L2L1497" target=3D"_blank" style=3D"color: rgb(17, 85, 204); ">ht=
tps://github.com/andj/openvpn-ssl-refactoring/commit/61218d729e5190dddb27d4=
ff69da87910e095cee#L2L1497</a>=A0(fix for new code)</div>
<div style=3D"color: rgb(34, 34, 34); font-family: arial, sans-serif; font-=
size: 13px; background-color: rgb(255, 255, 255); ">=A0- the new tls_userna=
me function was moved to the correct place:=A0<a href=3D"https://github.com=
/andj/openvpn-ssl-refactoring/commit/a76d8c8dfb1b4aa22b08c254fa9f2f91baf7b7=
70#L3R151" target=3D"_blank" style=3D"color: rgb(17, 85, 204); ">https://gi=
thub.com/andj/openvpn-ssl-refactoring/commit/a76d8c8dfb1b4aa22b08c254fa9f2f=
91baf7b770#L3R151</a></div>
<div style=3D"color: rgb(34, 34, 34); font-family: arial, sans-serif; font-=
size: 13px; background-color: rgb(255, 255, 255); ">=A0- a new patch to fix=
 a compiler warning:=A0<a href=3D"https://github.com/andj/openvpn-ssl-refac=
toring/commit/f2ca3bf675c500b839c22d2db828a7a73a7054cc" target=3D"_blank" s=
tyle=3D"color: rgb(17, 85, 204); ">https://github.com/andj/openvpn-ssl-refa=
ctoring/commit/f2ca3bf675c500b839c22d2db828a7a73a7054cc</a></div>
<div style=3D"color: rgb(34, 34, 34); font-family: arial, sans-serif; font-=
size: 13px; background-color: rgb(255, 255, 255); "><br></div><div style=3D=
"color: rgb(34, 34, 34); font-family: arial, sans-serif; font-size: 13px; b=
ackground-color: rgb(255, 255, 255); ">
If someone can ack these last few changes, then David can start merging!</d=
iv><div style=3D"color: rgb(34, 34, 34); font-family: arial, sans-serif; fo=
nt-size: 13px; background-color: rgb(255, 255, 255); "><br></div><div style=
=3D"color: rgb(34, 34, 34); font-family: arial, sans-serif; font-size: 13px=
; background-color: rgb(255, 255, 255); ">
Kind regards,</div><div style=3D"color: rgb(34, 34, 34); font-family: arial=
, sans-serif; font-size: 13px; background-color: rgb(255, 255, 255); ">Adri=
aan de Jong</div>

--bcaec544ecdecfcf4004af6ac61f--

