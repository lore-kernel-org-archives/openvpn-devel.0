Message-ID: <46b0385b-2de3-17e5-be85-2db312b56c6d@...1227...>
Date: Mon, 25 Apr 2022 14:06:38 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422134038.3801239-4-arne@...1227...>
 <1632774663.198868.1650642731983@...2642...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <1632774663.198868.1650642731983@...2642...>
Subject: Re: [Openvpn-devel] [PATCH 03/28] Move pre decrypt lite check to
 its own function
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
To: Frank Lichtenheld <frank@...2641...>, openvpn-devel@lists.sourceforge.net

Am 22.04.22 um 17:52 schrieb Frank Lichtenheld:
> 
> 
>> Arne Schwabe <arne@...1227...> hat am 22.04.2022 15:40 geschrieben:
>> diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
>> index 4fbe3c1a3..910268333 100644
>> --- a/src/openvpn/mudp.c
>> +++ b/src/openvpn/mudp.c
>> @@ -39,6 +39,20 @@
>>   #include <sys/inotify.h>
>>   #endif
>>   
>> +static bool
>> +do_pre_decrypt_check(struct multi_context *m)
>> +{
>> +    if (!m->top.c2.tls_auth_standalone)
>> +    {
>> +        return false;
>> +    }
>> +    if (!tls_pre_decrypt_lite(m->top.c2.tls_auth_standalone, &m->top.c2.from, &m->top.c2.buf))
>> +    {
>> +        return false;
>> +    }
>> +    return true;
> 
> Shouldn't this be
> if (!m->top.c2.tls_auth_standalone)

Yes. But then again the whole line is dead code anyway because 
m->top.c2.tls_auth_standalone is always initialised.

Arne

