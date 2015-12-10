MIME-Version: 1.0
In-Reply-To: <5669A739.2030901@...2070...>
References: <5661686A.4090305@...2070...>
	<1449656275-24934-1-git-send-email-iam@...2070...>
	<56694C04.6020904@...277...>
	<CAKuzo_j6+gjt+_EDVt3CeOR89mAnDNdYtMFfzXDMHbiTjumgnA@...278...>
	<5669A739.2030901@...2070...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 10 Dec 2015 11:31:19 -0500
Message-ID: <CAKuzo_iu2ucwr5KrKwv56DJ_wYZ1Qkku=k7M_OcU2qJXRUNeOw@...278...>
Content-Type: multipart/alternative; boundary=047d7bfcefb0bc0cd805268dbd64
Subject: Re: [Openvpn-devel] [PATCH v8-master] Add Windows DNS Leak fix
	using WFP ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ValdikSS <iam@...2070...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--047d7bfcefb0bc0cd805268dbd64
Content-Type: text/plain; charset=UTF-8

On Thu, Dec 10, 2015 at 11:24 AM, ValdikSS <iam@...2070...> wrote:

> That would break name resolver on reconnection if remote is a hostname.
>

Yes, I meant to leave the block all and permit openvpn.exe filters always
on and delete/re-add only the filters for the tun/tap interface. Well, its
probably just a cosmetic change, so no strong opinion.

Selva

--047d7bfcefb0bc0cd805268dbd64
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Dec 10, 2015 at 11:24 AM, ValdikSS <span dir=3D"ltr">&lt;<a href=3D=
"mailto:iam@...2070..." target=3D"_blank">iam@...2070...</a>&gt;</span> wro=
te:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><div bgcolor=3D"#FFFFFF" text=3D"#000=
000">That would break name resolver on reconnection if remote is a
    hostname.<span><br>
    </span></div></blockquote></div><br></div><div class=3D"gmail_extra">Ye=
s, I meant to leave the block all and permit openvpn.exe filters always on =
and delete/re-add only the filters for the tun/tap interface. Well, its pro=
bably just a cosmetic change, so no strong opinion.<br><br></div><div class=
=3D"gmail_extra">Selva<br></div></div>

--047d7bfcefb0bc0cd805268dbd64--

