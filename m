Date: Tue, 6 Oct 2015 12:40:38 +0200 (CEST)
Message-Id: <201510061040.t96AecjA097734@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <1441985627-14822-11-git-send-email-gert@...1296...>
References: <1441985627-14822-11-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: get_default_gateway_ipv6():
	Win32 implementation using GetBestRoute2()
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

Lazy-ACK rules have been applied ("nobody screamed for two weeks", the
code is for a single platform, does not involve buffer management or 
crypto, and is trivial enough).

The "get default gateway" part has been tested by Samuli (mingw), Heiko 
(cygwin) and Lev (MSVC), the "... and install proper routes" part needs 
more real-world exposure...

Patch has been applied to the master branch.

commit 5fcd49336812053aa1503078c0ebb72a2737a6b8
Author: Gert Doering
Date:   Fri Sep 11 17:33:47 2015 +0200

     get_default_gateway_ipv6(): Win32 implementation using GetBestRoute2()

     Signed-off-by: Gert Doering <gert@...1296...>
     Lazy-ACK-by: Gert Doering <gert@...1296...>
     Message-Id: <1441985627-14822-11-git-send-email-gert@...1296...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/10085


--
kind regards,

Gert Doering


