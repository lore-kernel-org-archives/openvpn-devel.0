From: David Sommerseth <davids@...515...>
Date: Fri, 22 Sep 2017 01:50:08 +0200
Message-Id: <20170921235008.5891-1-davids@...515...>
In-Reply-To: <20170907095530.15972-1-a@...2181...>
References: <20170907095530.15972-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH applied] tcp-server: ensure AF family is
 propagated to child context
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
To: antonio@...515...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Your patch has been applied to the following branches

commit 682e7feac3bd57e6ce7e60504cb4da5c894d0e18  (master)
commit b3b7d073ce05fa6b11a28f9e70d66c4907274db5  (release/2.4)
Author: Antonio Quartulli
Date:   Thu Sep 7 17:55:30 2017 +0800

     tcp-server: ensure AF family is propagated to child context

     Trac: 933
     Signed-off-by: Antonio Quartulli <antonio@...515...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <20170907095530.15972-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15380.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZxFAuAAoJEIbPlEyWcf3yLi0QAKqWdmij1JLt2kA7Ww0Qcgkc
pixB3s0Ir5J51ZIOodYlcN8hyoRXCdLe6EX3mjumZEMvwJ7XWDa7yrr3t9WZBgLN
lpW1M8jCvlevBc0sLNguFmQn++3ZDYhXN1HiDLep7hdIQrHaNGf4n4VRMtZjlITz
h2xyVUDTFCuCXFDAUFIxhYngdfdn3ySWXu6RmgK4MewMGoZ8qIPrVHgjsqvBpFUr
/tTnfMxZQ+fdmSth2MfWbGRapW5E7LXv2EdRiqPnhG9mhZABUHKWbL74MdUaU2yV
h2dW209/ufQ9GfviRy2pLLc7XsE5LljoRlkYsB9NlDw7dA1NyVYTq6XrgcZcngbg
pSFllWqVFPBvt5l7nBLY8ZcaCezFV56QaOmor8moDiKAEty0cPlweqIjCFIQakap
POcBcDrzX1i5ZDC7/njCeri/KHqhhGI1irWCzJCCqdHhG0zOOCfLyruaeINqoD3A
Uke/QmTzO5C6opIbGgIzalcF94BucgKFeLxsAfLuvknZxmIfS46u/OWUxUKTDzaN
8322lkeTSntCldxY0mL9b3mfhkcUsycFl88QAALIfda5Aea5aTvfYuIrzkC1D22N
/yoVZ0S2+tLnU607PTYxkqGNLbxGaovN/hUfoXU9DIP4alnsPrR30ZrPVCXxM9By
Ul8auE5SiGSDBdPctczF
=8SRp
-----END PGP SIGNATURE-----

