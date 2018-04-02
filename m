References: <1460475732-10951-1-git-send-email-fish.thss@...277...>
 <CAEsd45SVTP0gp0k=Pc=qDYhabZaVK6z8L4LYLrG_PH=cwAqFJQ@...278...>
 <CAKuzo_hjp491oFU5Z3vR=hUThZGetBF6uQio1g9BkTNpCdKmdg@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <77f10973-5aff-fe3a-fd2b-7e5480790c6a@...1856...>
Date: Mon, 2 Apr 2018 14:55:00 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_hjp491oFU5Z3vR=hUThZGetBF6uQio1g9BkTNpCdKmdg@...278...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Properly respond to SIGTERM received
 during DNS resolution.
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
To: openvpn-devel@lists.sourceforge.net

Hi,

On 06-02-18 06:53, Selva Nair wrote:
> On Mon, Feb 5, 2018 at 7:52 PM, Jonathan K. Bullard <jkbullard@...277...> wrote:
>> Hi, I'd like to reopen this patch -- it seems to have gotten lost.
>>
>> The patch is so old the line numbers are wrong but the code doesn't
>> seem to have changed.
>>
>> I'm top-posting because this thread doesn't show up in the SourceForge
>> archive[1] (???) so I've extracted the relevant parts below. There was
>> some top-posting but nothing was really out-of-order, so I've tried to
>> make the thread intelligible and include everything relevant below.
>>
>> On Tue, Apr 12, 2016 at 11:42 AM, Fish <fish.thss@...277...> wrote:
>>> In `link_socket_init_phase2`, it used to be the case that any received
>>> signal will be overwritten by SIGUSR1 if the socket cannot be created
>>> (e.g. when DNS resolution fails), which consequently prevents OpenVPN from
>>> responding to SIGTERM and exiting. This patch adds an additional check of
>>> whether the received signal during DNS resolution is SIGTERM or not, and
>>> prematurely exits from `link_socket_init_phase2` when receiving a SIGTERM.
>>> ---
>>>  src/openvpn/socket.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
>>> index 9bcf4d4..5e8abe1 100644
>>> --- a/src/openvpn/socket.c
>>> +++ b/src/openvpn/socket.c
>>> @@ -1905,6 +1905,11 @@ link_socket_init_phase2 (struct link_socket *sock,
>>>             }
>>>         }
>>>
>>> +      if (sig_info->signal_received == SIGTERM)
>>> +       {
>>> +         goto done;
>>> +       }
>>> +
>>>        /* Socket still undefined, give a warning and abort connection */
>>>        if (sock->sd == SOCKET_UNDEFINED)
>>>         {
>>
>> On Tue, Apr 12, 2016 at 11:46 AM, Gert Doering <gert@...1296...> wrote:
>>> That is the "on DNS failure, the client loops forever and is not killable"
>>> problem, right?
>>>
>>> (I'm not sure I'm reading the description right, to understand the
>>> actual issue this is fixing - but if I'm reading it right, then this
>>> makes sense :-)  - what about SIGINT?)
>>
>>
>> On Tue, Apr 12, 2016 at 11:48 AM, Fish Wang <fish.thss@...277...> wrote:
>>>
>>> Right, it's for the "on DNS failure, the client loops forever and is not killable" problem.
>>
>>
>> On Tue, Apr 12, 2016 at 12:25 PM, Jonathan K. Bullard
>> <jkbullard@...277...> wrote:
>>> Feature ACK; this should make DNS hangs much easier to deal with for
>>> GUIs such as Tunnelblick.
>>>
>>> The "hang forever" problem can be avoided by using --resolve-retry.
>>>
>>
>> On Tue, Apr 12, 2016 at 1:18 PM, Arne Schwabe <arne@...1227...> wrote:
>>> Am 12.04.16 um 17:42 schrieb Fish:
>>>> In `link_socket_init_phase2`, it used to be the case that any received
>>>> signal will be overwritten by SIGUSR1 if the socket cannot be created
>>>> (e.g. when DNS resolution fails)
>>>
>>> That should not happen in the first place, doesn't register_signal keep
>>> care of not overwriting higher priority signals?
>>
>> On Tue, Apr 12, 2016 at 10:07 PM, Fish Wang <fish.thss@...277...> wrote:
>>>
>>> No, the patch won't fix that issue. I may send out another patch later to fix that problem if I have free time this week.
>>
>> On Tue, Apr 12, 2016 at 10:11 PM, Fish Wang <fish.thss@...277...> wrote:
>>> Check out the code in socket.c [1]. This is where the received signal is overwritten by SIGUSR1.
>>>
>>>       /* Socket still undefined, give a warning and abort connection */
>>>       if (sock->sd == SOCKET_UNDEFINED)
>>>         {
>>>           msg (M_WARN, "Could not determine IPv4/IPv6 protocol");
>>>           sig_info->signal_received = SIGUSR1;
>>>           goto done;
>>>         }
>>> [1] https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/socket.c#L1909
>>
>> Note that theses lines are immediately below the patch. The last three
>> lines of the patch (which are not changed in the patch) are the same
>> as the first three lines shown above.
> 
> This jogs my memory.
> 
> We do have signal overwrite issues in more than a couple of places in
> the code and signal handling after getaddrinfo failure does need
> fixing. I think this is a good opportunity to discuss whether we
> continue tip-toeing around this or take a closer look at signal handling
> and make some bolder changes.
> 
> When this patch was being discussed 2 years ago I had looked into our
> signal handling code. A number of issues and some solutions were
> identified but never finished for one reason or other. My stab at
> improving signal handling is in this feature branch:
> https://github.com/selvanair/openvpn/tree/signals-v5
> 
> I'd like to resurrect it but it would be useful to know whether there
> is any interest in a revamping the signals code.
> 
> For those who may not want look through code based on a 2 years
> old branch, with a longish commit _not_ yet split into bite sized pieces,
> here is a gist:
> 
> 1. In many places in the code, signal_received is directly assigned to:
> always use register_signal() and/or provide similar abstractions for
> setting signals
> 
> 2. Low priority signals can currently write over high priority ones
> like SIGTERM: prioritize signals and to avoid losing signals. Doing
> this in a fool-proof way is hard, especially when we have many signal
> sources (hard, soft, management).  But moving to POSIX signals would
> help (see #3)
> 
> 3. signal() follows BSD semantics on some systems, system V semantics
> on others (including solaris, AIX). On Linux its more complex: signal() syscall
> in the kernel apparently follows system V behaviour but probably is
> not widely used: instead, glibc  (> version 2) provides its own
> implementation with BSD or system V personality based on feature set
> macros.
> Its much better move to POSIX sigaction() for consistency, for
> properly blocking signals in the handler, to mask signals etc. sigaction() is
> supported by all unix-like OSes we support.
> 
> 4. Windows "signals" (SetEvent, ctrl-C, ctrl-break) are not picked up
> during pre-init phase or while in openvpn_sleep() unless management
> interface is active. Note that on unix sleep() is interrupted by signals
> but on windows ctrl-C doesnt interrupt sleep(). Reports like "impossible to
> break out of dns resolution loop on Windows when run from command
> line" is related to this. Not hard to fix.
> 
> That said, getaddrinfo() will continue to block and cannot be
> interrupted by signals -- it never returns EINTR but continues trying
> until an internal timeout expires. This is known issue and I know of
> no fixes. But we can make sure that signal received during
> getaddrinfo() is properly acted upon when it returns. Currently we
> can't guarantee even that. This is important as that call can block for a
> long time (15 seconds?)  and is a very likely place to receive user interrupt.
> 
> Finally, I never completed this mainly because the changes are not
> "perfect": its only an attempt to tidy-up the existing signal
> infrastructure. The use of signals is deeply entrenched in openvpn
> code-base and is used for multiple purposes, has multiple origins
> (hard, soft, management). And the code is hard to follow. Only
> consolation is that there are no multiple threads to worry about.
> 
> I definitely do not know how to replace it with something clean. So
> comments and suggestions would help.

This approach sounds like a good step forward.  So yes, please share :)
(Even if responses might be slow...)

-Steffan

