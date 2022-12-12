Message-ID: <051ea819-72c4-54b6-6221-3bd36890d51e@...1227...>
Date: Mon, 12 Dec 2022 14:28:19 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20221126162648.150678-1-maximilian.fillinger@...2507...>
 <20221126162648.150678-2-maximilian.fillinger@...2507...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20221126162648.150678-2-maximilian.fillinger@...2507...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Fix message for too long
 tls-crypt-v2 metadata
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
To: Max Fillinger <maximilian.fillinger@...2507...>, openvpn-devel@lists.sourceforge.net

Am 26.11.22 um 17:26 schrieb Max Fillinger:
> The current code only checks if the base64-encoded metadata is at most
> 980 characters. However, that can encode up to 735 bytes of data, while
> only up to 733 bytes are allowed. When passing 734 or 735 bytes, openvpn
> prints a misleading error message saying that the base64 cannot be
> decoded.
> 
> This patch checks the decoded length to show an accurate error message.
> 

Gert looked at this again and we found some issues now:

This patch leaves an unused define TLS_CRYPT_V2_MAX_B64_METADATA_LEN 
that is no longer used.

TLS_CRYPT_V2_MAX_METADATA_LEN is actually 734 sice it includes the type 
byte for the type of metadata, which gives us the 733 bytes of metadata 
decoded from base64.




>                                                   BCAP(&metadata));
> @@ -644,10 +640,18 @@ tls_crypt_v2_write_client_key_file(const char *filename,
>               msg(M_FATAL, "ERROR: failed to base64 decode provided metadata");
>               goto cleanup;
>           }
> +        if (decoded_len > TLS_CRYPT_V2_MAX_METADATA_LEN)
> +        {
> +            msg(M_FATAL,
> +                "ERROR: metadata too long (%d bytes, max %u bytes)",
> +                decoded_len, TLS_CRYPT_V2_MAX_METADATA_LEN - 1);
> +            goto cleanup;
> +        }

The error message correctly uses 733 as length but the check should also 
check for TLS_CRYPT_V2_MAX_METADATA_LEN -1 or use >=

Maybe we can add a unit test for this


