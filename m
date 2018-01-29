References: <1516301696-11308-1-git-send-email-selva.nair@...277...>
 <1516909513-31683-1-git-send-email-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <02b6e2e4-64c9-75de-40ce-0a820117b07d@...1227...>
Date: Mon, 29 Jan 2018 11:18:57 +0100
MIME-Version: 1.0
In-Reply-To: <1516909513-31683-1-git-send-email-selva.nair@...277...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH v3 2/3] Allow external EC key through
 --management-external-key
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

Am 25.01.18 um 20:45 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
> 
> - This automatically supports EC certificates through
>   --management-external-cert
> - EC signature request from management is prompted by
>   >PK_SIGN if the client supports it (or >RSA_SIGN)
>   Response should be of the form 'pk-sig' (or rsa-sig
>   by older clients) followed by DER encoded signature
>   as base64 terminated by 'END' on a new line.
> 
>

Acked-by: Arne Schwabe <arne@...1227...>

Ack from my side. Note that this patch will ask for a ec signatre with >
RSA-SIGN when the user has put a EC certificate in the config and the ui
does not send "version 2". I am not sure that we need to address this
tough. That kind of configuration will break anyway. It just now does at
a different point. And putting an EC certificate is not something that
should happen on accident.

Arne

