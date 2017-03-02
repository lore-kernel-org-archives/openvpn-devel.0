Date: Thu, 2 Mar 2017 22:26:21 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170302212621.GE93896@...1296...>
References: <cover.1487368114.git.logout@...260...>
	<e5e93420586b24b7df5b2f5ac2df02ccec5ffdb1.1487368114.git.logout@...260...>
	<66d4f562-4786-f3fd-a6ae-27ebe10abf59@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zw8LCl77lEqAzX6n"
Content-Disposition: inline
In-Reply-To: <66d4f562-4786-f3fd-a6ae-27ebe10abf59@...1856...>
Subject: Re: [Openvpn-devel] [RFC PATCH v1 05/15] OpenSSL: don't use direct
 access to the internal of X509
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

--Zw8LCl77lEqAzX6n
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Mar 02, 2017 at 09:36:32PM +0100, Steffan Karger wrote:
> So, what I propose instead is:
>  * remove all the nsCertType code (except the option in add_option())
>  * update the help strings and man page to indicate that --ns-cert-type
> is no longer supported and --remote-cert-tls should be used instead
>  * in add_option(), if the option is enabled in a config file, act as if
> --remote-cert-tls was specified correspondingly, and print a clear
> warning that --ns-cert-type is no longer supported and stricter checks
> are enabled instead.

Mmmmh.  Is there a way to get the old behaviour with OpenSSL 1.1?

We decided that we do want 1.1 compatibility in release/2.4, but what
you propose might break people's working config when upgrading from 2.4.1
to 2.4.2 - bad enough if we make mistakes, but if there is an alternative
to consciously changing cert validation behaviour in the middle of a
release train, we should look again...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Zw8LCl77lEqAzX6n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYuI38AAoJEB2Cnv7KVigSKnUMAI2DLQ+Fhwr4QkbNOtN5ZDkj
7a0+IdLiitLcGt6W/vsJAvxyB4Y9wj4/2O2D1lr/YIVORztAgLNSfWMiM5K5EJHi
jTmMM3TRsWDb2EDddorRAhGwryvrw27oW7O6GKD9SHiqmR22lD3gbI8nH8OdSFbc
yLWeBOfREphhISY/y814eg2oe44MarfU2NTlhvb/RUVtfFvW0PEXS5q1KG8P2c6J
NkttfOMtg2oLAmqAKjo46GP2U8Dywal/RHwcl3VTWDCzChs8LkmAxTTqmROkFb+r
6SegMy9mn15FAJPUDhavLs4kXQ2c5HY5wPyr3864tlVwuzImrZlhYzpSpeYbTA/F
4a3t696enOrppp6mTvKI2S/oRxjxMz6DfZSwOoQehh6UFeJOsuryVOefKVedS299
xSFxCTycRWh31QpDH8Gy7HzQXfeRBnoUkwpNKRBVPFEYrsQ9hz3lY+WpXB8uxKc0
WcJBt0sJeCkn9Kh4CoFXgfrD0lSO3uIPqagCwCuiCg==
=icOR
-----END PGP SIGNATURE-----

--Zw8LCl77lEqAzX6n--

