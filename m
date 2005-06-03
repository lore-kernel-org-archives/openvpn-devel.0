From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Re: Re: Radius support (Authentification,
 Authorization and Accounting)
In-Reply-To: <d7q8hf$jos$1@...165...>
Message-ID: <Pine.LNX.4.58.0506031357340.16160@...41...>
References: <200504291033.00667.ralfluebben@...68...> <Pine.LNX.4.58.0504300118280.24107@...41...>
 <Pine.LNX.4.58.0504301334040.25603@...41...> <200505031348.25263.ralfluebben@...68...>
 <Pine.LNX.4.58.0505031000150.1970@...41...> <d6ck1r$3b9$1@...165...>
 <1116334849.14388.43.camel@...23...> <Pine.LNX.4.58.0505170713570.2777@...41...>
 <d7q8hf$jos$1@...165...>
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
Date: Fri Jun  3 13:04:26 2005
Content-Type: TEXT/PLAIN; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Ralf =?UTF-8?B?TMO8YmJlbg==?= <ralfluebben@...68...>
Cc: openvpn-devel@lists.sourceforge.net

On Fri, 3 Jun 2005, Ralf [UTF-8] L=C3=BCbben wrote:

> Hello,
>=20
> I have again two questions about the counter for the bytes send and
> received:
>=20
> What is the datatype of the counters?=20
> Radius only knows 32-bit unsingned integers.

Right now the counters are 32 bits, but they may be expanded to 64 bits in=
=20
the future.

> Which traffic is counted?
> Is only the real payload counted without the encryption overhead?
> What about the keepalive packets?=20
> I see there is always a little bit of traffic.
> Is it possible to count only the real payload or must I subtract the other
> bytes from the counters in the plugin?

OpenVPN internally keeps track of most of these, but right now only the=20
total number of bytes sent over the TCP or UDP socket (including=20
encryption overhead, keepalives, etc.) is included.

James


> James Yonan wrote:
>=20
> > On Tue, 17 May 2005, Torge Szczepanek wrote:
> >=20
> >> Am Dienstag, den 17.05.2005, 15:20 +0400 schrieb Ralf L=C3=BCbben:
> >>=20
> >> > I want to send following attribute:
> >> > Username
> >> > Password
> >> > NAS-Port =3D number of the tun interface
> >>=20
> >> This is bad, since you must send a unique identifier to the Radius
> >> Server for every connected client if I understand this correctly.
> >>=20
> >> The Radius servers decides based on a unique NAS-IP-Address:NAS-Port
> >> pair which IP-Addresse should be handed out to the client and which is
> >> in use.
> >>=20
> >> Example:
> >>=20
> >> NAS:XXX.XXX.XXX.40 port:0x0 - ipaddr:YYY.YYY.76.YYY active:1 cli:0 num=
:1
> >> NAS:XXX.XXX.XXX.40 port:0x1 - ipaddr:YYY.YYY.75.YYY active:1 cli:0 num=
:1
> >> [...]
> >> NAS:XXX.XXX.XXX.40 port:0x10 - ipaddr:YYY.YYY.76.YYY active:1 cli:0
> >> num:1
> >> NAS:XXX.XXX.XXX.40 port:0x11 - ipaddr:YYY.YYY.78.YYY active:1 cli:0
> >> num:1
> >> NAS:XXX.XXX.XXX.40 port:0x12 - ipaddr:YYY.YYY.72.YYY active:1 cli:0
> >> num:1
> >> NAS:XXX.XXX.XXX.40 port:0x13 - ipaddr:YYY.YYY.73.YYY active:1 cli:0
> >> num:1
> >> [...]
> >> NAS:XXX.XXX.XXX.40 port:0x100 - ipaddr:YYY.YYY.78.YYY active:0 cli:0
> >> num:0
> >> NAS:XXX.XXX.XXX.40 port:0x103 - ipaddr:YYY.YYY.77.YYY active:0 cli:0
> >> num:0
> >>=20
> >> Since the tun interface is the same for every connected client connect=
ed
> >> to the same openvpn process, this will not work. One might correct me,
> >> if I am wrong on this.
> >>=20
> >> So at the moment one has to generate a unique client id (NAS-Port) for
> >> every connected user. This should be done in a way that the first clie=
nt
> >> gets the id (NAS-Port) 0 assigned. The next one the id 1 and so on. On
> >> disconnect the id should be reused.
> >>=20
> >> For example:
> >>=20
> >> client 1 connects, gets id 0
> >> client 2 connects, gets id 1
> >> client 3 connects, gets id 2
> >> client 4 connects, gets id 3
> >> client 2 disconnects, releases id 1
> >> client 3 disconnects, releases id 2
> >> client 5 connects, gets id 1
> >> client 6 connects, gets id 2
> >> [...]
> >>=20
> >>=20
> >> I wondered whether it is possible to have a seperate tunx interface for
> >> each connected client. That would solve the problem and mimic the
> >> behaviour of ppp Connections, where you have a seperated ppp Interface
> >> for each connected client.
> >> Is this easy possible or would that mean to rewrite most parts of
> >> OpenVPN?
> >=20
> > It's more like the opposite:  1.x supported a specific tunx interface a=
nd
> > port for each client.  2.0 was rewritten to allow all clients to share a
> > single tun/tap interface and TCP/UDP port.  The 2.0 approach tends to be
> > preferred because it scales better and is easier to manage.
> >=20
> > James
> >=20
> >=20
> > -------------------------------------------------------
> > This SF.Net email is sponsored by Oracle Space Sweepstakes
> > Want to be the first software developer in space?
> > Enter now for the Oracle Space Sweepstakes!
> > http://ads.osdn.com/?ad_idt12&alloc_id=16344&opclick
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you sho=
tput
> a projector? How fast can you ride your desk chair down the office luge t=
rack?
> If you want to score the big prize, get to know the little guy.=20=20
> Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=3D20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

