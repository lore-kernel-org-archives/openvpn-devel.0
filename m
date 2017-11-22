Date: Wed, 22 Nov 2017 19:57:57 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20171122185757.GF631@...1296...>
References: <00bb01d363a1$2428e260$6c7aa720$@carroll.com>
 <20171122164212.GD631@...1296...>
 <016a01d363c3$3cc3bdf0$b64b39d0$@carroll.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="+jhVVhN62yS6hEJ8"
Content-Disposition: inline
In-Reply-To: <016a01d363c3$3cc3bdf0$b64b39d0$@carroll.com>
Subject: Re: [Openvpn-devel] OpenVPN + OpenSSL FIPS Object Module v2.0
 causes OpenVPN to SIGSEGV
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jim Carroll <jim@...2322...>
Cc: 'Gert Doering' <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--+jhVVhN62yS6hEJ8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 22, 2017 at 01:53:50PM -0500, Jim Carroll wrote:
> Question -- We'd like to submit a patch. Is the correct procedure still to
> submit patches via email as described
> https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation#Dailyde=
vel
> opment. Or is appropriate for us to just fork on github and push patches
> there?

Most preferred way is

 - you do a git clone of the tree
 - checkout master
 - apply changes there
 - "git commit -s"
 - git send-email --to=3Dopenvpn-devel@lists.sourceforge.net

this will make reviewing and applying (and keeping track of patches
in patchwork) much easier than any other method.

For simple patches, "just send a diff by mail" is ok, but so many MUA/MTAs
tend to wreck whitespace that "git send-email" is just more safe in that
regard.

> Conceptually, I believe supporting FIPS in OpenVPN will require four broad
> changes:
>=20
> 	1) A change to configure.ac to help build process find=20
> 		OpenSSL FIPS Object Module
> 	2) A new option to OpenVPN, eg: --fips-mode
> 	3) Code change to enable FIPS & Allow MD5 for PRF
> 	4) Build process documentation to build, eg: where to=20
> 		get OpenSSL pieces and how to build
>=20
> Do we need to run this by anyone, or do we just start patching?

You start patching, commit & send-email your diffs, and then face the
reviews :-) - I'm not the one who has any idea about FIPS and our
crypto stuff in general, so Antonio, David or Steffan are likely going
to review & ACK/NAK the result...  I only look at style and remember
things :-)

gert

--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--+jhVVhN62yS6hEJ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaFci1AAoJEB2Cnv7KVigSKBkL/Rp+qY8mwiEYdqw175ypk/ec
0Y/9xcObW8AWK2ILkS3qJ50o16SImgJ76zhOtvAd2laIWX8Pc6tGh9i55YLHxZPV
K3zdLqMy2HktM1Rqyp9KP/LmY6lHeupaskROBW/d/iJQXx4tQCiKc2Omcl93gZao
WcVU/EohgjGFF7KFRvW+oMyMSHrE4GeVr7QonFzG533NYEK2SjqqFLegX3bBi6ZP
cxmmARjg9zCdMhRv9R1q+ez/4/bKzHXt0FG0ps9giLM/6864PGGbaHuRNOBfbyJn
4syLpVo8cDtf4pUy1Xu53X4oh/TM8c34YJ35U93xUpyMlS/qDFWfqMqYb35ZqHLR
8ezW8XnpoXr+hhUJ/TW7Y4wM55fBRnCQyQnckYM5ZMHLwpGc83mu7NK3YGyOuzk6
uz9/kKyiFpSweRHtWkDxACcG8wLNIZtscz5a0pWTMRPmmRgsbu9OWWAolF5BHv+z
o5mqXshzKVLG5Q0c8niESS+8seQw0xWHwxvl/3Affw==
=s73x
-----END PGP SIGNATURE-----

--+jhVVhN62yS6hEJ8--

