References: <20200911115916.16117-1-gert@...1296...>
 <20200917085941.20972-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <a04ed804-ef55-9d6c-a27b-8d1569ac534e@...2181...>
Date: Thu, 17 Sep 2020 15:33:41 +0200
MIME-Version: 1.0
In-Reply-To: <20200917085941.20972-1-gert@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2] If IPv6 pool specification sets pool
 start to ::0 address, increment.
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On 17/09/2020 10:59, Gert Doering wrote:
> The first IPv6 address in a subnet is not usable (IPv6 anycast address),
> but our pool code ignored this.
> 
> Instead of assigning an unusable address or erroring out, just log the
> fact, and increment the pool start to <pool_base>::1
> 
> NOTE: this is a bit simplistic.  A pool that is larger than /96 and
> has non-0 bits in the "uppermost bits" will still get the increment
> as we only look at the lowermost 32 bits.
> 
> NOTE2: if the pool is specified with "--server-ipv6 $base/$bits", this
> is a non-issue, as the address for the pool start will be incremented
> anyway.
> 
> v2: make comment more explicit about "we're only talking about the
>     host part here" and "base sees only only 32 bit of the host part"
> 
> Reported-by: NicolaF_ in Trac
> Trac: #1282
> 
> Signed-off-by: Gert Doering <gert@...1296...>

Acked-by: Antonio Quartulli <a@...2181...>

-- 
Antonio Quartulli

