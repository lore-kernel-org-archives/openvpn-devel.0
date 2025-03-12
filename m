Date: Wed, 12 Mar 2025 10:40:39 +0100 (CET)
Message-Id: <202503120940.52C9edmr086480@...2054...>
From: Gert Doering <gert@...1296...>
In-Reply-To: <20250312092259.26487-1-gert@...1296...>
References: <20250312092259.26487-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH applied] Re: dns: support multiple domains
 without DHCP
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
To: Heiko Hund <heiko@...2662...>
Cc: openvpn-devel@lists.sourceforge.net

I have stared at the code for quite a while and it should do what it
intends to do.  Lev has tested it and +2'ed based on the test results.

There is one thing we need to re-test (will it behave properly if two
concurrent VPN sessions modify the global search list), but the standard
case is a "per interface" searchlist, so this is rare enough to not
hold up the DNS patch series further (*if* there is an issue lurking,
it will be "not properly cleaned up", but no "crash or anything").

Test compiled on Ubuntu 2204/MinGW64, no (new) warnings.

Your patch has been applied to the master branch.

commit ae90cbad50641cdf2579d1a6bcc35144866f68b1
Author: Heiko Hund
Date:   Wed Mar 12 10:22:53 2025 +0100

     dns: support multiple domains without DHCP

     Signed-off-by: Heiko Hund <heiko@...2662...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <20250312092259.26487-1-gert@...1296...>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31108.html
     Signed-off-by: Gert Doering <gert@...1296...>


--
kind regards,

Gert Doering


