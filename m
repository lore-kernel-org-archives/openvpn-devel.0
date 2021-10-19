References: <20211019034118.28987-3-selva.nair@...277...>
 <202110191547.19JFlZlp091520@...2054...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <2b531414-68d2-e69e-70fe-49569033d865@...1227...>
Date: Tue, 19 Oct 2021 17:54:14 +0200
MIME-Version: 1.0
In-Reply-To: <202110191547.19JFlZlp091520@...2054...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Require EC key support in
 Windows builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 19.10.21 um 17:47 schrieb Gert Doering:
> Acked-by: Gert Doering <gert@...1296...>
> 
> Now this one is straightforward, even I can ACK it :-) - this change is
> good as it will avoid compile mishaps, and since we control what SSL 
> build we want to use on Windows, we can enforce "always EC!".  Not sure
> about other platforms (maybe the Software Museum has OpenSSL versions
> compiled without EC...).

The software museum wants to support FIPS and FIPS mandates Suite B
curves. I would more think that embedded system that stripped their
OpenSSL to the mimimum like that one that removed DH/DHCE support a few
years ago are problematic.

Arne

