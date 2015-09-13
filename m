References: <1441985627-14822-1-git-send-email-gert@...1296...>
	<1441985627-14822-8-git-send-email-gert@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <55F53DD4.9070000@...1227...>
Date: Sun, 13 Sep 2015 11:11:48 +0200
MIME-Version: 1.0
In-Reply-To: <1441985627-14822-8-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 07/10] Implement '--redirect-gateway
	ipv6'
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Am 11.09.15 um 17:33 schrieb Gert Doering:
> Add "ipv6" and "!ipv4" sub-options to "--redirect-gateway" option.
> 
> This is done in the same way as in the OpenVPN 3 code base, so
> "--redirect-gateway ipv6" will redirect both IPv4 and IPv6 - if you
> want v6-only, use "--redirect-gateway ipv6 !ipv4".
> 

Current 2.3 code will exit with an error on seeing the ipv6 keyword.

Reading the source code this is  equivalent to

redirect-gateway
route-ipv6 ::/3
route-ipv6 2000::/4
route-ipv6 3000::/4
route-ipv6 fc00::/7

which also works in 2.3. What do we offer as config advice for users?

(It is good that this works otherwise my code will break configs that
use a remote ipv6-enabled-server)

Also the documentation is slightly wrong.

Sidenote: What about IPv6 multicast?

Arne

