Message-ID: <90e5620b-deaa-3c44-7c62-43608367f7b7@...1227...>
Date: Thu, 25 Aug 2022 14:28:34 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <CAKuzo_hyreVwf5DEDGQNOXNtci8pE8Kf=tBCnhw0X+Xh0PEEFQ@...278...>
 <20220822085647.389-1-lstipakov@...277...> <YwddALlQ32m4MkxB@...1296...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <YwddALlQ32m4MkxB@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v103] dco-win: implement ovpn-dco
 support in P2P Windows code path
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
To: Gert Doering <gert@...1296...>, Lev Stipakov <lstipakov@...277...>
Cc: Lev Stipakov <lev@...515...>, Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Am 25.08.22 um 13:29 schrieb Gert Doering:
> Hi,
> 
> On Mon, Aug 22, 2022 at 11:56:47AM +0300, Lev Stipakov wrote:
>> From: Antonio Quartulli <a@...2181...>
>>
>> With this change it is possible to use ovpn-dco-win when running OpenVPN
>> in client or P2P mode.
>>
>> Signed-off-by: Arne Schwabe <arne@...1227...>
>> Signed-off-by: Lev Stipakov <lev@...515...>
>> Signed-off-by: Antonio Quartulli <a@...2181...>
>> ---
>>   Changes from v102:
>>   * use "windows-driver ovpn-dco" without trailing "-win", since
>>     "windows" is already implied by option name.
> 
> I have received sufficient test reports to be happy about it.  The change
> for v102 makes sense.
> 
> Alas, there is one change in v101 that I initiated which I'm now no
> longer happy about:
> 
>> @@ -3434,6 +3436,10 @@ options_postprocess_setdefault_ncpciphers(struct options *o)
>>           /* custom --data-ciphers set, keep list */
>>           return;
>>       }
>> +    else if (dco_enabled(o))
>> +    {
>> +        o->ncp_ciphers = dco_get_supported_ciphers();
>> +    }
>>       else if (cipher_valid("CHACHA20-POLY1305"))
>>       {
>>           o->ncp_ciphers = "AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305";
> 
> This change does the right thing for DCO-enabled *Windows* builds, but
> it does bad things for DCO-enabled FreeBSD, because of

I would also NAK the patch based on this. The default is currenlty 
AES-128-GCM:AES-256-GCM and Chacha20-Poly1305 if supported. We don't 
want to expose all algorithms that a DCO implementation supports.

The other thing is AES-192-GCM that we never announced before by default 
and this change would announce that by default. That is also weird 
behaviour.

Currently that might sound like nit picking but there are already other 
AEAD ciphers that can be easily added to DCO implementations (ARIA as 
AES variant is probably trivial in Linux for example).

Arne

