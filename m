Reply-To: openvpn-devel@lists.sourceforge.net
References: <1538576212-2363-1-git-send-email-lstipakov@...277...>
 <CAKuzo_ijYi_qnpRJmNOUQpg9VEsPeqSwZS5d8VYuMNcMDNgw-w@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <8ddfa02f-4003-4a20-5cce-6bb5d8e70e89@...2080...>
Date: Wed, 3 Oct 2018 17:41:09 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_ijYi_qnpRJmNOUQpg9VEsPeqSwZS5d8VYuMNcMDNgw-w@...278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="WoypGDhNJQzgJqrSuxI5nsVqXP5OlGp7j"
Subject: Re: [Openvpn-devel] [PATCH] openvpnserv: clarify return values type
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Lev Stipakov <lstipakov@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WoypGDhNJQzgJqrSuxI5nsVqXP5OlGp7j
Content-Type: multipart/mixed; boundary="bn1RFXH5bJM2tCzrEMBpcD67UYGwlC1fb";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Selva Nair <selva.nair@...277...>
Cc: Lev Stipakov <lstipakov@...277...>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <8ddfa02f-4003-4a20-5cce-6bb5d8e70e89@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] openvpnserv: clarify return values type
References: <1538576212-2363-1-git-send-email-lstipakov@...277...>
 <CAKuzo_ijYi_qnpRJmNOUQpg9VEsPeqSwZS5d8VYuMNcMDNgw-w@...278...>
In-Reply-To: <CAKuzo_ijYi_qnpRJmNOUQpg9VEsPeqSwZS5d8VYuMNcMDNgw-w@...278...>

--bn1RFXH5bJM2tCzrEMBpcD67UYGwlC1fb
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 03/10/18 17:08, Selva Nair wrote:
>=20
>=20
>     To make code more clear, change return type to bool. Also
>     use stdbool.h header instead of bool definition macros.
>=20
> We do use BOOL all over the service code (unavoidable with
> Windows API), and bool is used in only one or two places. So would it
> be better to just change this to BOOL/TRUE/FALSE and not include
> stdbool.h?

Several years ago, we started towards a path to get rid of the BOOL/TRUE/FA=
LSE
stuff, in favour of stdbool.h.  And when we moved towards -std=3Dc99, this =
made
this move even more reasonable.

But ... are you saying Windows C compilers we use/support does not support
stdbool.h?  Even with -std=3Dc99?

I would prefer we switch over to using standard types instead of our own
"workaround" solutions wherever possible.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--bn1RFXH5bJM2tCzrEMBpcD67UYGwlC1fb--

--WoypGDhNJQzgJqrSuxI5nsVqXP5OlGp7j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJbtOMVAAoJEIbPlEyWcf3yJSAP/2H0bOOFn4F1wGHuDWrghYEM
HBgabGchkuwZkkvL14fXJmNnocgliKM1zx0dtvRXcNSb8ALFqTxTFz0TaXA8FVWn
N4flJqY8BUHryFHksoPvHWq+vJJ4M2olTjWdK68P85xDoN5QlQO9S0ah7lOr12Di
o9ho/ZwCQPGZx26uUB9/PrW3hdc8wa/+vvFJ+S25l2m3vxtAHcLipcB0DMAt+Tef
nXHOdVuA0wSiT903cyS+tAybcHZIXIdrcRdBqaZgj2Z8ca2gRMDScb7qWg5t6K81
/BRZq3MJ2l2Gt7JP+dot1+rcDKeu7jjnz0oT9bsY1QAQqBGqtVVPoyuRazlp0sez
RTYkeaoJ3WuNe7CpEfhlgSDaEu634JBdveMr+ihQzmTfn3WYEenSXAeRYGxgybDA
uJaUwdgCDxOSIeDt4ptlxAxMKpMKan+BGfxQ3T8aHSuqC9AZDJXRvvypvG2ut5g3
Ac+JXzvG/LLKMiFZEQbiyePzSbCsQGK3hMaPZExVXQ8T0d/zoXLa4EDipYF6RMhR
bZKTvlvde71//GVq+JiyrTa+ibiD82ggm/zkNm34U34j8eqNyvKwptRd5Wq4+ti8
LibMAfbly8Q+qpszPUGxf3NIsRG9JFvL8RB63l/LaP+FLQtNHlZ3KMF9AUpUtOE1
a5B8ImWGZEseaaTqTSow
=p8g0
-----END PGP SIGNATURE-----

--WoypGDhNJQzgJqrSuxI5nsVqXP5OlGp7j--

