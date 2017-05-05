From: David Sommerseth <openvpn@...2080...>
Message-ID: <b9a70fef-feda-053c-bd96-c2b0e74c576a@...2080...>
Date: Sat, 6 May 2017 01:21:21 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6NLuG6T0cB8434dBorK10CoNvxe9pWKLw"
Subject: [Openvpn-devel] The future of contrib/keychain-mcd
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6NLuG6T0cB8434dBorK10CoNvxe9pWKLw
Content-Type: multipart/mixed; boundary="N9Q7V60nEAvFT9emhhCQn8LXdSQ3G1GhH";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Cc: Vasily Kulikov <segoon@...2008...>
Message-ID: <b9a70fef-feda-053c-bd96-c2b0e74c576a@...2080...>
Subject: The future of contrib/keychain-mcd

--N9Q7V60nEAvFT9emhhCQn8LXdSQ3G1GhH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Hi,

We have had the contrib/keychain-mcd code under a more thorough code
review lately.  And there are several issues found during that review
which really needs to be improved.

Basically most of the functions handling memory management have a very
ambitious coding style.  The result of functions allocating memory is
never checked, just presumes it is fine.  That will in most scenarios
work perfectly fine, until the day where one of these allocations fails
and the rest of the code starts tries to use a NULL pointer instead.

I have tried to get in touch with the contributor (on Cc) directly two
times in April (12th and 21st) already and have not heard anything at all.

We in the core team would like to see this issue resolved, but it can't
drag out forever.  So I propose that unless someone who is interested in
this code shows up within the end of May 2017, that code is in high risk
of being completely removed from our source tree.

Please do get in touch ASAP if you use this code and would like to help
improving it.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--N9Q7V60nEAvFT9emhhCQn8LXdSQ3G1GhH--

--6NLuG6T0cB8434dBorK10CoNvxe9pWKLw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZDQj4AAoJEIbPlEyWcf3yTWEP/0nSHwKCt0dt/Y9hUFZlzf1b
4Vh+U+7DFtUhMq/5oQtilLmi8MVhM9C9gdt28tlXKoKnioIrd7I84U6L5GQDiIbY
owKI8qWvYX8eDu9BAF7h4CLrEtcbWf3opknxkB+1DYme2FI5f5/4Xx7b7OAeboFZ
Ag/vDZP4ddYmZbbwIUDgqE7KinxrYsg+DOA0AVmpswJ/GH1VBy+JAkAoruFU4kVP
CKzKmDTK1qX4De9nXeG23ACouv4z/0S4g+jnKinoFrxcynRQ8kie9emTfC2OMwyO
UKaOSF0LIBPKdI6vLGD3BnKevB9PnmIx63vByhclAF7pAOGslMMBfrhXMD38lvsD
B/6pLKmPKYDZWKn2FdPRDJR9I4rvc/IrB1Cqh1nOnhhM6t7y4hBcRUuISoGTVzhq
g9VqdA4nrLU3GRm2Y1rCpSmWU6isRVHZx7c1RLQaJOMuHXRjubHdKQNGfbJS8drr
jW9nODgG84YWa9hCHYcSOa3w6wTJ0JICiVYe6HCP0q/yTQjX2CwG2BCyBpkJyCUU
RALy7mDTXQc/Fn6nZak4WPiu0XrwVVqs+Zp3eDFBHwr+ZCHzbUA3AAfHKtywB/sc
tXD1H28/eoAnO2Buoef2NfQGfGhbLwLUvlqKCdul/DO/pCnuzrK/BYum+zl4e9fa
ubczYCSg+YJE+wzOiqg1
=9vsa
-----END PGP SIGNATURE-----

--6NLuG6T0cB8434dBorK10CoNvxe9pWKLw--

