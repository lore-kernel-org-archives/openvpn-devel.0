Message-ID: <52C4754D.8080805@...1856...>
Date: Wed, 01 Jan 2014 21:06:37 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <52ADF633.8040003@...1856...> <20131216073024.GC161@...1296...>
	<52C0AF83.5010501@...1856...> <20131230205032.GH226@...1296...>
In-Reply-To: <20131230205032.GH226@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Use RSA_generate_key_ex() instead of
 deprecated, RSA_generate_key()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi,

On 30-12-13 21:50, Gert Doering wrote:
> Could I ask you to provide a patch to remove this for 2.4?

Sure. I fixed some extra stuff along the way, I'll send a patch set in
a minute.

- -Steffan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJSxHVEAAoJEJgCyj0AftKIvVMH/12ohgqRLO7K8QwImJdMfRPE
rt+YIhHOyIxD+II4gRnBoDb1OlDVMLXUyPxpj9mjwq6dh0bBSfsacHCdVB5AyzTn
uejpbESoCqLCoK0fnoVHZpecIf5vyiIpv9a9wBgwrpN0ZEJn2vHfvw4vILYTT9cU
SXkgTQdFB3EjoKFatTXNT8om+jgapnkQpHoOZ2GMMkTXnLNWHwmV5C9mzkAYdDVY
/MN6nrU52LK1b5fZ2Fk3sP7Yk6K9qY80RAw6CVZy9NsTgv8wmKvza1Zz2QewfjLP
VwzvHjncrelt9J/izgQJlWFLJ5D3W8QmomttDfjpmSzgv4WPtzDaOV7zPKsYbn0=
=NRPZ
-----END PGP SIGNATURE-----

