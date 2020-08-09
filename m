Date: Sun, 9 Aug 2020 09:46:22 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200809074622.GR75094@...1296...>
References: <20200729113835.2415-1-arne@...1227...>
 <20200804202010.GV75094@...1296...>
 <b8c90764-96e4-6e6d-2060-ee3d84cb446d@...1227...>
 <20200805064318.GY75094@...1296...>
 <20200805114523.GA75094@...1296...>
 <f382976e-4125-ff7c-6d2c-84de886db5af@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="z3ovhOgMYmj8MRdq"
Content-Disposition: inline
In-Reply-To: <f382976e-4125-ff7c-6d2c-84de886db5af@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2] Rework NCP compability logic and
 drop BF-CBC support by default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--z3ovhOgMYmj8MRdq
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Aug 08, 2020 at 08:11:13PM +0200, Arne Schwabe wrote:
> > Not sure how to tackle the "ccd/ push cipher is broken now with 2.4-NCP
> > clients" part.  I think this is useful functionality, but the current
> > patch does not allow this "unless the client is already using the to-be-
> > pushed cipher, or it's one of the two NCP=3D2 AEAD ciphers".  Which mak=
es
> > it slightly less than useful...
>=20
> I am not sure we can fix this in a good way. The behaviour is bascially
> blindly push a cipher no matter what the client announces.

Yes.  And set the server instance to use this cipher.

So something like "--data-cipher-override-push"...

The use of that option would, basically, be "I have lots of 2.4 clients,
I can not update their client configs all over night, but for whatever
reason I do not want to use AES-GCM ciphers (and not BF-CBC either)".  I
can not foresee a strong reason to not use AES-GCM, but maybe some sort
of embedded platform that performs great on ChaCha-Poly and very poorly
on AES...  or, worst case, AES is broken.

Not sure how realistic that is.


> What we would need to still support this behaviour is a
>=20
> --data-cipher-force-cipher-if-only-iv_ncp2-present cipher
>=20
> that picks that cipher if the client has only IV_NCP=3D2. That sounds like
> a very ugly and obscure option. Or an option that is
>=20
> --iv-ncp-2-is-data-ciphers "foo:AES-128-CBC:MySpecial-Cipher"
>=20
> and then the server would translate IV_NCP=3D2 to that list instead of
> "AES-256-GCM:AES-128-GCM"
>=20
> All other options that I can come up break proper negotiation support.


Either this ("we pretend the client has really sent *this* list of=20
ciphers") or we override negotiation by forcing a particular cipher
for this client (use on the server and push to client - which a 2.3
and 2.2 client will ignore with a warning).=20=20=20

Overriding could come with a warning in the server log ("forcing a=20
cipher that is not in the list advertised by the client, might break").


> The option names are of course silly and would need to be replaced by
> better sounding alternatives. *If* we want to support this corner case I
> would suggest the second alternative and implement it in a follow up
> patch. The question is if this corner case is important enough to
> support it.

Doing this in a followup patch sounds reasonable...  this could even
go into 2.5 later on (as it would fix a - small - regression).

So - let's get this in :-) - v3, please, which does not core dump.


Also, I think we need to better document what happens wrt cipher
negotiation depending on client/server combinations (2.2+2.3, 2.4,
2.5 to a 2.3 / 2.4 / 2.5 server, OCC/NCP/new NCP, ...).

Maybe a table in the Wiki?   Or something in doc/

We have your commit message, which is a good start, but if people get
all confused about this (like I was :-) ), they will not look into the
git logs.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--z3ovhOgMYmj8MRdq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfL6nOAAoJEB2Cnv7KVigS5iIL/i6jbKOONgfEAQo0X1iUxWm5
5JKJH7vBvstumQpr6a7ZtrFeMWyobBIfIAi6kXhJILTzxYh1vEK6s7w7dNkecxaJ
YleSHCOTnvLzt8G301Ro8mTk2coaLnN8/rrZA/ylR21uGPJVFM169XlVmgatpwUD
wf7AdFmFD0y1DOLv7H6XmrM78gzDZCPEEr48m6bYJkUcFID0FemceZp0rJuefcnm
0gPetJsrYxHtO0V2zFDZfrPaV27wHqygqhnnUJMfRZ9hTvUlnB3fMwvvP7XkOqf2
CjCYTO9yAwDHSSEh+J1kP5gynTEoo39gubYWVe5yv3T8mLbioSEk/Cc1bZ0Jc0ld
OXISXWLsD0047L2gat1GiIi7RNBGKKAH6QZhexvof1f50QnGBbT6OoLSj0ji+l5n
bFue0AetA067zIi1x/Vuf3ackOujIUAzlXqfDaaQQH4UyCLpvOEnsTQfMg0i5i7s
dMoMYWZ6ZIdKjV5SmJZmS1WdV0V2BQcqH2LmUP5dNQ==
=hYx3
-----END PGP SIGNATURE-----

--z3ovhOgMYmj8MRdq--

