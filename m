From: David Sommerseth <davids@...515...>
Date: Thu,  7 Sep 2017 01:05:08 +0200
Message-Id: <20170906230508.23217-1-davids@...515...>
In-Reply-To: <20170816170450.10415-1-steffan@...1856...>
References: <20170816170450.10415-1-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH applied] tls-crypt: don't leak memory
 for incorrect tls-crypt messages
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

ACK.  This code looks good.  Hard to trigger to fully test it, but
it follows the usual coding paterns we have.

Your patch has been applied to the following branches

commit fca89379c53fe2c145db96a5bcd32327c4bcfa78  (master)
commit db52b6df6915d38a269bf68767faefd9cebf33bb  (release/2.4)
Author: Steffan Karger
Date:   Wed Aug 16 19:04:50 2017 +0200

     tls-crypt: don't leak memory for incorrect tls-crypt messages

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <20170816170450.10415-1-steffan@...1856...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15282.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZsH8VAAoJEIbPlEyWcf3yEPkP/iJBHppjZLB98538ylLYRXZg
QaT6ElLrbKr2fI6glC5dc63KUCNRv/oov1hR6RWfmWSEyjjaVj4xwzAt5eXq4us5
kiDvaqdWKQZORaPLMlYm46CC2+UJycgpgm0Nqi71GftSuJ6nbSVhGb/G7FFLkZHK
eqeTXq8ApE3XI2cL2DOE8jw6z8l4wYop8EMt4eXRcOJAcc2paby55LdlGkleuqG3
iDD+bF7KNinme5XLgR2ujyOhwJJg+EUycEnwsKB6w3tRK+kfdG0/UG/AoXJiBebX
cA5zFBgu5lXIJ1Dhtw8opvjpbt/x2FoVczMiAxNw7hHSv0e6UlNHUhkLHki3xxnj
Lhv3/2Zz228VIWkofv41bBNmyXxWaRlNeved9XJNZdGq/flLXEnZYZfxBi5T8UEz
gZDRv/k8NeYpgo3rPuwbtQUQ2oBRU0QF15Excm1qmG+7EMWt5/NowOjVD8N5QS9K
PQlT4TfkCbTj6BIlCY9ZoMgC3LlM68Jwen/X54/Pa0Nty+BUX+sKxGUYkjWNrt/A
E6FhVH+sh4YYdP9942qbXfqpoVgx49puoZVsUGvi+fblc8OtvOfjh4kxKS5JKWDl
ozfFJ4kdFJG4LVyniZqm6wCeKOl8G9dULchOcLulKysN0nCGme98XsQogZIwhwWk
vko0BRTINgNBTppWMM3W
=KYjg
-----END PGP SIGNATURE-----

