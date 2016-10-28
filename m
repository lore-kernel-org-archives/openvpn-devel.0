From: David Sommerseth <davids@...515...>
Date: Fri, 28 Oct 2016 15:16:05 +0200
Message-Id: <1477660565-7933-1-git-send-email-davids@...515...>
In-Reply-To: <1477655821-6711-1-git-send-email-steffan.karger@...1435...>
References: <1477655821-6711-1-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH applied] Limit --reneg-bytes to 64MB
	when using small block ciphers
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
To: steffan.karger@...1435...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

ACK.

Your patch has been applied to the dev/pre-push-hook branch

commit 752caece99a61e516386f94823e82ddf13fcbcab
Author: Steffan Karger
Date:   Fri Oct 28 13:57:01 2016 +0200

     Limit --reneg-bytes to 64MB when using small block ciphers

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <1477655821-6711-1-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg12798.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYE0+TAAoJEIbPlEyWcf3yPZ4P/08Gs7c8NXaER8G6dMY6y95g
ZHCwOSjBJaQpdHVZE4gnSq/pip+49fQjf4gz5g/xb+NgxSQqtzfYYRsmc2y9cOJJ
xj5jRzrJnrTgWEFumVJ3/4byzz+2WkkWVfeR+JUXyenwor4biyUbFyVbTVJcGFfO
GZRY+ZPoNjBMlbWyIAIit0O83XsdDnVd6aur1d1WK9HQsUTaYkkv4q5WS42vIWCn
CCrq0EN3V/vi6OnRQs2zQhYiV1/UvlojOuobLr9w5koeduKVtPsq0+7JM6a1+sUL
GuofhGWDlNtisoYO22g2RSluc//pwB1Ur3KyaXTvq/3o2ViwJI14ohK1sQWuFOgv
PZzH/eZ0lc4UN80kNskJ26e9QLD+/LQtSZMwlkNS1iL3oL1WfQRrn+yAzzr551GQ
HyK9q1zw7T5FPT0j3qnXfkn5HiwBv0SWjWipD4ot1OW+9fK/0StaI+cIHitWrPNl
FzJauLfAt9wOSFAaPePRlxz5fIRVWZ3I/1hK93qF7JhQMfCIkncyvn7UKAPgYAUc
SBGndYtLNkbBgfv/9F+1k8cHH8wcRNAPdexVdqrbM72I0K155Sl5eNoY9Gn1+A3s
JzxGGoEq+nF223fXVfQzNZ5jzKUx4NgWfe8Qbm3qJ6Ul9ZCYacan2to6kwR4YT1p
gngtP5O9S54N8L/FiWKJ
=z8RU
-----END PGP SIGNATURE-----

