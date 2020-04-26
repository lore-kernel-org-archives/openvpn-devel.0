Date: Sun, 26 Apr 2020 11:34:31 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200426093431.GX1431@...1296...>
References: <20200416113930.15192-1-arne@...1227...>
 <20200417085159.GC1431@...1296...>
 <4a4c73df-6771-8862-2ae0-274a98ee2158@...2181...>
 <20200417153605.GD1431@...1296...>
 <fbf3eaef-26d1-c81b-a456-c1be7d71b4f9@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="wh9kJD9MDTzc/E2s"
Content-Disposition: inline
In-Reply-To: <fbf3eaef-26d1-c81b-a456-c1be7d71b4f9@...1856...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/3] Use crypto library functions for
 const time memcmp when possible
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--wh9kJD9MDTzc/E2s
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Apr 26, 2020 at 11:25:49AM +0200, Steffan Karger wrote:
> >> well, sometimes to adhere to the codestyle, you have to re-arrange cod=
e :)
> >=20
> > "rearrange" and "rewrite in a not easy to understand way" (which looks
> > a bit overthought to me, TBH - unlike "secure memzero" I cannot see an
> > obvious reason why all that volatile would be relevant).
>=20
> This secure memcmp is relevant to avoid timing side channels in e.g.
> authentication tag compare. Think about the HMAC in our tls-auth/crypt
> and the HMAC of (non-AEAD) data channel packets.

I do understand why it has to be constant *time*, in regards to "do the
compared buffers differ or not".

I do not see how all this "volatile" and "copy from pointer to variables
to other stuff" handwaving is going to make any difference wrt constant
time comparison.

And it hurts my eyes.

[..]
> This kind of code is a tricky balance between "prevent the compiler from
> optimizing it to a not-constant-time implementation"=20

How could the compiler optimize *this* code?  It has very explicit
instructions to build the xor of every single byte in the buffer and
or them all together, and return the result as an integer.

Unlike secure_memzero() whatever compiler optimization is chosen, it
still needs to do the actual math for *all bytes*.   It can not optimize=20
out "if a string does not match early on, end comparisions more early".

(It could, if the result is already 0xff, but that optimization would
slow down the loop, so I would find very surprising)


> and "as much
> performance as we can get". Moving this responsibility to the crypto
> library seems like a good idea to me.
>=20
> And because our recommended data channel ciphers are AEAD ciphers for
> which the auth tag compare is handled internally by the crypto library,
> I don't care so much for the performance aspect. Want best security? Use
> AEAD! Want best performance? Use AEAD!
>=20
> You get the point. Use AEAD ;-)

Now that's definitely a strong argument against my "inline! performance!"
argument.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--wh9kJD9MDTzc/E2s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJepVWnAAoJEB2Cnv7KVigScl8MAIZIn1WTrQ6Jp3qkF5qK2ZgK
gFKC1n/Twsv1enfXqIoatwDWYpwtBeZlZRTPm6QQ0U7WOKxVbG714dMCA7D/Wr+I
PHtj/+SJDDuM47yOgFEFXLGcD6B2CCZKJ0dWcvzBEhBt9SbYSx47yNhcwb214yYI
II668LiXuruDyyXEOv3Bei9yw0eGYhWRROz5BCCPKe+zbClT1JtM7Z00gHdeuPPp
GIzY2x4NjeI7QoTFNpOgs+PfSf2P2jpve7Pjh4DCXWMFy4Kp+wtvo+N5acuk1hZH
rCXtOO+eWUrTUCEGeFLk5aCJE3hq9erD4IzvCzF99awMlFMFqZJupAYgK8vesZ7p
byv8oPhPhhhh4RT+gnFqhBxcSxodqNpX3VgxC9kmBqH7eEOg1KyjpurLbbiVMHA1
zJitlu0kAp4gytdmyhLoOZs6mJn7zsoOBAYdE9yvL3EDv2gcUK3zoARtCOA5xVlb
kxviOl2U9+ekPfA0w9EPUUnOPJ2R+e2JXRz8BZaBug==
=yQ1q
-----END PGP SIGNATURE-----

--wh9kJD9MDTzc/E2s--

