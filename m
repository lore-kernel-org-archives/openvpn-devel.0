References: <20200825073643.15920-2-arne@...1227...>
 <20200907162221.20928-1-arne@...1227...>
 <0a0abf2e-227e-c44e-4e2e-57c59472f851@...2181...>
 <fbddc4c1-e6bd-9696-2e3f-009e43f1d011@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <ca157141-dc88-8017-0e6e-3ace055bc36e@...2181...>
Date: Fri, 22 Jan 2021 12:22:56 +0100
MIME-Version: 1.0
In-Reply-To: <fbddc4c1-e6bd-9696-2e3f-009e43f1d011@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 3/5] Allow running a default
 configuration with TLS libraries without BF-CBC
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
To: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On 22/01/2021 12:19, Arne Schwabe wrote:
>> I would suggest some refactoring here.
>> We can just assume that BF-CBC is not supported by the SSL library,
>> while also reducing some code duplication:
>>
>> const char *ciphername = o->ciphername;
>>
>> ...
>>
>> /* o->ciphername might be BF-CBC even though the underlying SSL library
>>  * does not support it. For this reason we workaround this corner case
>>  * by pretending to have no encryption enabled and by manually adding
>>  * the required packet overhead to the MTU computation.
>>  */
>> if (strcmp(o->ciphername, "BF-CBC") == 0)
>> {
>>    ciphername = "none";
>>    /* 64 bit block size, 64 bit IV size */
>>    frame_add_to_extra_frame(&fake_frame, 64/8 + 64/8);
>> }
> 
> That drops the adjusting for the HMAC size.  I will add a comment to
> clarify what the other lines are good for.

I moved the crypto_adjustment call below this block, since it is
performed both for BF-CBC and non-BF-CBC. Doesn't it work?



-- 
Antonio Quartulli

