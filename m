Date: Tue, 31 Jan 2023 11:55:37 +0100
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y9jzqeRBOajsYG4u@...2685...>
References: <20230130172936.3444840-1-arne@...1227...>
 <20230130172936.3444840-3-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20230130172936.3444840-3-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 3/5] Update LibreSSL to 3.7.0 in Github
 actions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, Jan 30, 2023 at 06:29:34PM +0100, Arne Schwabe wrote:
> The version 3.5.3 triggers undefined behaviour with the usan sanatizer.
> Updating LibreSSSL to 3.7.0 does unfortunately does not fix the issue but
> at least we are now using a current version.
> 
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  .github/workflows/build.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
> index 2db90bcde..6adb69563 100644
> --- a/.github/workflows/build.yaml
> +++ b/.github/workflows/build.yaml
> @@ -409,7 +409,7 @@ jobs:
>          with:
>            path: libressl
>            repository: libressl-portable/portable
> -          ref: v3.5.3
> +          ref: v3.7.0
>        - name: "libressl: autogen.sh"
>          run: ./autogen.sh
>          working-directory: libressl
> @@ -417,7 +417,7 @@ jobs:
>          run: autoreconf -fvi
>          working-directory: libressl
>        - name: "libressl: configure"
> -        run: ./configure --enable-openvpn
> +        run: ./configure
>          working-directory: libressl
>        - name: "libressl: make all"

Acked-By: Frank Lichtenheld <frank@...2641...>

Always good to update to latest.

Regards,
-- 
  Frank Lichtenheld

