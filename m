MIME-Version: 1.0
References: <CAGyAFMVbX1m_LhB=rV1Kh0uqpjfgCy6WP9t1o2bLTT+dO-L9Gg@...278...>
 <20211109015927.311-1-lstipakov@...277...> <YY1HU85OwqH442H+@greenie.muc.de>
In-Reply-To: <YY1HU85OwqH442H+@greenie.muc.de>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 12 Nov 2021 14:33:31 +0200
Message-ID: <CAGyAFMXNmuHUphBCCnPtr+RJ5ygam5JNaK94VBGTU6mizkjCJw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Use network address for emulated DHCP
 server as a default
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

Hi,

I tested yesterday on Windows 10 and today also on Windows 7 and 8.1.

 - /30 subnet (OpenVPN Cloud as server)
 - /24 subnet (openvpn2) with redirect-gateway def1. Tested that ping
works and traffic goes through the tunnel.

Also our QA tested this (not exactly this one, but my original patch
with offset 0 for /28 and -1 for everything else) for
/30 subnet against OpenVPN Cloud. He has checked the connection,
access to the internet (e.g. ping 8.8.8.8), access to OpenVPN Cloud
(ping by internal IP).

I asked James what was the reason to have "-1" in the first place. He
said that he doesn't recall details, but thinks that the safest
approach would probably be to retain the old logic.

How about we apply my original patch (0 for /28 and -1 for the rest)
to 2.5 and this one to master?

-- 
-Lev

