Date: Thu, 12 Oct 2017 09:55:32 +0200 (CEST)
Message-Id: <201710120755.v9C7tWUO015310@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20171010231130.6832-3-simon@...2293...>
References: <20171010231130.6832-3-simon@...2293...>
Subject: [Openvpn-devel] [PATCH applied] Re: RtlIpv6AddressToStringW() and
 RtlIpv4AddressToStringW() require mstcpip.h
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
To: Simon Rozman <simon@...2293...>
Cc: openvpn-devel@lists.sourceforge.net

Your patch has been applied to the master and release/2.4 branch.

commit 55305a2fc66a768cbbf152da9092400590504574 (master)
commit 0e91a2ddb79f34a8cb361cda2f4d4a1df39d3c18 (release/2.4)
Author: Simon Rozman
Date:   Wed Oct 11 01:11:20 2017 +0200

     RtlIpv6AddressToStringW() and RtlIpv4AddressToStringW() require mstcpip.h

     Acked-by: Selva Nair <selva.nair@...277...>
     Message-Id: <20171010231130.6832-3-simon@...2293...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg15582.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


