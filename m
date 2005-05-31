From: Ralf =?utf-8?q?L=C3=BCbben?= <ralfluebben@...68...>
Subject: Re: [Openvpn-devel] Re: Re: Radius support (Authentification, Authorization and Accounting)
References: <200504291033.00667.ralfluebben@...68...> <d7fjlh$hrc$1@...165...> <1117524566.11540.16.camel@...23...>
In-Reply-To: <1117524566.11540.16.camel@...23...>
MIME-Version: 1.0
Message-Id: <200505311009.03402.ralfluebben@...68...>
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
Date: Tue May 31 01:12:09 2005
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Ok,

I think I understand the problem.=20
If a client send no stop packet the ip address will never be freed if the=20
nas-port is never used again.
So if a other client connects with the same nas port number, of the client=
=20
which has not send the stop packet, the freeradius server will free the ip=
=20
address. And this ip address can be used again.=20
Is this right?

I think I will create an array which manages this problem.
Maybe this stricture:
nas-port-number		free
-----------------------------------------
	1				false
	2				true
	3				true
	4				false
	5				false
	6				false
	7				true

If a client connects the nas port number is locked , if a client disconnect=
=20
the port number is freed.=20
A new client will always get the least number of the array.

Would this behaviour ok?

How many nas port numbers will I need?
I think 1000 will be enough or can there be more than 1000 clients at=20
the same time?

Greetings,
Ralf L=C3=BCbben




Am Dienstag, 31. Mai 2005 07:29 schrieb Torge Szczepanek:
> Am Montag, den 30.05.2005, 19:49 +0000 schrieb Ralf L=C3=BCbben:
> > I have still one question about the NAS-Port attribute. At the moment t=
he
> > port number is increment for every user, but never decremt.
> > Will this be a problem with freeradius? Must the number be in a special
> > range, maybe for assignment?
>
> This will not be a problem for freeradius. But this has drawbacks. The
> problem is that if the VPN Server crashes or the Radius server doesn't
> get any stop record (remeber that radius is based on UDP), the server
> will *never* free the IP-addresses handed out to the client.
>
> I you reuse the old Nas-Port Ids, which get free, when a client
> disconnects the server will free the ressource (the IP) and will hand
> out the IP to new users. Otherwise it would be blocked forever.
>
> An example with increasing Nas-Port:
>
> Freeradius has a pool of 6 IPs (a.b.c.10-a.b.c.16)
>
> Client 1 connects gets Nas-Port 1 IP a.b.c.10
> Client 2 connects gets Nas-Port 2 IP a.b.c.11
> Client 3 connects gets Nas-Port 3 IP a.b.c.13
> Client 4 connects gets Nas-Port 4 IP a.b.c.14
> Client 5 connects gets Nas-Port 5 IP a.b.c.15
>
> Now the communication between the OpenVPN server and the radius server
> is broken for some reason. Client 1-4 disconnect.
>
> After that happened communication is restored. IPs a.b.c.10-a.b.c.15 are
> marked as used by clients.
>
> Client 6 connects gets Nas-Port 6 IP a.b.c.16
>
> Everything OK, but now if another clients connects:
>
> Client 7 tries to connect and gets Nas-Port 7. On the radius server side
> all IPs are marked in-use.
>
>
> An example without increasing Nas-Port:
>
> Freeradius has a pool of 6 IPs (a.b.c.10-a.b.c.16)
>
> Client 1 connects gets Nas-Port 1 IP a.b.c.10
> Client 2 connects gets Nas-Port 2 IP a.b.c.11
> Client 3 connects gets Nas-Port 3 IP a.b.c.13
> Client 4 connects gets Nas-Port 4 IP a.b.c.14
> Client 5 connects gets Nas-Port 5 IP a.b.c.15
>
> Now the communication between the OpenVPN server and the radius server
> is broken for some reason. Client 1-4 disconnect.
>
> After that happened communication is restored. IPs a.b.c.10-a.b.c.15 are
> marked as used by clients.
>
> Client 6 connects gets Nas-Port *1* IP a.b.c.16
>
> (Nas-Port 1 is again free since Client 1 disconnected)
>
> Client 7 tries to connect and gets Nas-Port 2.
>
> Client 7 connects gets Nas-Port 2 IP a.b.c.11
>
> So everything is OK.

