From: David Sommerseth <davids@...515...>
Date: Wed,  6 Dec 2017 22:09:43 +0100
Message-Id: <20171206210943.20451-1-davids@...515...>
In-Reply-To: <20171204044907.32261-1-a@...2181...>
References: <20171204044907.32261-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH applied] reload HTTP proxy credentials
 when moving to the next connection profile
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
To: a@...2181...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

ACK from me as well.  Code looks sane and have tested this against
a quickly patched tinyproxy [1] with basic auth support.  The client
switched between three different connection blocks, all depending on
which tinyproxy instance I brought up or took down.

[1] <https://github.com/dsommers/tinyproxy

Your patch has been applied to the following branches

commit 86b58ceb29cf1cc3acf32e2ff370d9a4af68c051  (master)
commit fbc50963b9f8a4bac4362d472366730fed23aae9  (release/2.4)
Author: Antonio Quartulli
Date:   Mon Dec 4 12:49:07 2017 +0800

     reload HTTP proxy credentials when moving to the next connection profile

     Trac: #836
     Signed-off-by: Antonio Quartulli <a@...2181...>
     Acked-by: Steffan Karger <steffan@...1856...>
     Acked-by: David Sommerseth <davids@...515...>
     Tested-by: David Sommerseth <davids@...515...>
     Message-Id: <20171204044907.32261-1-a@...2181...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg16007.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth
OpenVPN Inc.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJaKFx8AAoJEIbPlEyWcf3yxJIQAL6ABxeacMYBJuFamF8gEoL+
W0a+grWzL7wNQ7n05pc/2UuOgbpliyGerhBx85VCFPTdYN6JBuVUEEDj67CptVL9
N3zSCbzVxeX21oaLfyoeYVypTopOBHB1rxBhwdC8MBdLBNPhZQ2Qy1r7XWLDX1mH
4vY1SP/X25NJcU71dmDN8zCimEPns/ANTjMf0r8lyQAdvMuSZE5sCRCutwTRNh/S
REAcXHtgFRfmNsmDRRCJvTvm+XiPNNY15EH/NmmHFquZAJuj2GkpGeBYa59q9l3D
tHcPzwes2xc1Te4kbca1tXAx6XCt/6e7FwENCQHCrwC0/NRSdmOFg89BiIZVnodh
L9NbVte8f+jFuV8DuBDqHIQdodry0JKD4YnC+QQhTJChGWwexyimLuxKMNANVEmb
6KRJvaUKzOyrsh8ct6ZMG35AgXM6MKQqMwmP+VB/SJrh6uCOZkxxxQMY5/vXL+hp
Zlzxs9WS/p2MbO9igHcMGXPGBEuzsp4KFKyMBAjrlpCFCFJFJfPPThi2eaiPSkXt
StFkSCLu1CnKifbB7KiLL2YORy3QyITDVshUbaBVZRl7g1Jlr+4UzG48NR9RIWE0
59XGJARegLPtxevO/DyArPOU+Ls5HQfN8YNCIf/dj41GuuYx4AdiKD1KSkClQHRK
83xeFyq2p7wWcIilIXXY
=NQs1
-----END PGP SIGNATURE-----

