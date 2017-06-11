MIME-Version: 1.0
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sun, 11 Jun 2017 20:10:39 +0500
Message-ID: <CAFHpkQH3DG9D9B2JE13J3oyS-7tVG+BUUTHs6x9fLWTCiRNgxg@...278...>
Content-Type: multipart/alternative; boundary="f403045f554a0620c20551b09b1d"
Subject: [Openvpn-devel] No hidden tap adapter anymore?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--f403045f554a0620c20551b09b1d
Content-Type: text/plain; charset="UTF-8"

Hello,

Long time ago it was possible to choose hidden tap adapter during install,
I missed the reason why we are not allowing it anymore.

For windows users we have 3 common "support cases"

1. Wrong password (it was improved greatly by Selva Nair)

2. Interactive service not started, routes are not added (discussion
started, no solution yet)

3. No tap adapter (it is indicated in very bad way, people do not
understand it)

For 3rd case, I see the solution of using separate tap adapters for each
connection. It will lead to numerous network connections (and people will
disable them even more often), so hidden tap adapters seem to be good
solution

--f403045f554a0620c20551b09b1d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hello,<div dir=3D"auto"><br></div><div dir=3D"auto">Long =
time ago it was possible to choose hidden tap adapter during install, I mis=
sed the reason why we are not allowing it anymore.</div><div dir=3D"auto"><=
br></div><div dir=3D"auto">For windows users we have 3 common &quot;support=
 cases&quot;</div><div dir=3D"auto"><br></div><div dir=3D"auto">1. Wrong pa=
ssword (it was improved greatly by Selva Nair)</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">2. Interactive service not started, routes are not a=
dded (discussion started, no solution yet)</div><div dir=3D"auto"><br></div=
><div dir=3D"auto">3. No tap adapter (it is indicated in very bad way, peop=
le do not understand it)</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>For 3rd case, I see the solution of using separate tap adapters for each c=
onnection. It will lead to numerous network connections (and people will di=
sable them even more often), so hidden tap adapters seem to be good solutio=
n</div></div>

--f403045f554a0620c20551b09b1d--

