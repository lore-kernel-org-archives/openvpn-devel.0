References: <12f1f4f7-0b03-3f45-c06b-aec77e4e1ef1@...2181...>
 <20180308202303.6492-1-steffan@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <596506ef-7229-8d5c-f772-bc94473fe408@...2181...>
Date: Mon, 16 Apr 2018 21:03:16 +0800
MIME-Version: 1.0
In-Reply-To: <20180308202303.6492-1-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SpYF1X2wyEiS6prDYqBClOniplyNmWf1w"
Subject: Re: [Openvpn-devel] [PATCH v2] tls-crypt-v2: add specification to
 doc/
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SpYF1X2wyEiS6prDYqBClOniplyNmWf1w
Content-Type: multipart/mixed; boundary="yeI7rczMXlIC0iXvGscFfn8XhvOBopWH2";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <596506ef-7229-8d5c-f772-bc94473fe408@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] tls-crypt-v2: add specification to
 doc/
References: <12f1f4f7-0b03-3f45-c06b-aec77e4e1ef1@...2181...>
 <20180308202303.6492-1-steffan@...1856...>
In-Reply-To: <20180308202303.6492-1-steffan@...1856...>

--yeI7rczMXlIC0iXvGscFfn8XhvOBopWH2
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

there was a comment in my previous review that remained unanswer.
Please, see it below

On 09/03/18 04:23, Steffan Karger wrote:
[CUT]
> +   The metadata is checked *after* the OpenVPN three-way handshake has
> +   completed, to prevent DoS attacks.  (That is, once the client has pro=
ved to
> +   the server that it possesses Kc, by authenticating a packet that cont=
ains the
> +   session ID picked by the server.)


just a thought here: the metadata is actually created by the
server/provider and it is authenticated/encrypted with the server key.

Isn't this enough to ensure that its content is not malicious and thus
allow the server to parse it right after having received the
HARD_RESET_V3 (instead of performing a "three-way handshake" first)?


Cheers,


--=20
Antonio Quartulli


--yeI7rczMXlIC0iXvGscFfn8XhvOBopWH2--

--SpYF1X2wyEiS6prDYqBClOniplyNmWf1w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlrUnxgACgkQB6U8WA7y
zXQ1Fg/8CqtPEEdQWvYx4MRq0YmmNfAtVLtVge2RgxTUfSh82zy2tQBDkkfcwdiL
ideFlC6ivXNhTgp+Y1W3khrGVIdNUVkyWLHkw63QObz8UfSe6d7AUz0YJ2lmDbLr
TJlmCPg3XMdpmyzozuwRlnj7eWZgQZ8F34ZY4ZJnTliv9NW1hCxEGPd641DcGdnk
0LzbQ1LHOt53AaAahIRzsjFTG7y05cjrxcWBtQLwvBqMAtR8FUqRV6s6HSIddV3n
e3Et3Mc4QGRra/FPsYJeodvJTzGwFRVHnKjveUWO7Yv2FLLAe9qirvDiHrqhdRzf
BRCZW4gUNeQIQh4ghuh0ROeXtwpthVEvgfzUQHYmfXDUERO4nb2jQ2+3N8+WkZCk
bFESRp3wXtBAFCE6wB40f1Dvt0QcMIoulE2YI1U0+lqU5tZzc1lkvRtTvUb4iHwC
aTj8yGQXkQ3PrgkDkk/2Iq5IKmN3LVTSwTtlILDkkJUj+kwR9DlcVZNmsdzKjMDf
8Ex/mKXBFCeHB0BkN04ZccJBI11yP8RvZwN/SswvvFJFt+t2YIpsf3tjo/zmNX0U
j3Sp4kvsbCqzP0HBl41XfiMtN4eVPmtcCQ9NQBm8xpBYJFF4xPHDLaeEPB79eEfC
7crzflR+u3gfIlLpvi+082gKDX+YLNK+ZJAcC8Vpi3fx6hQwiSc=
=JJBE
-----END PGP SIGNATURE-----

--SpYF1X2wyEiS6prDYqBClOniplyNmWf1w--

