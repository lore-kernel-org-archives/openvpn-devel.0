From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Re: Interface with GUI agent
References: <40E18559.8020407@...244...> <200407072255.54148.jim@...41...> <Pine.LNX.4.60.0407080941160.5287@...210...>
In-Reply-To: <Pine.LNX.4.60.0407080941160.5287@...210...>
MIME-Version: 1.0
Message-Id: <200407081043.25501.jim@...41...>
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
Date: Thu Jul  8 08:43:13 2004
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net
Cc: Mathias Sundman <mathias@...209...>, Jan Kiszka <jan.kiszka@...83...>

On Thursday 08 July 2004 02:55, Mathias Sundman wrote:
> On Wed, 7 Jul 2004, James Yonan wrote:
> > On Tuesday 06 July 2004 16:58, Mathias Sundman wrote:
> >> Some more things to consider...
> >>
> >> 1. On Windows, if the the service wrapper has started some openvpn
> >> processes before our gui agent is started, how should find out about
> >> those processes?
> >>
> >> I can think of the following ways:
> >>
> >> 1a. Ask the service wrapper via the socket interface that I'm working on
> >> right now. This will require the service wrapper not only start the
> >> processes, but keep a table over running processes.
> >
> > I think it's an important point worth some discussion on whether to (a)
> > put all the "intelligence" in the GUI applet and have the service wrapper
> > just be a basic proxy to an admin-privileged CreateProcess, or (b) write
> > a portable service wrapper that's designed to run on all the OSes which
> > OpenVPN currently supports, and which would do all the "under-the-hood"
> > work in starting/stopping/managing of different OpenVPN processes, and
> > the GUI applet would do nothing more than export the control interface of
> > the portable service wrapper to a platform-specific, lightweight GUI.
> >
> > (a) is probably simpler to develop, but (b) may be a better solution
> > long-term because it handles the management interface in a portable way,
> > and makes the GUI itself (which probably needs a separate admin module
> > for Win32, YaST, X, http, etc.) as lightweight and stateless as possible.
> >
> > Now the way I would implement (b) is to design as much of the "portable
> > service wrapper" code as is possible without actually coding any function
> > calls to create windows or dispatch window messages or do any GUI stuff
> > directly.  The service wrapper would take care of instantiating OpenVPN
> > processes, managing the 127.0.0.1 port pool to communicate with the
> > processes.
> >
> > Now the GUI applet itself becomes very simple and stateless, it only
> > needs to connect to the service wrapper, and any window message
> > corresponding to a user mouse action gets encoded into a simple command
> > that gets sent to the service wrapper.
> >
> > I agree that this is a more complicated problem to solve because now we
> > have the service wrapper which is talking to the individual OpenVPN
> > processes, and we have the GUI applet talking to the service manager.
> >
> > But long term (IMHO) this gives us great flexibility to easily port the
> > GUI applet to other interfaces, such as even http.  It would be very
> > cool, for example, if with a little bit of php programming, you could
> > control your OpenVPN instances via a web interface for example.  You
> > wouldn't need to rewrite a huge program which deals with all the details
> > of
> > starting/stopping/managing the pool of OpenVPN processes, because that
> > program would already exist as the cross-platform service wrapper daemon.
>
> I agree this seems to be the best way to proceed. On thing is unclear (for
> me atleast) though. The gui should talk with the service manager to do the
> follow things:
>
> * Get a list of running processes.
> * Start a new process.
> * Stop a running process.
>
> But, how should the "check tunnel status" part be implemented?
>
> 1. The gui applet gets information from the service manager about which
> port each ovpn process is listening on. The gui then connects directly to
> each process to monitor it's status.
>
> 2. The service manager connects to each process to monitor its "tunnel
> status" and then maintain this information in its table over running
> processes. The gui applet can then get this information from the
> service manager over the same socket as it starts/stops the ovpn
> processes.

I think that the goal here is to work towards putting all of the complexity 
into the portable service manager, so the GUI applet will only open a single 
local TCP connection to the service manager, and the service manager will 
deal with communicating with the individual OpenVPN processes.

So the GUI applet will send a command to the service manager to enumerate all 
configs.  Each line of output from the service manager will list the name of 
the config file and a comma-separated list of status fields, including stuff 
like connection status, and traffic byte counts.

There will also be a mechanism for the GUI to turn on asynchronous 
notification of various events from all or specific OpenVPN processes.  As 
discussed before, such notifications (when turned on) will cause unsolicited 
output to be sent to the GUI applet with some kind of prefix which identifies 
the source of the notification.

One thing that's nice about using 127.0.0.1 TCP ports for ascii-based 
communication is that you can telnet to the the service manager or the 
individual OpenVPN processes, on their TCP ports, and test various commands 
and responses.

All of this of course represents a lot of development effort, so I think it 
makes a lot of sense to "evolve" towards these goals in small incremental 
steps.

James


The GUI applet can that

