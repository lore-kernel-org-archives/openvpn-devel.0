From: Arne Schwabe <arne@...1227...>
References: <20200717134739.21168-1-arne@...1227...>
 <20200724140407.22393-1-arne@...1227...>
Message-ID: <1b9f890e-5646-825d-a75f-b2fe29a19220@...1227...>
Date: Fri, 24 Jul 2020 16:16:00 +0200
MIME-Version: 1.0
In-Reply-To: <20200724140407.22393-1-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lW5svGezDjFYzy8POgLnrtpFoo3lnZkKu"
Subject: Re: [Openvpn-devel] [PATCH 10/10] Add a note that ncp-ciphers is
 replaced by data-ciphers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lW5svGezDjFYzy8POgLnrtpFoo3lnZkKu
Content-Type: multipart/mixed; boundary="3NWtO2jh6Mk0N2YsfsEz0bthEC9d21GoY"

--3NWtO2jh6Mk0N2YsfsEz0bthEC9d21GoY
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 24.07.20 um 16:04 schrieb Arne Schwabe:
> This patch adds a message that informs the user that the ncp-cipher
> is renamed to data-ciphers. This should address the following concerns:
>=20
>  - Users being confused by old options.
>  - Nudge users to use the modern variant of an option
>=20
> The man page already documents ncp-ciphers as an old name for
> data-ciphers, so looking it up in the man page will also work.
>=20
> Note that I did not add "deprecated old option" to this message
> since I still think that eventually removing the option will only
> break configs and we gain almost nothing from that.
>=20
> Also still accepting the option even though we do not recommend usage of
> it also follows the robustness principle of:
> "be strict in what you send and tolerant in what you receive"
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/options.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 5beaba0f..01f0ca0f 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -7939,6 +7939,11 @@ add_option(struct options *options,
>              && p[1] && !p[2])
>      {
>          VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INSTANCE);
> +        if (streq(p[0], "ncp-ciphers"))
> +        {
> +            msg(M_INFO, "Note: Rewriting option '--ncp-ciphers' to "
> +                        " '--data-ciphers'");
> +        }
>          options->ncp_ciphers =3D p[1];
>      }
>      else if (streq(p[0], "ncp-disable") && !p[1])
>=20

Sorry, send out an old version. V2 incoming.

Arne


--3NWtO2jh6Mk0N2YsfsEz0bthEC9d21GoY--

--lW5svGezDjFYzy8POgLnrtpFoo3lnZkKu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8a7SAACgkQFRhsZwKx
RFQCBQ/8CotUV30JQgXc4jslnr/aE6jJQKGeYbAgxwvuyE6u1pxQRRYJZbDpaBdJ
CyOin7/uC0II+DEeQ9dqvuFU1DanBpQzBDZeUc+gQy8YxTwjGL6FsTtE8YBLuxOj
M7pa5vuvWwFi5+K7gUGRqZWJhjj+L+Dx4WCUbwWlmIv0JgeSROaBwiFgVIpdhyME
IC8kcPy0qH1sqzXMFK3a7dWKrFrRffVNKiDWdpqZ1PfV4c460dUYaq7W9Lr6/0tO
vxpmMcITS+QZmhCTzyLVEP7+QCp9B3yNacVGiYxKgqFj2SGe5QResssGUxTrfR3u
+rxl1kjvz5KXq+Yfr0J4TEe2BPVESoVgSVAbOFlfrfQ+pd3YTwULI6/6tUYNJrPr
VcAvVXL9T5LwIpnFpYSDyADNBTAdUW1aPsVT1x6tZuyfNY17yCMeW0X9wQEPzojC
8z2KthSLRGKgZZ0LeL++RXy/cH8q4NYazXUItFmP9WXA+lwGeLN5cMwDRcLPjG5S
oOn4HGNBhEI9sOXqiBGaHx7i1ohpQLIMoCx7kL3gh4B7t87holCz88jgYInkkS5i
mvjfs3TBptPDXHBznHDw3LoTPIgxc2aeNXNXkcEhjgLKXJLipZe+YfrDLqOfurAo
zDI2YXIRdCtrIU7cPUG+0b5QeOa14hzBjL2EHHyS+fLIncjR6c0=
=34tL
-----END PGP SIGNATURE-----

--lW5svGezDjFYzy8POgLnrtpFoo3lnZkKu--

