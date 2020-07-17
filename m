References: <20200717150526.124733-1-matthias.andree@...68...>
From: Matthias Andree <matthias.andree@...68...>
Message-ID: <9f8416d1-1a4b-46d4-bb9d-f80180e25dcd@...68...>
Date: Fri, 17 Jul 2020 20:25:29 +0200
MIME-Version: 1.0
In-Reply-To: <20200717150526.124733-1-matthias.andree@...68...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 2/2] Permit make dist* targets without
 py*-docutils
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

Am 17.07.20 um 17:05 schrieb Matthias Andree:
> Signed-off-by: Matthias Andree <matthias.andree@...68...>
> ---
>  doc/Makefile.am | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/doc/Makefile.am b/doc/Makefile.am
> index add92198..80cb2cb8 100644
> --- a/doc/Makefile.am
> +++ b/doc/Makefile.am
> @@ -59,8 +59,9 @@ else
>  endif
>
>  if HAVE_PYDOCUTILS
> -dist_noinst_DATA += openvpn.8
> -dist_html_DATA = openvpn.8.html
> +nodist_noinst_DATA = openvpn.8
> +nodist_html_DATA = openvpn.8.html
> +EXTRA_DIST = openvpn.8 $(nodist_html_DATA)

NAK - reject - superseded by newer patch.



