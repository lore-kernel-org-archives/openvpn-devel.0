MIME-Version: 1.0
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 23 Jun 2016 18:07:51 +0500
Message-ID: <CAFHpkQEi0Nw1=urbawcLhn_3TVTbcNDuvKdwdwtf-M4fBdoUXQ@...278...>
Content-Type: multipart/alternative; boundary=001a114b1408da45b60535f1bd15
Subject: [Openvpn-devel] windows installer: choosing x86/x64 and NDIS5/NDIS6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114b1408da45b60535f1bd15
Content-Type: text/plain; charset=UTF-8

Hello,

we used to enroll our own installer, and we bundled both x86 and x64 into
single installer

it was easy, several blocks

${If} ${RunningX64}
....
${Else}
...
${EndIf}


we are going to pack NDIS5/NDIS6 the same way. in order to choose proper
installer automatically, not to put that decision to user.

if there's an interest, I can make some PR on that.

Cheers,
Ilya Shipitsin

--001a114b1408da45b60535f1bd15
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>we used to enroll our own instal=
ler, and we bundled both x86 and x64 into single installer</div><div><br></=
div><div>it was easy, several blocks</div><div><br></div><div><div>${If} ${=
RunningX64}</div><div><span class=3D"" style=3D"white-space:pre">	....</spa=
n></div><div>${Else}</div><div><span class=3D"" style=3D"white-space:pre">	=
</span>...</div><div>${EndIf}</div></div><div><br></div><div><br></div><div=
>we are going to pack NDIS5/NDIS6 the same way. in order to choose proper i=
nstaller automatically, not to put that decision to user.</div><div><br></d=
iv><div>if there&#39;s an interest, I can make some PR on that.</div><div><=
br></div><div>Cheers,</div><div>Ilya Shipitsin</div><div><br></div></div>

--001a114b1408da45b60535f1bd15--

