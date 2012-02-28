Message-ID: <4F4D2212.2020008@...1114...>
Date: Tue, 28 Feb 2012 19:50:58 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4F4CE4FE.3010009@...515...>
	<1848924920.20120228183103@...449...>
	<4F4D18C0.1020008@...1114...>
	<1958561304.20120228192904@...449...>
In-Reply-To: <1958561304.20120228192904@...449...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?ISO-8859-1?Q?Carsten_Kr=FCger?= <C.Krueger@...448...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/02/12 19:29, Carsten Kr=FCger wrote:
> Hello David,
>=20
>> The solution we've ended up with is a OpenVPN service helper which
>> runs some code parts with admin rights and the OpenVPN binary
>> itself (openvpn.exe) will run completely unprivileged.  Those two
>> instances will communicate via named pipes, to set up the proper
>> routes and other networking parameters.
>=20
> Why named pipes?
>=20
> Why don't extend this=20
> http://openvpn.net/index.php/open-source/documentation/miscellaneous/79-m=
anagement-interface.html
>
>=20
that it works without admin privileges?

Heiko can probably give a much better answer, but if I remember right,
the argument was this:  Think of a multi-user setup (like a Terminal
Server), the management interface will be accessible for all users on
that server.

Named pipes will be available only for that single user, so the attack
vector in an abuse scenario, compared to the management interface, is
more limited.  And considering this pipe will do privileged network
setup, it should be restricted as much as possible.  I don't recall now
if there was even more restrictions you could apply to these pipes as well.

And how this is implemented, the OpenVPN Service will be started
automatically.  The GUI contacts the Service and the service starts the
OpenVPN process with the privileges of the GUI user (IIRC, it was some
neat Windows functions which allows to create processes with privileges
based upon the user credentials of the other side of the named pipe).
And again, the only code pieces in the Service are those related to
network configuration.  The rest of the Service code runs unprivileged.

This service should be able to (for now only in theory; it has not been
tested yet) handle more users simultaneously.

However, the management interface will be used in addition too, at least
in the very beginning, where the logging is transferred back to the GUI
and so on.  I don't recall now all the GUI would do via this interface.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9NIhAACgkQDC186MBRfrpPJwCfYlbHHIGZtb8TQj2v7ZJKCcxw
NFEAmQGuOczRPZzMswO5lDxJEdgtEDs+
=3DL5DL
-----END PGP SIGNATURE-----

