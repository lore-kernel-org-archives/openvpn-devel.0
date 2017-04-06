References: <11253b26-cb11-8b7a-02e0-d5b1ad89e199@...277...>
	<2465b076-35e8-6144-f1b8-085ad5a016f0@...277...>
	<e09e9fbc1ce629510c439bbc06569b1a.squirrel@...2260...>
	<f6a87e19-4ac0-4ea2-69f3-2f424cbe8891@...1227...>
	<86ef0241-5144-206a-4691-6713434fdaa4@...277...>
	<20170405204236.GM93896@...1296...>
	<ec5b45716d7fad0f492b19e6c54b82fe.squirrel@...2260...>
	<e6e53a2e-55ff-656d-4eb1-1c4a31403dbc@...2080...>
	<CAA1AbxLMr+vxxNqbmQ3OmJzL2ph9SWq=Snwspy9bJSbkPT0eJg@...278...>
	<3092a563-61dd-9240-b288-190b6f5fc259@...277...>
	<20170406130520.GR93896@...1296...>
	<f02c8610-0e25-9d7b-77ad-381779c4a00b@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <111c81b2-12a6-f8f7-23c0-c13a843b0e3d@...2080...>
Date: Thu, 6 Apr 2017 15:49:32 +0200
MIME-Version: 1.0
In-Reply-To: <f02c8610-0e25-9d7b-77ad-381779c4a00b@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Xbl5hl2E4VQF762ahjooLArkudLDtNGGW"
Subject: Re: [Openvpn-devel] [PATCH v2] Add per session pseudo-random
 component to --reneg-sec intervals
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Xbl5hl2E4VQF762ahjooLArkudLDtNGGW
Content-Type: multipart/mixed; boundary="7R5jF6uFUKpfg56er7x5h87Q4HgLSX29T";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: debbie10t <debbie10t@...277...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <111c81b2-12a6-f8f7-23c0-c13a843b0e3d@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add per session pseudo-random
	component to --reneg-sec intervals
References: <11253b26-cb11-8b7a-02e0-d5b1ad89e199@...277...>
	<2465b076-35e8-6144-f1b8-085ad5a016f0@...277...>
	<e09e9fbc1ce629510c439bbc06569b1a.squirrel@...2260...>
	<f6a87e19-4ac0-4ea2-69f3-2f424cbe8891@...1227...>
	<86ef0241-5144-206a-4691-6713434fdaa4@...277...>
	<20170405204236.GM93896@...1296...>
	<ec5b45716d7fad0f492b19e6c54b82fe.squirrel@...2260...>
	<e6e53a2e-55ff-656d-4eb1-1c4a31403dbc@...2080...>
	<CAA1AbxLMr+vxxNqbmQ3OmJzL2ph9SWq=Snwspy9bJSbkPT0eJg@...278...>
	<3092a563-61dd-9240-b288-190b6f5fc259@...277...>
	<20170406130520.GR93896@...1296...>
	<f02c8610-0e25-9d7b-77ad-381779c4a00b@...277...>
In-Reply-To: <f02c8610-0e25-9d7b-77ad-381779c4a00b@...277...>

--7R5jF6uFUKpfg56er7x5h87Q4HgLSX29T
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 06/04/17 15:37, debbie10t wrote:
> Company A has 1,000 vpn users and (for what ever reason) they reboot
> the server every 24 hours.  They experience the slow down because all
> their vpn users are permanently connected.  They all connect at once.
> This patch is not trying to address the initial connect it is trying
> to address the subsequent reneg's all happening at once.

This is not what --reneg-sec is about.  --reneg-sec does not control the
initial connection.  What you want here is a randomized initial
connection delay when client have lost connection to the openvpn server
and needs to do a reCONNECT.

That is an entirely different feature than reNEGOTIATION of established
tunnels (which --reneg-sec targets).  However, randomizing --reneg-sec
will improve the situation *after* the initial connect congestion, once
the first renegotiation round starts.  At this point in time, things
will start to spread out.

But I emphasize again, --reneg-sec have never tried to solve randomizing
of the _initial_ connect step.

--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--7R5jF6uFUKpfg56er7x5h87Q4HgLSX29T--

--Xbl5hl2E4VQF762ahjooLArkudLDtNGGW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY5kdsAAoJEIbPlEyWcf3yhGkQAJCD6rowIFF64mTRUjvsDAqr
aU1HAElVrWG2N/i2Tz8QSzUsnSLNBesLChs69jz1EQrZ6+nQnXr8rpFxj5hSQPgS
99vH8iOw537JNQP9Uec7A0i2vsYXZ5b/czmyuEi2Dzr53DiGHf9y5wZ2Ep3Bqrie
bVG+kUX05s8XxddjAgkex63FhhXbXlf348ZV56TPiMvP/MjfwdWnJqpI/ROwHBwD
WXlnW7sYRK5ua77g2xiuH1z+1noTLPCvB6bEp0KMRGzftlLz6lmihOt9qgcshD1O
RlIgQl6oLtZ2/WNExcIjOKL9xiJUUXboXPPgcHY+ndU/jXLwkM5qlCffXxPNYeIv
7OBkuO2s0pVmaP79f/2YiF3PY3G8kjUBq6HnxEc0I0UArWlDrfJzdgLuQqaACxwk
Dwk8Zc2fCo+EvjtdxQtjyKZLE9sIMIjgrdeIklLUIQpyEWhdC6nRk+9mK+00XhMU
0eLyQPLSguEH2H8DcDCEqKl3j1HuxJLQsudsR36a2SZ8B1FAl3Aeu0uIO3zPosx1
iKWypjkx1ycnFGXOWiP8aV+kAkCc88+UQh8K8E+LYyqt+IQuOp+AiMRmzEiMJ7CW
FnOIBlJvDJ57Nbi8g+vd1wvkHwni0syVjHIJyqZqBGVqEUwg34cZN8/2SgRdMKVW
DU3koAiGKcvuSY54CzoY
=YXin
-----END PGP SIGNATURE-----

--Xbl5hl2E4VQF762ahjooLArkudLDtNGGW--

