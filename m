From: David Sommerseth <davids@...515...>
Date: Thu,  7 Sep 2017 01:15:34 +0200
Message-Id: <20170906231534.24330-1-davids@...515...>
In-Reply-To: <20170827161515.2424-1-gert@...2298...>
References: <20170827161515.2424-1-gert@...2298...>
Subject: Re: [Openvpn-devel] [PATCH applied] Warn that DH config option is
 only meaningful in a tls-server context
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
To: gert@...2298...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

ACK.  Glared at code and tested a simple client config.  Works as expected.

I did one simple on-the-fly update, prefixing the message with 'WARNING: ',
which is what we do other places where M_WARN is used.

Your patch has been applied to the following branches

commit 47a0a80b7718fe88451c82bdfe838e5a6e3c4248  (master)
commit b1298bbb2be73e978bb5b555d1bd8722cf9b28b0  (release/2.4)
Author: Gert van Dijk
Date:   Sun Aug 27 18:15:15 2017 +0200

     Warn that DH config option is only meaningful in a tls-server context

     Signed-off-by: Gert van Dijk <gert@...2298...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20170827161515.2424-1-gert@...2298...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15332.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZsIGVAAoJEIbPlEyWcf3yTjUP/2aub3MTttpcfCDw4t+zjrH/
oKkvQvpEdH7+ynec0o7GJOw9eZ3/ejSIiZ4EMPFTCyUes/Bd+zfgM2RWvnJd7Jxe
D7TbSOj0nF56Ywn8rlVh9dM4BsS34yte4cpYnWLf3JJ3tzzihiAA2CQOxP0V95PE
Lqesq2rXbxvjV05fjvjSHxsgC6fHZO8zR/1aBKBeghD3rB67iKnjGcNZxnqULIop
e/20EcTlzyXOtqcWQnqqmdY1umNYbrNurBBxI8WcpDK3i9cRGjnc9+pEqkmfAHEE
DzAKnpThDhoSvJo/wpvMJmBQUm741I0SQdasGB9lNFNyzjcvOuxt8oXR9rcp+FZX
vnKZnfV1haA9pgyuJERUt/EIkvQP3QvRKqfvZpJy4fioaWZav/uOsRaXWc8z11HB
okUV6CfwnpB7ltEKkrYm3xabiQE0OvAKVkZNVK1vfdKI0O9Qm9E1z8rwmCMnAfQv
YLJ95cYHVS2U9ch9dP148/AXa9d+HKeg6Xh/FS2OD92jtBlZI374QKhbERmhaE1q
YeIPqMc2sulSVOUTx2IXRKCFlZhr6LwYtDWtm0PeZraom4iyXIf6b8Aq8LwfeU6d
cp44vk/Ob8Zz9Vk26Tf3zgRzn1RV378HipKXn3w0wNmmLYAO0jox+IvO97rXfKaL
kWmHx5qUQ4wnMo6dBL74
=aY2R
-----END PGP SIGNATURE-----

