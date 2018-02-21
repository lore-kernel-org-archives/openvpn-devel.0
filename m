References: <1519231562-5641-1-git-send-email-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <a1d3bf03-7d11-a500-b382-422786fbdc29@...1227...>
Date: Wed, 21 Feb 2018 18:00:38 +0100
MIME-Version: 1.0
In-Reply-To: <1519231562-5641-1-git-send-email-selva.nair@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Disable external ec key support when
 building with libressl
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
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

Am 21.02.18 um 17:46 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> - This codepath uses some openssl-1.1 specific API and is enabled only
>   for openssl 1.1 and higher versions. But, due to incompatible
>   version numbering in libressl, it gets wrongly enabled with libressl
>   versions that do not support the reqired API. As an easy workaround
>   disable the feature when LIBRESSL_VERSION_NUMBER is defined.
>

I will reluctantly ACK this because LibreSSL will not fix their stuff.

Acked-By: Arne Schwabe

I have not tested this to compile but the code looks good.

Arne

