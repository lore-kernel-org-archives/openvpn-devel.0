References: <1479524624-13863-1-git-send-email-arne@...1227...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <78d36d7c-a30b-35d5-2118-e6ce647b07b7@...1856...>
Date: Sat, 19 Nov 2016 09:16:22 +0100
MIME-Version: 1.0
In-Reply-To: <1479524624-13863-1-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Document that tls-crypt also supports
 inline
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net



On 19-11-16 04:03, Arne Schwabe wrote:
> ---
>  doc/openvpn.8 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index e997b09..11564af 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -6613,9 +6613,9 @@ X509_1_C=KG
>  .SH INLINE FILE SUPPORT
>  OpenVPN allows including files in the main configuration for the
>  .B \-\-ca, \-\-cert, \-\-dh, \-\-extra\-certs, \-\-key, \-\-pkcs12, \-\-secret,
> -.B \-\-crl\-verify, \-\-http\-proxy\-user\-pass
> +.B \-\-crl\-verify, \-\-http\-proxy\-user\-pass, \-\-tls-auth
>  and
> -.B \-\-tls\-auth
> +.B \-\-tls\-crypt
>  options.
>  
>  Each inline file started by the line
> 

ACK

-Steffan

