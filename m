References: <20210307161547.25130-1-gert@...1296...>
 <CAKuzo_iG4RfV+u1e5_qtgeet0p8Ne5UvCZNL4afnuPpavdLtGQ@...278...>
 <20210307181002.GQ976@...1296...>
 <CAKuzo_gecRK0fkWToNRuc7oGK==cZQnLFn08_6_C5MERMBKTJQ@...278...>
 <20210307184402.GS976@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <fd76a92c-aad1-53e1-f3fd-fe887be64a24@...1227...>
Date: Mon, 8 Mar 2021 09:06:10 +0100
MIME-Version: 1.0
In-Reply-To: <20210307184402.GS976@...1296...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Require at least 20MB of mlock()-able
 memory if --mlock is used.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Am 07.03.21 um 19:44 schrieb Gert Doering:
> Hi,
> 
> On Sun, Mar 07, 2021 at 01:36:03PM -0500, Selva Nair wrote:
>>> "I'm not sure", TBH.  rlimit handling in unix is a bit of an unknown
>>> territory for me.
>>>
>>> What I understand is that root can *increment* the rlimit at will, but
>>> I'd assume that the rlimit value "in existance right now" (specifically,
>>> the soft limit) applies to root processes as well.  Sort of a voluntary
>>> protection against processes running away.
>>
>> On modern linux kernels (since some 2.6.x..) RLIMIT_MEMLOCK applies only to
>> unprivileged processes -- privileged processes allowed to lock "unlimited"
>> amount of memory as documented in man mlock. We updated the man page based
>> on that sometime ago.
> 
> Indeed, "man mlock" says something about "privileged processes" on Linux
> (it doesn't say that on FreeBSD).
> 
>> We could also consider using setrlimit to increase the limit before
>> dropping privileges.
> 
> That's another possible angle... just up soft+hard to "something"
> (how much would that be? :-) ) and log the fact.
> 
> David, Arne, any opinion on this?  Where do we want to go?

Looking at this feature  from today's perspective, it feels like one of
OpenVPN's boutique features. Was probably useful at some point but
doesn't really make much sense today anymore. Esepcially with what is
written in the manpage. Today you rather would use full disk encryption
or disable swapping rather than to rely on OpenVPN's --mlock.

That being said I am against your patch, I am just wondering if that is
a feature we need to keep at all.

Arne

