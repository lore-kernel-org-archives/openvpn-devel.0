From: Mathias Sundman <mathias@...209...>
Subject: Re: Interface with GUI agent, was: Re: [Openvpn-devel] [Patch] revoke
 scripts were broken
In-Reply-To: <200407031601.24438.jim@...41...>
Message-ID: <Pine.LNX.4.60.0407032205510.17721@...210...>
References: <40E18559.8020407@...244...> <200406301725.43961.jim@...41...>
 <1088881994.40e7054a0e5e6@...238...> <200407031601.24438.jim@...41...>
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
Date: Sat Jul  3 13:43:02 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: James Yonan <jim@...41...>
Cc: Brandon Knitter <knitterb@...237...>, openvpn-devel@lists.sourceforge.net, Jan Kiszka <jan.kiszka@...83...>

On Sat, 3 Jul 2004, James Yonan wrote:

> On Saturday 03 July 2004 15:13, Brandon Knitter wrote:
>> Where do I start?  Are the namedpipe hooks into the OpenVPN service built?
>> I'm not too familiar with named pipes on Windows (done a bit on *nix), but
>> I'm sure it can't be too hard.  I guess what I'd need to know are the
>> command to send to the named pipe, and also what I can get from the named
>> pipe in regards to status and such.
>
> There are no hooks as of yet to control a running OpenVPN instance (other than
> sending signals).
>
> While I initially thought that named pipes might be the appropriate channel
> for this, I'm wondering if if might make more sense (for portability) to use
> a local TCP/IP socket as the control channel, such as 127.0.0.0:[some port].
>
> Then for testing purposes, you could just telnet to the socket.
>
> I am thinking the interface should consist of a standard ascii command
> response loop, such as is used by SMTP.
>
> Possible client -> server commands:
>
> (1) send auth credentials
> (2) get status (as in SIGUSR2)
> (3) send signal (SIGHUP, SIGUSR1, or SIGUSR2, SIGTERM)
>
> And server -> client commands:
>
> (1) need auth credentials -- GUI should query the user then return them to the
> daemon via a "send auth credentials" command
>
> The basic mechanism of operation to enable the management interface would be
> to pass an option like this in the config file:
>
>  management 127.0.0.1 20001
>
> This will cause OpenVPN to listen on 127.0.0.1:20001 as its management
> interface port.
>
> It's important, of course, that the management port always be local, since we
> are using it to potentially pass passwords and other sensitive data that
> should never actually touch a real network interface.
>
> Thinking ahead, the challenge/response sequence for passing authentication
> info should be open-ended to provide for future implementation of alternative
> authentication methods such as Radius, LDAP, NT Auth, etc.
>
> This is all just a proposal, no code has been written yet, comments are
> welcome.

This sounds good to me, and will allow us to start with a basic set of 
"commands", and add more as we find the need for a specific function.

One little wonder though, is it good to have a bi-directional protocol 
over a single socket. Ofcource replys to command can go over the same 
channel, but if both the server and the client is allowed to "start the 
conversation", how do we handle the case when both the server and client
sends a command at the same time.

How will we know if what we recieve is an answer to our command, or a 
command from the server?


In addition to the information given by SIGUSR2 I'd would like to be able 
to get current state of the the link. We should be able to define several 
STATEs during the establishing of the connection. Like:

STATE_WAIT_FIRST_RESPONE - When we have tried to connect to the remote 
peer but still not recieved any answer.

STATE_WAIT_AUTH - We have recieved some answer from the remove peer, but 
not yet fully authenticated. (This state will never happend when using 
static keys.)

STATE_WAIT_PUSH - We wait for options to be pushed from the server.

STATE_WAIT_SETIP - We are waiting for the system to set the ip address.

STATE_WAIT_APPLY_SETTINGS - We are waiting for the system to set other 
pushed parameters like routes.

STATE_CONNECTED - We are fully connected!


I have not though through the absolute meaing of those states or if the 
names are any good, but it gives you an idea of what kind of information 
I'd like to get.

The reason for several states during the init is ofcource that it will 
allow me to set timeout values for every step and report to the user at 
what step the connection failed.

I suppose it will be best if the gui client query the server for the 
current state.

/Mathias

-- 
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
NILINGS AB                        X    NO HTML/RTF in e-mail
Tel: +46-(0)8-666 32 28          / \   NO Word docs in e-mail

