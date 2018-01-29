MIME-Version: 1.0
In-Reply-To: <02b6e2e4-64c9-75de-40ce-0a820117b07d@...1227...>
References: <1516301696-11308-1-git-send-email-selva.nair@...277...>
 <1516909513-31683-1-git-send-email-selva.nair@...277...>
 <02b6e2e4-64c9-75de-40ce-0a820117b07d@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 29 Jan 2018 12:32:44 -0500
Message-ID: <CAKuzo_hWSZ=+x1gruXHmz8sbZa6kUm=Jc0ApmEGbEmBfny9wpA@...278...>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

Thanks for the review and ACK.

On Mon, Jan 29, 2018 at 5:18 AM, Arne Schwabe <arne@...1227...> wrote:
> Am 25.01.18 um 20:45 schrieb selva.nair@...277...:
>> From: Selva Nair <selva.nair@...277...>
>>
>> - This automatically supports EC certificates through
>>   --management-external-cert
>> - EC signature request from management is prompted by
>>   >PK_SIGN if the client supports it (or >RSA_SIGN)
>>   Response should be of the form 'pk-sig' (or rsa-sig
>>   by older clients) followed by DER encoded signature
>>   as base64 terminated by 'END' on a new line.
>>
>>
>
> Acked-by: Arne Schwabe <arne@...1227...>
>
> Ack from my side. Note that this patch will ask for a ec signatre with >
> RSA-SIGN when the user has put a EC certificate in the config and the ui
> does not send "version 2". I am not sure that we need to address this
> tough. That kind of configuration will break anyway. It just now does at
> a different point. And putting an EC certificate is not something that
> should happen on accident.

I do not think we need to be concerned about this. An old UI would
just say either it doesn't support signing using the key or that it
got incorrect signature request from the daemon. So instead of
erroring out in openvpn we will error out in the UI.

But that's the theory, I do not know how extant UI's out there would
respond to RSA_SIGN request with data != 36 bytes or when key is not
RSA. The !=36 byte thing already happened when we merged the TLS1.2
patch. What will the android client do in this case?

Jonathan, would tunnelblick cope if it gets an RSA_SIGN when the key
is EC or with unexpected data size?

Selva

