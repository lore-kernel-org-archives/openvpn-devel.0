Subject: Re: [Openvpn-devel] Re: Re: Radius support (Authentification,
	Authorization and Accounting)
From: Torge Szczepanek <openvpn-devel@...239...>
In-Reply-To: <d7fjlh$hrc$1@...165...>
References: <200504291033.00667.ralfluebben@...68...>
	 <Pine.LNX.4.58.0504300118280.24107@...41...>
	 <Pine.LNX.4.58.0504301334040.25603@...41...>
	 <200505031348.25263.ralfluebben@...68...>
	 <Pine.LNX.4.58.0505031000150.1970@...41...> <d6ck1r$3b9$1@...165...>
	 <1116334849.14388.43.camel@...23...>   <d7fjlh$hrc$1@...165...>
Message-Id: <1117524566.11540.16.camel@...23...>
Mime-Version: 1.0
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
Date: Tue May 31 00:31:28 2005
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Am Montag, den 30.05.2005, 19:49 +0000 schrieb Ralf L=C3=BCbben:

> I have still one question about the NAS-Port attribute. At the moment the
> port number is increment for every user, but never decremt.
> Will this be a problem with freeradius? Must the number be in a special
> range, maybe for assignment?

This will not be a problem for freeradius. But this has drawbacks. The
problem is that if the VPN Server crashes or the Radius server doesn't
get any stop record (remeber that radius is based on UDP), the server
will *never* free the IP-addresses handed out to the client.

I you reuse the old Nas-Port Ids, which get free, when a client
disconnects the server will free the ressource (the IP) and will hand
out the IP to new users. Otherwise it would be blocked forever.

An example with increasing Nas-Port:

Freeradius has a pool of 6 IPs (a.b.c.10-a.b.c.16)

Client 1 connects gets Nas-Port 1 IP a.b.c.10
Client 2 connects gets Nas-Port 2 IP a.b.c.11
Client 3 connects gets Nas-Port 3 IP a.b.c.13
Client 4 connects gets Nas-Port 4 IP a.b.c.14
Client 5 connects gets Nas-Port 5 IP a.b.c.15

Now the communication between the OpenVPN server and the radius server
is broken for some reason. Client 1-4 disconnect.

After that happened communication is restored. IPs a.b.c.10-a.b.c.15 are
marked as used by clients.

Client 6 connects gets Nas-Port 6 IP a.b.c.16

Everything OK, but now if another clients connects:

Client 7 tries to connect and gets Nas-Port 7. On the radius server side
all IPs are marked in-use.


An example without increasing Nas-Port:

Freeradius has a pool of 6 IPs (a.b.c.10-a.b.c.16)

Client 1 connects gets Nas-Port 1 IP a.b.c.10
Client 2 connects gets Nas-Port 2 IP a.b.c.11
Client 3 connects gets Nas-Port 3 IP a.b.c.13
Client 4 connects gets Nas-Port 4 IP a.b.c.14
Client 5 connects gets Nas-Port 5 IP a.b.c.15

Now the communication between the OpenVPN server and the radius server
is broken for some reason. Client 1-4 disconnect.

After that happened communication is restored. IPs a.b.c.10-a.b.c.15 are
marked as used by clients.

Client 6 connects gets Nas-Port *1* IP a.b.c.16=20

(Nas-Port 1 is again free since Client 1 disconnected)

Client 7 tries to connect and gets Nas-Port 2.=20

Client 7 connects gets Nas-Port 2 IP a.b.c.11

So everything is OK.

--=20
Torge Szczepanek <openvpn-devel@...239...>


