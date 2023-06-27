Message-ID: <10fbb492-a07b-7fe3-eae8-0f834b95b548@...2181...>
Date: Tue, 27 Jun 2023 10:14:14 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20230626130939.3267280-1-sergey.korolev@...2736...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20230626130939.3267280-1-sergey.korolev@...2736...>
Subject: Re: [Openvpn-devel] [PATCH] dco-linux: fix counter print format
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
To: Sergey Korolev <sergey.korolev@...2736...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 26/06/2023 15:09, Sergey Korolev via Openvpn-devel wrote:
> Avoid compilation warnings on 32 bit platforms.
> 
> dco_linux.c: In function 'dco_update_peer_stat':
> dco_linux.c:830:26: error: format '%lu' expects argument of type
> 'long unsigned int', but argument 4 has type 'counter_type'
> {aka 'long long unsigned int'} [-Werror=format=]
>    830 |         msg(D_DCO_DEBUG, "%s / dco_read_bytes: %lu", __func__,
>        |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
>    831 |             c2->dco_read_bytes);
>        |             ~~~~~~~~~~~~~~~~~~
>        |               |
>        |               counter_type {aka long long unsigned int}
> 
> Signed-off-by: Sergey Korolev <sergey.korolev@...2736...>

Thanks for catching this!

Acked-by: Antonio Quartulli <a@...2181...>

-- 
Antonio Quartulli

