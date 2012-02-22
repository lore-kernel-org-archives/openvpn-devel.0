From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 22 Feb 2012 17:27:04 +0100
Message-ID: <7281371.PNMm8PBGWv@...1526...>
In-Reply-To: <CAOazyz21EEqHhEabEY_L-ve5JFnuZoE8fgqLVJjEYTjfpBSq9w@...278...>
References: <CAOazyz21EEqHhEabEY_L-ve5JFnuZoE8fgqLVJjEYTjfpBSq9w@...278...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [RFC][windows] gettimeofday()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

On Wednesday 22 February 2012 16:12:24 Alon Bar-Lev wrote:
> In windows there is own implementation of gettimeofday().
> In the past there was no gettimeofday(), so we used performance counters,
> then James optimize it to reduce CPU consumption.
>=20
> Unlike in the past, mingw does provide this function these days.
> The question is if it is good enough.

Since there's no gettimeofday() in MSVC this will break building with the=20
python build system. Not sure if we're in the process of getting rid of it,=
=20
which I would welcome, so this is just for additional information.

Heiko
--=20
Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
Astaro a Sophos Company | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germ=
any
Commercial Register: Mannheim HRA 702710 | Headquarter Location: Karlsruhe
=20
Represented by the General Partner Astaro Verwaltungs GmbH
Amalienbadstra=DFe 41 Bau 52 | 76227 Karlsruhe | Germany=20
Commercial Register: Mannheim HRB 708248 | Executive Board: Gert Hansen,
Markus Hennig, Jan Hichert, G=FCnter Junk, Dr. Frank Nellissen


