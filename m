References: <20211107090138.3150187-1-arne@...1227...>
 <5fa04cf3-c7b7-7e26-db95-ee734b0001ea@...68...>
 <9ab3a55c-062a-d849-0434-0df90bea4224@...1227...>
 <eaaa8190-3418-c155-4459-a12e853c9eda@...68...>
 <dc3a4862-c794-00b2-7ef7-87a1b6bc82fb@...1227...>
From: Max Fillinger <maximilian.fillinger@...2507...>
Message-ID: <f4c07758-6b7c-e47b-3853-bd14b9889fec@...2507...>
Date: Sun, 7 Nov 2021 13:34:54 +0100
MIME-Version: 1.0
In-Reply-To: <dc3a4862-c794-00b2-7ef7-87a1b6bc82fb@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Completely remove DES checks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 07/11/2021 13:29, Arne Schwabe wrote:
> 
>>>
>>> The patch removes checking for weak keys and making DES just like any
>>> other CBC cipher and not doing extra checks for this. It basically
>>> removes the special treatment of DES.
>>
>>
>> After this, do we have any DES functionality left in OpenVPN? If so, we
>> should remove it.
>>
> 
> After this patch, no special handling for DES anymore. YOu can still use 
> DES but it is handled like any other cipher, e.g. BF-CBC, AES-CBC
> 
> Arne

I think the point is that if we stop checking weak keys, we should rip 
out DES support completely. (I'd be in favor, but I'm not deep enough 
into it to know what the fallout would be.)

My view is, if someone's doing DES, they're not caring about security, 
so the small risk of weak keys is acceptable. Basically, "all DES keys 
are weak keys."

