MIME-Version: 1.0
In-Reply-To: <CAKuzo_jskO41boC19osX6tQaVYHio4XFPUyROEWeQuFmuLCf7Q@...278...>
References: <1465388443-15484-1-git-send-email-steffan@...1856...>
	<1465388443-15484-5-git-send-email-steffan@...1856...>
	<CAKuzo_jskO41boC19osX6tQaVYHio4XFPUyROEWeQuFmuLCf7Q@...278...>
From: Steffan Karger <steffan@...1856...>
Date: Wed, 8 Jun 2016 18:11:57 +0200
Message-ID: <CAA1AbxKN5AJAmXjjZxLEkiEsFbCAQTXnjPGB6s7MLrMc1t8KNQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH 4/5] Add options to restrict cipher
	negotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Wed, Jun 8, 2016 at 5:53 PM, Selva Nair <selva.nair@...277...> wrote:
> On Wed, Jun 8, 2016 at 8:20 AM, Steffan Karger <steffan@...1856...> wrote:
>>
>> --- a/src/openvpn/push.c
>> +++ b/src/openvpn/push.c
>> @@ -239,11 +239,21 @@ incoming_push_message (struct context *c, const
>> struct buffer *buffer)
>>      {
>>        c->options.push_option_types_found |= option_types_found;
>>
>> +      /* delay bringing tun/tap up until --push parms received from
>> remote */
>>        if (status == PUSH_MSG_REPLY)
>> -       do_up (c, true, c->options.push_option_types_found ); /* delay
>> bringing tun/tap up until --push parms received from remote */
>> +       {
>> +         if (!do_up (c, true, c->options.push_option_types_found))
>> +           {
>> +             msg (D_PUSH_ERRORS, "Failed to open tun/tap interface");
>> +             c->sig->signal_received = SIGUSR1; /* connection reset */
>> +             c->sig->signal_text = "open-tuntap-failed";
>
>
> Please try to avoid that potential overwrite of a pending signal --- as this
> runs on the client, c->sig here is a pointer to the global siginfo_static.
>
> Use register_signal (c, SIGUSR1, "open-tuntap-failed") instead  -- it will
> at least protect SIGTERM. I'm looking into how to prioritize signals, and it
> would help to have all signals set through a few functions such as
> register_signal, throw_signal_soft etc ..

Sure, please tell me what to use.  I never had to deal with our
signals before, so I simply copied this from a few lines below, where
(as far as I could see) the did what I wanted it to do.

I had already replaced this with

   throw_signal_soft( SIGUSR1, "process-push-msg-failed" );

based on feedback from Gert (v2, yet to come).  In my tests that also
works as I want it to (abort the connection attempt, try again).  Can
you explain when I need to use register_signal(), throw_signal() or
throw_signal_soft()?

> By the way "open-tun-tap failed" may be a confusing as a real open tun/tap
> error would have resulted in a  FATAL exit -- the error handled here could
> happen even if tun/tap has been successfully opened, isn't it?

Yes, noticed that too, and is actually fixed by 5/5.  I didn't notice
4/5 still got the confusing text.

-Steffan

