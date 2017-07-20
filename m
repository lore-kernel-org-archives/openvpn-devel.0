Date: Thu, 20 Jul 2017 13:00:06 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170720110005.GK70062@...1296...>
References: <1500537403-15079-1-git-send-email-steffan.karger@...1435...>
	<1500547913-16653-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrvsYIebpInmECXG"
Content-Disposition: inline
In-Reply-To: <1500547913-16653-1-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH v3] Remove strerror_ts()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

--lrvsYIebpInmECXG
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jul 20, 2017 at 12:51:53PM +0200, Steffan Karger wrote:
>      if ((flags & M_ERRNO) && e)
>      {
>          openvpn_snprintf(m2, ERR_BUF_SIZE, "%s: %s (errno=3D%d)",
> -                         m1, strerror_ts(e, &gc), e);
> +                         m1, strerror(e, &gc), e);

Can I have a v4, please...?

> -                    strerror_ts(my_errno, &gc),
> -                    my_errno);
> +                    extended_msg, strerror(my_errno, &gc), my_errno);

... with strerror() calls that do not carry a &gc...

(Why is that not exploding in your compile tests?)

thanks,

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--lrvsYIebpInmECXG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZcI01AAoJEB2Cnv7KVigSAJsL/3qWGYMMwpKhY829mixZxj1K
7nHPIKUrzwMyxToNTRfDdUzyjH06ikJeSBMKEm/uDeoVm8GlIT6b0VrhSLGMP6vK
/6FyAvXrk4iy5G1g87g3C0e0sLvktsRfUU1CoaASb2OARFusBGdJfCo7A1BLSuXf
WWucNTMb28GVqndvyhkPAr5XCcxgNXzYhz+seH3Bbgm1nSMiX5csYKxYARHa9SVw
opeDEhTEqOnIYAhRFRbhxWtfTofEVqI8kTNPzPq59oKlHiOYK4DqK3boZQn8pY/s
SuDvPe+Q7VJpMkkQITadQ4wtyYio9C1IGzT5DQVrjKfVeMs09Q9P2QTPGg2eIeOE
T6OfhgkXwvGcLsVgwOZ0eivxODI1NR5u549F5o/kra9zdTMYUNMcGxPbNzh+CeSe
1NCR32kO9ONNM4lwE9NLl8XK2IHflugGNQZL7S/9DJcTggWyyHF3pCkMQJMTwN7T
8UCRifTCt+1yVbQjI1pZARzHwxt5LihaSXsdlMV8WA==
=AAwq
-----END PGP SIGNATURE-----

--lrvsYIebpInmECXG--

