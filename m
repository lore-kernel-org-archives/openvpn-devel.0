From: James Yonan <jim@...41...>
Subject: Re: Interface with GUI agent, was: Re: [Openvpn-devel] [Patch] revoke scripts were broken
References: <40E18559.8020407@...244...> <200406301725.43961.jim@...41...> <1088881994.40e7054a0e5e6@...238...>
In-Reply-To: <1088881994.40e7054a0e5e6@...238...>
MIME-Version: 1.0
Message-Id: <200407031601.24438.jim@...41...>
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
Date: Sat Jul  3 13:02:01 2004
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: Brandon Knitter <knitterb@...237...>
Cc: openvpn-devel@lists.sourceforge.net, Mathias Sundman <mathias@...209...>, Jan Kiszka <jan.kiszka@...83...>

On Saturday 03 July 2004 15:13, Brandon Knitter wrote:
> Hey there.  James and I had a prior discussion about the systray app
> offline, but I thought I'd just poke my head in here.  I'm not a strong
> Windows application programmer, but I've been doing a lot of C# these days.
>
> With that in mind, I was gonna whip together a quickie little systray app
> in C# which could control the openvpn server.  I know that C# adds the
> rather large .NET framework runtime installation, so my app could be
> considered a prototype if you would like!
>
> Where do I start?  Are the namedpipe hooks into the OpenVPN service built? 
> I'm not too familiar with named pipes on Windows (done a bit on *nix), but
> I'm sure it can't be too hard.  I guess what I'd need to know are the
> command to send to the named pipe, and also what I can get from the named
> pipe in regards to status and such.

There are no hooks as of yet to control a running OpenVPN instance (other than 
sending signals).

While I initially thought that named pipes might be the appropriate channel 
for this, I'm wondering if if might make more sense (for portability) to use 
a local TCP/IP socket as the control channel, such as 127.0.0.0:[some port].

Then for testing purposes, you could just telnet to the socket.

I am thinking the interface should consist of a standard ascii command 
response loop, such as is used by SMTP.

Possible client -> server commands:

(1) send auth credentials
(2) get status (as in SIGUSR2)
(3) send signal (SIGHUP, SIGUSR1, or SIGUSR2, SIGTERM)

And server -> client commands:

(1) need auth credentials -- GUI should query the user then return them to the 
daemon via a "send auth credentials" command

The basic mechanism of operation to enable the management interface would be 
to pass an option like this in the config file:

  management 127.0.0.1 20001

This will cause OpenVPN to listen on 127.0.0.1:20001 as its management 
interface port.

It's important, of course, that the management port always be local, since we 
are using it to potentially pass passwords and other sensitive data that 
should never actually touch a real network interface.

Thinking ahead, the challenge/response sequence for passing authentication 
info should be open-ended to provide for future implementation of alternative 
authentication methods such as Radius, LDAP, NT Auth, etc.

This is all just a proposal, no code has been written yet, comments are 
welcome.

James

