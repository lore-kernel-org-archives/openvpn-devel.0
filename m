Date: Sun, 12 Nov 2017 21:22:58 +0100
From: Simon Ruderich <simon@...2161...>
Message-ID: <20171112202258.hat3hetjonkv2pxc@...2161...>
References: <20171111161836.23356-1-a@...2181...>
 <20171111161836.23356-3-a@...2181...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="=_zucker.schokokeks.org-26048-1510518179-0001-2"
Content-Disposition: inline
In-Reply-To: <20171111161836.23356-3-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v5 3/3] ensure function declarations are
 compiled with their definitions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_zucker.schokokeks.org-26048-1510518179-0001-2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sun, Nov 12, 2017 at 12:18:36AM +0800, Antonio Quartulli wrote:
> --- a/src/openvpn/crypto.h
> +++ b/src/openvpn/crypto.h
> @@ -459,6 +459,9 @@ void prng_bytes(uint8_t *output, int len);
>
>  void prng_uninit(void);
>
> +/* an analogue to the random() function, but use prng_bytes */
> +long int get_random(void);
> +
>  void test_crypto(struct crypto_options *co, struct frame *f);
>
>
> @@ -514,5 +517,10 @@ key_ctx_bi_defined(const struct key_ctx_bi *key)
>  }
>
>
> +#else
> +
> +/* use plain random is no crypto support is compiled */

Minor typo, "is" -> "if"

> +#define get_random random
> +
>  #endif /* ENABLE_CRYPTO */
>  #endif /* CRYPTO_H */

Regards
Simon
--=20
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9

--=_zucker.schokokeks.org-26048-1510518179-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO7rfWMMObpFkF3n0kv79t+RMMvkFAloIraIACgkQkv79t+RM
MvkCrhAAoP/b8NYVkPzIjepfXKgyGrmttGXT7l6K0o8RTjEviKVOnLPBqQrYPWMd
l+Awpwlgbi1GPLm4bJYRN0aYeB48w5+RwJkTbnzKH3781Vw+UBKVRqMyndUErWE+
wmkiuohRMuLsMfp7+E6/ADnKuwCFKuE5Zpc+UIqDw+BuCX0qcVq3DBI0qY7lwUAL
npxNgOy1yjYE3uEfvTuK/OXwfIEZbK3lO/xpgjQiKgtGR4ICeQ8M1V+EtzAXhnfD
phqd7ucr98Zb/MbYHAZC9qwkO8VR8KeHgTVcPqoi2zhsGmMQtVwANOvCP7sxty0K
KVBxULtuaONPtg9GqG0p9e0onPSDokNbYN+H4nTbbnCuummvRbhSE4OUCS81taHp
LziMryOXPNbJ9WiSMvJXREYgUDhqYjeZhez9reewurdeF/a59mH7UUAZvOCSXJFV
ZybXcf4P2kt9aIs3bUeWUXXaKMmqdY2EjaJB2cZ7n38J0/ndQ0Vts5/JbpmaOEdD
FX8/rpZun4llvDI9QymLWLGeEJ6ezNnvRScVAKDLb8XdNjaFPerfsGga0lg7CwPA
BjwZFccfm+T5jHkdwV4NTP4Spuwgg/oBu8JW0N8JXhStnliM18yXLwAE5vmyloaH
EKlbClNmyGkwofNf/W0sewA3fVSQ78EcelinVIPYL8k8cKbBy1Q=
=kEuE
-----END PGP SIGNATURE-----

--=_zucker.schokokeks.org-26048-1510518179-0001-2--

