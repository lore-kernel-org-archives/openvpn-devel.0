Message-ID: <90d15dcb-71e8-4663-d2a6-3229b1cb361e@...1227...>
Date: Thu, 20 Jan 2022 11:42:50 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20211214165928.30676-1-selva.nair@...277...>
 <20211214165928.30676-6-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20211214165928.30676-6-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3 05/18] Initialize the xkey provider
 and use it in SSL context
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
> - Add function to check when external key is in use
> 
> - Load xkey provider into a custom library context when required
> 
> - Use the custom libctx in SSL CTX when external key is in use
> 
> As no keys are yet loaded through the provider,
> no functionality gets delegated to it as yet.
> 
> v2 changes: Provider loading is reworked to activate only when external
>              keys are in use
>              This was 2/9 in v1
> 

Acked-By: Arne Schwabe <arne@...1227...>




