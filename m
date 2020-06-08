References: <20200530000600.1680-1-a@...2181...>
 <20200530000600.1680-8-a@...2181...> <20200607105939.GF1431@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <4c38100c-a5f2-5d1e-ea8d-fcf7d787df37@...2181...>
Date: Mon, 8 Jun 2020 17:43:42 +0200
MIME-Version: 1.0
In-Reply-To: <20200607105939.GF1431@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v4 7/7] ipv6-pool: get rid of size
 constraint
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 07/06/2020 12:59, Gert Doering wrote:
> My idea would be to make this conditional on the pool size - if the size
> is /64.../111, make it +0x1000 ("keep existing behaviour for large-enough
> pools"), if it's /112.../124, make it +2
> 
> Thoughts?

I think it makes sense, especially to preserve the current behaviour on
already deployed setups.

New patch incoming!


-- 
Antonio Quartulli

