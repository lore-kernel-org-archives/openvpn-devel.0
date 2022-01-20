Message-ID: <8dd82c72-b55e-c4e8-1cec-4e4590613a53@...1227...>
Date: Thu, 20 Jan 2022 11:16:46 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20211214165928.30676-1-selva.nair@...277...>
 <20211214165928.30676-4-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20211214165928.30676-4-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3 03/18] Implement SIGNATURE operations
 in xkey provider
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
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

Am 14.12.21 um 17:59 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> - Basic frame work for announcing support for signature
>    operations
> 
> - DigestSign and Sign functions for native keys are also
>    implemented.  Though strictly not needed, these functions
>    for native keys sets up the framework for signature operations.
>    They also help loading an exportable key from a file through
>    the provider for testing.
> 
>    Subsequent commits will add support for signing with
>    external keys.
> 
> v2 changes:
>    - Remove verify operations which are no longer
>      required with proposed changes in OpenSSL 3.0.1 that we target.
> 
>    - Undigested message is passed to the backend sign operation when
>      possible. This would allow more flexibility as some backends
>      prefer to do the hash operation internally.
> 
>    This was 4/9 in v1
> 
>

Acked-By: Arne Schwabe <arne@...1227...>



