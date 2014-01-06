Message-ID: <52CAABBB.2090706@...1227...>
Date: Mon, 06 Jan 2014 14:12:27 +0100
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1389012640-24174-1-git-send-email-gert@...1296...>
In-Reply-To: <1389012640-24174-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Document "lz4" argument to "compress"
 config option.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Am 06.01.14 13:50, schrieb Gert Doering:
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  doc/openvpn.8 | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index f06d536..3df7a6f 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -2417,9 +2417,11 @@ Enable a compression algorithm.
>  
>  The
>  .B algorithm
> -parameter may be "snappy", "lzo", or empty.  Snappy and LZO
> +parameter may be "snappy", "lzo", "lz4", or empty.  Snappy, LZO and LZ4
>  are different compression algorithms, with Snappy generally
> -offering the best performance.
> +offering the best performance while LZ4 is faster with less CPU usage.
> +For backwards compatibility with OpenVPN versions before 2.4, use "lzo"
> +(which is identical to the older option "\-\-comp-lzo yes").
>  
>  If the
>  .B algorithm
ACK

