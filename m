References: <CAPM6dUC_L=Q2HseFEKS7bfrff6McwQo9TSuWKramkbC+5k9Phw@...278...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <5d43db38-5481-3f67-555d-b2b59b89be63@...1147...>
Date: Wed, 17 Apr 2019 12:18:17 +0200
MIME-Version: 1.0
In-Reply-To: <CAPM6dUC_L=Q2HseFEKS7bfrff6McwQo9TSuWKramkbC+5k9Phw@...278...>
Content-Language: nl-NL
Subject: Re: [Openvpn-devel] openvpn with udp lost event.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: wei wang <lnykww@...277...>, openvpn-devel@lists.sourceforge.net

On 15/04/19 14:29, wei wang wrote:
> Hi,
>
> For function multi_process_io_udp receive many events, but only
> process one at a time. Doest it cause the event to be lost?
yes it does
> In our test, we had create thousands of client. When clients connect
> to server at a time, for the clients which already connected on this
> server will not receive packet from tun device.
that is correct - this is known limitation of  the OpenVPN 2 code base. 
Fixing this limitation is far from trivial, however.

HTH,

JJK


