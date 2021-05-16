References: <20200717171036.20687-1-davids@...515...>
 <6062d64c-14ef-0e0d-4e83-925b79b4900b@...1227...>
 <7030cf8b-d047-107d-21b8-f02c8a1338c9@...1227...>
 <77750051-9589-15db-34cb-3aacc8b69694@...2181...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <c120ccab-50b8-fc24-1edc-6229d2b75ac5@...1856...>
Date: Sun, 16 May 2021 15:23:33 +0200
MIME-Version: 1.0
In-Reply-To: <77750051-9589-15db-34cb-3aacc8b69694@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Remove --no-replay
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 07-04-2021 17:50, Antonio Quartulli wrote:
> On 26/07/2020 15:31, Arne Schwabe wrote:
>> Am 26.07.20 um 02:01 schrieb Arne Schwabe:
>>> Am 17.07.20 um 19:10 schrieb David Sommerseth:
>>>> The --no-replay feature is considered to be a security weakness, which
>>>> was also highlighed during the OpenVPN 2.4 security audit [0].  This
>>>> option was added to the DeprecatedOptions[1] list and has been reported
>>>> as deprecated since OpenVPN 2.4.
>>>
>>> As a side note, removing this feature weakens the ability to use OpenVPN
>>> is a pure tunnel without crypto (--auth none, --cipher none and
>>> no-replay) since this removes the ability to disable replay proctection
>>> when no authentication is enabled. (replay protection without auth is
>>> silly as a attacker can just fake the replay id too.)
>>>
>>> Acked-By: Arne Schwabe
>>
>> I given that a bit of a thought. But we need to decide if we to support
>> unencrypted transport only session or not in future. If we do not want
>> to support them, then applying this patch is fine, otherwise we should
>> restrict disabling no-replay to --auth none and also --auth none to
>> --cipher none basically:
>>
>> --cipher != none => auth none and no-replay forbidden
>>
>> --cipher == none => allows auth none and also no-replay
>>
>> --cipher none and auth none, warn if no-replay is used that it does not
>> prevent replay attacks. But do not fail since we would break a lot of
>> setups.
> 
> I work for the ministry of oversimplification and I think that removing
> user knobs is simply a good thing.
> 
> Following the logic provided by Arne, how about removing the --no-reply
> knob and making this mechanism automatic?
> 
> * if cipher != none -> replay prevention is always enabled;
> * if cipher == none && auth == none -> replay prevention is disabled.
> 
> 
> [allowing or disabling auth=none should be tackled saparately imho]

Before getting into solutions, let me state a few facts:

1. Replay protection only really works when authentication is enabled.

2. Our AEAD modes all require replay protection.

3. Automatically disabling replay protection will cause a config
backward compatibility break.


Given 1, if we were to couple allowing --no-replay to some crypto
settings, I would say it should be coupled to --auth none.

Given 2, how clear is our timeline on sunsetting non-AEAD ciphers? That
would automatically sunset --no-replay. (I've lost track a bit...)

Point 3 should not really be a problem, because --no-replay has been
deprecated since 2.4 (2017), and is an edge use-case anyway. But it
should be a conscious decision.


So, unless we're about to sunset non-AEAD ciphers soon (which would
automatically solve the issue), I would suggest a small variation to
Antonio's approach:

Remove the option, and:
 * if auth != none -> replay prevention is always enabled;
 * if auth == none -> replay prevention is disabled.

(Of course, considering that auth != none for AEAD cipher modes, even
when --auth none is set.)

-Steffan

