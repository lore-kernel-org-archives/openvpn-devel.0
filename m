From: Antonio Quartulli <a@...2181...>
References: <011701d6858cyandex-team.ru>
 <20200908123625.23179-1-themiron@...2010...>
Message-ID: <46aa47fd-0b16-d09b-fa76-8474fc8b1567@...2181...>
Date: Thu, 10 Sep 2020 11:02:14 +0200
MIME-Version: 1.0
In-Reply-To: <20200908123625.23179-1-themiron@...2010...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3] Fix best gateway selection over
 netlink
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
To: Vladislav Grishenko <themiron@...2010...>, openvpn-devel@lists.sourceforge.net

Hi,

On 08/09/2020 14:36, Vladislav Grishenko wrote:
> Netlink route request with NLM_F_DUMP flag set means to return
> all entries matching criteria passed in message content -
> matching supplied family & dst address in our case.
> So, gateway from the first ipv4 route was always used.
> 
> On kernels earlier than 2.6.38 default routes are the last ones,
> so arbitrary host/net route w/o gateway is likely be returned as
> first, causing gateway to be invalid or empty.
> After refactoring in 2.6.38 kernel default routes are on top, so
> the problem with older kernels was hidden.
> 
> Fix this behavior by selecting first 0.0.0.0/0 if dst was not set
> or empty. For IPv6, no behavior is changed - request ::/128 route,
> so just clarify the sizes via netlink route api.
> 
> Tested on 5.4.0, 4.1.51, 2.6.36 and 2.6.22 kernels.
> 
> Signed-off-by: Vladislav Grishenko <themiron@...2010...>

Thanks for taking care of this issue and for digging into the sitnl code.

The change is really contained and and easy to review.
Tested a bit and it works as expected.

Acked-by: Antonio Quartulli <a@...2181...>

-- 
Antonio Quartulli



