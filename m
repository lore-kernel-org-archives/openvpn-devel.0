Message-ID: <10630dcd-f294-b94e-1a39-67e2bd7668d7@...1227...>
Date: Tue, 18 Jul 2023 12:59:47 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20230718105241.620221-1-frank@...2641...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20230718105241.620221-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH] GHA: Add macos-13
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
To: Frank Lichtenheld <frank@...2641...>, openvpn-devel@lists.sourceforge.net

Am 18.07.23 um 12:52 schrieb Frank Lichtenheld:
> Change-Id: Ica2e4b5a6b8da1368b487a33cd4b03ed9fc36011
> Signed-off-by: Frank Lichtenheld <frank@...2641...>
> ---
>   .github/workflows/build.yaml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
> index 2ae231ee..1b75a1a7 100644
> --- a/.github/workflows/build.yaml
> +++ b/.github/workflows/build.yaml
> @@ -198,7 +198,7 @@ jobs:
>         matrix:
>           ssllib: [ openssl11, openssl3, libressl]
>           build: [ normal, asan ]
> -        os: [macos-11, macos-12]
> +        os: [macos-11, macos-12, macos-13]
>           include:
>             - build: asan
>               cflags: "-fsanitize=address -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"


Acked-By: Arne Schwabe <arne@...1227...>


