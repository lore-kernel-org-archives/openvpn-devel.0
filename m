From: Mathias Sundman <mathias@...209...>
Subject: Re: [Openvpn-devel] Win32: Event signals
In-Reply-To: <Pine.LNX.4.58.0411041746140.3946@...41...>
Message-ID: <Pine.LNX.4.61.0411050154150.30162@...210...>
References: <Pine.WNT.4.60.0411032312390.48052@...254...>
 <Pine.LNX.4.58.0411041746140.3946@...41...>
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
Date: Thu Nov  4 17:10:54 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, 4 Nov 2004, James Yonan wrote:

> On Wed, 3 Nov 2004, Mathias Sundman wrote:
>
>> Okay, I've finished my event signals patch, which adds events for SIGUSR1,
>> SIGUSR2 and SIGHUP.
>>
>> If --service is used, it still creates the exit_event just like before,
>> but it also creates the new events with the same name as the exit_event
>> but appends the signal name like, exit_event_SIGHUP.
>>
>> It always creates the new signals in non signaled state.
>>
>> Some things to consider that I havn't thought through fully.
>>
>> 1. To have the new events checked I added them in wait_signal() in
>> event.h. Was this the correct place? Or do the diffent events need to be
>> added to the "check event list" at a diffrent time?
>>
>> 2. I modified the win32_service_interrupt() function to return the signal
>> value instead of just true/false. This means that this function will now
>> return "true" for all signals, not only sigterm. Will that cause any
>> problems?
>>
>> 3. Do we need to block the new events from beeing checked at some time?
>>
>> 4. Do you have plans to give SIGINT a diffrent functionallity than SIGTERM
>> in the future? If so, do you think we should add a event for SIGINT also
>> now?
>
> No, I think SIGINT and SIGTERM should be handled identically.
>
>> Apart from that I think it works well. I can now send all the signals from
>> my GUI and it does not break compatibility with existing software.
>
> My only hesitancy with this patch is that it will become obsolete after we
> develop the management channel interface, i.e. have the openvpn daemon
> listen on a TCP socket for control commands.  I'm thinking of the
> management interface as having a bunch of commands to allow real-time
> control over a running daemon, such as:
>
> signal [signal_name] -- send SIGHUP, SIGTERM, SIGUSR1, SIGUSR2, etc.
> kill [common_name|source_IP_port] -- kill a client instance
> status [format_version] -- produce a status listing
> password [password] -- simple authentication to access management interface

I thought of that, but I though that this management interface would not 
make it into the 2.0 stable release, so this was an easy way of adding 
signals support now which I think can be useful to have in the stable 2.0 
release.

/Mathias

