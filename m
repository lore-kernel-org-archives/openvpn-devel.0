References: <20170824133305.25604-1-a@...2181...>
 <20170824191848.GH70062@...1296...>
 <011fb50e-4b84-6f2c-c730-dc419b840f6f@...2080...>
 <f9727fce-bda2-e21d-c944-22b5b28f7629@...2181...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <6e449f4b-271a-f738-7ee9-f9120ed0e714@...1147...>
Date: Tue, 29 Aug 2017 18:19:21 +0200
MIME-Version: 1.0
In-Reply-To: <f9727fce-bda2-e21d-c944-22b5b28f7629@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] bash: substitute legacy `` with modern
 $()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Antonio Quartulli <a@...2181...>, David Sommerseth <openvpn@...2080...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 25/08/17 03:41, Antonio Quartulli wrote:
>
> On 25/08/17 04:21, David Sommerseth wrote:
>> On 24/08/17 21:18, Gert Doering wrote:
>>> (gen-release-tarballs.sh only needs to work on FreeBSD and Linux, and
>>> FreeBSD's /bin/sh is sufficiently modern so so it's likely to work
>>>   - but the test scripts need to run robustly everywhere a user builds,
>>> so never assume "because bash says so!" is a way anywhere but into worlds
>>> of pain.  And yes, we've been there before :-) )
>> And to avoid style confusions ... as long as we can avoid having "one
>> style" on the test scripts and "another style" on the dev-tools scripts,
>> that will be easier to review and maintain.
>>
>> We can have more slack in dev-tools, but if we deviate, then we need to
>> properly document it so we won't forget why.
> I also think it is a bad idea to have different styles. If we have to
> agree on something, it should be valid for every file of that type.
>
> Let's postpone this for when we'll have tested various platforms.
>
>
my biggest complaint about the so-called modern $() notation is that it 
clashes/confuses the heck out of me when using proper variable usage, 
e.g. I find
   output=`${SOME_COMMAND} ${SOME_ARGS}`
much better readable than
   output=$(${SOME_COMMAND} ${SOME_ARGS})

especially since you are allowed to **NEST** $() strings, IIRC. Things like

   output=$(${cmd} $(${cmd2}))

work, and in my view, thank god that you cannot do that using backtics ;)

JM2CW,

JJK



