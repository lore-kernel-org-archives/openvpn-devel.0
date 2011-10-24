Message-ID: <4EA53C2A.30808@...1114...>
Date: Mon, 24 Oct 2011 12:21:30 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1319449145-27671-1-git-send-email-dejong@...1435...>
In-Reply-To: <1319449145-27671-1-git-send-email-dejong@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Added missing #ifdef to allow
 --disable-managent to work again
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Adriaan de Jong <dejong@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 24/10/11 11:39, Adriaan de Jong wrote:
> Signed-off-by: Adriaan de Jong <dejong@...1435...>

Applied to master branch in -testing and -stable trees.

commit 7c785a27bfe5267ee4aac12fe6d0a24c42e388d6
Author: Adriaan de Jong <dejong@...1435...>
Date:   Mon Oct 24 11:39:05 2011 +0200

    Added missing #ifdef to allow --disable-managent to work again

    Signed-off-by: Adriaan de Jong <dejong@...1435...>
    Acked-by: Gert Doering <gert@...1296...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk6lPCYACgkQDC186MBRfroGXgCeMOAdUqK6IEskhbTa6RpT+/RM
NygAniULo59KPmbfEufbrv+bVJHm4WOL
=M39S
-----END PGP SIGNATURE-----

