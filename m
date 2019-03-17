References: <20190311133620.18278-1-chipitsine@...277...>
 <20190311133620.18278-2-chipitsine@...277...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <269d4875-c787-bf51-a4fa-fe1a7115aa6c@...1856...>
Date: Sun, 17 Mar 2019 09:49:37 +0100
MIME-Version: 1.0
In-Reply-To: <20190311133620.18278-2-chipitsine@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/3] travis-ci: add "linux-ppc64le" to
 build matrix
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

Hi,

On 11-03-19 14:36, chipitsine@...277... wrote:
> From: Ilya Shipitsin <chipitsine@...277...>
> 
> Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
> ---
>  .travis.yml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/.travis.yml b/.travis.yml
> index ede2aaa6..428131ec 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -33,6 +33,9 @@ matrix:
>      - env: SSLLIB="openssl" OPENSSL_VERSION="1.1.0h"
>        os: linux
>        compiler: gcc
> +    - env: SSLLIB="openssl" OPENSSL_VERSION="1.1.0h" LABEL="linux-ppc64le"
> +      os: linux-ppc64le
> +      compiler: gcc
>      - env: SSLLIB="openssl" CFLAGS="-fsanitize=address"
>        os: linux
>        compiler: clang
> 

Looks good to me and passes tests on travis.

Acked-by: Steffan Karger <steffan@...1856...>

-Steffan

