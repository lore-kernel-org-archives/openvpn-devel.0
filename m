Message-ID: <4f5791ec-2736-a6df-7bc6-c149e1e7e3b3@...2181...>
Date: Mon, 27 Mar 2023 22:51:05 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20230327171236.51771-1-selva.nair@...277...>
 <b7194780-5729-9435-a641-9ef926926e86@...2181...>
 <CAKuzo_j5tMm+dVweJTrHM=+tGe5Cq_6NNwjb7sxhbLOiD=AN_g@...278...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <CAKuzo_j5tMm+dVweJTrHM=+tGe5Cq_6NNwjb7sxhbLOiD=AN_g@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Bug-fix: segfault in
 dco_get_peer_stats()
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 27/03/2023 22:42, Selva Nair wrote:
> But this may not be the time and place for a refactor. As dco is young, 
> I think it can mature in 2.7..
I agree on all fronts.
Let's get this patch in with a minimal fix that deals with what we have.

We can make this better in master.

Acked-by: Antonio Quartulli <a@...2181...>

-- 
Antonio Quartulli

