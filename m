Date: Wed, 11 Jul 2018 20:38:38 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180711183838.GB989@...1296...>
References: <20180711165918.12762-1-a@...2181...>
 <20180711170042.15154-1-a@...2181...>
 <20180711174957.GA989@...1296...>
 <12dcd8dd-58f6-3fde-6e6f-bee91fc3f580@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="NJBzyuYYykgY2yjn"
Content-Disposition: inline
In-Reply-To: <12dcd8dd-58f6-3fde-6e6f-bee91fc3f580@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] socket: make stream_buf_* functions
 static
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--NJBzyuYYykgY2yjn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jul 12, 2018 at 01:56:14AM +0800, Antonio Quartulli wrote:
> > Why not just add prototypes at the top?
>=20
> Because I wanted the result to be clean code :)

Prototypes are clean code :-)

> Imho, prototypes should be used only if really needed (i.e. when
> re-ordering is not an option).
>=20
> The information about what/why was introduced can still be extracted
> with a "git log -S$something_here".

Won't help if I want to see how a particular line came to be - and this
is something relevant if you try to understand why "openvpn used to do
things differently" in earlier versions.

> I wouldn't make such a big deal of "breaking git blame" if the changes
> slowly move towards cleaner code.

I'm not objecting if it moves "towards cleaner code" (like the 2.4
reformatting, or moving code blobs to smaller units) - but "just move
it around in the same source file" is not achieving much cleaning,=20
so I consider the negative aspects to be stronger in that case.

> Actually some functions did not strictly needed to be moved, but I
> wanted all the stream_buf helpers to be in the same place and not
> scattered along socket.c. This can be changed if you think it's too
> invasive.

I do.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--NJBzyuYYykgY2yjn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbRk6uAAoJEB2Cnv7KVigSP9UMAJByEXh9tWy0VC4xHFDskI62
NYL8X3nkg2TaG770dQGpogwFeKBItiEwHR1xarur7X/ssSizECqpRxQI1AMBC0rC
zRryRwJveR3zbXdcASNmBqYD5CGSRgj9nWypbe/6IufcUSy5Oxt3ijy1AI2HGNMY
TgBw3eNDs9vgj2X+Hrb9LXxI8vtmUGnL+yflzj4yJ9fhnYqofE4vi9sew0IRsg85
NtDKY46JkWhz78vkaBetmHfXn+RDRyK7HI70cxGdkFYWbbDhchvo+zERBHnXbFBC
bzJm3lRzidDNhsT+MCIag6wOKmMaEv1UXsc4r+jWslkfIkU840LYatnE8ToQIur8
pBkkWplzDZLzcEGkVLqz07sOh/C2kqsUirs4fffv+Bk5ll+/ORD+scOJDEur7GNA
9B56Po4gi3cQsN8UrOe07IogqCkRIA/dnFIZszhD98/dTOIO5QSxAaHy/pnz0aAd
P83lQNXodXOTkaDs2HtsryqlwJ9g4I3+QMPA95509A==
=B+XU
-----END PGP SIGNATURE-----

--NJBzyuYYykgY2yjn--

