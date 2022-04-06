Message-ID: <cb67c49f-ebb3-caac-0e5e-d94135a506fe@...2080...>
Date: Wed, 6 Apr 2022 15:34:02 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220329192934.1415-1-timo@...2669...>
 <20220330205536.139-1-timo@...2669...>
 <67b5b48f-619a-b344-9f51-e1bba55aa3d2@...2181...>
 <d2fd8d11-225c-992c-28f4-9a8522d65b37@...2669...>
From: David Sommerseth <openvpn@...2080...>
In-Reply-To: <d2fd8d11-225c-992c-28f4-9a8522d65b37@...2669...>
Subject: Re: [Openvpn-devel] [PATCH v2] Retain CAP_NET_ADMIN when dropping
 privileges
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
To: Antonio Quartulli <a@...2181...>
Cc: Timo Rothenpieler <timo@...2669...>, openvpn-devel@lists.sourceforge.net

On 06/04/2022 14:44, Timo Rothenpieler wrote:
>>>
>>
>> 'man cap_change_id' does not mention setting errno at all.
>> What do we expect to see with M_ERRNO?
> 
> Every function it internally calls sets errno, so in case of failure 
> errno will reflect what went wrong. Like, for example EPERM will be the 
> most common cause of failure.

capng_change_id() does several other lower level calls, like prctl(), 
setgroups(), setresgid() and setresuid().  They all set errno if an 
error occurs.  The return code of capng_change_id() just reflects in 
which phase of dropping privileges/uid/gid it failed.

For more details of the capng_change_id(), the implementation itself 
isn't that hard to read (but it does a several steps to harden the 
privilege drop): 
<https://github.com/stevegrubb/libcap-ng/blob/03b8572843b36bf071776a311c61f8d1dcfc4d53/src/cap-ng.c#L960>


-- 
kind regards,

David Sommerseth
OpenVPN Inc


