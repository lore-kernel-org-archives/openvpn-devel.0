From: Mathias Sundman <mathias@...209...>
Message-ID: <Pine.LNX.4.61.0410312241110.16282@...210...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Win32: Event signals
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
Date: Sun Oct 31 14:22:44 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hi James and everyone else,

I'm working on a patch to add events for the other unix signals. I want 
this because I want the GUI to have the same possibility to send openvpn 
signals like you have in unix or when running from the console.

While working on this I think I either found a bug or I've missunderstood 
something.

What is the purpose of beeing able to set the exit_event initial state 
with the --service option?

Currently I've always done as the service_wrapper. I've created a 
non-signaled event and then started openvpn with --service 
exit_event_nameXX 1.

I think this is wrong, as I (and the service wrapper) had created the 
event in non-signaled state, so shouldn't I tell openvpn that the initial 
state is non-signaled?

But, as the event is already created as non-signaled state when OpenVPN 
tries to create the exit_event, it will remain in the non-signaled state, 
even though openvpn tries to create it signaled, so things works as 
expected.

What doesn't work as expected is if I create the event in signaled state, 
then OpenVPN wont start regardless if I pass 1 or 0 as initial_state via 
--service, because

       if (WaitForSingleObject (event, 0) != WAIT_TIMEOUT)
         msg (M_FATAL, "ERROR: EventMSN ('%s') is signaled", event_name);

always fails if the event is in signaled state.

So, if it is impossible to start with a signaled event, why would you want 
to tell openvpn to create the event in signaled state?


I found this while rebugging my real problem, which is how to add the new 
signals. I wanted to avoid adding new options to openvpn if not necessary, 
so I though that I would create events simply named as the specified 
exit_event_name and just append _SIGUSR1, _SIGUSR2 and _SIGHUP.

The problem arised when I tried to create these events in the same initial 
state as specified via --service, which is 1 from both the service_wrapper 
and my GUI.

As I havn't added support for these events in the GUI, and we have to 
remain compatibility with the service wrapper, openvpn would fail to start 
as no such events exist, and openvpn then creates the new events in signal 
state, which means that the above code will fail, as the event is 
signaled.


So how do we fix this?

For the new signals I could just ignore the initial_state parameter of 
--service and always create them in non-signaled state.

or, we could fix the code by making it check that the event really is in 
the state given by --service instead of always checking if it's 
non-signaled. The drawback of this is that it will break compatiblity with 
the current version of the service_wrapper and OpenVPN GUI, but maybe it's 
the only right way to go...

Hope I havn't missunderstood everything and just waisted your time...

--
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
OpenVPN GUI for Windows           X    NO HTML/RTF in e-mail
http://www.nilings.se/openvpn    / \   NO Word docs in e-mail


