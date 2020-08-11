Date: Tue, 11 Aug 2020 11:10:06 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200811091006.GA75094@...1296...>
References: <20200810143707.5834-1-arne@...1227...>
 <20200810143707.5834-2-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="TMgB3/Ch1aWgZB1L"
Content-Disposition: inline
In-Reply-To: <20200810143707.5834-2-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 01/17] Refactor/Reformat tls_pre_decrypt
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

--TMgB3/Ch1aWgZB1L
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Aug 10, 2020 at 04:36:51PM +0200, Arne Schwabe wrote:
> - Extract data packet handling to its own function
> - Replace two instances of
>           if (x) { code }
>   with
>           if (!x) return; code
>=20
> - Remove extra curly braces that were used for pre C99 code style
>   to be able to declare variables in the middle of a block
>=20
> This patch is easier to review with "ignore white space" as the
> diff is then a lot smaller in that case and the changes more obvious.

Generally, the patch works, and makes the resulting code better - but
we're not fully there yet.  There is a funny germanism with "packet()"
showing up as "paket()" [which I could fix on the fly] but there is
also the labels at the end of handle_data_channel_pa(c)ket() which=20
are a bit awkward now - "done:" is not used anymore, "error:" is only
used once (so the caller could just increase the ->n_soft_errors and=20
jump to error_lite:)

So I'd rather not merge it "as it is"

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--TMgB3/Ch1aWgZB1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfMmBuAAoJEB2Cnv7KVigSQ9sMAIGmWTRVim0wFkECZ1PO+e2R
yeisOlDl6ijaQbmRAy3hgDfQqZwC7H8CiuLHL6pnsiY5MTJnOzbwYf3q6dvENzSq
HWNEqI5aDlbNH/qpelNb4s91QWbWdBinkm4PYBfgFEhNr2P6Es/4+ccU+j3xFYt7
VuDXChKuNzuF/yF6+vko3H1RxHdg4tUxxGsBxvWFfak99wX92Ilr/t6ZL0wep2a+
uhcsiQaRLVCZK8C/tGT9wzh2sADDgwHQaOyTwl8zb2y6DSUNC3cJoZ3y5tRFD8IB
cRh/8Ky7Wo/i2MxaUtcqq0mpSu5IbEifNo7ujWCTIoB+z9y5eEtuM4Mf6ANKWN8J
q+NYpPgnp6KazFniHdmGiWmCWrK5v4CQvJ33DzLU3BpFEIRLjogpCKrn3li/eVJh
CM+4MsakXuz2Jsd7y9Nxyl1OvvzOd9ls+1geVTGj+MnwJKbULKaHZsMooazdehsw
WFSq1LN5X27Ogai4kdF5b03SclCWbw9I4LwYf2Tmbg==
=l1HD
-----END PGP SIGNATURE-----

--TMgB3/Ch1aWgZB1L--

