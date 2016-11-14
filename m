From: David Sommerseth <davids@...515...>
Date: Mon, 14 Nov 2016 23:10:03 +0100
Message-Id: <1479161403-12040-1-git-send-email-davids@...515...>
In-Reply-To: <1479153967-6788-1-git-send-email-steffan@...1856...>
References: <1479153967-6788-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH applied] Deprecate key-method 1
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
To: steffan@...1856...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

ACK, but with a minor adjustment to the warning + Changes.rst
file.  The text now tries to encourage not setting --key-method
at all, as that will default to --key-method 2.

Your patch has been applied to the master branch

commit 1ce0638627eb35631af9bfaa569468573568ec65
Author: Steffan Karger
Date:   Mon Nov 14 21:06:07 2016 +0100

     Deprecate key-method 1

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <1479153967-6788-1-git-send-email-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13054.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYKjYzAAoJEIbPlEyWcf3yiSMP/27hFtYCIUlLIaMyvaHWeLqu
Rfizl0PPpXX3Q3Nwi9SJBGwQdMEFf9UJJKMKpBdrVq4ftRHD/qef25pe+a3DxsCY
/l5skP3SXHGf+7EsRvRmvmqXoHArJlJuQy3LYJZF6M7SBw39tDiaEI/p2zFCwgTS
tVmQr0IMs/ZKYKmnDF6LHdUfzpEDkYfe1yhqsO0+nFUdbV6ePZ80xHyGy/BWbypK
QVS6o3uxiCl7CakyxA2Twg7DFg0/64g+lE+OGCEy3rS6IUGB6q/0njAKYqlPp8VP
81ULuFrHXydVHSgy3jb6peakHu1MP2zEKBiaBtPm2nuQ+IgkvoCQIwgmdc39FZDs
DPRheUQXvoUv2Dx2U2ns01SANzpXpQzVsFiyJZqzC59RLLigL9V5CRrPDiw9YozQ
KKQahLf5BtCVNhYwVrlQhrKdYQnoIlTGc6XXU0LR32HGahEHaZDgNmZsLi6I5VUV
XQaKd9SZWozIqwaA1vWisUlJXKyCSkEqK/9fukaa7AyVwrcyRUNttig6Hwh+rbXL
czUxZZaou2TQeDOwtuOOuguNNl2TNo3Xg84JxYxhgBV/LO0+QooTt2s4g8M2BB4y
lbQoZeU9xxG+wsvr7Tq/mt3FfMVMqApaFR//G1VU0n/SeoS+ktF82XyJz8CEN/kn
TPXJUvjlvmnJHQaFZ1CC
=WZJS
-----END PGP SIGNATURE-----

