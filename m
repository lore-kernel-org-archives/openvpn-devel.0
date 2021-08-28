Date: Sat, 28 Aug 2021 21:26:24 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YSqN4PfCbeN4rmxQ@...1296...>
References: <20210811095853.27870-1-a@...2181...>
 <20210827190014.12640-1-a@...2181...>
 <3e75a75e-2fc7-d6b4-fc46-63c146e4e875@...68...>
 <YSo52uB5tf9qUIQ5@...1296...>
 <CAKuzo_gFArLosfU5t8x=3n-LFNZsMzVccuraBsfFrJewrAzu-g@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="NXT/XksA2kZn6X0I"
Content-Disposition: inline
In-Reply-To: <CAKuzo_gFArLosfU5t8x=3n-LFNZsMzVccuraBsfFrJewrAzu-g@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Remove support for PF (Packet Filter)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, Matthias Andree <matthias.andree@...68...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--NXT/XksA2kZn6X0I
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Aug 28, 2021 at 10:49:42AM -0400, Selva Nair wrote:
> On Sat, Aug 28, 2021 at 9:29 AM Gert Doering <gert@...1296...> wrote:
>=20
> > On Sat, Aug 28, 2021 at 10:51:58AM +0200, Matthias Andree wrote:
> > > Do we need to maintain C89 compatibility these days?
> > No.  C99 is fully acceptable.
>=20
> But our coding style still has to be followed. That means /* */ comments
> only.

Ah.  Seems I misunderstood the reason for Matthias' question.

Indeed, comments must be /* */ for coding style / consistency reasons,
and for no other reason than we agreed to do it that way.  And not
use tabs for indenting (which I personally find cumbersome as "vi"
really loves to auto-tab stuff :-) ).

And while the whitespace police can be really annoying at times, the
overall readability of our code *has* improved quite a bit.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--NXT/XksA2kZn6X0I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhKo3gAAoJEB2Cnv7KVigS3tsL/ibMcZMcjRx/56BvkrtUgvcz
NsUUv8VIG1KhD/Z7gYfn2zgxw6qDcMpn5dU6PWDkN6iqdCA8ATuP5w/9GeHTHFXq
D2RuAwtG40Ymz21QdXRljyBaj84FghK+cFnNYyXsctP5WzsaTjxMESmCboaA6kbg
jayijNrtwA7mPpVISd23UH3nweYqM254GPMddJEiESRsuPeyJuAN9RsWMvogT+eU
JFB4boCcnEl3REwBEOGGkdDPPssJEfiwSFVpm+A31tDJbOvd9iQxe/sUqgB4279l
MqF1oUr79HLeQi0Bu4p4iIXOa9YCaofE2fM8pnL/JDdiVcGzA68AjAhABkflFMUU
3hU6Rp7ckjjDdZb4E2y24svloMzJucIWP5HjE8bwPmA72VkTmy19h85DLD+OvMM4
DQNsgUltB/27wf47+9KFilEzWOXJqcoRHowt/CjlJ/nREvflRKrpDd1N32dChDCX
sIr5HyAbngVuWxFJqp0JyDspIJYeR2wPReTrYOoy8Q==
=MO9p
-----END PGP SIGNATURE-----

--NXT/XksA2kZn6X0I--

