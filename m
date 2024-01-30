Message-ID: <ed69cd1c-8817-44c3-a8f9-af1ccb2379be@...2181...>
Date: Tue, 30 Jan 2024 12:02:22 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <CAAUX2SWqB=3zUqqxcXBEN-p6mq2ea8i-gjy-AX3aBXJzrE-QMA@...278...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <CAAUX2SWqB=3zUqqxcXBEN-p6mq2ea8i-gjy-AX3aBXJzrE-QMA@...278...>
Subject: Re: [Openvpn-devel] [ovpn-dco] Can ovpn-dco use all cpu cores?
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
To: Tony He <huangya90@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 29/01/2024 05:25, Tony He wrote:
> Hi Antonio,
> 
> I'm using ovpn-dco which is backported to v4.14 based on your latest
> code. My topology is:
> 
> LAN PC -- openwrt router running openvpn server -- WAN PC running openvpn client
> Router is with two mips64 cores.
> 
> I use the iperf3 to test speed between LAN PC and WAN PC.
> The result is sometime the performance is good(~280Mbps） while
> sometimes is bad(~140Mbps).
>   When the performance is bad, one of two CPUs is 100% idle. When the
> performance is good, two CPUs are busy. However， I don't see the issue
> when ipsec is tested in the same test env. Two cores are always used
> for ipsec. So , can ovpn-dco use all cpu cores to get max performance?

ovpn-dco uses more than core in order to perform different operations, 
but more parallelism on traffic processing can definitely be implemented 
(patches are welcome ;)).

Now it's hard to tell if what you are seeing is the result of this 
implementation detail or something else, especially because in some 
cases you get higher throughput.


Cheers,

-- 
Antonio Quartulli

