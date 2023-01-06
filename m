Message-ID: <84f85177-538a-d1b4-040d-b2a0080251d7@...1227...>
Date: Fri, 6 Jan 2023 16:04:33 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20230103202330.1835-1-a@...2181...>
 <20230103202330.1835-2-a@...2181...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20230103202330.1835-2-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 2/3] dco: bail out when no peer-specific
 message is delivered
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Am 03.01.23 um 21:23 schrieb Antonio Quartulli:
> multi_process_incoming_dco() is currently partly processing
> messages that were actually discarded. This results in a bogus
> message being printed:
> 
> "Received packet for peer-id unknown to OpenVPN: -1, type 0, reason 2"
> 
> Change the flow so that we bail out immediately when we know that no
> message was truly delivered by DCO.
> Currently this can be verified by chacking that the peed_is is greater
> than -1.

I think we should somewhere properly document that peer-id = -1 has this 
meaning.

Acked-By: Arne Schwabe <arne@...1227...>

Arne

