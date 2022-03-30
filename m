Message-ID: <1a4c7f58-16fb-b909-0b40-41f20390179b@...2080...>
Date: Wed, 30 Mar 2022 11:11:54 +0200
MIME-Version: 1.0
Content-Language: en-GB
From: David Sommerseth <openvpn@...2080...>
References: <20220329192934.1415-1-timo@...2669...>
 <0886f123-9243-f7df-347c-68b62c469675@...2080...>
In-Reply-To: <0886f123-9243-f7df-347c-68b62c469675@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Retain CAP_NET_ADMIN when dropping
 privileges
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Timo Rothenpieler <timo@...2669...>
Cc: openvpn-devel@lists.sourceforge.net

On 30/03/2022 10:51, David Sommerseth wrote:
> On 29/03/2022 21:29, Timo Rothenpieler wrote:
>> ---
>> This patch sits on top of the current dco branch, and will not apply to
>> latest master.
>>
>> It solves the issue of dropping root privileges breaking dco and sitnl
>> due to missing NET_ADMIN capabilities.
>>
>>
>>   configure.ac           |  3 ++
>>   src/openvpn/init.c     | 22 +++++++++++++-
>>   src/openvpn/platform.c | 65 +++++++++++++++++++++++++++++++++++++++++-
>>   src/openvpn/platform.h |  2 +-
>>   4 files changed, 89 insertions(+), 3 deletions(-)
>>
> 
> Thanks a lot!  I've quickly looked through the code, and I have to NAK 
> this approach:
> 
>> +#ifdef HAVE_LINUX_CAPABILITIES
>> +#define SET_CAP_HELPER(data, set, cap) data[(cap)>>5].set |= 
>> 1<<((cap)&31)
>> +
>> +static bool
>> +do_keep_caps(bool prepare)
>> +{
>> +    struct __user_cap_header_struct cap_hdr = { 
>> _LINUX_CAPABILITY_VERSION_3 };
>> +    struct __user_cap_data_struct cap_data[_LINUX_CAPABILITY_U32S_3] 
>> = {};
>> +
>> +    if (syscall(SYS_capget, &cap_hdr, cap_data) < 0)
> 
> We should really use libcap or libcap-ng and not avoid using syscalls 
> directly.

This did not come out well.  Sorry about that.

We should really avoid using syscalls directly, as that binds us to 
certain APIs and bindings.

Newer kernels may also require additional adjustments in the future, to 
preserve the same behaviour.  Which means we need to maintain this code 
and also pay more attention to the security aspects of privilege 
management, like new vulnerabilities and exploits.

The libcap or libcap-ng libraries are used by far more applications, 
doing similar privilege management - and these libraries already pay 
attention to the security aspects of new vulnerabilities and exploits. 
The libcap-ng library is also recommended by more developers, due to its 
simpler API.

It is possible to argue that sitnl does low-level calls to the kernel as 
well.  But potential libraries had an API which was making everything 
far more complex on the OpenVPN side.  For libcap-ng at least, that is 
not the case; as the API it provides is pretty simple.

> I have used libcap-ng in openvpn3-linux, both for preserving 
> capabilities and dropping root.  It does all the right steps fairly easily.
> 
> The configure.ac detection, which for OpenVPN 2.x can be restricted when 
> DCO is going to be built into openvpn:
> <https://github.com/OpenVPN/openvpn3-linux/blob/master/configure.ac#L113>
> 
> The code for preserving capabilities:
> <https://github.com/OpenVPN/openvpn3-linux/blob/c40218df43c8e652fedfa70304eae797b305e780/src/netcfg/openvpn3-service-netcfg.cpp#L82> 
> 
> 
> And the code for dropping root, ensuring the capabilities are restricted 
> properly:
> <https://github.com/OpenVPN/openvpn3-linux/blob/c40218df43c8e652fedfa70304eae797b305e780/src/netcfg/openvpn3-service-netcfg.cpp#L64> 
> 


-- 
kind regards,

David Sommerseth
OpenVPN Inc


