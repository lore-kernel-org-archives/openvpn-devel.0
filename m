Message-ID: <20040203222308.GA7843@...85...>
References: <20040130120412.GA12576@...85...>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <20040130120412.GA12576@...85...>
From: Christof Meerwald <cmeerw@...83...>
Subject: [Openvpn-devel] Re: Socks proxy support for OpenVPN 1.5.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Tue Feb  3 14:24:04 2004
To: openvpn-devel@lists.sourceforge.net

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, 30 Jan 2004 13:04:12 +0100, Christof Meerwald wrote:
> I have added support for Socks5 proxies to OpenVPN 1.5.0. It should work for
> TCP and UDP client modes (but I have only tested it in UDP client mode yet,
> because that's what I plan to use).

I have now also tested the Socks support in TCP client mode and it seems to
work, but I have discovered a problem in the Socks support for UDP.

UDP packets might be truncated because the Socks server adds a 10-byte
header to them - here is a patch (against 1.6 beta5) to fix it.


bye, Christof

-- 
http://cmeerw.org                                 JID: cmeerw@...84...
mailto cmeerw at web.de

--fdj2RfSjLxBAspz7
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="openvpn-1.6_beta5-socks.diff.gz"
Content-Transfer-Encoding: base64

H4sICFYZIEACA29wZW52cG4tMS42X2JldGE1LXNvY2tzLmRpZmYArVVrb9owFP1MfsVdK1VA
EsgDKA2jYtM2adLUVmunfbQCcZqsJY5sh9Gh/vf5kfAoUFg1hGIpvvfk+px7j6M0jsEuKJAc
Z7M8s91WD40xD7stQtP7dvm6NdkOWO0Ztm0fBKjdFhl8wWMAFzw/6HQCtwee43QM0zRfQ6/d
FVgn+uB5geMHjqMTRyOwXad3YfXAVKvrwWhkwCnOojQ2wACAdtMwxdKED9GvgnGIaTjFwNI/
GGJC4cenG7glkwcGrMhzQnlLh7flksZQJzlPScbsSyajUE7J/AkxTGeYNlQo6I1QwSMFj/JQ
LhxTBvUz9cqCJZCA4KQxMEyZLsqDPeWNQ4YjIBnwBINt8yKzp7yw8ZzTEJZfaOn8tlw26hXx
SMQjFY8iHKcZjhpGdEBweRrMd+pdbb0mdxWzrrZzHnjdwDl/Te1l3guxO+K/Ervbc6XWcrlQ
Si/UsTMOIX/KB0LxUrWP3z5f1cdF3ID34DqlUPeCd8CUEirJFy9EAKI4jFAhWlGFDyoaV1t9
vQPvhiCA4CXQkXwm+8+cHMFn8oJPxw087wg+k20+u+6Kz45/brkOmGrtrjEqGJAIZbPCcAg3
36/vrpEYl1mnZGGhWdX8U8zKjoaN/LWpESrUpuFc9bY5FLIoFU7TWPQm/Px65XuGvQEIQ3hM
swekz1LKEeXod5r5nv6AJTW0xNSQqZwonf6WVOEZjwwfWUBOWDrfQCnP9Q+VHMbYsLGKVYl4
CQ6cncEOgo9pRrZ3ttnh0Wbbk+0e8PEqbcvFvf5aI/blXIun66sulH2RTR6LCMPJFE+j8X0r
OZHjbZgzkkaHPJdxWkwqM22WBixF1d5rmIvKKHb3t5JPw4ZRhDgpXVToFGMK9RJROIuQ+lm2
sazKEJ9IOVpTZFnJ+uWRZjGBZm4ZUKsBTIRZc5gkIYWmvlasI2VM9pKdHJbxTYbCtv3EDfze
SkZfXcXi2Vcq6kGSt6ro5mdlz/9BvUHF91voVr9dnK92q5ot4y/vA+huHQkAAA==

--fdj2RfSjLxBAspz7--

