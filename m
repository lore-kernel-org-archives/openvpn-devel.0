From: David Sommerseth <davids@...515...>
Date: Fri, 28 Oct 2016 15:16:22 +0200
Message-Id: <1477660582-8056-1-git-send-email-davids@...515...>
In-Reply-To: <1477656607-7440-1-git-send-email-steffan.karger@...1435...>
References: <1477656607-7440-1-git-send-email-steffan.karger@...1435...>
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

Your patch has been applied to the  branch

commit a91ddc99a524014ec79560d873721e8fa81a5631
Author: Steffan Karger
Date:   Fri Oct 28 14:10:07 2016 +0200

     Limit --reneg-bytes to 64MB when using small block ciphers

     Signed-off-by: Steffan Karger <steffan.karger@...1435...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <1477656607-7440-1-git-send-email-steffan.karger@...1435...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg12799.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYE0+kAAoJEIbPlEyWcf3yMJYP/0owxGi9kgHWnU6eg/9yFxgj
GORwUBZFTOCbj6funmVinJ43EWLXY78QcmUcSgiCCOOmapA7IByWNo/4KBMd9ypD
h5hVcnosKEQmcp7hBS8bDV5xb0X+R7JnDUvw1ErGsU2a15C2+80lEg86HX70bkg5
MtkxYY+FK3h9RO53T4a2+RTctukikbfo7Hd3HkDo+MaNY1ZsEwM/GytBko4tHTql
fwGhbCBmL5o8MK9l3M8AUVBgMa5lPvvwnINP0dLyx4obyAscLnQtxyEN63j7CPx6
JjUwWpycVN7jERm78l/kce4/CYSwAtvbYqnQAvn2dioiwSyk155vDYmp9Jslv30b
ojmMpMGaewVTuAUS5/MpE7qNfw2Pl1EBDs8nTfYDvYROIQ+6d1iZ7gLdqJ8Xd75m
c5e9yVkOcyXxLHgeKduCnQYfLmnH+kSQSFnToLupENqeJSjqLD4uiAGwBGwlBp2J
yzbuf0GFvmRcQ0Rjtg26VEocfuASLMnNDK7s4u3iCGPqhvq3umBwIqynBSiPGMbu
qgX/ottDL3QcIZoHIRU2SphQ+dosXwEvnm9zg9RLkFvf7ZJX+02mVTHT/tPkLE37
1q7WQ27Owwm9OkjLrV+wlLbZgOvXWNcpJMMXO4wTyxkGJ0NESjkBt67oY+5ov83F
AEWrOrgWpnoRGUxs/x0h
=WdOO
-----END PGP SIGNATURE-----

