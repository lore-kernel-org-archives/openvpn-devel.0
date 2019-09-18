References: <4ae4ef50-efbe-c744-7133-7f926052be0a@...2080...>
 <20190917123321.15993-1-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <ea9c2a41-3c7d-a242-6124-6ec111c120fc@...2080...>
Date: Wed, 18 Sep 2019 16:41:49 +0200
MIME-Version: 1.0
In-Reply-To: <20190917123321.15993-1-arne@...1227...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v7 7/7] Implement unit tests for
 auth-gen-token
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Cc: Arne Schwabe <arne@...515...>

On 17/09/2019 14:33, Arne Schwabe wrote:
> From: Arne Schwabe <arne@...515...>
> 
> The unit test is breaking the 80 char limit in some places
> but the remaining lines it breaks the limit I feel
> forcing the 80 char limit will impair readibility
> 
> Patch V2: adapt unit tests to other V2 patches
> Patch V4: Resolve rebase conflicts
> Patch V5: Add \ lost in rebase that broke compilation
> Patch V7: Fix unit test failure, try to stay below 80
> ---
>  tests/unit_tests/openvpn/Makefile.am       |  18 +-
>  tests/unit_tests/openvpn/test_auth_token.c | 394 +++++++++++++++++++++
>  2 files changed, 411 insertions(+), 1 deletion(-)
>  create mode 100644 tests/unit_tests/openvpn/test_auth_token.c

Acked-By: David Sommerseth <davids@...515...>

This looks good now, and passes on my system.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


