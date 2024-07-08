Message-ID: <2a9ac24a-462f-4761-ac04-e803cb714b5d@...2181...>
Date: Mon, 8 Jul 2024 23:57:56 +0200
MIME-Version: 1.0
References: <20240708210912.566-1-chipitsine@...277...>
 <20240708210912.566-2-chipitsine@...277...>
 <5b9f85fd-dcd1-463a-bb0f-9cc3a9081116@...2181...>
 <CAFHpkQFw4sD6P7cVVWgr31z1J=MyyyLx-bt=mSXFYe84nWjWSw@...278...>
 <bd7c09ce-490e-4855-a043-74d4272486a5@...2181...>
 <CAFHpkQHWwPZY3nwOSPFMp3eiRvytDOuUK4RVDO96uBy8Jtonug@...278...>
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <CAFHpkQHWwPZY3nwOSPFMp3eiRvytDOuUK4RVDO96uBy8Jtonug@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/5] src/openvpn/init.c: handle strdup
 failures
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
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: openvpn-devel@lists.sourceforge.net

On 08/07/2024 23:53, Илья Шипицин wrote:
> пн, 8 июл. 2024 г. в 23:47, Antonio Quartulli <a@...2181...>:
>>
>> Hi,
>>
>> On 08/07/2024 23:44, Илья Шипицин wrote:
>>>>> +                msg( M_FATAL, "Failed allocate memory saved_pid_file_name");
>>>>
>>>> patchset looks great, but (!!) there should be no space after the
>>>> opening parenthesis..
>>>
>>> I just followed code style already present in repo
>>>
>>> $ grep -r 'msg( M_FATAL' .
>>> grep: ./.git/objects/pack/pack-d09f3eabac42224b1dc52ffb4f53d9af23bc5b7d.pack:
>>> binary file matches
>>> ./src/openvpn/auth_token.c:        msg( M_FATAL, "Failed to get enough
>>> randomness for "
>>> ./src/openvpn/tun.c:            msg( M_FATAL, "init_tun: problem
>>> converting IPv6 ifconfig addresses %s and %s to binary",
>>> ifconfig_ipv6_local_parm, ifconfig_ipv6_remote_parm );
>>> ./src/openvpn/tun.c:            msg( M_FATAL, "cannot find unused tap device" );
>>> ./src/openvpn/tun.c:            msg( M_FATAL, "TAP device name must be
>>> '--dev tapNNNN'" );
>>
>> Unfortunately those are unlucky leftovers that haven't been fixed yet:
>>
>> $ grep -r 'msg(M_FATAL' . |wc -l
>> 286
>>
>> $ grep -r 'msg( M_FATAL' . |wc -l
>> 4
>>
>>>
>>> also, uncrustify GHA jobs agreed that it is no formatting violation
>>
>> doubly unfortunate as I think uncrustify can't force this or it gets
>> confused somehow :(
> 
> if those spaces makes you unhappy, I'm fine if you fix them during commit apply

I don't think Gert like to change code lines while committing a patch 
(We can wait for him to say something)

However, I can also offer myself to send a patch with a full cleanup 
afterwards.

Cheers,


-- 
Antonio Quartulli

