From: Sampo Nurmentaus <audiopoppi-13@...22...>
Reply-To: <sampo.nurmentaus@...22...>
Subject: Re: [Openvpn-devel] Multiple VPN connections on the same port
In-Reply-To: <057d01c23286$4c391110$1000000a@...4...>
Message-ID: <Pine.LNX.4.33.0207241343250.5299-100000@...23...>
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Wed Jul 24 06:00:03 2002
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: James Yonan <jim@...3...>
Cc: sampo.nurmentaus@...22..., openvpn-devel@lists.sourceforge.net

> > > Hi Sampo,
> > >
> > > > I have been busy writing a forking server
> > > > addon to openvpn.
>
> Will forking server only work for TLS mode?

No, It works also with shared secret or without
security.

For prefork security I could use either the key used
for tls-auth or preshared secret.

Any examples of how to implement tls-auth like
authentication in simples form?

> > --remote as server addres in the client.
> >
> > I just got it running. Still with out dynamic ip address assigment
> > and proper signal handling in parent process. And there ain't
> > anykind of DoS protection yet.
>
> One way to do DoS protection would be to augment --tls-auth with persistent
> anti-replay protection by saving the Session ID (struct session_id) and
> reject any Session ID that was seen before.

Let's see when I get it working. :-)

> > port before calling openvpn(). Mayby I could add the exchange of
> > address info here, since I don't think it needs to be
> > transferred over a secure channel.
>
> Actually the temporary keys + options_string() get passed over the secure
> TLS channel, so you could add further handshaking options and they would be
> secure.



> >
> > > > This way I have been able to keep
> > > > those well tested procedures and protocol
> > > > of openvpn untouched.
> > > >
> > > > I still have some questions unsolved like
> > > > DoS protection, dropping root priviledges
> > > > and how to handel SIGUSR1 and SIGHUP.
>
> It would be cool if we could get the forking server to work with dropping
> root privs.
>
> One of the goals of dropping privs is that no datagram is ever read from the
> network with root privs.
>
> It would be great if we could preserve this behavior.
>
> Otherwise the split privileges model of the new openssh would be a
> possibility, but it's more complex.


For a forking server accepting connections from any ip, I
consider it even more critical than for a peer2peer version.

I did it simply by calling set_user() in the
server's main process and everything seems to work at least
for me.

Don't know if this works in all cases since the server drops
priviledges before opening tun dev.


Sampo


