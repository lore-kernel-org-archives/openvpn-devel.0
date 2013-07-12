Message-ID: <51E01835.6070803@...1114...>
Date: Fri, 12 Jul 2013 16:52:37 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <51DFD7D9.6050503@...1388...>
In-Reply-To: <51DFD7D9.6050503@...1388...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2QJERHFALRQOTXCDFQJIO"
Subject: Re: [Openvpn-devel] client-connect / client-disconnect scripts
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Michael Ludvig <mludvig@...1388...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2QJERHFALRQOTXCDFQJIO
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 12/07/13 12:18, Michael Ludvig wrote:
> Hi
>=20
> I'm having troubles with client-connect and client-disconnect scripts in
> OpenVPN 2.3.2.
>=20
> 1) client-connect script is called on the server only once (maybe once
> for each user?) and on subsequent connects its previous output is
> re-used but the script isn't called again. It looks like the config
> produced by the script is cached - can I somehow disable that caching
> and force calling the script for every client connect?
>
> 2) client-disconnect never seems to be called. If I successfully connect
> (and and then kill the client the disconnect is never called. I tried to
> wait for a timeout for openvpn to realise the other end has died but it
> never happened.
>=20
> Any idea how what's causing these problems and how to make openvpn do
> what I want? That is call the scripts on all client connects and
> disconnects?

I believe 1) and 2) are connected in your case.  I've not poked much at
the source code yet, but I have some similar experiences when working
with my eurephia plug-in.

It's hard to say exactly what's happening without seeing client and
server logs and configs.  But it sounds like you're experiencing a
re-connection scenario.  This isn't necessarily so obvious if you're
using UDP, as this is a stateless connection.  In TCP mode, OpenVPN will
close the connection with the server explicitly, which should trigger
the disconnect script.  However in UDP mode, there's no explicit
disconnection.  So if you reconnect with UDP, it might actually try it's
best to re-establish the previous connection.

If you wait until a connection time-out happens (I believe the default
is 2 minutes, defined by --ping-restart), see if your disconnect script
is called then.

If this is the issue you're hitting, you can try to add
--explict-exit-notify to your client configs if you're using UDP.  You
can also try TCP and see if that changes the behaviour - but of course,
we don't recommend TCP mode if UDP works for you.


--=20
kind regards,

David Sommerseth


------enig2QJERHFALRQOTXCDFQJIO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlHgGDoACgkQDC186MBRfrq1MgCfcoL8O3svvGOkWUE6BZAGHU57
CCIAni6IDSvJehP4KIIxiJ8w4pXWar7s
=eieA
-----END PGP SIGNATURE-----

------enig2QJERHFALRQOTXCDFQJIO--

