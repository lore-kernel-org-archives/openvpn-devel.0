Date: Thu, 23 Jun 2016 20:32:46 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160623183246.GN79504@...1296...>
References: <1465410882-15540-1-git-send-email-steffan@...1856...>
	<1465852568-6972-1-git-send-email-steffan@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5FDiZl1vRbLRjwwc"
Content-Disposition: inline
In-Reply-To: <1465852568-6972-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCHv3 3/5] Add client-side support for
 cipher negotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--5FDiZl1vRbLRjwwc
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jun 13, 2016 at 11:16:08PM +0200, Steffan Karger wrote:
> Based on the 'IV_NCP=3D2' mechanism described in
> http://permalink.gmane.org/gmane.network.openvpn.devel/9385.
>=20
> This is the first patch of a set that adds support for cipher negotiation.
> Follow-up patches will add ways to restrict or disable the mechanism, and
> add server-side support.
>=20
> v2:
>  * Account for crypto overhead through struct frame.  This is less
>    transparant, but the code has been built to work this way.  The
>    previous approach didn't work with TCP mode (or --port-share).
>  * Calculate the link-mtu sent in the options string based on the crypto
>    parameters specified in the config file (prevents link-mtu warnings in
>    older peers when connecting).
>=20
> v3:
>  * Use existing max_int() function, instead of new MAX() macro.
>  * Fix typo in comment.
>  * Do not regenerate keys if the server sends a second push msg.
>  * Only advertise IV_NCP=3D2 if we're a pull-client (and thus can do NCP).

There might be surprises lurking here regarding explicitly configured
--link-mtu, so this will need detailed testing in as many possible option
variants as possible.

"Logic wise" this looks reasonable to me, so I'm willing to give an ACK
to v4

"Memory wise", to address James' concerns, I do not see anything obvious
where this would lead to memory leaks, given that it's mostly just moving
code around that is run once before and afterwards.  I think we're going
to waste a handful of bytes on the frame overhead (like, "100"-ish) and
resulting maximum buffer size, but that seems impossible to avoid without
much more intrusive changes.

One small thing I did not like, but that's "style":

> -  /*
> -   * key_id increments to KEY_ID_MASK then recycles back to 1.
> -   * This way you know that if key_id is 0, it is the first key.
> -   */
>    ++session->key_id;
>    session->key_id &=3D P_KEY_ID_MASK;
>    if (!session->key_id)

I think we should leave this comment in - I saw you've added a more
detailed comment to the associated .h file, but poor folks like me,=20
without a decent "explain in a second window what the docs say about
the line of code I'm staring at" IDE might benefit from this comment...


> +int
> +tls_peer_info_ncp_ver(const char *peer_info)
> +{
> +  const char *ncpstr =3D peer_info ? strstr (peer_info, "IV_NCP=3D") : N=
ULL;
> +  if (ncpstr)
> +    {
> +      int ncp =3D 0;
> +      int r =3D sscanf(ncpstr, "IV_NCP=3D%d", &ncp);
> +      if (r =3D=3D 1)
> +	return ncp;
> +    }
> +  return 0;
> +}
> +

This one should better go to 5/5 :-) - but you know that already.

thanks,

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--5FDiZl1vRbLRjwwc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV2wrTqkuBuNlUUl1AQJGiQP/dq+rfQnR+KvsGxlsxFcgJ8cqJg24+m4j
5zEpVXzabl9xE1DW+fISbkHP9WB48xrqDnZL7bkioHBGgQrhHc5Y1OlIeyv7Xc/q
a03zd7beK42f/l1EKwSwUzXVQgJV98oAdv4eKXlbKQ87dysPwlFnPwJs2h8tMvPg
V+lIY+WFYqo=
=EUOT
-----END PGP SIGNATURE-----

--5FDiZl1vRbLRjwwc--

