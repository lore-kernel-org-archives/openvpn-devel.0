MIME-Version: 1.0
In-Reply-To: <20100219143841.GS9556@...1296...>
References: <4B7E71A5.3020806@...1114...>
	<20100219134650.GR9556@...1296...> 
	<7bb795fd1002190621oefc5e4dx9ccb19d55f0e7534@...278...> 
	<20100219143841.GS9556@...1296...>
From: JuanJo Ciarlante <jjo+ml@...410...>
Date: Sun, 21 Feb 2010 12:31:58 +0100
Message-ID: <7bb795fd1002210331g77687f7em91181bb599fd013f@...278...>
Subject: Re: [Openvpn-devel] [IPv6] Merge conflicts in mroute.c (was: Re:
	openvpn-testing tree available)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: Openvpn-devel@lists.sourceforge.net

On Fri, Feb 19, 2010 at 3:38 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Fri, Feb 19, 2010 at 03:21:34PM +0100, JuanJo Ciarlante wrote:
>> > JJO's patch does more than that, he does DNS lookups to print the
>> > DNS name for the IPv6 address in question.
>>
>> Wrong.
>> From getaddrinfo(3):
>> =A0 =A0"""
>> =A0 =A0 =A0 If hints.ai_flags contains the AI_NUMERICHOST flag then the =
node
>> =A0 =A0 =A0 parameter must be a numerical network address.
>> =A0 =A0 =A0 The AI_NUMERICHOST flag suppresses any potentially =A0lengthy
>> =A0 =A0 =A0 network host address lookups.
>> =A0 =A0"""
>
> Ah! =A0Learned something new today. =A0So what's the specific advantage of
> using getnameinfo() instead of inet_ntop() instead?
>
> (I've only ever used getnameinfo() if I really wanted to do DNS lookups).
>
>> >=A0Now we enter religious
>> > territory - *I* think that this is not a good thing.
>>
>> I can't more eagerly _agree_ on tossing out any reverse
>> DNS lookups at this level.
>
> OK, good. =A0Glad that this was just a misreading of the code.
>
>
>> > The existing
>> > code doesn't do reverse DNS lookups for IPv4 mroute printing, and so
>> > the IPv6 code should behave similar to the IPv4 code, and not do DNS
>> > either (also, depending on DNS lookup in this place might lead to
>> > weird delays in unexpected situations). =A0But this is partly religiou=
s,
>> > partly "follow the coding style of the existing code" stuff.
>>
>> IMO we should void using inet_ntop() and friends, personally
>> I don't like locking around their lack of multi-threading.
>
> Mmmh, ok. =A0I wasn't aware that inet_ntop() is not thread-safe. =A0(Look=
ing
> at the FreeBSD implementation, at least that one *is* thread-safe - no
> static buffers, etc.).

And now I learned something new, by *actually* closely looking
inet_ntop() manpage, heh (had a totally wrong braino on it using
static buffers).
Please just ignore this non MT-safe state from me.

>
> If it is not thread-safe, it won't break anything in my code, though
> (lucky me :-) ) - my use of it in print_in6_addr() is mutex-locked anyway,
> due to the use of a static buffer there.
>
> Is getnameinfo() *guaranteed* to be thread-safe?
>
> Do you have a reference that documents that inet_ntop() and inet_pton()
> are unsave to be used in a threaded context?
>
> gert
> --
> USENET is *not* the non-clickable part of WWW!
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 //www.muc.de/~gert/
> Gert Doering - Munich, Germany =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 gert@...1296...
> fax: +49-89-35655025 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gert@=
...1297...
>



--=20
--JuanJo ; echo jAjo@...1263... | sed 's/[SPAM]//g'

