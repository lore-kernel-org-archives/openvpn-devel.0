From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Win32: Event signals
In-Reply-To: <Pine.LNX.4.61.0410312241110.16282@...210...>
Message-ID: <Pine.LNX.4.58.0411031212330.17216@...41...>
References: <Pine.LNX.4.61.0410312241110.16282@...210...>
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
Date: Wed Nov  3 11:24:48 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Mathias Sundman <mathias@...209...>
Cc: openvpn-devel@lists.sourceforge.net

On Sun, 31 Oct 2004, Mathias Sundman wrote:

> Hi James and everyone else,
> 
> I'm working on a patch to add events for the other unix signals. I want 
> this because I want the GUI to have the same possibility to send openvpn 
> signals like you have in unix or when running from the console.
> 
> While working on this I think I either found a bug or I've missunderstood 
> something.
> 
> What is the purpose of beeing able to set the exit_event initial state 
> with the --service option?

You almost always want to set initial state to 0.

The only reason to set it to 1 is to force OpenVPN to exit with an error 
if the event object does not already exist.

This works because the initial state is only used by the process which 
creates the event for the first time.

So it is a good way to make the startup of an openvpn process be
conditional on the exit event having been pre-created by a controlling
service.

James


