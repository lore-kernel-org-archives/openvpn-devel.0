Date: Thu, 7 Nov 2019 13:57:07 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20191107125707.GR40538@...1296...>
References: <20191009143422.9419-3-a@...2181...>
 <201911062041.xA6KfP8R010468@...2054...>
 <CAGyAFMWBd2GzuZdBfTfGwROPw-hEzqSMUCUY3vrWENeqd1A46w@...278...>
 <20191107122743.GQ40538@...1296...>
 <CAGyAFMU5VAWDPuR7V3dTMKBsDbn2vgH61sgn6O9dtZNi-OTebQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="M9bFcvWzl0n6AFYF"
Content-Disposition: inline
In-Reply-To: <CAGyAFMU5VAWDPuR7V3dTMKBsDbn2vgH61sgn6O9dtZNi-OTebQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: VLAN: add basic VLAN
 tagging support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Gert Doering <gert@...1296...>, Antonio Quartulli <a@...2181...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--M9bFcvWzl0n6AFYF
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Nov 07, 2019 at 02:42:17PM +0200, Lev Stipakov wrote:
> > I'm a bit unhappy with that one, as it changes behaviour for all
> > non-windows
> > builds (including all the openssl build output even if it succeeds).
>=20
> The only place it changes behavior is this
>=20
>  install:
>    - if [ ! -z "${CHOST}" ]; then unset CC; fi
> -  - .travis/build-deps.sh > build-deps.log 2>&1 || (cat build-deps.log &&
> exit 1)
> +  - .travis/build-deps.sh
>=20
> I don't see it as an issue to print output when building dependencies. The
> reason why
> it is done is that travis aborts build if there is no output for more than
> 10 minutes.

It's lots of text that is totally uninteresting if it succeeds, but that
you need to scroll over when looking for the reason why a build fails -
which is the reason why it is the way it is today.

[..]
> We could probably have a templatized project file and script which inserts
> source files to there
> based on content of Makefile.ac, but I don't like it. I consider necessity
> of modifying VS project a lesser evil.
>=20
> (you open it and it just works)

I'm not taking responsibility for not breaking MSVC builds.  This is a
world alien to me - if you want me to not break things, it needs to be
"without fiddling XML files".

If you volunteer to update MSVC every time we add or change a source file,
I'm happy to send you a HEADS UP notice.  But I am not doing it, and I will
not request it from any contributor who is not using windows.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--M9bFcvWzl0n6AFYF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdxBSjAAoJEB2Cnv7KVigSt+cL/A+eDUAqndaIuQ+SXlY/gi5K
w/RUWORD0Y7LttvTw3Bzj8X+zGri8/esXpkb7fMdeqc14Zi0oxFw4NE+qp4QMknP
dYaVCOZ4oukFpsKM1gkfXBdICGdm6YMqQzn3IMg/UWyhcSox8qmhXA8QIuseDBqL
bsvT6wt0Y+mO3WWtF//w3VtDYBT03VFguUjlgPIJa4lJ06eS0B9KL7ZlsF3H31Y3
JCrJNoYYSoazzz11YptUavKfSw5aPx7pmvWJa74AE6pKTFLcUX21oETpJRTQyjp8
XANO8bPC7pBjbiyby8OyEAk646E11HRG4sP4YEEHurjOWxd29G39tpe0hBVQljOb
GdBS5p60Y92u0bDJa8gO4SiA8mldzeit423b1zALtECZtV1JiNwQyriBY911Wdtb
/7CuNdRkdJ0iaDvwl429QYntpzeD3I9Z6oLN8sOSrdqAmR0NHLudMyUvCg8Ob37V
pJGhmSznkDKbO059CoTkr2sbiYPS69/uDsYsKWuglw==
=CGn9
-----END PGP SIGNATURE-----

--M9bFcvWzl0n6AFYF--

