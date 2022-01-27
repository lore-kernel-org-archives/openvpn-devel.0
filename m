Date: Thu, 27 Jan 2022 16:32:00 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YfK68CaW5JpYGedt@...1296...>
References: <20210510013239.18087-1-selva.nair@...277...>
 <20210815222558.22502-1-selva.nair@...277...>
 <CAKuzo_jVEFRzXUAM5FXkXJMauBE50Fx+=LMpVusN87bpopg3rQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="9WDNMl9CnBDgMv0m"
Content-Disposition: inline
In-Reply-To: <CAKuzo_jVEFRzXUAM5FXkXJMauBE50Fx+=LMpVusN87bpopg3rQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] Allow PKCS#11 uri to be used as
 --cert and --key file names
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--9WDNMl9CnBDgMv0m
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jan 25, 2022 at 12:02:44PM -0500, Selva Nair wrote:
> > In its simplest form, just have
> >
> > --cert 'pkcs11:id=3D%01'
>=20
> I'm withdrawing this patch as it has no prospects going forward with
> engines on their way out in
> OpenSSL 3.0 and beyond. Withdrawing is also an honourable way out when no
> one seems to care :)

Recorded as such.  Thanks for the patch anyway.

(And indeed, I have no current usecase for this - though it definitely
looked interesting - and too much other stuff that I needed to care for...)

> That said, in the spirit of this patch, I think we should consider reusing
> "--cert" and, optionally, "--key" options when newer ways of specifying t=
he
> certificate are introduced: like "--cert <uri>" instead of a new option
> "--cryptoapi-cert <foo>" etc.

Let's try to keep this in mind when the next patch suggesting

 --mysecretkeystore-cert <identifier>

comes along :-)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--9WDNMl9CnBDgMv0m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJh8rrvAAoJEB2Cnv7KVigSGEQMAIwXViTJB8gd97M+kRyBQsdt
iO/pGaWgpefk7Km3FSoQOFwhJXO/R11Xb9k355l3EkQZyuh2YVhLurNmlo1s0zVV
76MasRlbBOO+KP9EnXpWKzJqdlUvxrMFdD4E5U2G8UiDdycYcEEsHKFPGPKHUDh5
8YD0Vx0Q0WIR60gCX1hLUQQOir2VBFOvnlDoqo3zu64BhW5qNNcHj0PTo3uNaESP
fYAVYJJsuK2vNH70B2R6+l2BpwhwSs7P3KM9V5K0PnMf4bgE21XB0Ax+GLSORL3m
zh8xXlNTe0zGKrhK4lmdZERKt8pchXO6XJxfvRmA6w5KSxqsMwsZVW0SOoMOaN4K
8Fsvet3LFCnYeCvOmY9g2SFqZekeHwTMdUZpXLym3ZoEHpjzP9NR1STiY0dT5jpw
ujlFqcY/GTnU/ZJWcPScso7H3MuHUkdX/kGIWk0RyEJXpsFQXmuQ6IzJB0SXha1o
74AHZlRDpBeH9gMRt07fwOzZ7X3FD+JZiMg86vIoTA==
=rzYp
-----END PGP SIGNATURE-----

--9WDNMl9CnBDgMv0m--

