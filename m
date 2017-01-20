From: David Sommerseth <davids@...515...>
Date: Fri, 20 Jan 2017 19:16:47 +0100
Message-Id: <20170120181647.10199-1-davids@...515...>
In-Reply-To: <1484772172-19758-1-git-send-email-selva.nair@...277...>
References: <1484772172-19758-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH applied] Add a check for -Wl,
	--wrap support in linker
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
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

ACK to this approach, with one commit-time modification (removed the AC_DEFINE
line, as already discussed in the patch mail thread)

Your patch has been applied to the following branches

commit f91ab283a407e25c4b32aecb390911b212ce2694  (master)
commit 2f5f1d8fffcba26d21d47cbcb1e99e0e1c313568  (release/2.4)
Author: Selva Nair
Date:   Wed Jan 18 15:42:52 2017 -0500

     Add a check for -Wl, --wrap support in linker

     Signed-off-by: Selva Nair <selva.nair@...277...>
     Acked-by: Gert Doering <gert@...1296...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <1484772172-19758-1-git-send-email-selva.nair@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13897.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYglP5AAoJEIbPlEyWcf3yDzMP/1LRWOqsbo2T0Wn7R4tgrEgB
GsYNSgBMdIEzjcKCIgZPhVmqhNMTa9gNJYWpJ649KZM/sf5FrP/N4M0hNNoklpLc
6ScxPGnB0/iRGPlKFp+jPvK+WHpDKAidV0TQszHORB2O2BzY6W+hZ7UJIQ7Igb6P
VN6vkzFq49jZiiiBbT9RQErp9o7Pv2h/+7gYoZlw0uhqgfGVzAbtJSQAk817C3y0
px/HUcTH14ANrIKfQNTryUQConMcmw6nJpGJFAP/yL2S8xfGgcmf7uNORprOBTle
Anj5OvJuKRgenCQ03mYyiOLkq38aLBZnLmUBRnHayivwNoXnexBNOh7Xl8Pj1R9l
RB/Vcx6cPa1FNLk4PpqFC5v9ZkBIDj9FWjsrbs7wlsbw7ud/KoSUgklqGNf18tZ7
bJZ4v0eLXmy1IxOVrmWNaFRn/NJJf4sCVoePmMovi0Exoydy3TRL5ZMTOgB3DeoM
BmPow+StIUJYeG8ARfq9BHVhhDr4DP08aOLuECdNGKZexSK1jWZp6wqX7YmKQhdF
OZRhHmxtzy6OzIu9n5XW9I9F1HZZIWWSDsLmhdWSIYCxaDis7AiUrKL04hTgrpoR
6aS06HRUxPGyP35NjwLcvyvpqOsuwlgCHFQ8FEfac0aGYCyCq3hK73III8dTfufw
BW10WDHQUkUzubdzWqSz
=0Y0J
-----END PGP SIGNATURE-----

