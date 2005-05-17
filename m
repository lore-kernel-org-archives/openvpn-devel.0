From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Re: Radius support (Authentification, Authorization
 and Accounting)
In-Reply-To: <d6dh8d$g4o$1@...165...>
Message-ID: <Pine.LNX.4.58.0505171429520.2777@...41...>
References: <200504291033.00667.ralfluebben@...68...> <Pine.LNX.4.58.0504300118280.24107@...41...>
 <Pine.LNX.4.58.0504301334040.25603@...41...> <200505031348.25263.ralfluebben@...68...>
 <Pine.LNX.4.58.0505031000150.1970@...41...> <d6dh8d$g4o$1@...165...>
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
Date: Tue May 17 13:35:19 2005
Content-Type: TEXT/PLAIN; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Ralf =?UTF-8?B?TMO8YmJlbg==?= <ralfluebben@...68...>
Cc: openvpn-devel@lists.sourceforge.net


> One more question to the plugin PLUGIN_CLIENT_DISCONNECT:
> Does every plugin which is called, gets the pointer to thesame=20
> struct openvpn_plugin_handle_t, so I can save here the socket to=20
> the background processes and the plugin PLUGIN_CLIENT_DISCONNECT
> can send data to these socket numbers?

Yes -- each plugin (as defined by a specific "plugin" directive in the=20
OpenVPN config file) will have a single openvpn_plugin_handle_t memory=20
region which will be shared across all of the different PLUGIN_x plugin=20
types.

James

>=20
>=20
>=20
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
> >>
> -------------------------------------------------------------------------=
------------------------------------
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
> >>
> -------------------------------------------------------------------------=
-----------------------------------
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
> >>
> -------------------------------------------------------------------------=
-----------------------------
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

