Message-ID: <8b9722eb-3282-dc1b-abbe-91cc37083af3@...2669...>
Date: Wed, 30 Mar 2022 13:31:24 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220329192934.1415-1-timo@...2669...>
 <0886f123-9243-f7df-347c-68b62c469675@...2080...>
 <1a4c7f58-16fb-b909-0b40-41f20390179b@...2080...>
From: Timo Rothenpieler <timo@...2669...>
In-Reply-To: <1a4c7f58-16fb-b909-0b40-41f20390179b@...2080...>
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
To: David Sommerseth <openvpn@...2080...>
Cc: openvpn-devel@lists.sourceforge.net

On 30.03.2022 11:11, David Sommerseth wrote:
> On 30/03/2022 10:51, David Sommerseth wrote:
>> On 29/03/2022 21:29, Timo Rothenpieler wrote:
>>> ---
>>> This patch sits on top of the current dco branch, and will not apply to
>>> latest master.
>>>
>>> It solves the issue of dropping root privileges breaking dco and sitnl
>>> due to missing NET_ADMIN capabilities.
>>>
>>>
>>>   configure.ac           |  3 ++
>>>   src/openvpn/init.c     | 22 +++++++++++++-
>>>   src/openvpn/platform.c | 65 +++++++++++++++++++++++++++++++++++++++++-
>>>   src/openvpn/platform.h |  2 +-
>>>   4 files changed, 89 insertions(+), 3 deletions(-)
>>>
>>
>> Thanks a lot!  I've quickly looked through the code, and I have to NAK 
>> this approach:
>>
>>> +#ifdef HAVE_LINUX_CAPABILITIES
>>> +#define SET_CAP_HELPER(data, set, cap) data[(cap)>>5].set |= 
>>> 1<<((cap)&31)
>>> +
>>> +static bool
>>> +do_keep_caps(bool prepare)
>>> +{
>>> +    struct __user_cap_header_struct cap_hdr = { 
>>> _LINUX_CAPABILITY_VERSION_3 };
>>> +    struct __user_cap_data_struct cap_data[_LINUX_CAPABILITY_U32S_3] 
>>> = {};
>>> +
>>> +    if (syscall(SYS_capget, &cap_hdr, cap_data) < 0)
>>
>> We should really use libcap or libcap-ng and not avoid using syscalls 
>> directly.

Is there any preference between the two? I initially used libcap, but 
wanted to avoid introducing another dependency.
But both libcap and libcap-ng seem to be widely adopted by distros, and 
there isn't a huge difference in boilerplate between them for this purpose.

> This did not come out well.  Sorry about that.
> 
> We should really avoid using syscalls directly, as that binds us to 
> certain APIs and bindings.
> 
> Newer kernels may also require additional adjustments in the future, to 
> preserve the same behaviour.  Which means we need to maintain this code 
> and also pay more attention to the security aspects of privilege 
> management, like new vulnerabilities and exploits.
> 
> The libcap or libcap-ng libraries are used by far more applications, 
> doing similar privilege management - and these libraries already pay 
> attention to the security aspects of new vulnerabilities and exploits. 
> The libcap-ng library is also recommended by more developers, due to its 
> simpler API.
> 
> It is possible to argue that sitnl does low-level calls to the kernel as 
> well.  But potential libraries had an API which was making everything 
> far more complex on the OpenVPN side.  For libcap-ng at least, that is 
> not the case; as the API it provides is pretty simple.

Shouldn't caps support also be enabled when sitnl is in use?
Given it also needs CAP_NET_ADMIN.


