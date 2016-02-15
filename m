Date: Mon, 15 Feb 2016 20:58:11 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160215195811.GA24952@...1296...>
References: <1454874438-5081-1-git-send-email-steffan@...1856...>
	<1454874438-5081-11-git-send-email-steffan@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L6+jdixQxvr87aHm"
Content-Disposition: inline
In-Reply-To: <1454874438-5081-11-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH 10/10] Add preliminary server-side
 support for negotiable crypto parameters
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

--L6+jdixQxvr87aHm
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hiya,

On Sun, Feb 07, 2016 at 08:47:18PM +0100, Steffan Karger wrote:
> This patch:
>  * Makes the server advertise "IV_NCP=3D2", if --push-peer-info 2 is enab=
led.

I'd rather not do that - it won't do harm, but technically, it's not
correct (we don't support "negotiable" ciphers in that direction either) -
and then, nothing at the client ever *looks* at the peer-info variables,
so it's somewhat moot.  And that makes it "unneccessary extra code"...

>  * Pushes a 'cipher XXX' directive to the client, if the client advertises
>    "IV_NCP=3D2", where XXX is the cipher set in the server config file.
>=20
> This enables clients that have support for IV_NCP to connect to a server,
> even when the client does not have the correct cipher specified in it's
> config file.
>=20
> Since pushing the cipher directive is quite similar to pushing peer-id, I
> moved peer-id pushing to same prepare_push_reply() function I created for
> pushing cipher.  Adding these directives as regular push options allows us
> to use the existing 'push-continuation' infrastructure.  Note that we
> should not reduce safe_cap in send_push_reply, because it was never
> increased to account for peer-id.
>=20
> This is a preliminary patch, which will be followed by more patches to add
> client support, and configurability.

For the rest, this looks good to me.  Especially introducing the=20
intermediate step with push_option_fmt() simplifies the extra buffer
handling and fixes the potential overflow if "peer-id" happens to be
put at the exactly wrong spot...

So, feature- and code-ACK, except for pushing "IV_NCP=3D2"...

As a side note: I was wondering if o->gc is save to use here (when is it
cleaned up?  is it ever cleaned up?) and under the assumption that the
existing code in push_option_ex() is correct, the new code is correct
as well - the existing code uses o->gc too.


A minor comment comment:

>  #if P2MP
>=20=20
> +/**
> + * Add an option to the push list by providing a format string.
> + *
> + * The string added to the push options is allocated in o->gc, so fmt ma=
y be
> + * free'd by the caller before the option is sent to the peer.

Since nobody ever free()s *fmt*, maybe word that slightly differently,
like:

 * The resulting string added to the push options is allocated in o->gc,
 * so the caller does not have to preserve anything

or so

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--L6+jdixQxvr87aHm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVsIt06kuBuNlUUl1AQI2yQP9HzYzlHzTgSYhAKzpPIuyH5YeqQ2qVHrp
qnxONwv/CQC0cwhVA1uVrByit5KP8jaD28uS8QRX4w9jbHPZXP26oBWEkQZ4AA+P
/nCQqOMwKk9yzbTFp9LrEWTvmklfjZVhjgw8Sk+GAhW7Dz3r1jzbMLPp1lSI4i4D
kwD3ph51Lac=
=Fjg0
-----END PGP SIGNATURE-----

--L6+jdixQxvr87aHm--

