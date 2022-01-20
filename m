Message-ID: <25882b91-21c6-aad7-302b-77d505823a55@...1227...>
Date: Thu, 20 Jan 2022 11:55:36 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20211214165928.30676-1-selva.nair@...277...>
 <20211214165928.30676-11-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <20211214165928.30676-11-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3 10/18] Respect algorithm support
 announced by management client
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
> Support for padding algorithms in management-client is indicated
> in the optional argument to --management-external-key as "pkcs1",
> "pss" etc. We currently use it only for an early exit based on heuristics
> that a required algorithm may not be handled by the client. When
> signature is requested we do not check whether the padding is indeed
> supported by the client. This leads to situations like the client announcing
> nopadding support but we request pss signature.
> 
> Here we add a check while requesting signature as well. If the padding
> treat it as an error instead of submitting the request to the
> management-interface regardless.
> 
> This change is made only when xkey provider is in use, though such a check
> would be appropriate always.

Acked-By: Arne Schwabe <arne@...1227...>



