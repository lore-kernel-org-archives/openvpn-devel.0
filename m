Date: Thu, 11 Jul 2013 20:24:26 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130711182425.GG16543@...1296...>
References: <1371818610-4599-1-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CNfT9TXqV7nd4cfk"
Content-Disposition: inline
In-Reply-To: <1371818610-4599-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Add support to ignore specific options.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--CNfT9TXqV7nd4cfk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 21, 2013 at 02:43:30PM +0200, Arne Schwabe wrote:
> +.B \-\-ignore-unknown-option opt1 opt2 opt3 ... optN
> +When one of options=20

Feature-ACK, but the code confuses me a bit...

> +  else if (streq (p[0], "ignore-unknown-option") && p[1])=20
> +    {
> +      int i;
> +      int j;
> +      int numignored=3D0;
> +      const char **ignore;
> +
> +      VERIFY_PERMISSION (OPT_P_GENERAL);
> +      /* Find out how many options to be ignored */
> +      for (i=3D1;p[i];i++)
> +        numignored++;
> +
> +      numignored=3Di;

This...  (I think the "numignored=3Di" bit should just go - while it does
not harm, it doesn't help, and confuses people :-))

> +        {
> +          const char* opt =3D options->ignore_unknown_option[i];
> +
> +          if (streq(p[0], opt))

... and I'm not *so* happy about that either - if you only need "opt" once,
why add an extra variable for that?  Code is technically OK, though.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--CNfT9TXqV7nd4cfk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUd74WakuBuNlUUl1AQIf0gQAmqELMMx9wN740WYttLA46PShaDky/hZP
rkYLm6XngO4VmyteUZDivbwtXtZhfY3GW1iKzhb0yyJuJr1m8hAU1g/vaVT5tCmP
YUzK/9NDSyBPr6Fkom2bqS1gMKoaj/RKRYJh3sir7r5tGdu6x3TlwQb5LDPiljah
rEGspc37VoY=
=9M/6
-----END PGP SIGNATURE-----

--CNfT9TXqV7nd4cfk--

