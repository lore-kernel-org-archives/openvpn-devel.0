Message-ID: <915e2e7b-3b4d-a553-28eb-1b50439851b5@...2181...>
Date: Fri, 14 Jan 2022 13:12:53 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20220114111535.19970-1-a@...2181...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20220114111535.19970-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] GitHub Actions: ensure Ubuntu builds
 are made with the chosen SSL library
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
To: openvpn-devel@lists.sourceforge.net

NAK.

This change still lacks installing mbedtls as dependency.

On 14/01/2022 12:15, Antonio Quartulli wrote:
> The configure parameter was appended to the stage name but not to the
> actual command. Fix this.
> 
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>   .github/workflows/build.yaml | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
> index ea1233b1..f96515bc 100644
> --- a/.github/workflows/build.yaml
> +++ b/.github/workflows/build.yaml
> @@ -161,8 +161,8 @@ jobs:
>           uses: actions/checkout@...2620...
>         - name: autoconf
>           run: autoreconf -fvi
> -      - name: configure --with-crypto-library=${{matrix.ssllib}}
> -        run: ./configure
> +      - name: configure
> +        run: ./configure --with-crypto-library=${{matrix.ssllib}}
>         - name: make all
>           run: make -j3
>         - name: make check

-- 
Antonio Quartulli

