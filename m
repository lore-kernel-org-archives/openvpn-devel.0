References: <20181207123303.70827-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <4e683bf2-541b-b320-5166-5753716e75ca@...2181...>
Date: Sat, 8 Dec 2018 09:47:37 +1000
MIME-Version: 1.0
In-Reply-To: <20181207123303.70827-1-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EHvdQvz5LnC1EGLU477VEh1ajbUSWLFcb"
Subject: Re: [Openvpn-devel] [PATCH] Add 'printing of port number' to
 mroute_addr_print_ex() for v4-mapped v6.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EHvdQvz5LnC1EGLU477VEh1ajbUSWLFcb
Content-Type: multipart/mixed; boundary="sWsqnZloZuQ4FNBOtBpTYHTXUrVyXkoJB";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <4e683bf2-541b-b320-5166-5753716e75ca@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Add 'printing of port number' to
 mroute_addr_print_ex() for v4-mapped v6.
References: <20181207123303.70827-1-gert@...1296...>
In-Reply-To: <20181207123303.70827-1-gert@...1296...>

--sWsqnZloZuQ4FNBOtBpTYHTXUrVyXkoJB
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 07/12/2018 22:33, Gert Doering wrote:
> For whatever reason, this function never printed port numbers for
> IPv6 addresses (but it did for IPv4) - which creates a bit of
> confusion for IPv6-mapped v4 addresses on a dual stack socket,
> that will have ports numbers printed or not, depending on whether
> it's a dual-stack v6 socket or single-stack v4.
>=20
> This will not(!) add printing of port numbers for "proper" v6
> addresses yet, because that might have adverse side effects to address
> parsing elsewhere.
>=20
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/mroute.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
> index 28940a8d..134f4c00 100644
> --- a/src/openvpn/mroute.c
> +++ b/src/openvpn/mroute.c
> @@ -477,6 +477,13 @@ mroute_addr_print_ex(const struct mroute_addr *ma,
>                  {
>                      buf_printf(&out, "%s", print_in_addr_t(maddr.v4mappe=
dv6.addr,
>                                                             IA_NET_ORDER,=
 gc));
> +		    /* we only print port numbers for v4mapped v6 as of
> +		     * today, because "v6addr:port" is too ambiguous
> +		     */

The comments above are indented with tab+spaces, while the code below is
just all spaces. Please use the all spaces everywhere.

> +                    if (maddr.type & MR_WITH_PORT)
> +                    {
> +                        buf_printf(&out, ":%d", ntohs(maddr.v6.port));
> +                    }

I don't understand how is this solving the ambiguity? Or you are just
saying: "we can't do much, let's just print the port anyway"? My
suggestion would be to surround the address with [], so basically change
the printf format above from %s to [%s]. Does it make sense?


Cheers,

>                  }
>                  else
>                  {
>=20

--=20
Antonio Quartulli


--sWsqnZloZuQ4FNBOtBpTYHTXUrVyXkoJB--

--EHvdQvz5LnC1EGLU477VEh1ajbUSWLFcb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlwLBpkACgkQ9FVsWUWD
Dm2FQg/8C3oz2UNWj6Z4HVBf8GlgRSjDuaFj0EAvVPrDk7ynCkmxAbsfrOwWyo+u
yITlYwHw7qst47Y6C75XtqyIepB2grwajhHVARBZD4PPkYB6iOOsjrmqpgISZDm6
7ZOurwIcp+CAeolQh7F+AlAhZBm1LDNN1J+ZqSyK1xxYqPjLe43WwbxRthX45PPA
FmJDUvuPq/tL1oC7zHWzEX6GagEtgu7FxGaBmivn9NMXLqFyO1Yc9FiZRcTUn+p0
CqZmpCgrAKzJvRxMhi/+rCfUIFt9aeBtf4EhO2cusWTRftzQSpjxbRSDgEdlw6R4
3UtehwdOFIHGzbh8LSKMysx+6e2o6krSIHNgAbngr5YKxitLp77SK4GJgFv+HxMx
Zl1rJUe3EOE42R7aKpE4JqBexR1dx4XdAzhv8eQzGCB2VzpBprMmuUGBY5mJ+xpV
QnUAmLaZkWh7pmsjw1QRP5ufUpDPXvAQeaIrhBeYN7b4L+NNBRRiqOXGCU+LSqx2
9Azt7oq+4FE9swrFGufVjSFTK96JHVv4dhbpAa16BnMUTQVJEV5J0C1KJsnxBOCl
9jqt7No05RkwM3eY0flrmXx+CjpiZjQg+vaq0pxhMqnusoKsOI4ageuB5JIpm1Si
LDj64k+F+AN3mpHW/2n5KwWZqC+inffGjpgHyGC5RoC8RzOZAVw=
=0JJw
-----END PGP SIGNATURE-----

--EHvdQvz5LnC1EGLU477VEh1ajbUSWLFcb--

