References: <20210325000121.10331-1-arne@...1227...>
 <2d571572-e3c0-9d9b-81a7-ccb5f8bd0736@...277...>
 <016c3086-965b-2c78-9769-59f60551cf36@...2181...>
 <b8e67a75-2459-bc49-8950-391913809b7a@...2181...>
 <1c7912e4-3437-c918-2181-ee752cece126@...277...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <3dc8bb5d-48c7-049f-6415-aaa8df4500e5@...2181...>
Date: Thu, 25 Mar 2021 16:52:52 +0100
MIME-Version: 1.0
In-Reply-To: <1c7912e4-3437-c918-2181-ee752cece126@...277...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 1/2] Deprecate non TLS mode in OpenVPN
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
To: tincanteksup <tincanteksup@...277...>, openvpn-devel@lists.sourceforge.net

Hi,

On 25/03/2021 16:46, tincanteksup wrote:
> Hi,
> 
> On 25/03/2021 07:59, Antonio Quartulli wrote:
>> Hi,
>>
>> On 25/03/2021 08:49, Antonio Quartulli wrote:
>>> That change (that was *Actually* made in 2.4) was exactly to remove this
>>> ambiguity.
>>
>> Forgive my hasty reply. This combination of option is actually
>> not-supported since 2.5 (in 2.4 we probably only introduced the
>> deprecation warning).
> 
> I think I know what you mean.
> 
> Deprecating `--secret` to be `--genkey secret` is on the wiki.
> But the change *has* been made in 2.5 not pending for 2.7

correct.

> 
> Deprecating non-TLS mode VPNs is not on the wiki.
> 
> Deprecate non-TLS mode in 2.5

this depends on where the patch will be merged. I guess we have to wait
for that.

> To be removed in 2.7

correct

> Replaced by peer-fingerprint option.

not replaced as drop-in, but users of --secret should look at
--peer-fingerprint, yes.

> 
> If that is correct then I can add "non-TLS mode" to the wiki.
> Clear up the mess^D^D^D^D ambiguity ..

I would suggest to wait for the patch to be merged first.
But the summary sounds right.


Cheers,

-- 
Antonio Quartulli

