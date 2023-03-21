Message-ID: <94943c91-36ea-1255-6cd6-97284b69cb0e@...1227...>
Date: Wed, 22 Mar 2023 00:58:08 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20230321231003.3582-1-a@...2181...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20230321231003.3582-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] dco_freebsd: use m->instances[] instead
 of m->hash
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Cc: Kristof Provost <kp@...2721...>

Am 22.03.23 um 00:10 schrieb Antonio Quartulli:
> When retrieving the multi_instance of a specific peer,
> there is no need to peform a linear search across the
> whole m->hash list. We can directly access the needed
> object via m->instances[peer-id] in constant time (and
> just one line of code).
> 
> Adapt the dco-freebsd code to do so.
> 

Acked-By: Arne Schwabe <arne@...1227...>

Arne


