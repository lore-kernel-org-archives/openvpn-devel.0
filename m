MIME-Version: 1.0
Date: Mon, 07 May 2012 17:11:33 +0300
From: Adrien Bustany <adrien@...1716...>
In-Reply-To: <CAOazyz2ZO7VMzrNBMFO6Eczi858+Y0FnmrGVUmKbw=9-nrN0LA@...278...>
References: <c0aca6be1ae29a0fe176829a83dd827f@...1717...>
	<CAOazyz2ZO7VMzrNBMFO6Eczi858+Y0FnmrGVUmKbw=9-nrN0LA@...278...>
Message-ID: <7635bcaa0673518cf86ba939bcf7f9cb@...1717...>
Subject: Re: [Openvpn-devel] A few questions related to the management
 interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

Le 2012-05-07 16:51, Alon Bar-Lev a =C3=A9crit=C2=A0:
> On Mon, May 7, 2012 at 2:58 PM, Adrien Bustany <adrien@...1716...>=20
> wrote:
>> Hi,
>>
>> I was toying with the management interface of openvpn (on server=20
>> side),
>> to monitor the connections/disconnections of my clients. The clients
>> are authenticated with TLS certificates, without a password. I=20
>> needed to
>> patch two things in order to get things working as I wanted, but=20
>> since
>> I'm new to the code base, I'm not sure at all that those patches=20
>> make
>> sense, especially the second one. I still attach them to this email,
>> in the hope that people here will point where I'm wrong :)
>>
>> Cheers
>>
>> Adrien
>>
>
> Hello,
>
> Yes, they are making sense.
> But please next time submit them using git send-email and separately,
> so we can discuss each.

Sure, I could have done that even though those patches were not meant
to be merged as-is. I'll do that next time.

>
> Regarding 001 - As far as I can see, the code does exactly that... if
> not DAF_CONNECTION_CLOSED, issue disconnect message and turn
> DAF_CONNECTION_CLOSED, otherwise do nothing. So what is the problem?
>

Hmm you're right, it does not matter if the method is called twice
since the second time it'll return early and won't send anything. So
that patch is useless.

> Regarding 002 - I think this is correct, but then we need to modify
> management_learn_addr as well, no? Or the mdac->cid is not=20
> initialized
> all the time and the flag marks that this is client session... Did=20
> not
> test.
>

That sounds right, I haven't tested this "learn" feature either, but
I'll have a more thorough review of the use of DAF_INITIAL_AUTH across
the file, and will do a real patch submission.

> Alon.

Thanks for the comments

Adrien


