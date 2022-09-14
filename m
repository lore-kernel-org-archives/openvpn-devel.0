Date: Wed, 14 Sep 2022 08:23:59 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YyFzfzdi1Mk3Fe7n@...1296...>
References: <202208301957.27UJv74w093000@...2054...>
 <20220912074149.31160-1-gert@...1296...>
 <a0668e8c-897d-c360-e501-89a246de4bd6@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/UVDR37iT/5JrBGa"
Content-Disposition: inline
In-Reply-To: <a0668e8c-897d-c360-e501-89a246de4bd6@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Improve documentation for --dev and
 --dev-node.
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

--/UVDR37iT/5JrBGa
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Sep 13, 2022 at 11:38:29PM +0200, Antonio Quartulli wrote:
> > +  On other platforms, ``--dev-node node`` will influence the naming of=
 the
> > +  created tun/tap device, if supported on that platform.  If OpenVPN c=
annot
> > +  figure out whether ``node`` is a TUN or TAP device based on the name,
> > +  you should also specify ``--dev-type tun`` or ``--dev-type tap``.
> > +
> >   --dev-type device-type
> >     Which device type are we using? ``device-type`` should be :code:`tu=
n`
> >     (OSI Layer 3) or :code:`tap` (OSI Layer 2). Use this option only if
>=20
>=20
> I like this improved version as it tries to bring clarity. However, I=20
> feel it is too vague as to which platform does what.
>=20
> For example the last paragraph starts with "On other platform", but what=
=20
> are these "other platforms"?

The intent was to list the 3 platforms where --dev-node does something
special, and then "other platforms" is "everything else" (technically,
all platforms that call open_tun_generic(), so I'm not absolutely sure
if AIX or Solaris qualify... but I'm not going to mention AIX or Solaris
there, as it's way too unimportant and will just increase text length).

Especially as it's not even working on "all other platforms" due to
limitations, the documentation won't get less vague than the actual
implementation...

> Maybe it's just me, but saying "other platforms" or "some platforms" or=20
> "most platforms" without explicitly saying which ones is the same as to=20
> not really documenting the behaviour. Because I am still unable to=20
> understand which platform does what.
>=20
> Should we rather split this platform by platform with related paragraphs?
>=20
> What do you think?

We could do that, and nobody would really read it - it would just get
long, with quite some repetitions (the BSDs are all very similar, except
when they are not)...

I'm still for "on platforms that are not Windows, MacOS or Linux, --dev-node
will usually not do what you want, so forget about it right away" - wrapped
in a slightly longer text :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--/UVDR37iT/5JrBGa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjIXN/AAoJEB2Cnv7KVigScLYL/jrDL0LSJo6QkyoDih7mBVx+
Z6AqXjdBe6OxgEEsPosv9I0RkDu4RRWhlTJEbeoyqPC1TgJ9L9XLkN6Kxnw1jwPX
GKskrbqEVLYdpDEW0Ql3aDxf7lxp7dRzP2heJUUoO4tGynd5wEWCrLOqJV7NSFOp
vqFRDNj1TvTj980n5TV4uk+VBkVPkGbvaEj6o/yG1C2vN7F4wUxeXTBtq38+xxe5
lFe4lWsBfWTV08mtMlxGkKm7LQ/w8iAMGXAg4zyzHtOURTQQEKv7LOBNohUG1p20
MWKeZ1XHg/i8B7QVw9DoVGZYNw0ve4TCFj/tB2Rf3HmBLD9FWTSW6GC74DQB7ekZ
6IpJA7L+VuqpZ98lXUnxpR39Xcy0857iegSuJ2xqkZyW4Bj7yLjVlFmt11R+dd5g
0PqGlWLjlUSHTON6K+TNrKH0lKC6Sbdn5PskBm9EsiTgqDidt0bPwGl8v6Fu5Sby
5aI7APcDui3zGcloHsDUXzdj0wKLf3N6NmkcjsjDgQ==
=auKC
-----END PGP SIGNATURE-----

--/UVDR37iT/5JrBGa--

