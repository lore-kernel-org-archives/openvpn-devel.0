From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Radius support (Authentification, Authorization
 and Accounting)
In-Reply-To: <200505031348.25263.ralfluebben@...68...>
Message-ID: <Pine.LNX.4.58.0505031000150.1970@...41...>
References: <200504291033.00667.ralfluebben@...68...> <Pine.LNX.4.58.0504300118280.24107@...41...>
 <Pine.LNX.4.58.0504301334040.25603@...41...> <200505031348.25263.ralfluebben@...68...>
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
Date: Tue May  3 09:33:03 2005
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Ralf =?iso-8859-1?q?L=FCbben?= <ralfluebben@...68...>
Cc: openvpn-devel@lists.sourceforge.net

On Tue, 3 May 2005, Ralf [iso-8859-1] L=FCbben wrote:

> Hello,
>=20
> I tried to create a concept for the RADIUS-Plugin.
> Maybe someone have some additional ideas or can answer me some questions =
I=20
> wrote down in the following text.
>=20
> -------------------------------------------------------------------------=
------------------------------------
> Start of the connection:
>=20
> The plugin sends a "access-request-radius-ticket" with the username and a=
=20
> hash(MD5-hash over the password and the shared-secret)  to the radius ser=
ver.
> If the server sends a "access-reject-ticket" or "access-challenge-ticket"=
 the=20
> authorization fails.
>=20
> If the server sends a "access-accept-ticket" the authorization is ok, in =
the=20
> ticket can be some attributes:
>=20
> - Framed-IP-Address: The IP-address which is pushed to the client.
>=20
> - Framed-Route: These routes have to pushed to the servers routing table.=
 This=20
> attribut can occur several times in the  "access-accept-ticket".

You might need a split privilege model here, because adding routes
requires root privileges, and for security reasons, we don't want to run
the main OpenVPN process as root.  The OpenVPN plugin model supports split
privileges, i.e. where the plugin process holds onto root while the main
OpenVPN process drops privileges (see auth-pam or down-root for examples
of this), so you'd probably need to have the plugin fork a process to
handle route additions.

> - Acct-Interim-Interval: The interval in which the accounting data is sen=
t to=20
> the radius server.
>=20
> Maybe these attributes are not important :
> - Session-Timeout: The maximum time for a connection.

OpenVPN doesn't support this right now.

> - Idle-Timeout: The connection is disconnected, if there is no traffic=20

This is tricky, because how do you define traffic?

> Maybe it is possible to create a vendor specific attribut for routes whic=
h are=20
> pushed to the client. There is no attribut for that in the radius protoco=
l.

Good idea.

> After the authorization is done:
> The plugin has to start another process/thread for the accounting data  w=
ith=20
> the parameter value of the attribut "Acct-Interim-Interval".=20
> This process has to sent an "accounting-request-ticket" to the radius ser=
ver=20
> with the attribut "acct-status-type"=3D1 (start). (There must be included=
 some=20
> more attributes for the radius server (NAS-IP-address (=3Dopenvpn-ip-addr=
ess)=20
> or NAS-identifier, real ip address of the user as framed-ip-address-attri=
but,=20
> NAS-Port or NAS-port-type)=20
> The process has to wait for a "accounting-response-ticket" from the serve=
r,=20
> if he gets no response he has to send the ticket again (interval=3D?).
>=20
> The plugin must return 0 if everything is ok, otherwise 1.
>=20
> Questions:
>=20
> Which is the best plugin to use? I need the username and the password bef=
ore=20
> the ip address and the routes are sent to the client?=20

Use OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY (called first) to authorize
username/password and OPENVPN_PLUGIN_CLIENT_CONNECT (called next) to push
IP address and routes to client.

> Do the openvpn process waits until the plugin is finished? So I can write=
 the=20
> conf-files without getting a IO-error.

With 2.0.x, OpenVPN is running in a single thread, so plugin callbacks=20
will stall the whole process.

For 2.1, there will be multithread support (two threads actually), so
calls to plugins will occur from a different thread than the main packet
forwarding thread.  There will only be a single thread for calling
plugins, so you won't need to make the plugin callbacks themselves
reentrant.

> -------------------------------------------------------------------------=
-----------------------------------
> During the connection:
>=20
> The separate process/thread which is started at the beginning of the=20
> connection sends=20
> with the interval time of the  attribut "Acct-Interim-Interval" accountin=
g=20
> data to the radius server.=20
> The process reads the information out of the status file which is generat=
ed by=20
> the openvpn process every second. The status file must be generated every=
=20
> second because the attribut "Acct-Interim-Interval" is in seconds and so=
=20
> nobody knows, when ths process reads the status file.=20

This would work, but it might be cleaner for OpenVPN 2.1 to add a new
callback for passing accounting data to the plugin.

The problem with polling the status file is that there's no guarantee of=20
change atomicity, i.e. an entry could be added and then deleted from the=20
file between pollings.

> The attribut "acct-status-type" must be set to 3 (interim-Update).
>=20
> The process has to wait for a "accounting-response-ticket" from the serve=
r,=20
> if he gets no response he has to send the ticket again (interval=3D?).
>=20
> Attributes in the accounting-request-ticket:
> - NAS ip address and NAS identifier=20
> - Framed ip address (=3Dreal ip address of the client)
> - NAS-port or NAS-port-type
> - Acct-Input-Octets=20
> - Acct-Output-Octets=20
> - Acct-Input-Packets=20
> - Acct-Output-Packets=20
> - Acct-Session-Time=20
>=20
>=20
> Questions:
> Is it possible to generate the status file every second?

Yes, however if the OpenVPN event loop is not actively forwarding packets,=
=20
the status file update interval could be as long as 10 seconds.

> Is the accounting information in the status file separate for every user?

Yes.

> Which information can I get from the status file?

For each client:

  Common Name,Real Address,Bytes Received,Bytes Sent,Connected Since

For each internal routing table entry:

  Virtual Address,Common Name,Real Address,Last Reference

> -------------------------------------------------------------------------=
-----------------------------
> End of the connection:
> At the end a "accounting-request-ticket" with the "acct-status-type"=3D2 =
(stop)=20
> must be sent to the radius server.=20
> With the following attributes:
> - NAS ip address and NAS identifier=20
> - Framed ip address (=3Dreal ip address of the client)
> - NAS-port or NAS-port-type
> - Acct-Input-Octets=20
> - Acct-Output-Octets=20
> - Acct-Input-Packets=20
> - Acct-Output-Packets=20
> - Acct-Session-Time
> (- Acct-Terminate-Cause)
>=20
> Also the accouting process must be killed.
>=20
> I think the "PLUGIN_CLIENT_DISCONNECT"-type will be fit for this.
>=20
> Questions:
> Is the "PLUGIN_CLIENT_DISCONNECT"-type called at every disconnect?=20

Yes, but sometimes there is a delay on UDP disconnects, since UDP is
connectionless, so the call to PLUGIN_CLIENT_DISCONNECT might occur more
than 1 minute after the actual disconnection.  Also, with UDP, if a client
disconnects and immediately reconnects using the same port number (if
nobind isn't used on the client), the server will see both the original
connection and the reconnect as being part of the same connection, so
there won't be a call to PLUGIN_CLIENT_DISCONNECT then
PLUGIN_CLIENT_CONNECT.

James


