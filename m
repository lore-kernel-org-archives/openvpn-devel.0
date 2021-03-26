From: tincanteksup <tincanteksup@...277...>
References: <1538820128-27086-1-git-send-email-lstipakov@...277...>
 <1540904039-2129-1-git-send-email-lstipakov@...277...>
 <4864a5a9-7816-6347-9a82-1e2432321562@...2181...>
 <650e29b8-e009-ba88-8d2b-1117fceeba65@...277...>
Message-ID: <5e3933a9-a3d0-01b2-b2b8-21573b7036a8@...277...>
Date: Fri, 26 Mar 2021 02:25:13 +0000
MIME-Version: 1.0
In-Reply-To: <650e29b8-e009-ba88-8d2b-1117fceeba65@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH v4] Improve "recursive routing" warning
 message
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
To: openvpn-devel@lists.sourceforge.net



On 26/03/2021 01:09, tincanteksup wrote:
> Hi,
> 
> On 25/03/2021 23:26, Antonio Quartulli wrote:
>> Hi,
>>
>> On 30/10/2018 13:53, Lev Stipakov wrote:
>>> From: Lev Stipakov <lev@...515...>
>>>
>>> +
>>> +        msg(D_LOW, "Recursive routing detected, drop packet %s. Fix 
>>> your routing or consider using --allow-recursive-routing option.", 
>>> BSTR(&addrs_buf));
>>
>> I would add "if you know what you are doing", otherwisethe average Joe
>> will think that he can just add "--allow-recursive-routing" to his
>> config and the problem is fixed.
>>
> 
> "If you know what you are doing" is no help
> because they all "_know what they are doing_" ...
> 
> My understanding is as follows:
> 
> Recursive-routing means that I send encrypted packets, which are
> destined for the public IP of the peer address, over the tunnel.
> Instead of over the internet (or other common network).
> 
> Considering the loops which the receiver will have to jump
> though to accept these packets, I question the validity of
> documenting this "feature" --allow-recursive-routing, at all.
> 

Perhaps this would be better suited as:
./configure --enable-recursive-routing
make

