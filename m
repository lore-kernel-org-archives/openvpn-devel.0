From: James Yonan <jim@...41...>
Subject: Re: Interface with GUI agent, was: Re: [Openvpn-devel] [Patch] revoke scripts were broken
References: <40E18559.8020407@...244...> <200407031601.24438.jim@...41...> <Pine.LNX.4.60.0407032205510.17721@...210...>
In-Reply-To: <Pine.LNX.4.60.0407032205510.17721@...210...>
MIME-Version: 1.0
Message-Id: <200407031729.30190.jim@...41...>
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
Date: Sat Jul  3 14:30:00 2004
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Mathias Sundman <mathias@...209...>
Cc: Brandon Knitter <knitterb@...237...>, openvpn-devel@lists.sourceforge.net, Jan Kiszka <jan.kiszka@...83...>

On Saturday 03 July 2004 16:40, Mathias Sundman wrote:
> On Sat, 3 Jul 2004, James Yonan wrote:
> > On Saturday 03 July 2004 15:13, Brandon Knitter wrote:
> >> Where do I start?  Are the namedpipe hooks into the OpenVPN service
> >> built? I'm not too familiar with named pipes on Windows (done a bit on
> >> *nix), but I'm sure it can't be too hard.  I guess what I'd need to know
> >> are the command to send to the named pipe, and also what I can get from
> >> the named pipe in regards to status and such.
> >
> > There are no hooks as of yet to control a running OpenVPN instance (other
> > than sending signals).
> >
> > While I initially thought that named pipes might be the appropriate
> > channel for this, I'm wondering if if might make more sense (for
> > portability) to use a local TCP/IP socket as the control channel, such as
> > 127.0.0.0:[some port].
> >
> > Then for testing purposes, you could just telnet to the socket.
> >
> > I am thinking the interface should consist of a standard ascii command
> > response loop, such as is used by SMTP.
> >
> > Possible client -> server commands:
> >
> > (1) send auth credentials
> > (2) get status (as in SIGUSR2)
> > (3) send signal (SIGHUP, SIGUSR1, or SIGUSR2, SIGTERM)
> >
> > And server -> client commands:
> >
> > (1) need auth credentials -- GUI should query the user then return them
> > to the daemon via a "send auth credentials" command
> >
> > The basic mechanism of operation to enable the management interface would
> > be to pass an option like this in the config file:
> >
> >  management 127.0.0.1 20001
> >
> > This will cause OpenVPN to listen on 127.0.0.1:20001 as its management
> > interface port.
> >
> > It's important, of course, that the management port always be local,
> > since we are using it to potentially pass passwords and other sensitive
> > data that should never actually touch a real network interface.
> >
> > Thinking ahead, the challenge/response sequence for passing
> > authentication info should be open-ended to provide for future
> > implementation of alternative authentication methods such as Radius,
> > LDAP, NT Auth, etc.
> >
> > This is all just a proposal, no code has been written yet, comments are
> > welcome.
>
> This sounds good to me, and will allow us to start with a basic set of
> "commands", and add more as we find the need for a specific function.
>
> One little wonder though, is it good to have a bi-directional protocol
> over a single socket. Ofcource replys to command can go over the same
> channel, but if both the server and the client is allowed to "start the
> conversation", how do we handle the case when both the server and client
> sends a command at the same time.

TCP connections are always full duplex so both sides can send and receive at 
the same time without collision issues.

Having said that, the application needs to support bidirectionality, by always 
having a listen queued on the port for possible incoming data.

On Windows, the best way to do this is to use the WSAAsyncSelect or 
WSAEventSelect functions.  WSAAsyncSelect is particularly useful for Windows 
GUI-based programs because it gives you notification of incoming data on a 
TCP socket through the standard Windows message notification mechanism.

> How will we know if what we recieve is an answer to our command, or a
> command from the server?

The unsolicited notification from the server would have a specific prefix that 
indicates that it is an asynchronous notification from the server, as opposed 
to a response to a client->server command.

For example, the server would say something like this:

NOTIFY:NEED_AUTH,USER,PASS

The "ASYNC" indicates that the message is an asynchronous notification.

NEED_AUTH is the command, and USER/PASS indicates that the GUI should prompt 
the user for and return both username and password.

Then the GUI would reply back:

AUTH_USER [username]
AUTH_PASS [password]

> In addition to the information given by SIGUSR2 I'd would like to be able
> to get current state of the the link. We should be able to define several
> STATEs during the establishing of the connection. Like:
>
> STATE_WAIT_FIRST_RESPONE - When we have tried to connect to the remote
> peer but still not recieved any answer.
>
> STATE_WAIT_AUTH - We have recieved some answer from the remove peer, but
> not yet fully authenticated. (This state will never happend when using
> static keys.)
>
> STATE_WAIT_PUSH - We wait for options to be pushed from the server.
>
> STATE_WAIT_SETIP - We are waiting for the system to set the ip address.
>
> STATE_WAIT_APPLY_SETTINGS - We are waiting for the system to set other
> pushed parameters like routes.
>
> STATE_CONNECTED - We are fully connected!

We already have something like this in ssl.h (see "key negotiation states"), 
but your idea expands beyond this.

> I have not though through the absolute meaing of those states or if the
> names are any good, but it gives you an idea of what kind of information
> I'd like to get.
>
> The reason for several states during the init is ofcource that it will
> allow me to set timeout values for every step and report to the user at
> what step the connection failed.
>
> I suppose it will be best if the gui client query the server for the
> current state.
>
> /Mathias

I think the states are a good idea.  The state info, like the request for auth 
credentials, will be an asynchronous server -> client notification.

For example:

NOTIFY:STATE,STATE_CONNECTED

James

