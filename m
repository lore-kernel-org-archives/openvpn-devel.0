Message-ID: <1d08e1b3-8208-98d5-3fd8-4031cf53c38a@...2181...>
Date: Wed, 14 Sep 2022 08:56:18 +0200
MIME-Version: 1.0
References: <20220808152344.17539-1-gert@...1296...>
 <9a825c98-7066-9beb-20cf-28ee9fc0c4b4@...2181...>
 <YyFxbhLzeb36494C@...1296...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <YyFxbhLzeb36494C@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] cleanup open_tun() for TARGET_NETBSD
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 14/09/2022 08:15, Gert Doering wrote:
>> Other than that the patch looks good and the new comment for open_tun is
>> easy to digest, also for non bsders like me.
> 
> Would that be an ACK? :-)

Yes:

Acked-by: Antonio Quartulli <a@...2181...>

we may really want to prune this --dev-node thing once and for all on 
those platforms where it does nothing :)

Cheers,

> 
> gert

-- 
Antonio Quartulli

