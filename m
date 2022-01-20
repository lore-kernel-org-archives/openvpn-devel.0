Message-ID: <4c7d083b-5499-cfde-07c1-be9417e8f654@...1227...>
Date: Thu, 20 Jan 2022 12:21:30 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20211214165928.30676-1-selva.nair@...277...>
 <20211214165928.30676-16-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20211214165928.30676-16-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3 15/18] Enable signing using CNG
 through xkey provider
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
> - Add xkey_cng_sign() as sign_op for the provider
>    and load the key using xkey_generic_load.
> 
> - Enable/Disable old code when provider is available or not.
> 
> - xkey_digest is made non-static for use in cryptoapi.c
> 
> One function cng_padding_type() is moved down to reduce number
> of ifdef's.


Acked-By: Arne Schwabe <arne@...1227...>

Note, I have not tested the CNG signing myself.

