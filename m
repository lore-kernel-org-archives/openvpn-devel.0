Message-Id: <03F19102-8A51-4742-B7CE-BD499BA793C0@...1348...>
From: Toby Thain <toby@...1348...>
In-Reply-To: <201006060058.21798.dave_br@...1278...>
Mime-Version: 1.0 (Apple Message framework v936)
Date: Mon, 7 Jun 2010 07:02:39 +1000
References: <20100604224938.GA19956@...1375...>
	<201006052336.37559.dave_br@...1278...>
	<915E9EDC-6AC1-4CAE-963C-0CBBFA3315F5@...1348...>
	<201006060058.21798.dave_br@...1278...>
Subject: Re: [Openvpn-devel] PATCH: remove bashisms from easy-rsa
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: Davide Brini <dave_br@...1278...>
Cc: openvpn-devel@lists.sourceforge.net


On 6-Jun-10, at 9:58 AM, Davide Brini wrote:

> On Sunday 06 June 2010, Toby Thain wrote:
>
>>>> Most of the common GNU utilities (including gcc) are in the  
>>>> standard
>>>> Solaris install, either via /usr/sfw/ or by using g prefix (e.g.
>>>> gawk,
>>>> gmake).
>>>
>>> Possibly, but it still means that either scripts using standard
>>> names and expecting standard functionality have to be changed, or  
>>> the
>>> system has to be changed to have the standard-named utilites point  
>>> to the
>>> GNU versions.
>>
>> Yes and no... Autotools will generally find the g-binaries (obviously
>> autotools has long supported Solaris). OpenSolaris does, I believe,
>> bring more GNU to standard userland (but this is not  
>> uncontroversial).
>
> Well yes, but to paraphrase what you say later, "all the world's not  
> GNU", so
> probably not everyone uses autotools :-)
>
> In my (admittedly limited) experience, solaris has always shipped  
> non-standard
> or inferior default tools, even long before GNU came about.

Yes - Buggy/poorly supported vendor tools (Sun was certainly not the  
only or worst offender) was a major issue GNU was meant to fix. (In  
the particular case of SunOS, missing vendor compiler.)

>
>> It is a bit tricky deriving a portable bang-path in your case. But
>> innovations like dash on Debian also serve to prove that 'all the
>> world's not a GNU/Linux'.
>
> Agreed! (although dash isn't perfect yet, but nevermind). That's why  
> I think
> #!/bin/sh should be used.
>

--Toby

>
> -- 
> D.


