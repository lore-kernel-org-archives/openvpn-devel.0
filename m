References: <1479203199-15297-1-git-send-email-steffan.karger@...1435...>
	<1479216586-20078-1-git-send-email-steffan.karger@...1435...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <94a3a08d-78fb-6b0c-527c-d78aac249109@...1227...>
Date: Wed, 16 Nov 2016 10:49:34 -0500
MIME-Version: 1.0
In-Reply-To: <1479216586-20078-1-git-send-email-steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] [PATCH 2/5 v3] Add control channel encryption
 (--tls-crypt)
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
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

Am 15.11.16 um 08:29 schrieb Steffan Karger:

> 
> v2 - processed Arne's review comments:
> 
>  * Error out early with a clear error message when AES-256-CTR or
>    HMAC-SHA-256 are not supported by the crypto library.
>  * Clarify that cipher_ctx_reset() sets the IV.
> 
> v3 - actually add error messages promised in v2...
> 

Thanks! ACK

Arne


