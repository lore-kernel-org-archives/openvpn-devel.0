References: <1493106641-16173-1-git-send-email-chipitsine@...277...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <078f6fd3-c344-6a02-d0c3-bfbe3167fbe4@...1856...>
Date: Tue, 25 Apr 2017 19:49:26 +0200
MIME-Version: 1.0
In-Reply-To: <1493106641-16173-1-git-send-email-chipitsine@...277...>
Subject: Re: [Openvpn-devel] [PATCH] travis-ci: add 2 mingw "build only"
 configurations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 25-04-17 09:50, Ilya Shipitsin wrote:
> Inspired by https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13032.html
> build options are taken from regular windows installer builds
> 
> Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
> ---
> v2: moved download/build dependencies into functions, changed cross build
> detection from shell expansion ${CHOST+x} to more recognised -z "${CHOST}",
> which required changing 'set -eux' to 'set -ex'. Added comments to make
> code readable without looking into commit message.

Thanks, this looks much better now!  Just one nit: if we give $CHOST a
default value, we don't have to remove set -u:

> --- a/.travis/build-deps.sh
> +++ b/.travis/build-deps.sh
> @@ -1,9 +1,58 @@
>  #!/bin/sh
> -set -eux
> +set -ex
>  
>  # Set defaults
>  PREFIX="${PREFIX:-${HOME}/opt}"

Just add a CHOST="${CHOST:-}" line here.  Keeping -u will help us catch
future problems (typos in variable names, for example).

Samuli already verified that this does what it should, so once we can
get -u back I too agree that this patch is ready to be applied.

Thanks for improving the patch and not giving up :)

-Steffan

