From: David Sommerseth <davids@...515...>
Date: Wed, 25 Jan 2017 19:49:41 +0100
Message-Id: <20170125184941.10124-1-davids@...515...>
In-Reply-To: <20170124143947.27385-2-list@...1798...>
References: <20170124143947.27385-2-list@...1798...>
Subject: Re: [Openvpn-devel] [PATCH applied] systemd: Do not race on
	RuntimeDirectory
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: mail@...1798...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

ACK.  I've tested this a bit, and it is very reasonable.

Your patch has been applied to the following branches

commit 3de7be7b17de879a78eea4afe4c918c6104c635d  (master)
commit e5492222a9ae5d31d69cc9e5cb57dc094cda556e  (release/2.4)
Author: Christian Hesse
Date:   Tue Jan 24 15:39:47 2017 +0100

     systemd: Do not race on RuntimeDirectory

     Signed-off-by: Christian Hesse <mail@...1798...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20170124143947.27385-2-list@...1798...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13939.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYiPNEAAoJEIbPlEyWcf3yG3YQAKxRuzhC5wn8iEfNYlyTyc8+
UTs3L/sU2pp/jNwfcyjVTJxl0B5ZQb/o4Z3Br519dzXYU+UYMHYKwQpAjWDL0pyU
Ma4XF1em4cnadY7AGtKnCer8JBZzIUDyjWZxmKNBOlzXoy5uKETJSxS0snuMJydC
r6IgzsZqASeCUw5Z8s1WdM9bH3H+a6sjaVTgKOkd2VVfpgbTi4cEvhAusON6SFg2
j8PSrdqUwmG5TEUSGr6o8fTwmp0B6EAocMUQGuOzNON3yNifR7KlPDPu2s8IQVZL
ee3mR0KFSaPrMm/EA2eJ7wWlqECCDAndlV4VdFLkJj5eXQ56dlkkPrXbxHSIKJpY
155fqL6aKunj6dDghIK3eoJbMVHSh9L9h6blSPhbZB635w75LILj0a0ocTPsRSvp
OdnVP0sUj3XoWntG5iBYZzV09T9v6xEPMw6GuKskwfeWA5PdGf9qICX1ElpJ0oxm
3Rpo5+UqMQyyDD27jMmkI1bvx5Txs9M2r+JW3MP5+bAqsuIvn1rqjY0N/5EGxJiG
7CdL5TbT5FuO7n+gChWrSRGlKZIERVdOi1XVsstzqDQSBgYgKlKy5+9VEIxX2LKS
fv6IEFwtX6pncOZ+kO/44GI1t8iajKhmDMf3kay8nKVu5UuzLMANR6jK0a6YsZAG
0SiQO+2n1Ly710IcCuqy
=5MIX
-----END PGP SIGNATURE-----

