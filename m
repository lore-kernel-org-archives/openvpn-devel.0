From: Arne Schwabe <arne@...1227...>
References: <1d93843c-6fe8-1a60-28fc-c013a57877da@...2181...>
 <20181029172040.17034-1-arne@...1227...>
 <BN6PR04MB0932760BE8E092FA236F57C0DDF30@...2439...>
 <20181029220904.GR962@...1296...>
 <7e8d9603-4864-09be-44d8-334871afc426@...75...>
Message-ID: <00d7269a-5f6d-b224-bfe2-ca9616a742c8@...1227...>
Date: Tue, 30 Oct 2018 11:22:18 +0100
MIME-Version: 1.0
In-Reply-To: <7e8d9603-4864-09be-44d8-334871afc426@...75...>
Content-Language: de-DE
Subject: [Openvpn-devel]  [PATCH v5] Implement block-ipv6
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
To: =?UTF-8?Q?Thomas_Sch=c3=a4fer?= <tschaefer@...75...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Am 30.10.18 um 11:07 schrieb Thomas Schäfer:
> Am 29.10.18 um 23:09 schrieb Gert Doering:
>> Hi,
>>
>> On Mon, Oct 29, 2018 at 09:06:13PM +0000, Kristian McColm wrote:
>>> Will this feature break VPNs that use NAT64 to connect to IPv4-only
>>> OpenVPN servers?
>>
>> No.
>>
>> This is an opt-in feature which you can enable by pushing "block-ipv6"
>> from the server to the client, to avoid IPv6 traffic (to, say, youtube)
>> bypassing your IPv4-only VPN.
>>
>> If your VPN is dual-stacked *inside* the tunnel, you wouldn't enable
>> this.  If your VPN is IPv4-only, but the client has external IPv6
>> connectivity, you might consider enabling this.
>>
>> gert
> 
> 
> Sure?
> 
> NAT64 means the client has (only) IPv6 connectivity. I am not sure
> about, if a openvpn connections survive from an IPv6-only/NAT64 endpoint
> to an IPv4-only server (transport protocol is changing during the
> transport from 6 to 4 and vice versa). May be they do it via NAT64 or
> via 464xlat. But if you block IPv6 ("external") at the client, you will
> lose also you connectivity. (except 464xlat which generates a v4 socket)
> 
> I cannot test it at the moment. I have two IPv6-only configured ovpn
> servers and two NAT64-ISP (tm and lrz) but no time to build an
> IPv4-only-openvpn-Server.

This patch only adds code to reject ipv6 packets that are *already* in
the tunnel. It still depends on having redirect-gateway ipv6 or a
default route to your tun device to actually do anything. If your
packets to the VPN server ended up inside the tunnel something else is
wrong already. I can add a followup patch to clarify this.

Arne

