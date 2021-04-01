References: <20210331180323.19222-1-maximilian.fillinger@...2507...>
 <E1lRfW3-0001sy-Te@...2508...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <e6692bbe-c095-65d4-1e65-4d67f9d293f6@...1227...>
Date: Thu, 1 Apr 2021 12:22:37 +0200
MIME-Version: 1.0
In-Reply-To: <E1lRfW3-0001sy-Te@...2508...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 1/1] reliable: retransmit if 3 follow-up
 ACKs are received
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
To: Max Fillinger <maximilian.fillinger@...2507...>, openvpn-devel@lists.sourceforge.net

Am 31.03.21 um 20:03 schrieb Max Fillinger:
> From: Steffan Karger <steffan.karger@...1435...>
> 
> To improve the control channel performance under packet loss conditions,
> add a more aggressive retransmit policy similar to what many TCP
> implementations do: retransmit a packet if the ACK timeout expires (like
> we already do), *or* if three ACKs for follow-up packets are received.
> 
> The rationale behind this is that if follow-up packets *are* received, the
> connection is apparently functional and we should be able to retransmit
> immediately. This significantly improves performance for connections with
> low (up to a few percent) packet loss.

This is a reasonable approach and thanks for adding the comments.

Acked-By: Arne Schwabe <arne@...1227...>


