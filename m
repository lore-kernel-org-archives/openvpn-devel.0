References: <1478515852-17381-1-git-send-email-gert@...1296...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <4c063145-f052-fca4-3390-c7b8fd130a71@...1435...>
Date: Mon, 7 Nov 2016 12:34:35 +0100
MIME-Version: 1.0
In-Reply-To: <1478515852-17381-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] openvpn version line: remove [IPv6],
 add [AEAD] if available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 07-11-16 11:50, Gert Doering wrote:
> Printing [IPv6] is no longer relevant information, as IPv6 support
> is always build in.  So, "2.4 = has IPv6, always".
> 
> [AEAD] is relevant information, as the underlying SSL library might
> be too old to have support for it (OpenSSL 0.9.x) and this eases
> figuring out why NCP is not upgrading a connection to AES-256-GCM.
> 
> Trac #762
> 
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/options.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 552bf5a..5a5e7ef 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -103,7 +103,9 @@ const char title_string[] =
>    " [MH/RECVDA]"
>  # endif
>  #endif
> -  " [IPv6]"
> +#ifdef HAVE_AEAD_CIPHER_MODES
> +  " [AEAD]"
> +#endif
>    " built on " __DATE__
>  ;

ACK

-Steffan


