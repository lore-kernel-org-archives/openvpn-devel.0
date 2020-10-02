References: <63aacbfb-20a0-de78-fccb-bbf8a2ad4189@...2318...>
 <b4686963-bb89-8777-94f2-caf3ceca8328@...1227...>
From: =?UTF-8?Q?Fran=c3=a7ois_Kooman?= <fkooman@...2318...>
Message-ID: <87553ed7-7289-39e2-3530-a01966f96d4f@...2318...>
Date: Fri, 2 Oct 2020 17:26:37 +0200
MIME-Version: 1.0
In-Reply-To: <b4686963-bb89-8777-94f2-caf3ceca8328@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] with IPv6 VPN connection,
 IPv4 traffic does not get router over VPN
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
To: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 10/2/20 5:12 PM, Arne Schwabe wrote:
> Is that a host that does not have a ipv4 default gw at all? Like IPv6
> only connectivity?

It does, it has both IPv4 (RFC 1918) and IPv6 (Public IP) connectivity 
behind a FritzBox. Both IPv4 and IPv6 work fine (checked it using v6.de) 
without VPN. When starting the VPN, the IPv6 address changes, but the 
IPv4 address stays the same indicating IPv4 traffic stays out of the tunnel.

Regards,
François

