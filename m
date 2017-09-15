References: <CABMULtJc_dvbLPwmVTP9Y4+Y6bGPnCT+nmCjk38fDQC4OaK9Uw@...278...>
 <20170915153547.GL70062@...1296...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <9354c1bb-13d7-d719-347d-b68dcdcc1c1b@...1435...>
Date: Fri, 15 Sep 2017 18:21:59 +0200
MIME-Version: 1.0
In-Reply-To: <20170915153547.GL70062@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="FGW4Nh5Tf8U5eJkJda8odPE15EWU79nbM"
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN per client cipher
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--FGW4Nh5Tf8U5eJkJda8odPE15EWU79nbM
Content-Type: multipart/mixed; boundary="9JgQ7j1Pqa6W3jn14FUFmHSAoj1H5mhSq";
 protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <9354c1bb-13d7-d719-347d-b68dcdcc1c1b@...1435...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN per client cipher
References: <CABMULtJc_dvbLPwmVTP9Y4+Y6bGPnCT+nmCjk38fDQC4OaK9Uw@...278...>
 <20170915153547.GL70062@...1296...>
In-Reply-To: <20170915153547.GL70062@...1296...>

--9JgQ7j1Pqa6W3jn14FUFmHSAoj1H5mhSq
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 15-09-17 17:35, Gert Doering wrote:
> Thanks for testing the per-client ccd cipher patch - this is definitely
> useful.  Interaction with NCP needs a bit more thought, it seems.

Yeah.  Until now, we've always said "NCP trumps --cipher".  I guess the
question is whether 'cipher' in a CCD file should trump (ie, disable)
NCP.  It might be what users expect, but it's also somewhat
inconsistent.  I think it's better to have people explicitly add
'ncp-disable' to the ccd too if they want it to trump NCP.  (I'd need to
check whether that's allowed right now.)

-Steffan


--9JgQ7j1Pqa6W3jn14FUFmHSAoj1H5mhSq--

--FGW4Nh5Tf8U5eJkJda8odPE15EWU79nbM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJZu/4rAAoJEEEwndWOY1w5APoH/RX3tjHLJDzSUP7ryHAMX+Gu
Sn7QyHYefTe1QVA0vChHjOzXTefcg5vlPKjO572v1a/Tr5COTDgUGyljK4BFQCNv
4v15camgyXR5El5Uh9x8VwsB2l8IYnuZv5nV9gexPbTiYcK4MvnT8r4A3vR/3o55
XpBzh6aJj/6TxwIc6BKzRmc4EaRIfugOOKfXA/f97N8fB3D30MM7Lcw8hB6K1U+d
jukG11Q6ZpcuHr5evIEzhjCaXVIZZmdMS4QEHM7VbxXQq0740jXO7GEqaTj4dqnf
H6ar3ZD2nW24r7Cz1xW4NxdmrIDfeEu795eiTXFGJiu9aFgmQxvBc4BhXTVZxiU=
=vec+
-----END PGP SIGNATURE-----

--FGW4Nh5Tf8U5eJkJda8odPE15EWU79nbM--

