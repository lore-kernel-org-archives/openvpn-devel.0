From: Denis Vlasenko <vda@...216...>
Subject: Re: [Openvpn-devel] Opvenvpn as gateway
References: <20686C579479DC438276A726FE80CDAA01A68140@...281...>
In-Reply-To: <20686C579479DC438276A726FE80CDAA01A68140@...281...>
MIME-Version: 1.0
Message-Id: <200409221843.03454.vda@...216...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Sep 22 08:44:05 2004
Content-Type: text/plain;
  charset="windows-1251"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: satinders@...280..., openvpn-devel@lists.sourceforge.net

On Wednesday 22 September 2004 12:48, satinders@...280... wrote:
> Scenario is:
> 
> Client    - - - - - - - - - --  Gateway Server -- - - - - - - |
>  
> |- - - -  Server 1
>  
> |- - - -  Server 2
>  
> With OpenVpn :
> 
> Client (openvpn)    - - - - TUN- - - - - --  Gateway Server (openvpn) -- - -
> - - - - |
>  
> |- - - -  Server 1 
>  
> |- - - -  Server 2 

Everything linewrapped horribly

> I need to redirect IP packets from Client to Server1 and Server2 through
> Gateway depending upon request parameters.
> Here Gateway is Apache Proxy with Server 1 and Server 2 as backend/protected
> servers. 
> Can I route ip packets from Client to backend servers ip through TUN tunnel?
> Or
> Does openvpn provides hook-ups to filter ip-packets? I can use that to
> filter ip packets at TUN of Gateway.

I don't understand why do want to do this in such a complex and
incomprehensible way.

Just protect servers with firewall, and forward specific open ports from
servers to gateway.

Easily doable with iptables alone. No need to modify openvpn.
--
vda


