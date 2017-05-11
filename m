From: David Sommerseth <davids@...515...>
Date: Thu, 11 May 2017 18:39:24 +0200
Message-Id: <20170511163924.722-1-davids@...515...>
In-Reply-To: <1494493257-8125-1-git-send-email-steffan.karger@...1435...>
References: <1494493257-8125-1-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH applied] Don't assert out on receiving
	too-large control packets (CVE-2017-7478)
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
Hash: SHA256

ACK from me as well on this one.  As Gert already said, patch is identical
to what we applied in master and release/2.4.

The Changes.rst file was updated on-the-fly, removing references to
tls-crypt, which isn't available in the v2.3 releases.

Your patch has been applied to the  branch

commit feb35ee5cac605edddd6e9dc62941e2c53f96fb3
Author: Steffan Karger
Date:   Thu May 11 11:00:57 2017 +0200

     Don't assert out on receiving too-large control packets (CVE-2017-7478)

     CVE: 2017-7478
     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: Gert Doering <gert@...1296...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <1494493257-8125-1-git-send-email-steffan.karger@...1435...>
     URL: http://www.mail-archive.com/search?l=mid&q=1494493257-8125-1-git-send-email-steffan.karger@...1435...
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZFJO6AAoJEIbPlEyWcf3yygkP/0fXxoxHtE+cGLA4ts+dqhsC
/zGDm5JuJox5hLIm4BN88vtLCRJTXlQ+JyvQw4n7LWhrqaNCuWMPR1Q3f+di3734
0ltIH6IyTmfPZbdL/2Zd2SnMIDDhuJ6M+D3Vs3ZfN+uP6mRPsaEsSekJ1gsj4wC3
6Pcl3yi/6sI5k8aCFFNvLRaAUv5/XngQxcJa4b6TAqO7ADQ/Fd5URv6Xkvw7269U
GCbDYL8h92dwOuhGFgF/mi02MmKP8Qz78CxIPQNjmR+3PB5hhsnepUf6YxoabMcx
tjT0sVlJ6+kcc1Ot0pNP3r5xXhIWPrJOXxX5rMvW7lb0esYZe8vD1fh2NmhdcKwv
ngjvk5Eb2u4oRsjYQy+kdwivuI9fGppqNFFsyU1LG1LhO5Xtlip5pwSQeCxRscUE
aJkQS+Y0DF4MfrJYP/0hr97Sabk5cm1kIXJ+EQri89Sqa8uB4EH26t2Wy0dS6DcA
U/Dhtk1HVQ/bjV9mQoQgarNZc51FvOQJUagP1s76JPOIl0L7LQefs7ZcmFYGBJ2q
MnXtWZH37C3lCUm/33lHIs9darbRHcqJPKjECU/7xjRRUdPcuy6L6WcLSptO4u4g
un3lRuu5/hlx9f1P6dMxtRpd1Nd/oWwcNRSzc4K9byr7wuR74NGbWRmbHwB2gLKi
PrH002aRQraZzmKSMZQf
=OjWV
-----END PGP SIGNATURE-----

