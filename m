From: Mathias Sundman <mathias@...209...>
Subject: Re: [Openvpn-devel] Win32: Event signals
In-Reply-To: <Pine.LNX.4.61.0410312352280.16474@...210...>
Message-ID: <Pine.LNX.4.61.0411010019400.16474@...210...>
References: <Pine.LNX.4.61.0410312241110.16282@...210...>
 <Pine.LNX.4.61.0410312352280.16474@...210...>
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
Date: Sun Oct 31 15:39:15 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

On Mon, 1 Nov 2004, Mathias Sundman wrote:

>> I'm working on a patch to add events for the other unix signals. I want 
>> this because I want the GUI to have the same possibility to send openvpn 
>> signals like you have in unix or when running from the console.
>> 
>> While working on this I think I either found a bug or I've missunderstood 
>> something.
>> 
>> What is the purpose of beeing able to set the exit_event initial state with 
>> the --service option?
>> 
>> Currently I've always done as the service_wrapper. I've created a 
>> non-signaled event and then started openvpn with --service 
>> exit_event_nameXX 1.
>> 
>> I think this is wrong, as I (and the service wrapper) had created the event 
>> in non-signaled state, so shouldn't I tell openvpn that the initial state 
>> is non-signaled?

After even more thinking about this, I realize that I probably did 
misunderstood the --service option after all.

If the intention of starting openvpn with --service xxx 1, is that openvpn 
should exit immediataly if no non-signaled event already exists, then 
there's no bug in the current code.

But, why would one want that?

and, back to my origial problem, how should I add these new signals? I 
don't want to break compatibility with existing versions of OpenVPN GUI or 
the service wrapper, which both calls openvpn with --service xxx 1.

If I create them accordingly to --service option, it will cause openvpn to 
exit immediatly as these events don't exist when using an old version of 
OpenVPN GUI or the service_wrapper.

Should I just create them in non-signaled state regardless of the 
--service option?

or, do I need to add a new option for each signal?

/Mathias

