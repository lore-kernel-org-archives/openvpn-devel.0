From: David Sommerseth <davids@...515...>
Date: Mon, 26 Dec 2016 13:24:05 +0100
Message-Id: <1482755045-23545-1-git-send-email-davids@...515...>
In-Reply-To: <20161225105919.25792-1-gert@...1296...>
References: <20161225105919.25792-1-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH applied] Remove IV_RGI6=1 peer-info
	signalling.
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
To: gert@...1296...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm adding an ACK as well.  I can confirm that the IV_RGI6 peer-info
signalling have only been available git master/v2.4.

The first commit introducing IV_RGI6 is 3ddb56433b1fa0f2.  This commit
is only present in the following tags:

    $ git tag --contains 3ddb56433b1fa0f2
    v2.4_alpha1
    v2.4_alpha2
    v2.4_beta1
    v2.4_beta2
    v2.4_rc1
    v2.4_rc2

Your patch has been applied to the following branches

commit 392c9e47f6418612bc2a4932faf22bb711e65a54  (master)
commit 554504c5e2692c3e6cfd3feae10c9d5c8ec363f8  (release/2.4)
Author: Gert Doering
Date:   Sun Dec 25 11:59:19 2016 +0100

     Remove IV_RGI6=1 peer-info signalling.

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Steffan Karger <steffan@...1856...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20161225105919.25792-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13706.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYYQvRAAoJEIbPlEyWcf3yJXkQAJeHh5orvaKC5oPhMvhPIThy
T3UsXTYpuBr7siGbYxMRCKvDublXR+89UT7wp3Z49/4evrr+kzykPEItYqlhUiyE
8pxiuKaPtlr1/Ru7RP04DTiUyATAK9prAqj0aXvJGRf3aMHH9zQt344n4r8XBkPP
FDWh8lqhrCYmPuX1aVMqvKf6kw268jVX4ODqJTkDWlTgqfKvvBfBAoZXvtqYaEzj
7OEyKAUb4CDXY6ARnvdhLKLdZS58QwPTCvvHOMcQqLOaowIntFcD31qpM9uKJTe8
d+KkEQJ7WCs1Lpmu5BXdA76YxnaaoNzWxa/XQlcIMN+6mOmzbZ46zoHqWM0PE4jA
jIG3qSZtQLHWk95EnaFOcxYVOfaRcQMShJVgju1HEs4oe5/FEomaTebgqhxi7n5A
NUklyubIehreFwy5JW4787rPX0U9cliMZlYZtGlLNDhF61z/3RQ+G/u6OpMX1d0l
769ZG7HtgnT6TJwpCx6zPCVDuOnYHVHaMqV+UfQQugkFQhfC23fQfTyFK/X/xVg7
0uN1GpxZvPnp1x2v9QxmJuKBj5oqdi9c/ck262HIHcXibLSEIvKXUdzQRnZUt6LQ
4mAFVzsxRn0h/18hFpjraVff/+46sR09tP6mZCvOX94Jnwz4GxY55qxNPX4G4ByE
3KBT19lY6pueJHz9LEyU
=lsLW
-----END PGP SIGNATURE-----

