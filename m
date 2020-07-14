Date: Tue, 14 Jul 2020 22:47:03 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200714204703.GK1431@...1296...>
References: <20200620162206.13956-1-gert@...1296...>
 <20200623092848.21214-1-gert@...1296...>
 <CAKuzo_iX0_=o1Z+dpPUwoyQZuYyuG0RNSaAzmwBN_UGeTHedcg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ibjPynG1TKEHlv58"
Content-Disposition: inline
In-Reply-To: <CAKuzo_iX0_=o1Z+dpPUwoyQZuYyuG0RNSaAzmwBN_UGeTHedcg@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add deferred authentication support
 to plugin-auth-pam
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ibjPynG1TKEHlv58
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jul 14, 2020 at 01:47:06PM -0400, Selva Nair wrote:
> Sorry for the long delay in getting back to this.. A few minor
> nitpicks on style follows:

Thanks for the review.  Indeed, my style fu was sort of absent when
I wrote this :-) (it's "mgetty+sendfax" style, with "I must remember
to use vim and :set expandtab!!!", but the braces always escape me...
and Antonio was busy elsewhere :) )

This...:

> On Tue, Jun 23, 2020 at 5:29 AM Gert Doering <gert@...1296...> wrote:
> > +                /* client wants deferred auth
> > +                 */
> > +                if ( strlen(ac_file_name) > 0 )
> > +                {
> > +                    if (do_deferred_pam_auth(fd, ac_file_name,
> > +                                             service, &up) < 0)
> > +                    {
> > +                        goto done;
>=20
> Do we have to abort in this case? This will exit the background
> process and cripple the server while this could be a temporary memory
> pressure causing the fork to fail. Why not just break and plough
> along? The core will fail to get a response via the ac_file, but that
> could happen if the grand-child fails as well -- the server is
> supposed to cope with such failures.

... is something I need to look more closely at.  I remember that the
general approach to "mmmh, something failed!" here is "goto done",=20
but your argument about "yeah, fork() failed, so what - try again
later!" has merits.

> Apart from these minor issues that could be corrected or ignored at
> merge time, all look good.

This is actually a code change, so I think I'll send a v3 with all
the nitpicks fixed (uncrustify is my friend :-) ) and this one changed.

> We should put the usage info into README.auth-pam as that seems to be
> the only documentation of the plugin. Also an entry in changelog?
> Could be a separate patch.

When I do a v3 anyway, I can add this as well.  Makes sense to have it
one commit.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ibjPynG1TKEHlv58
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfDhnGAAoJEB2Cnv7KVigSLmcL/3rwP/6/qUkUDZZD4Yf1dW8M
OlG1iwzWR5U1/PyBqO5u3jJqYlVc3cW+E0jSO8sKTOkCnSoK30E+y4OF3Mhs5JGw
XYcj4U49rCH+DhNJCDU5rOsD5jFNr6PhtePvZbjsAclypHopTaC5gfxoTaNO42mP
vbgMM+JKk59pxlcPqbDwtfdmsBJzWAkTyOfOprprg2CZdh3Wyyxn9L+PISgp34L4
JruvvbaDtsumIVT41HX3c/FFIn4mQ7W/Dhb59YvhcQXXZaNALRrQ1q1NCHFzMwYh
hJ9S9JSyCqHZXZKtm1MTuO+VyKvBjHPu88Y6vvP/eGFBm7RPdD4CQnqaq+xnxcxm
uIp6NN2CspDckC3Kg/RxUb99d7T/+h3R6Aqw4aEV/bel6Q091tGk8lMgL4gSVlZv
liBQsckhuxaqbyEG0FcwDnW7GULV5M3ZkJ0gtSlYckAP0zQsnPeNQmzGufMPpwNw
enHHoUTXCSm9yh81eSt7jKjqQNiNjUwHGmioLHFfoQ==
=SLoa
-----END PGP SIGNATURE-----

--ibjPynG1TKEHlv58--

