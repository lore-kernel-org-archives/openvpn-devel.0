Date: Tue, 5 Jul 2022 11:32:06 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <YsQFFkxkn5BdEdTQ@...2678...>
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-26-a@...2181...>
MIME-Version: 1.0
In-Reply-To: <20220624083809.23487-26-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 25/25] dco-win: update GH Actions config
 file
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lev@...515...>

I think this commit could use an additional sentence
in the commit message on why exactly you remove this?

Doesn't immediately make sense to me.

On Fri, Jun 24, 2022 at 10:38:09AM +0200, Antonio Quartulli wrote:
> Signed-off-by: Lev Stipakov <lev@...515...>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  .github/workflows/build.yaml | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
> index b905c0d2..536dd9d6 100644
> --- a/.github/workflows/build.yaml
> +++ b/.github/workflows/build.yaml
> @@ -59,11 +59,6 @@ jobs:
>      steps:
>        - name: Install dependencies
>          run: sudo apt update && sudo apt install -y mingw-w64 libtool automake autoconf man2html unzip
> -      - name: Checkout ovpn-dco-win
> -        uses: actions/checkout@...2620...
> -        with:
> -          repository: OpenVPN/ovpn-dco-win
> -          path: ovpn-dco-win
>        - name: Checkout OpenVPN
>          uses: actions/checkout@...2620...
>          with:
> @@ -151,7 +146,7 @@ jobs:
>          run: cp ./tap-windows-${TAP_WINDOWS_VERSION}/include/tap-windows.h ${HOME}/mingw/opt/include/
>  
>        - name: configure OpenVPN
> -        run: PKG_CONFIG_PATH=${HOME}/mingw/opt/lib/pkgconfig DCO_SOURCEDIR=$(realpath ../ovpn-dco-win) LDFLAGS=-L$HOME/mingw/opt/lib CFLAGS=-I$HOME/mingw/opt/include OPENSSL_LIBS="-L${HOME}/opt/lib -lssl -lcrypto" OPENSSL_CFLAGS=-I$HOME/mingw/opt/include PREFIX=$HOME/mingw/opt LZO_CFLAGS=-I$HOME/mingw/opt/include LZO_LIBS="-L${HOME}/mingw/opt/lib -llzo2" ./configure  --host=${CHOST} --disable-lz4 --enable-dco
> +        run: PKG_CONFIG_PATH=${HOME}/mingw/opt/lib/pkgconfig LDFLAGS=-L$HOME/mingw/opt/lib CFLAGS=-I$HOME/mingw/opt/include OPENSSL_LIBS="-L${HOME}/opt/lib -lssl -lcrypto" OPENSSL_CFLAGS=-I$HOME/mingw/opt/include PREFIX=$HOME/mingw/opt LZO_CFLAGS=-I$HOME/mingw/opt/include LZO_LIBS="-L${HOME}/mingw/opt/lib -llzo2" ./configure  --host=${CHOST} --disable-lz4
>          working-directory: openvpn
>  
>        - name: build OpenVPN

Regards,
-- 
  Frank Lichtenheld

