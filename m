Date: Mon, 18 Sep 2017 10:31:16 +0200
From: Simon Ruderich <simon@...2161...>
Message-ID: <20170918083116.w67qmug4imxyjmns@...2161...>
References: <20170828085620.23186-1-a@...2181...>
 <20170828085620.23186-2-a@...2181...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="=_zucker.schokokeks.org-28118-1505723477-0001-2"
Content-Disposition: inline
In-Reply-To: <20170828085620.23186-2-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCHv3 2/2] ensure function declarations are
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
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_zucker.schokokeks.org-28118-1505723477-0001-2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

The patch contains conflict markers.

On Mon, Aug 28, 2017 at 04:56:20PM +0800, Antonio Quartulli wrote:
> [snip]
>
> diff --git a/src/openvpn/occ.h b/src/openvpn/occ.h
> index 369ebac4..f81e68d7 100644
> --- a/src/openvpn/occ.h
> +++ b/src/openvpn/occ.h
> @@ -90,6 +90,19 @@ is_occ_msg(const struct buffer *buf)
>
>  void process_received_occ_msg(struct context *c);
>
> +<<<<<<< HEAD
> +=3D=3D=3D=3D=3D=3D=3D
> +void check_send_occ_req_dowork(struct context *c);
> +
> +void check_send_occ_load_test_dowork(struct context *c);
> +
> +void check_send_occ_msg_dowork(struct context *c);
> +
> +/*
> + * Inline functions
> + */
> +
> +>>>>>>> 5222207d... ensure function declarations are compiled with their=
 definitions

Here.

> [snip]
>
> diff --git a/src/openvpn/pf.h b/src/openvpn/pf.h
> index 480d5b7b..e588f0e0 100644
> --- a/src/openvpn/pf.h
> +++ b/src/openvpn/pf.h
> @@ -104,6 +104,21 @@ void pf_context_print(const struct pf_context *pfc, =
const char *prefix, const in
>
>  #endif
>
> +<<<<<<< HEAD
> +=3D=3D=3D=3D=3D=3D=3D
> +bool pf_cn_test(struct pf_set *pfs, const struct tls_multi *tm, const in=
t type,
> +                const char *prefix);
> +
> +bool pf_addr_test_dowork(const struct context *src,
> +                         const struct mroute_addr *dest, const char *pre=
fix);
> +
> +/*
> + * Inline functions
> + */
> +
> +#define PCT_SRC  1
> +#define PCT_DEST 2
> +>>>>>>> 5222207d... ensure function declarations are compiled with their=
 definitions

And here.

Regards
Simon
--=20
+ privacy is necessary
+ using gnupg http://gnupg.org
+ public key id: 0x92FEFDB7E44C32F9

--=_zucker.schokokeks.org-28118-1505723477-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO7rfWMMObpFkF3n0kv79t+RMMvkFAlm/hE8ACgkQkv79t+RM
MvlEGQ//bmFPSN7J8oy5k6owYvjJRVIoFovSTdsx1GuUA2M1HLFUnw2aVVUul20t
ruhrnPCN0rq9+jzgqsRnJqLAvZZ8o0UGzW8wjAaKVj66IHuUPkvG/GqQJcfWrP3A
nClsywmVykoY3U57o/YHvI/ungpTuUcfXa6hJtjlFgXJ3gVJIDsv4MfETGVLbwzk
VIPSwqRRTN48/CLJFpDuKtQrtSGmvUqTmcL9uFCIfOve3eEGdzga4iGeunqQtlYl
pbI4yhj5umpcVafvy9PSaCam4ayDvzdolf6FSzc+BeBV7vYi9iD1T/mNQi0y2BGV
s4AVPbtBla/RjcVwFHnkh5xpLQmcfktz6iE8RWBjiDHtK5ufuXxB6zoIWwIeFuQS
Vkwe0RY1+WsVa9JUVIgV6Pxtc9CgO+ItPBiC3Be0I6F7wK3j0bwyEdANQHZlUm2o
fwsIFT6SYjIohmRo7e+S+Ts9Toq7LSH2vzWa/TI18+Ywv3JneF93d2G+HBJzZBoE
pP53gu+zBXs/06Oy5d57neDQRXUmaZI98Nqk5I2Yus2SaE1F6OfVPFwP9RLV6etN
RTp/JFSgQJN0LSyUGUvzoggKplqL+ljt40ZuOcL5Pp16a7MX2lZEGSooTlpXkOF9
OavqB6i2lYqKMYUkeqryktgYUyMf36s1Rml6zRiy5YabC+QM9Go=
=TCJ3
-----END PGP SIGNATURE-----

--=_zucker.schokokeks.org-28118-1505723477-0001-2--

