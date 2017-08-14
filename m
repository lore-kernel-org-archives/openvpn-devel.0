From: David Sommerseth <davids@...515...>
Date: Mon, 14 Aug 2017 15:52:54 +0200
Message-Id: <20170814135254.21007-1-davids@...515...>
In-Reply-To: <1500573357-20496-1-git-send-email-steffan@...1856...>
References: <1500573357-20496-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH applied] Always use default keysize for
 NCP'd ciphers
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
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
Hash: SHA512

ACK.  Checked code and ran a few quick local tests where it was observed
that --keysize was reset to 0 when NCP was active.

Your patch has been applied to the following branches

commit 956bb1c32fa40ee184919b3ce569c90643a01b5b  (master)
commit 6f616aa6b7570db965b8eee1d8b8d182af4bb05f  (release/2.4)
Author: Steffan Karger
Date:   Thu Jul 20 19:55:57 2017 +0200

     Always use default keysize for NCP'd ciphers

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <1500573357-20496-1-git-send-email-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15110.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZkaszAAoJEIbPlEyWcf3yRloP/0fYFXg2FbBw1wC7kr45K9DK
aOWseSiHZy20TcrPxUJySy8prN6LopyDf1HNsWkPmOWA7duZwZLio1n4Hmh393ew
ooXHH/iNkp4CWWppAf7Z+nzN0Wn1pH2yHchbtZoT+rLqLQP5Rgt1y94yb6gx1FC5
JfBw99weWvVfvrvFDXdJlrnDJYoJtoyfd6Z+gJL2n+DBkoHPTaxN6yU28raIzksC
gvs2j98WAThiIfTMbstDiR2Qxz7/puIR0xDZkzQkgLnq8jV5uoH4jvnHJFbQO3Wa
cPuBHQguTsKe/q2si9y0qhLQ8zURdVy+yTOgzPDHueVuRJs7deeXbDClf1Wfn+dd
RPdH4DQoCjsjDZ+AFyPCEn1hora1ulFpnVE97pWnFUIlTeRVIJ9P4r9/z4iABGmp
TVfvapucdED0VKxeYqyZYlEXHK3Vxg7eruS9f2X7gPwTYJbQ8DvKqigZIuBjMEcE
tGkzt4A3XNSbtHHcgdssI2WVInhRPQG1Y0YFSxPNLw5SYlkY2zlUlVCHROoOZfBT
AilgH3kygPgymf+k+OLxVCCm8HL8TC8DD/YxczV8i6kKkvMbIQfR+wM1i592eKSQ
Ryi4md7F+FJUfnDUB0JT07FK95jFF7ANStq+vhj9TyzyV3v6ktQVF3t+pgv6djyF
YLY70Eu/WV15iXBZnddU
=582X
-----END PGP SIGNATURE-----

