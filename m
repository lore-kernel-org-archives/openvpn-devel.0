Message-ID: <d7dc1c7d-de6a-fa03-0553-fbe9f7cb9d44@...1227...>
Date: Thu, 6 Oct 2022 15:05:08 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220923085804.3743109-1-arne@...1227...>
 <Yy2Ggixtz/Uo1RVZ@...2685...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <Yy2Ggixtz/Uo1RVZ@...2685...>
Subject: Re: [Openvpn-devel] [PATCH] Document/cleanup event_timeout functions
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

Am 23.09.22 um 12:12 schrieb Frank Lichtenheld:

> 
>>   bool event_timeout_trigger(struct event_timeout *et,
>>                              struct timeval *tv,
>> -                           const int et_const_retry);
>> +                           int et_const_retry);
> 
> Why remove the const here? You did not remove it in interval.c

clang-tidy complains here. The reason is that the const is doing
nothing in the prototype:

Clang-Tidy: Parameter 'et_const_retry' is const-qualified in the 
function declaration; const-qualification of parameters only has an 
effect in function definitions.

Arne


