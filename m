From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 22 Feb 2012 11:36:49 +0100
Message-ID: <1653841.mDJ7IUcjyx@...1526...>
In-Reply-To: <CAOazyz2gNp_wwXKYHtsZnFh_-ywXLqDkHd3n79X5VxGmv3=Cbg@...278...>
References: <CAOazyz3CAK6Huf7qzAv_Uv+bn5QFFd_cC7A8S_s42HZQGNLC4g@...278...>
	<8821332.jJMvSfGUe1@...1526...>
	<CAOazyz2gNp_wwXKYHtsZnFh_-ywXLqDkHd3n79X5VxGmv3=Cbg@...278...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [build] Windows build test
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Wednesday 22 February 2012 10:32:23 Alon Bar-Lev wrote:
> On Wed, Feb 22, 2012 at 12:27 PM, Heiko Hund <heiko.hund@...1489...> wrot=
e:
> > I was cross compiling for Windows previously doing something very
> > standard
> > like `./configure --host=3Di686-w64-mingw32 ...` followed by `make`. Wh=
at
> > the rationale behind moving away from this way?
>=20
> This is exactly what this build is doing.
> Just it also builds the dependencies and package the output.
> The most difficult task (usually) is to compile the dependencies.

What dependencies do you mean? lzo, openssl and pkcs11-helper?

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


