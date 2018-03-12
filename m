Date: Mon, 12 Mar 2018 17:15:31 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180312161531.GV69387@...1296...>
References: <1520817479-17203-1-git-send-email-selva.nair@...277...>
 <20180312082122.GP69387@...1296...>
 <CAKuzo_hnjcLSAi0PxFUC+KxtahUAgdt_qRMKZJCsjvmT3WWLvQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="mnamcX5BDF+ZiagH"
Content-Disposition: inline
In-Reply-To: <CAKuzo_hnjcLSAi0PxFUC+KxtahUAgdt_qRMKZJCsjvmT3WWLvQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Skip expired certificates in
 Windows certificate store
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

--mnamcX5BDF+ZiagH
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 12, 2018 at 10:37:53AM -0400, Selva Nair wrote:
> Agree, this could qualify for 2.4. Anyway, the context is the same and
> it applies/cherry-picks to 2.4 without issues.

OK, thanks.

> Elsewhere in the code we only warn about expired certs (like those
> read from a file) and continue with the connection to eventually end
> up with the unhelpful "TLS key negotiation failed to complete. Check
> your network..." error [*].  In that sense this is a regression. IMO, the=
 client
> should error out on invalid certs from other sources as well.

Well.  In other cases, we do not have anything else to try, and when
Steffan added the "oh, this might have expired!" warning, it was much
better than the "mysterious TLS handshake failure" we had before.

The reason it's only a warning was a conscious decision: our clock might
be wrong, or sufficiently different from the server's clock that it
actually *could* be valid on his side.  So we print a warning so it's
more obvious why it fails, but try anyway.

But I do not have strong feelings either way, so if "you" (for an=20
unspecified value of "you") want to change this to error out, fine with=20
me :-) - I just wanted to provide background.

gert
--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--mnamcX5BDF+ZiagH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJapqejAAoJEB2Cnv7KVigSPV4L/RK5K1iR3+fWmgUnclsOxFzv
aqRNxbofdnmnZWxViqkE08j5POl1gN4vU8jCMYFiadCcOLDbv5HwQIJy7MSgqn1g
7t+agP3QWqPwp+KmNCAUFY8lf8pnDsayI6cDKGrpwkkaHzadXpF38ZCHHP4p+1QU
6NS6ZKaFKvFIcLpS3ZEMGb0WHZC+U8bKqPEdsQcYvw5dsApSIhScTQbq6h0tJJUl
8dsMt7gP19Xt3l7vwjtJr2rsLUxPq2ftbP9mcTx2Cqul7+sxz5K+AzgmWSZWkLYo
3perFvsnG3LCuCUR0Qn8oavUgR48wyer/UIDoQBLBZcUGQmnIyu8u/yq2REbWNES
oAZNqaib8g50p7+wQkkXH2ZQi+nYF3kt3pjSjn4L01kjJQUE9HHpsuJwVOfRMVkT
c8ZArp1U76CLwCl+hC+JMgpaGDLSo/zxCXfVbmCE6Dylyvdtpw6oTMmTO702AunY
bvvV4Pi5Un8RiK1C6aCKqx/Q+b6TOI0nO52Xco5miw==
=wgxG
-----END PGP SIGNATURE-----

--mnamcX5BDF+ZiagH--

