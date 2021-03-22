Date: Mon, 22 Mar 2021 09:54:11 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210322085411.GG976@...1296...>
References: <20210321144627.1621-1-simon@...2293...>
 <20210321165045.GY976@...1296...>
 <487884f67f874d438ca181de91399c52@...2293...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="CWYje2kLmgZipIV6"
Content-Disposition: inline
In-Reply-To: <487884f67f874d438ca181de91399c52@...2293...>
Subject: Re: [Openvpn-devel] [PATCH 1/5] MSVC: Disable LZ4
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--CWYje2kLmgZipIV6
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 22, 2021 at 07:29:30AM +0000, Simon Rozman wrote:
> Thank you and Arne for explaining this. I should have followed
> the discussion on the OpenVPN meetings. Unfortunately, my workload
> doesn't allow me to follow on anything these days. So, I am not in
> condition to prepare LZ4 building in openvpn-build/msvc either.

Understood.  Thanks for sending these patches anyway :-)

> I can live with LZ4 disabled in my sandbox only.
>=20
> Shall we drop this patch for now?

I have set it to "Rejected" (and the discussion is visible in patchwork).

"It should not be so hard", so I'll try to talk Heiko / Arne / Lev into=20
it :-) - might actually be easier than getting generic/build right for
MinGW.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--CWYje2kLmgZipIV6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgWFsyAAoJEB2Cnv7KVigS2pkL/AiAxpuGnn3oonsWoHajX4e6
tyjKzs+lL+jf8M96gs3jtoD/2DKhvBCV61zAEMiHNZQSbq1IyoMtI3djs4heT+sc
/8ZnfE2IqQIz68OIrRlp39rux30IoC39J13ApFKn6T6Z2o9LQrGEp3aUDrSctsy4
yTwQerqCLbGtgdyE9oe8dKFBhvdAyzvlf+6w778ucW9wkfnO1ODQIElXcKa9P1Lm
JqDUORwNuMTFyZbBFWTZmr8eZ2yhzklER6Ht7NuEoGbZ/SaTKsPvQAkUakmJ56RT
duY9FQDuxNzJz+aMvLiQdZacP7FV5CMZi94kZkgoQZ8B1tI4QetIVbuELMdobuYz
yZaAilNGvLuZbRbobWFG7T75ZRCfZ2Sdboam2j7zsfOQRNZegFSi/y8V9bzeRfHS
KaoqticEQMWZqVr6wBIYZ80hNsavDmJb7TTcksMc+EDWLrDDmapckYtqQGNm93ky
n8YvS6JoG53diHESmxtbyd4DU5WwE1LJi317oYeEaA==
=9jRn
-----END PGP SIGNATURE-----

--CWYje2kLmgZipIV6--

