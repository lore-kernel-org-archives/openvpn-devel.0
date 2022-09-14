Message-ID: <7986ab95-4904-2092-522a-e238923b0ce5@...2181...>
Date: Wed, 14 Sep 2022 09:20:52 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <202208301957.27UJv74w093000@...2054...>
 <20220912074149.31160-1-gert@...1296...>
 <a0668e8c-897d-c360-e501-89a246de4bd6@...2181...>
 <YyFzfzdi1Mk3Fe7n@...1296...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <YyFzfzdi1Mk3Fe7n@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Improve documentation for --dev and
 --dev-node.
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 14/09/2022 08:23, Gert Doering wrote:
> Hi,
> 
> On Tue, Sep 13, 2022 at 11:38:29PM +0200, Antonio Quartulli wrote:
>>> +  On other platforms, ``--dev-node node`` will influence the naming of the
>>> +  created tun/tap device, if supported on that platform.  If OpenVPN cannot
>>> +  figure out whether ``node`` is a TUN or TAP device based on the name,
>>> +  you should also specify ``--dev-type tun`` or ``--dev-type tap``.
>>> +
>>>    --dev-type device-type
>>>      Which device type are we using? ``device-type`` should be :code:`tun`
>>>      (OSI Layer 3) or :code:`tap` (OSI Layer 2). Use this option only if
>>
>>
>> I like this improved version as it tries to bring clarity. However, I
>> feel it is too vague as to which platform does what.
>>
>> For example the last paragraph starts with "On other platform", but what
>> are these "other platforms"?
> 
> The intent was to list the 3 platforms where --dev-node does something
> special, and then "other platforms" is "everything else" (technically,
> all platforms that call open_tun_generic(), so I'm not absolutely sure
> if AIX or Solaris qualify... but I'm not going to mention AIX or Solaris
> there, as it's way too unimportant and will just increase text length).
> 
> Especially as it's not even working on "all other platforms" due to
> limitations, the documentation won't get less vague than the actual
> implementation...
> 
>> Maybe it's just me, but saying "other platforms" or "some platforms" or
>> "most platforms" without explicitly saying which ones is the same as to
>> not really documenting the behaviour. Because I am still unable to
>> understand which platform does what.
>>
>> Should we rather split this platform by platform with related paragraphs?
>>
>> What do you think?
> 
> We could do that, and nobody would really read it - it would just get
> long, with quite some repetitions (the BSDs are all very similar, except
> when they are not)...
> 
> I'm still for "on platforms that are not Windows, MacOS or Linux, --dev-node
> will usually not do what you want, so forget about it right away" - wrapped
> in a slightly longer text :-)

Ok, so it's not the comment that is vague, but it's the implementation 
itself that is not clean.

Well, then let's go with your new doc and let's see if we can improve 
the implementation after 2.6 is done.

Acked-by: Antonio Quartulli <a@...2181...>

Cheers,

> 
> gert

-- 
Antonio Quartulli

