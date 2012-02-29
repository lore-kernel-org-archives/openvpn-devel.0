From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 29 Feb 2012 11:50:25 +0100
Message-ID: <3440230.bBsdCSzEj1@...1526...>
In-Reply-To: <1945967716.20120228230913@...449...>
References: <4F4CE4FE.3010009@...515...> <4F4D2212.2020008@...1114...>
	<1945967716.20120228230913@...449...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net, Carsten =?ISO-8859-1?Q?Kr=FCger?= <C.Krueger@...448...>

On Tuesday 28 February 2012 722:09:13 Carsten Kr=FCger wrote:
> DS> Heiko can probably give a much better answer, but if I remember right,
> DS> the argument was this:  Think of a multi-user setup (like a Terminal
> DS> Server), the management interface will be accessible for all users on
> DS> that server.
>=20
> a) Who an earth allows users on a terminal server to create VPN-sessions?
> What happens if one of the sessions use redirect gateway?
> All users are redirected?

That was actually an open question. I don't know if TS manages per session=
=20
routing tables and haven't tried. However it was only an example and thus=20
didn't have to make any practical sense. =3D)
=20
> I don't think that this is a valid point.

The thing is that you need a second communication channel for requesting=20
privileged operations. The management interface won't do, because the GUI=20
(hopefully) runs with an unprivileged token. So the distinction between bot=
h=20
is:

  * mgmt itf for interactive communication with the user=20
  * privilege channel for requesting operations that require elevation
=20
> Privilege seperation in openvnp deamon is nice, but is a complete
> different thing than management interface access.

It is, you got it right.

> In openvpn case it should be something like this:
> openvpnserv.exe running as a service, has no privileges and opens
> management interface
> openvpnhelpserv.exe running as a service has network operator rights
> (no need for local system ...)
>=20
> openvpnserv and openvpnhelpserv could communicate via pipe.
>=20
> openvpn-management client (could be a perl script) connects to
> management interface of openvpnserv.exe to start/stop a tunnel and
> supply secrets.

You forgot the GUI in this picture. If the service is connected to the=20
management interface the GUI can't connect anymore. It need to to get thing=
s=20
done, though.
=20
> DS> And how this is implemented, the OpenVPN Service will be started
> DS> automatically.  The GUI contacts the Service and the service starts t=
he
> DS> OpenVPN process with the privileges of the GUI user (IIRC, it was some
> DS> neat Windows functions which allows to create processes with privileg=
es
> DS> based upon the user credentials of the other side of the named pipe).
>=20
> The sounds very bad.
> The service shouldn't create processes in the name of the user.

Interesting, could you elaborate?

> DS> This service should be able to (for now only in theory; it has not be=
en
> DS> tested yet) handle more users simultaneously.
>=20
> Pretty useless, see above

Not users, really. More like session. So you can connect to different serve=
r=20
simultaneously. Of course this could be used by two different users at the=
=20
same time or different impersonations in the same session, while still runn=
ing=20
ovpn with the credentials of the entity who started openvpn. So the point=20
isn't really that many user can connect, but that the running sessions will=
 be=20
isolated from each other by the service.

Regards
Heiko
--=20
Heiko Hund | Software Engineer | Phone +49-721-25516-237 | Fax -200
Astaro a Sophos Company | Amalienbadstr. 41 Bau 52 | 76227 Karlsruhe | Germ=
any
Commercial Register: Mannheim HRA 702710 | Headquarter Location: Karlsruhe
=20
Represented by the General Partner Astaro Verwaltungs GmbH
Amalienbadstra=DFe 41 Bau 52 | 76227 Karlsruhe | Germany=20
Commercial Register: Mannheim HRB 708248 | Executive Board: Gert Hansen,
Markus Hennig, Jan Hichert, G=FCnter Junk, Dr. Frank Nellissen


