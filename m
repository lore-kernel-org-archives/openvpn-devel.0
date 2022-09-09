Message-ID: <8e896f80-25d5-6855-78bd-c0ded22aa21f@...2181...>
Date: Fri, 9 Sep 2022 14:57:10 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220909091037.553-1-lstipakov@...277...>
 <20220909121841.646-1-lstipakov@...277...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220909121841.646-1-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] dco.c: check certain options only on
 startup
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
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net
Cc: Lev Stipakov <lev@...515...>

Hi,

On 09/09/2022 14:18, Lev Stipakov wrote:
> From: Lev Stipakov <lev@...515...>
> 
> Following options are set on startup and cannot be changed later:
> 
>   - dev
>   - dev-type
>   - connections list
>   - mode
>   - topology
> 
> Same for system-wide availability of dco.
> 
> dco_check_option_conflict(), where those options
> were checked, is also called in server mode when
> client is connected. Move those checks to
> dco_check_startup_option_conflict() which is only
> called at startup.
> 
> Since we moved dco_enabled() check to startup,
> dco_check_option_conflict() might now trigger exit
> on Windows if system lacks chachapoly support.
> Since dco checks only need to be performed for
> dco, wrap those into "if (dco_enabled) {}".
> 
> Signed-off-by: Lev Stipakov <lev@...515...>

Reordering the checks this way makes more sense and helps keeping the 
code cleaner. When a CCD file is loaded, we now only check options that 
can only be in there.

Anything that cannot be changed by a CCD file is only checked at startup.

Acked-by: Antonio Quartulli <a@...2181...>

Cheers,

-- 
Antonio Quartulli

