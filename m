References: <20180201072731.GU69387@...1296...>
 <20180201154521.7642-1-steffan@...1856...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <9f28fcf6-53fd-ad9c-a292-d4df65c10fa9@...1856...>
Date: Thu, 1 Feb 2018 17:02:38 +0100
MIME-Version: 1.0
In-Reply-To: <20180201154521.7642-1-steffan@...1856...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3] Enable stricter compiler warnings by
 default
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
To: openvpn-devel@lists.sourceforge.net


On 01-02-18 16:45, Steffan Karger wrote:
> +AX_CHECK_COMPILE_FLAG(
> +    [-Wno-unused-function],
> +    [CFLAGS="-Wno-unused-function ${CFLAGS}"]
> +)
> +AX_CHECK_COMPILE_FLAG(
> +    [-Wno-unused-parameter],
> +    [CFLAGS="-Wno-unused-parameter ${CFLAGS}"]
> +)

Gah, those should have been tab-indented like the surrounding code.  If
all else looks good, maybe the committed can fix that when applying? O-)

-Steffan

