Date: Sun, 24 Nov 2013 14:55:47 +0100
Message-Id: <201311241355.rAODtlnW019730@...1729...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1385064495-25877-6-git-send-email-arne@...1227...>
References: <1385064495-25877-6-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH applied] Re: Fix two instances of asserting
	AF_INET
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

ACK.

I have applied this patch slightly out of sequence, as it makes
--http-proxy and --socks-proxy work using IPv6 to connect to the
proxy (ASSERT(af==AF_INET) failure otherwise), and does not rely 
on changes introduced by 04/14 and 05/14.

Patch has been applied to the master branch.

commit 500c16f319e21ae9590a2207d0b518f8e57abdde

Author: Arne Schwabe
Date:   Thu Nov 21 21:08:07 2013 +0100

     Fix two instances of asserting AF_INET

     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1385064495-25877-6-git-send-email-arne@...1227...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/8010
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


