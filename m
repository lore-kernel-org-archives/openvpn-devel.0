References: <20210727143741.29039-1-gert@...1296...>
 <20210802152619.30754-1-gert@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <a61c0ad1-96e5-4482-615f-fe10c0645a4a@...2181...>
Date: Tue, 3 Aug 2021 12:23:44 +0200
MIME-Version: 1.0
In-Reply-To: <20210802152619.30754-1-gert@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v2] Use more C99 initialization in
 add_route/add_route_ipv6().
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

On 02/08/2021 17:26, Gert Doering wrote:
> This gets rid of a few #ifdef and also removes the need for
> commit a11bea18b1c93 (argv is only initialized after the
> early exit check on RT_DEFINED).
> 
> v2:
>   use gc_new(), group gc and argv init in both add_route*() functions
> 
> Signed-off-by: Gert Doering <gert@...1296...>

Thanks for addressing my comments!
Code looks good and compiles in my CI (linux and windows only)

No leaks detected during a basic test.

Acked-by: Antonio Quartulli <antonio@...515...>


-- 
Antonio Quartulli

