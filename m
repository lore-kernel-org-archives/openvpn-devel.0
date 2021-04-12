References: <E1lW0eX-00012w-9n@...2487...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <aa2d14ed-6872-e695-807a-e0924ceb998a@...2181...>
Date: Mon, 12 Apr 2021 21:21:30 +0200
MIME-Version: 1.0
In-Reply-To: <E1lW0eX-00012w-9n@...2487...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Fix build with mbedtls w/o SSL
 renegotiation support
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
To: Max Fillinger <maximilian.fillinger@...2507...>, openvpn-devel@lists.sourceforge.net

Hi,

On 12/04/2021 19:46, Max Fillinger wrote:
> In mbedtls, support for SSL renegotiation can be disabled at
> compile-time. However, OpenVPN cannot be built with such a library
> because it calls mbedtls_ssl_conf_renegotiation() to disable this
> feature at runtime. This function doesn't exist when mbedtls was built
> without support for SSL renegotiation.
> 
> This commit fixes the build by ifdef'ing out the function call when
> mbedtls was built without support for SSL renegotiation.
> 
> Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>

Compile tested against mbedtls with and without this feature defined.
Could see the error and it gets fixed when this patch is applied.

By having a look at the mbedtls git history I could see this define
exists since the library was under the polarssl namespace. Which means
it is old enough for us to not worry about.

Acked-by: Antonio Quartulli <antonio@...515...>


-- 
Antonio Quartulli

