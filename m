References: <20210421134348.1950392-1-arne@...1227...>
 <20210421134348.1950392-4-arne@...1227...>
 <b4147c3d-e538-941f-1b71-54740635f5b0@...2181...>
 <768cdbbb-1a54-d943-a0e5-8e511ec0244b@...1227...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <fe529573-cee9-6191-0f8a-282102777a08@...2181...>
Date: Thu, 22 Apr 2021 16:10:24 +0200
MIME-Version: 1.0
In-Reply-To: <768cdbbb-1a54-d943-a0e5-8e511ec0244b@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 4/7] Fix a number of mingw warnings
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 22/04/2021 14:39, Arne Schwabe wrote:
> 
>>>  #ifndef _WIN32
>>> +    const char *device = tt->actual_name;
>>
>> This variable is not used in all cases embraced by "ifndef _WIN32".
>> I.e. I think it is not used when any of the following is defined:
>> TARGET_OPENBSD
>> TARGET_NETBSD
>> TARGET_AIX
>>
>> Therefore this change would fix *only* the warning on Windows.
>> Do we want to go this way? or should we rather rearrange the ifdefs a
>> bit so that we have a cleaner change/function?
> 
> 
> No all other platforms. The variable is used just 2 lines below it
> definition to set gateway_needed which is used by all platforms apart
> from _WIN32. So only WIN32 had this warning.

Well, it's assigned but not used on the platforms I mentioned.
I guess the compiler isn't able to throw a warning at the moment though.

Anyway, I am fine with keeping this change as it is. This code may
require some bigger restructuring at some point.
So fixing the usage of one variable only doesn't give us anything.

But at least this changes gets rid of a warning :)

> 
>>
>>
>>
>>>      if (r6->iface != NULL)              /* vpn server special route */
>>>      {
>>>          device = r6->iface;
>>> @@ -2713,7 +2713,7 @@ get_default_gateway_row(const MIB_IPFORWARDTABLE *routes)
>>>              const DWORD index = row->dwForwardIfIndex;
>>>              const DWORD metric = row->dwForwardMetric1;
>>>  
>>> -            dmsg(D_ROUTE_DEBUG, "GDGR: route[%d] %s/%s i=%d m=%d",
>>> +            dmsg(D_ROUTE_DEBUG, "GDGR: route[%lu] %s/%s i=%d m=%d",
>>
>> shouldn't be enough to convert to %u ? (/me is not a DOWRD expert though)
> 
> No. DWORD is a long unsigned int as mentioned in the commit message. It
> is 32 bit int since Windows always has long as 32 bit. It is a bit
> confusing when you are used to the long=64 bit :)
> 
>>> index 2c1b270dd..4ef34e4eb 100644
>>> --- a/src/openvpn/tun.c
>>> +++ b/src/openvpn/tun.c
>>> @@ -5606,7 +5606,7 @@ windows_set_mtu(const int iface_index, const short family,
>>>  
>>>      if (err != NO_ERROR)
>>>      {
>>> -        msg(M_WARN, "TUN: Setting %s mtu failed: %s [status=%u if_index=%d]",
>>> +        msg(M_WARN, "TUN: Setting %s mtu failed: %s [status=%lu if_index=%d]",
>>
>> same question as above.
>>

Thanks for the explanation on DWORD.

Compiled on my rig and no problem showed up.

Acked-by: Antonio Quartulli <antonio@...515...>



-- 
Antonio Quartulli

