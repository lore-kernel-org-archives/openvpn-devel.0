From: David Sommerseth <davids@...515...>
Date: Wed,  7 Dec 2016 04:14:03 +0100
Message-Id: <1481080443-3186-1-git-send-email-davids@...515...>
In-Reply-To: <1481067951-28917-1-git-send-email-lstipakov@...277...>
References: <1481067951-28917-1-git-send-email-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH applied] Arm inotify only in server mode
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
To: lstipakov@...277...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

ACK.  Also tested using the reproducer in Trac.  This patch
fixes the issue when OpenVPN is built using --enable-async-push.

Your patch has been applied to the master branch.

commit 7084a3993fa35c6fb71abe8aac7b30f442205e2a
Author: Lev Stipakov
Date:   Wed Dec 7 01:45:51 2016 +0200

     Arm inotify only in server mode

     Trac: #786
     Signed-off-by: Lev Stipakov <lstipakov@...277...>
     Acked-by: David Sommerseth <davids@...515...>
     Message-Id: <1481067951-28917-1-git-send-email-lstipakov@...277...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13415.html
     Signed-off-by: David Sommerseth <davids@...515...>


- --
kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYR342AAoJEIbPlEyWcf3ysysP/jfNdapMwuRJ8hhqJFMOvMzg
ss+EOhWpZHzC7RJfBUeYWVdXMMGL+I8beKGZTHoC1DEPkVOV4wg2FHB0wpvIQMja
BrEo/AiCBUrMC5eiIn8IO6b6ATKQih/oD07GcECcSZ0/Vica3goP1hVik7JUkAZA
2fsDjGh+5g4KfObHMaTjpID9UfQV7wsPU/C2pWc0ywq51CZXingWQnWwaYKS93OZ
i7EKxQrWy0Nxs0YhzloVI/2k6mcwwP0mzeZdQ+imhjtuXoYmSisXxUSNDrwvgYUN
byMb4qhcuuDRquR3mRO0jjVR7nlL68NDlX57Z60ocbxskZBzhfxMM1/CkXgVLC5L
TBU6IHaTWn/5/d4jo4aA50sDBQohu73Yf4/SnqwcWURsui4yJCejVQTFeKyKPxiD
CQ1T0n9swXRsgYqsKioZHv3Mywaciq5y3+3BpJ9oGg9mfYcoQxQ5kJNY6jjIYC3C
xQiFFP92bqi7d761bKhwsJU//DZ4FRwqWihhkUL9VJ4WhZmVdrJjYEcyknnRPm1F
/Woc9V2sBhIZ00VCfvu0WNvLb1w40q6PV695uqfOQzjhPuhXp3q0ZEOp76ArqZqN
OW6DjKodACCZKkSP2Ef1/9jsmXmL/46348FVBSa4Qbr7PNRlHe1LjTYQSg/aS1y4
T33QanBd0sAGstvfuf2C
=Lcf0
-----END PGP SIGNATURE-----

