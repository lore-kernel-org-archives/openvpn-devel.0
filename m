Date: Mon, 23 Sep 2019 16:34:31 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190923143431.GF40538@...1296...>
References: <20190923133224.13899-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7cm2iqirTL37Ot+N"
Content-Disposition: inline
In-Reply-To: <20190923133224.13899-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Only announce IV_NCP=2 when we are
 willing to support these ciphers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--7cm2iqirTL37Ot+N
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Sep 23, 2019 at 03:32:24PM +0200, Arne Schwabe wrote:
> +        if (!(tls_item_in_cipher_list("AES-128-GCM", options->ncp_cipher=
s)
> +              && tls_item_in_cipher_list("AES-256-GCM", options->ncp_cip=
hers)))

What about AES-192-GCM?  What *exactly* does IV_NCP=3D2 guarantee?

Can we have something nicer for cipher negotiation instead?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--7cm2iqirTL37Ot+N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdiNf2AAoJEB2Cnv7KVigSurwL/Rt99oSaBkV5ITf5OYUFMKbK
CsgEmDQyGvai5o4+sI/HYcyEk6JxFEdkf16iUaKcJDQKKH+kbhNbZkcZ9hzB/VMX
QY77YqTkbu+QLgQr/WA06XUHKZZCbjfTXUnGvE4F0Prs/iN1kZbF6qOuLSTUNcBg
mUIBVl9B2Tr7p3BUXZX1JPcxVDJMfggf55a5I0XppvgSTuiCle4eeUZh6nAMmD/c
bQN9m+2aMgUpBNEXdvMZcBFmIsEqPhzI7SafDfFPnLfx/xkQll7FUYAHrrahfaCd
/jg1FfYpJZfWTbbwzTEJ6R9FPB7lk2QQwuAmCoD3FuTLTsEDr0jq4rOfPu9xqTVQ
aCxNARMNE2uKZWLycDf2NxcfhpBs3+UicaFYw15NYg39r2nC0xzt7mCLlKZ4hBga
3EqTrSK7gGrUbMUDpC4BHYMZXABLWxrhtNONOIEJqfs/Ds6DcS3LhmLQXF2FdNZZ
taHbtsmaweCAjXBmAinoj4YBJmVGi6KdP3tOQ1t12w==
=D6Fg
-----END PGP SIGNATURE-----

--7cm2iqirTL37Ot+N--

