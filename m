Date: Thu, 17 Sep 2015 20:10:18 +0200 (CEST)
Message-Id: <201509171810.t8HIAIaE095934@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1441985627-14822-7-git-send-email-gert@...1296...>
References: <1441985627-14822-7-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: Implement handling of
	overlapping IPv6 routes with IPv6 remote VPN server address
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Patch has been applied to the master branch, with the change Arne has
proposed ("because it makes sense" :) ), making "bits" inside
route_ipv6_match_host() unsigned and drop the "if (bits<0)" check.

commit 3ddb56433b1fa0f20565dfda13a647459c06251a
Author: Gert Doering
Date:   Fri Sep 11 17:33:43 2015 +0200

     Implement handling of overlapping IPv6 routes with IPv6 remote VPN server address

     Signed-off-by: Gert Doering <gert@...1296...>
     Acked-by: Arne Schwabe <arne@...1227...>
     Message-Id: <1441985627-14822-7-git-send-email-gert@...1296...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10089


--
kind regards,

Gert Doering


