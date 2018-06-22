MIME-Version: 1.0
In-Reply-To: <20180622182709.GO57262@...1296...>
References: <20180608052017.6696-1-a@...2181...>
 <20180613141213.5962-1-a@...2181...>
 <20180620155301.GY57262@...1296...>
 <c416ea67-e4ce-148b-eb19-6d18b35da559@...2181...>
 <20180622094635.GI57262@...1296...>
 <d496bbf5-3c55-f2d9-2ab2-bc89ded80131@...2181...>
 <CAKuzo_jDrcGjQeMaVm3X6yzgKBZecbYHfAAxxCFAuycagTe22Q@...278...>
 <20180622182709.GO57262@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 22 Jun 2018 14:52:53 -0400
Message-ID: <CAKuzo_goH+3fXtpO-s4xLyay56EMy21WjrO5eQYFXH1wZRMogw@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3 2/8] windows: properly configure TAP
 driver when no IPv4 is configured
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On Fri, Jun 22, 2018 at 2:27 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Fri, Jun 22, 2018 at 02:12:24PM -0400, Selva Nair wrote:
>> My tap adapter has a link local address (169.254.98.86) on it possibly due
>> to a previous dhcp failure. May be I need to get rid of that (how?) to
>> activate this code path?
>
> I guess this is related - the branch in question is triggered by
> is_on_link(), so maybe in Antonio's case the tap adapter is set to
> 0.0.0.0 - or it actually tried to install a route related to
> redirect-gateway.
>
> Are you connecting to your VPN server over IPv6 or IPv4?

This physical link is v4.

I tried without !ipv4 in redirect-gateway and got:

(i) without route-gateway defined: redirecting v4 fails with a warning
"route-gateway or ifconfig is missing"

(ii) with route-gateway: the route is added but warns "route gateway
not reachable by any active
interfaces" -- fair enough.

Selva

