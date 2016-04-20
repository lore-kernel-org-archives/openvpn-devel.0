References: <570EC469.4090204@...277...> <570FCDFE.7000307@...1147...>
From: debbie10t <debbie10t@...277...>
Message-ID: <5717530D.9070801@...277...>
Date: Wed, 20 Apr 2016 10:59:41 +0100
MIME-Version: 1.0
In-Reply-To: <570FCDFE.7000307@...1147...>
Subject: Re: [Openvpn-devel] [openvpn-devel] route_net/vpn_gateway not set
 if server is manually expanded and topology is subnet
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Jan Just Keijser <janjust@...1147...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>




Hi,

On 14/04/16 18:06, Jan Just Keijser wrote:
 > Hi,
 >
 > On 14/04/16 00:12, debbie10t wrote:
 >> Hi,
 >>
 >> *On the server*
 >>
 >> When --topology subnet is used *only* $redirect_gateway is held in env.
 >>
 >> When --topology net30 is used the following are held in env:
 >>     o  $redirect_gateway
 >>     o  $route_net_gateway
 >>     o  $route_vpn_gateway

 > your configs are not the same. add
 >
 >                    route 10.105.101.0 255.255.255.0
 >
 > to the "topology subnet" variant and re-run - the env vars will be set
 > (as they are set only due to the 'route' statement).
 >

Thanks JJK this does remedy the problem .. nice use of parenthesis ;)

https://community.openvpn.net/openvpn/ticket/676#ticket

Kind regards
-- 


