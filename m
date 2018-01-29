References: <1516909261-31623-1-git-send-email-selva.nair@...277...>
 <1516909261-31623-2-git-send-email-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <5dd97615-fdb8-6e32-c595-3d0e280df496@...1227...>
Date: Mon, 29 Jan 2018 09:05:34 +0100
MIME-Version: 1.0
In-Reply-To: <1516909261-31623-2-git-send-email-selva.nair@...277...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH 2/2] Prompt for signature using
 '>PK_SIGN' if the client supports it
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

Am 25.01.18 um 20:41 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> - Increase the management version from 1 to 2
> - If the client announces support for management version > 1
>   prompt for signature using >PK_SIGN to which the client
>   responds using 'pk-sig'
>   Older (current) clients will be continued to be prompted
>   by '>RSA_SIGN' and can respond using 'rsa-sig'
> - Remove an unused rsa_sig buffer-list variable
> 

Acked-by: Arne Schwabe <arne@...1227...>

Arne

