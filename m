From: Antonio Quartulli <a@...2181...>
References: <20201023113431.26691-1-arne@...1227...>
 <20201023113431.26691-2-arne@...1227...>
 <20201024194301.GB976@...1296...>
 <c0f890fb-bd6c-1e76-7316-590c95bfb34e@...1227...>
 <46c513d0-8b2f-d4db-427f-c8d39e8a659f@...2181...>
Message-ID: <fdbab89d-80ba-07da-eb91-b23e116232d3@...2181...>
Date: Thu, 25 Mar 2021 22:55:16 +0100
MIME-Version: 1.0
In-Reply-To: <46c513d0-8b2f-d4db-427f-c8d39e8a659f@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 2/5] xmit_hold is only required for
 port_share
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 25/03/2021 22:37, Antonio Quartulli wrote:
> Anybody can see why we need that for port-share?
> I'd rather try to understand the above and ditch this member entirely,
> if the answer is "we don't need it".

After more tests I indeed recovered the reason why this is needed with
port-share.

If we don't "hold back", upon connection the server will send its own
SERVER_HARD_RESET, regardless of the client having sent a
CLIENT_HARD_RESET or not.

This behaviour indeed breaks port-share because the non-OpenVPN
application on the other side will receive an unexpected packet and will
most likely kill the connection.

For this reason we need to hold any control channel packet until we have
confirmed that the first packet is indeed a CLIENT_HARD_RESET.


Regarding TCP, the only thing I can think about is that this flag helps
mimicking UDP: instead of sending the HARD_RESET right after a TCP
Connection is opened, the server will wait for the client packet first.

In UDP I presume this is standard behaviour as we have no connection
opening event.

My guess is that this behaviour may be useful to avoid race conditions
on the client where the SERVER_HARD_RESET is received when still unexpected?

But maybe the code has evolved enough to not requiring this sequence of
events anymore.

Cheers,

-- 
Antonio Quartulli

