Date: Fri, 10 Jul 2020 20:09:28 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200710180928.GG1431@...1296...>
References: <f664dcaf-7224-1b17-c953-584557f2ac56@...1147...>
 <CAKuzo_iFf2iuOLg4LpXrz42MG1GggvdrcWKJrcDT6j38tQjrUw@...278...>
 <20200624102804.GM1431@...1296...>
 <50ad64e7-b75c-e40b-5d5e-9e89e90db45d@...1147...>
 <20200630141103.GY1431@...1296...>
 <67f23584-07bd-7f0a-de1d-6ac285342e46@...1147...>
 <20200706161532.GH1431@...1296...>
 <e5be8b49-0689-eb96-b294-f5b50388a67b@...1147...>
 <20200708082428.GT1431@...1296...>
 <1271e0f7-2768-74df-e81b-6fa8ccf82af1@...1147...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/AN50ryWMsMfRFla"
Content-Disposition: inline
In-Reply-To: <1271e0f7-2768-74df-e81b-6fa8ccf82af1@...1147...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Multiple DNS search suffixes on
 Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--/AN50ryWMsMfRFla
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jul 10, 2020 at 06:48:26PM +0200, Jan Just Keijser wrote:
> > It's just a comment, but if that is wrong, it's not helpful in trying to
> > understand the code.
> >
> just submitted patch v4 but forgot to fix that:=A0=A0 richard is right 29=
=20
> decimal is=A0 0x1D -=A0 or just 29, I guess=A0 - not 0x13
>=20
> Want a v5 for that :P ?

If the rest is working nicely, I usually fix comment or commit message=20
errors (if the proposer agrees) on the fly.

So, will test v4 tomorrow, and then report back :-)

While I couldn't sleep a few nights ago, I came up with a more elegant
approach than strtok()/strchr()/strsep() though... just walk the string,
remember where to put the lenght byte, and every time you hit a "." or
"\0", put (p-lenght_p)-1 into *length_p and remember the current position
as new "length_p"...   less code, no remainder to deal with, and=20
single-pass... :-) - so if v4 is not working yet, that might be another=20
thing for v5.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--/AN50ryWMsMfRFla
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfCK7XAAoJEB2Cnv7KVigSqIAL/1tWfYHhR9O0FjLy0mG7RuFs
P7SQqI3tWxT4FTCjzzQ9oRNIQ7eAJ6lXlrfELqtzz9YbGT9Mk1700ohtqIi8OQbi
mKWz84wqatKNQ9vemzb2sX7Prpjygohvf/6PZG8TLikvjRe3fsc9jOH5ZGkYlYQ0
7AIYND1O4Esqtw1YTdaN2CG4kZYuobkcHGpmILDkS+Bie5wFKECJ/y5Ufgy8N58i
ERajhfJ+R5cXTAGKUy8KuHIqlJBI65DJXfs+CADc1jotVeDPaPQ3nJVeIjBIWViI
GGTzzhTdQFPgzAXSiwT8s8IAN/AkBwJwSXxGQ2mImZnnAd+V3Wc9D2jHAOCegSCc
qyTjndgAnO5Mfw8GYKKKK5MIJPXIxzP3RqqZ1WHPC/1rMaJGy4X8lAElRUsSocb6
s4bo8OtaQY2ZN2rUHvIWAEL3a+bjlW2C063IRSLr7RY7M4a4lISBcSfC9AOpS1CX
Tu3V74yheN2grlZ6z/aM3jHYkr2xp8nZ7OVjp7gp8g==
=uLi7
-----END PGP SIGNATURE-----

--/AN50ryWMsMfRFla--

