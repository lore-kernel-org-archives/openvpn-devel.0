From: Mathias Sundman <mathias@...209...>
Subject: Re: [Openvpn-devel] Patch: Output log message after routes is added
In-Reply-To: <twig.1091957700.34931@...41...>
Message-ID: <Pine.LNX.4.60.0408081532480.15475@...210...>
References: <twig.1091957700.34931@...41...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sun Aug  8 06:45:01 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

On Sun, 8 Aug 2004, James Yonan wrote:

> Mathias Sundman <mathias@...209...> said:
>
>> --- forward-orig.c      Fri Jul 30 22:08:22 2004
>> +++ forward.c   Sun Aug  8 09:48:21 2004
>> @@ -243,6 +243,7 @@
>>         update_time ();
>>         event_timeout_clear (&c->c2.route_wakeup);
>>         event_timeout_clear (&c->c2.route_wakeup_expire);
>> +      msg (M_INFO, "Finished adding routes to system.");
>>       }
>>     else
>>       {
>>
>>
>> James, could you include this in next beta?
>
> Yes, this is fine.  Regarding the details:
>
> * I take it that you are using the M_INFO message level so you can be sure the
> message will be in the log.  Normally I would want to use something like
> D_ROUTE for this.  And even if M_INFO is used, it can still be silenced with
> --verb 0.

Exactly. I wanted it to be displayed at the lowest possible verb level. I 
think requirying atleast verb 1 for the GUI to work should be okay for all 
users.


> * As is, the patch will cause the message to go to the log, even if there are
> no routes to add.  In such a case, the message will be output showing the
> point in time at which routes would have been added, had they been present in
> the config.  So maybe the message should read differently, such as "TUN/TAP
> interface up".

Sure, "TUN/TAP interface up" is fine with me. Lets use that instead.


> * The message will only be output if c->options.route_delay_defined is true.
> On Windows, this is always the case, so that's probably what you want.

Well, it's good enough for me, but it would have been better it worked on 
all platforms in all cases. Is there a better place to put it that will 
always work (but still after possible routes are added)?

-- 
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
NILINGS AB                        X    NO HTML/RTF in e-mail
Tel: +46-(0)8-666 32 28          / \   NO Word docs in e-mail

