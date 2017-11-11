References: <20171111171406.7562-1-gert@...2298...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <cbaa4193-1889-3174-d7ce-d8eb2b0befe3@...1856...>
Date: Sat, 11 Nov 2017 18:16:38 +0100
MIME-Version: 1.0
In-Reply-To: <20171111171406.7562-1-gert@...2298...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Add generated openvpn.doxyfile to
 .gitignore
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

On 11-11-17 18:14, Gert van Dijk wrote:
> I think this was omitted in 66bf378e.
> 
> Signed-off-by: Gert van Dijk <gert@...2298...>
> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.gitignore b/.gitignore
> index 18a45202..25009d81 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -52,6 +52,7 @@ config-msvc-version.h
>  doc/openvpn.8.html
>  /doc/doxygen/html/
>  /doc/doxygen/latex/
> +/doc/doxygen/openvpn.doxyfile
>  distro/rpm/openvpn.spec
>  distro/systemd/*.service
>  sample/sample-keys/sample-ca/
> 

Yes, my mistake, sorry.

Reviewed-by: Steffan Karger <steffan@...1856...>
Acked-by: Steffan Karger <steffan@...1856...>

-Steffan

