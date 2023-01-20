MIME-Version: 1.0
References: <20230113235754.1942385-2-selva.nair@...277...>
 <20230120094100.2063883-1-selva.nair@...277...>
In-Reply-To: <20230120094100.2063883-1-selva.nair@...277...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 20 Jan 2023 12:13:33 +0200
Message-ID: <CAGyAFMWh=4HSAX5aEHbm8_qYR9_HqOwpei=9LAio5ye4m19Pug@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2 2/2] Cleanup route error and debug
 logging on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

Hi,

Stared at the code and slightly tested - works as expected. Nice that
we display interface id:

  add_route_ipv6(2000::/3 -> 2001:db8:0:456::1 metric 200) IF 74

instead of device name:

  add_route_ipv6(2000::/3 -> 2001:db8:0:456::1 metric 200) dev OpenVPN
Data Channel Offload

Another thing which would be good to improve is a consistency between
IPv4 and IPv6 log messages:

2023-01-20 11:59:56 us=265000 C:\Windows\system32\route.exe ADD
128.0.0.0 MASK 128.0.0.0 10.58.0.1
2023-01-20 11:59:56 us=281000 ROUTE: CreateIpForwardEntry succeeded
with dwForwardMetric1=25 and dwForwardType=4
2023-01-20 11:59:56 us=281000 Route addition via ipapi [adaptive] succeeded
2023-01-20 11:59:56 us=281000 add_route_ipv6(2000::/3 ->
2001:db8:0:456::1 metric 200) IF 74
2023-01-20 11:59:56 us=281000 IPv6 route added using ipapi

 - for IPv4 we print route.exe command line (for debugging I think?,
since we use IPAPI), and we don't do it for IPv6.

 - for IPv4 we print "Route addition via ipapi [adaptive] succeeded",
for IPv6 "IPv6 route added using ipapi"

Besides that, we use capitalized IPAPI spelling in delete_route. That
function could probably benefit from the same
refactoring as add_route. Anyway, this is not really about this patch.

Acked-by: Lev Stipakov <lstipakov@...277...>

