Message-ID: <0e23e645-f573-42dc-b938-06d09252737b@...2181...>
Date: Wed, 7 May 2025 21:38:34 +0200
MIME-Version: 1.0
From: Antonio Quartulli <a@...2181...>
References: <20250506210853.10585-1-a@...2181...>
 <aBsBm7IRQYGr8aKm@...1296...>
 <940953cd-4755-4bb5-81ea-d32ed2dba222@...2181...>
Content-Language: en-US
In-Reply-To: <940953cd-4755-4bb5-81ea-d32ed2dba222@...2181...>
Subject: Re: [Openvpn-devel] [PATCH ovpn-net-next] ovpn: set skb->ignore_df
 = 1 before sending IPv6 packets out
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

On 07/05/2025 08:49, Antonio Quartulli wrote:
> Hi,
> 
> On 07/05/2025 08:45, Gert Doering wrote:
>> so:
>>
>> Tested-By: Gert Doering <gert@...1296...>
>> Acked-By: Gert Doering <gert@...1296...>
> 
> Sending your tags this way is definitely the way to go.
> I'll add them when pushing the patch to my tree.

Merged to main branch, commit id e2fb21d856f8

Thanks!

-- 
Antonio Quartulli


