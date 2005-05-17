From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Re: Radius support (Authentification, Authorization
 and Accounting)
In-Reply-To: <d6ck1r$3b9$1@...165...>
Message-ID: <Pine.LNX.4.58.0505170718220.2777@...41...>
References: <200504291033.00667.ralfluebben@...68...> <Pine.LNX.4.58.0504300118280.24107@...41...>
 <Pine.LNX.4.58.0504301334040.25603@...41...> <200505031348.25263.ralfluebben@...68...>
 <Pine.LNX.4.58.0505031000150.1970@...41...> <d6ck1r$3b9$1@...165...>
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
Date: Tue May 17 06:47:36 2005
Content-Type: TEXT/PLAIN; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Ralf =?UTF-8?B?TMO8YmJlbg==?= <ralfluebben@...68...>
Cc: openvpn-devel@lists.sourceforge.net

> 2. Accounting
> Here I'm not sure, want is the best way to do it, maybe somebody have
> some ideas.
> One idea is to create for every openvpn-client who
> connects to the openvpn-server a own process with fork().=20
> So every process gets his own Acct-Interim-Interval and can send=20
> the accounting data to the radius server. The data is read from
> the status file. This file must be accessible by the user (nobody)
> of the openvpn process.=20
> If there are a lot of users, there are a lot of processes and every=20
> process reads the status file.
>=20
> The other idea is to create only one process which handles all
> accounting, this process will work like the auth-pam-plugin (split privil=
ege
> execution model). This process must schedule the differnt
> Acct-Interim-Intervals of the clients. The data is read from
> the status file.
>=20
> Accounting Attributes:
> Acct-Status-Type:=20
>         start - at the beginning of the connection
>         update - during the connection
>         stop - at the end
> NAS-Session-ID: unique for a connection
> NAS-Identidier: user-defined value
> Acct-Input-Octets: read from the status file
> Acct-Output-Octets: read from the status file
> Acct-Session-Time: intenal counter or read from the status file
>=20
> The accounting stop ticket can only be send by the disconnect plugin.
> Can I share informations between plugins? So the disconnect plugin can=20
> send a disconnect signal to the accounting process, maybe over a socket?
> So the accounting for this users stopps and the ticket is generated.

Regarding accounting, I am planning to add another plugin call type to
pass accounting data to the plugin so that it doesn't have to read the
status file to get the same info.

While the OPENVPN_PLUGIN_CLIENT_CONNECT and
OPENVPN_PLUGIN_CLIENT_DISCONNECT plugin call types can be used to bracket
a connection, and the latter passes final accounting data for the
connection, I would add a new call type such as OPENVPN_PLUGIN_STATS which
would be called once per second for any client with send/receive activity.=
=20=20
The environmental variables common_name, bytes_sent (cumulative), and
bytes_received (cumulative) would be passed to it.

James

>=20
>=20
> support
> James Yonan wrote:
>=20
> > On Tue, 3 May 2005, Ralf [iso-8859-1] L=C3=BCbben wrote:
> >=20
> >> Hello,
> >>=20
> >> I tried to create a concept for the RADIUS-Plugin.
> >> Maybe someone have some additional ideas or can answer me some questio=
ns
> >> I wrote down in the following text.
> >>=20
> >> -----------------------------------------------------------------------
> >> Start of the connection:
> >>=20
> >> The plugin sends a "access-request-radius-ticket" with the username an=
d a
> >> hash(MD5-hash over the password and the shared-secret)  to the radius
> >> server. If the server sends a "access-reject-ticket" or
> >> "access-challenge-ticket" the authorization fails.
> >>=20
> >> If the server sends a "access-accept-ticket" the authorization is ok, =
in
> >> the ticket can be some attributes:
> >>=20
> >> - Framed-IP-Address: The IP-address which is pushed to the client.
> >>=20
> >> - Framed-Route: These routes have to pushed to the servers routing tab=
le.
> >> This
> >> attribut can occur several times in the  "access-accept-ticket".
> >=20
> > You might need a split privilege model here, because adding routes
> > requires root privileges, and for security reasons, we don't want to run
> > the main OpenVPN process as root.  The OpenVPN plugin model supports sp=
lit
> > privileges, i.e. where the plugin process holds onto root while the main
> > OpenVPN process drops privileges (see auth-pam or down-root for examples
> > of this), so you'd probably need to have the plugin fork a process to
> > handle route additions.
> >=20
> >> - Acct-Interim-Interval: The interval in which the accounting data is
> >> sent to the radius server.
> >>=20
> >> Maybe these attributes are not important :
> >> - Session-Timeout: The maximum time for a connection.
> >=20
> > OpenVPN doesn't support this right now.
> >=20
> >> - Idle-Timeout: The connection is disconnected, if there is no traffic
> >=20
> > This is tricky, because how do you define traffic?
> >=20
> >> Maybe it is possible to create a vendor specific attribut for routes
> >> which are pushed to the client. There is no attribut for that in the
> >> radius protocol.
> >=20
> > Good idea.
> >=20
> >> After the authorization is done:
> >> The plugin has to start another process/thread for the accounting data=
=20
> >> with the parameter value of the attribut "Acct-Interim-Interval".
> >> This process has to sent an "accounting-request-ticket" to the radius
> >> server with the attribut "acct-status-type"=3D1 (start). (There must be
> >> included some more attributes for the radius server (NAS-IP-address
> >> (=3Dopenvpn-ip-address) or NAS-identifier, real ip address of the user=
 as
> >> framed-ip-address-attribut, NAS-Port or NAS-port-type)
> >> The process has to wait for a "accounting-response-ticket" from the
> >> server, if he gets no response he has to send the ticket again
> >> (interval=3D?).
> >>=20
> >> The plugin must return 0 if everything is ok, otherwise 1.
> >>=20
> >> Questions:
> >>=20
> >> Which is the best plugin to use? I need the username and the password
> >> before the ip address and the routes are sent to the client?
> >=20
> > Use OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY (called first) to authorize
> > username/password and OPENVPN_PLUGIN_CLIENT_CONNECT (called next) to pu=
sh
> > IP address and routes to client.
> >=20
> >> Do the openvpn process waits until the plugin is finished? So I can wr=
ite
> >> the conf-files without getting a IO-error.
> >=20
> > With 2.0.x, OpenVPN is running in a single thread, so plugin callbacks
> > will stall the whole process.
> >=20
> > For 2.1, there will be multithread support (two threads actually), so
> > calls to plugins will occur from a different thread than the main packet
> > forwarding thread.  There will only be a single thread for calling
> > plugins, so you won't need to make the plugin callbacks themselves
> > reentrant.
> >=20
> >> ---------------------------------------------------------------
> >> During the connection:
> >>=20
> >> The separate process/thread which is started at the beginning of the
> >> connection sends
> >> with the interval time of the  attribut "Acct-Interim-Interval"
> >> accounting data to the radius server.
> >> The process reads the information out of the status file which is
> >> generated by the openvpn process every second. The status file must be
> >> generated every second because the attribut "Acct-Interim-Interval" is=
 in
> >> seconds and so nobody knows, when ths process reads the status file.
> >=20
> > This would work, but it might be cleaner for OpenVPN 2.1 to add a new
> > callback for passing accounting data to the plugin.
> >=20
> > The problem with polling the status file is that there's no guarantee of
> > change atomicity, i.e. an entry could be added and then deleted from the
> > file between pollings.
> >=20
> >> The attribut "acct-status-type" must be set to 3 (interim-Update).
> >>=20
> >> The process has to wait for a "accounting-response-ticket" from the
> >> server, if he gets no response he has to send the ticket again
> >> (interval=3D?).
> >>=20
> >> Attributes in the accounting-request-ticket:
> >> - NAS ip address and NAS identifier
> >> - Framed ip address (=3Dreal ip address of the client)
> >> - NAS-port or NAS-port-type
> >> - Acct-Input-Octets
> >> - Acct-Output-Octets
> >> - Acct-Input-Packets
> >> - Acct-Output-Packets
> >> - Acct-Session-Time
> >>=20
> >>=20
> >> Questions:
> >> Is it possible to generate the status file every second?
> >=20
> > Yes, however if the OpenVPN event loop is not actively forwarding packe=
ts,
> > the status file update interval could be as long as 10 seconds.
> >=20
> >> Is the accounting information in the status file separate for every us=
er?
> >=20
> > Yes.
> >=20
> >> Which information can I get from the status file?
> >=20
> > For each client:
> >=20
> >   Common Name,Real Address,Bytes Received,Bytes Sent,Connected Since
> >=20
> > For each internal routing table entry:
> >=20
> >   Virtual Address,Common Name,Real Address,Last Reference
> >=20
> >> --------------------------------------------------------------
> >> End of the connection:
> >> At the end a "accounting-request-ticket" with the "acct-status-type"=
=3D2
> >> (stop) must be sent to the radius server.
> >> With the following attributes:
> >> - NAS ip address and NAS identifier
> >> - Framed ip address (=3Dreal ip address of the client)
> >> - NAS-port or NAS-port-type
> >> - Acct-Input-Octets
> >> - Acct-Output-Octets
> >> - Acct-Input-Packets
> >> - Acct-Output-Packets
> >> - Acct-Session-Time
> >> (- Acct-Terminate-Cause)
> >>=20
> >> Also the accouting process must be killed.
> >>=20
> >> I think the "PLUGIN_CLIENT_DISCONNECT"-type will be fit for this.
> >>=20
> >> Questions:
> >> Is the "PLUGIN_CLIENT_DISCONNECT"-type called at every disconnect?
> >=20
> > Yes, but sometimes there is a delay on UDP disconnects, since UDP is
> > connectionless, so the call to PLUGIN_CLIENT_DISCONNECT might occur more
> > than 1 minute after the actual disconnection.  Also, with UDP, if a cli=
ent
> > disconnects and immediately reconnects using the same port number (if
> > nobind isn't used on the client), the server will see both the original
> > connection and the reconnect as being part of the same connection, so
> > there won't be a call to PLUGIN_CLIENT_DISCONNECT then
> > PLUGIN_CLIENT_CONNECT.
> >=20
> > James
> >=20
> >=20
> >=20
> > -------------------------------------------------------
> > This SF.Net email is sponsored by: NEC IT Guy Games.
> > Get your fingers limbered up and give it your best shot. 4 great events=
, 4
> > opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
> > win an NEC 61 plasma display. Visit http://www.necitguy.com/?r
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by Oracle Space Sweepstakes
> Want to be the first software developer in space?
> Enter now for the Oracle Space Sweepstakes!
> http://ads.osdn.com/?ad_id=3D7412&alloc_id=3D16344&op=3Dclick
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

