Date: Sat, 27 Dec 2014 15:53:09 +0100 (CET)
Message-Id: <201412271453.sBREr9VF021807@...1295...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1418905506.21260.6.camel@...1866...>
References: <1418905506.21260.6.camel@...1866...>
Subject: [Openvpn-devel] [PATCH applied] Re: Make 'provider' option to
	--show-pkcs11-ids optional where p11-kit is present
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
To: David Woodhouse <dwmw2@...1866...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the release/2.3 and master branches.

Thanks for improving our pkcs#11 support.

I have taken the liberty to fix up some whitespace to conform to our current
coding style - which we intend to change, but for the time being, we stick
to it... - only whitespace, nothing else.

commit a91a06cb291414c9e657377e44f7a57343ae7f5a (release/2.3)
commit 7c1d614c5c5282a73cb799f919eac6750363783a (master)

Author: David Woodhouse
Date:   Thu Dec 18 12:25:06 2014 +0000

     Make 'provider' option to --show-pkcs11-ids optional where p11-kit is present

     Signed-off-by: David Woodhouse <David.Woodhouse@...753...>
     Acked-by: Steffan Karger <steffan.karger@...1435...>
     Message-Id: <1418905506.21260.6.camel@...1866...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/9355
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


