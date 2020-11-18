References: <20201118145413.26134-1-huangya90@...277...>
 <20201118145413.26134-2-huangya90@...277...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <6ee9c9c9-9276-7155-8a5f-d1b89435e1fe@...2181...>
Date: Wed, 18 Nov 2020 16:14:12 +0100
MIME-Version: 1.0
In-Reply-To: <20201118145413.26134-2-huangya90@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] ovpn-dco: nestns-test.sh - fix the
 issue that veth is not created successfully.
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
To: Tony He <huangya90@...277...>, openvpn-devel@lists.sourceforge.net, antonio@...515...

Hi,

On 18/11/2020 15:54, Tony He wrote:
> According to user manual of "ip link", the command should be
> "ip link add veth0 type veth peer name veth1"
> 
> instead of
> "ip link add veth0 type veth peer veth1"
> 
> With this fix, after running "./netns-test.sh", we can do ping test by
> executing "ip netns exec peer0 ping 5.5.5.2"
> 
> Tested in Ubuntu 18.04 PC.
> 
> Signed-off-by: Tony He <huangya90@...277...>

Applied to master in revision c56b9d024570 with slightly amended commit
message.

Cheers,

-- 
Antonio Quartulli

