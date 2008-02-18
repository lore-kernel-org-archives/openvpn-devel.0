Message-ID: <47B9AE95.7050903@...411...>
Date: Mon, 18 Feb 2008 13:13:09 -0300
From: Giancarlo Razzolini <linux-fan@...411...>
MIME-Version: 1.0
References: <47B9AB97.5040407@...1030...>
In-Reply-To: <47B9AB97.5040407@...1030...>
Content-Type: multipart/signed; micalg=pgp-ripemd160;
	protocol="application/pgp-signature";
	boundary="------------enig56E1EA267E1A06638AC9965B"
Sender: Giancarlo Razzolini <grazzolini@...277...>
Subject: Re: [Openvpn-devel] Needing help with writing an
 easy-to-use	Radius-Plugin for authentication
Reply-To: linux-fan@...411...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Marcus <adesperateuser@...1030...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig56E1EA267E1A06638AC9965B
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Marcus escreveu:
> Hi Folks,
>=20
> since pam doesn't work for me on ubuntu, as already stated on the=20
> user-list, I decided to take a different approach towards=20
> authentication. There is a python module called pyrad=20
> (http://www.wiggy.net/code/pyrad/), which is able to authenticate a user=
=20
> with a username and a password against a radius-server.
>=20
> The goal is to put a line like
> plugin /path/to/my-auth-script.py
> in openvpn-server.conf and take the user + pass which the client=20
> provides via the "auth-user-pass"-Directive in it's client.conf.
>=20
> I already read the README file in the plugin folder of the OpenVPN=20
> source distribution, and also browsed through the plugin.h-file but I'm=20
> not that good in reading header-files.
>=20
> An authentication-script could look something like this:
>=20
>=20
> #!/usr/bin/python
>=20
> import sys
> import socket
> import pyrad.packet
> from pyrad.client import Client
> from pyrad.dictionary import Dictionary
>=20
> args =3D sys.argv[1:] # drop first entry (progpath)
> if len(args) !=3D 2:
>          raise SystemExit("expected two parameters (username and password=
)")
>=20
> srv=3DClient(server=3D"server_ip",
>          secret=3D"some_s3cret",
>          dict=3DDictionary("dictionary"))
>=20
> req=3Dsrv.CreateAuthPacket(code=3Dpyrad.packet.AccessRequest,User_Name=3D=
sys.argv[1])
>=20
> req["User-Password"]=3Dreq.PwCrypt(sys.argv[2])
>=20
>=20
> req["NAS-IP-Address"] =3D "The_Nas_IP"
> req["NAS-Port"] =3D 0
> req["Service-Type"] =3D "Login-User"
> req["NAS-Identifier"] =3D "openvpn"
>=20
> try:
> #       print "Sending authentication request"
>          reply=3Dsrv.SendPacket(req)
> except pyrad.client.Timeout:
>          print "RADIUS server does not reply"
>          sys.exit(1)
> except socket.error, error:
>          print "Network error: " + error[1]
>          sys.exit(1)
>=20
> if reply.code=3D=3Dpyrad.packet.AccessAccept:
>          sys.exit(0)
> else:
>          sys.exit(1)
>=20
>=20
> Can anyone tell me (pretty please with sugar on top) how to put this=20
> together?
> What I don't know yet is:
> 1. What is the script supposed to return? 0 for authenticated and 1 for=20
> not authenticated?
> 2. How are arguments (username/password) passed to the plugin?
> 3. How can I use a python-script instead of a *.so-File or a perl-Script?
>=20
> I hope it's not a big deal to get this set-up running.
>=20
> I recognized, that easy authentication via a MS-IAS-Radius server IS an=20
> issue in the openvpn-community. This solution would be very simple to=20
> set up and I'd document it in the official wiki to share with the world,=
=20
> in return.
>=20
> Best regards, Marcus
>=20
> My client.conf looks like this:
>=20
> client
> dev tun
> proto udp
> remote SOME_IP 1194
> route-method exe
> route-delay 2
> resolv-retry infinite
> nobind
> persist-key
> persist-tun
>=20
> auth-user-pass
> ca keys/ca.crt
>=20
> comp-lzo
> verb 3
>=20
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20
Marcus,

	An openvpn auth plugin, intercepts the
OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY callback, which is internal to
openvpn. So your plugin must be a shared library (.so) program that
"fits" with openvpn. This plugin uses the openvpn_plugin.h C header and,
as i'm aware of, can be written only in C and C++. I do not know any
other openvpn plugin written in other language. I do had written one
myself to make autentication directly from /etc/shadow files, as an
alternative to authenticate with PAM. See http://auth-passwd.sf.net. If
you want to use a .py script, it's much simpler to use the
auth-user-pass-verify that receive a script as argumen. this is script
is given a path to a temporary file that contain the username and the
password priveded by the client, one at a line. This is more insecure
than using a plugin, but for your case it might suit.

My regards,

--=20
Giancarlo Razzolini
Linux User 172199
Red Hat Certified Engineer no:804006389722501
Moleque Sem Conteudo Numero #002
Slackware Current
OpenBSD Stable
Ubuntu 6.10 Edgy Eft
Snike Tecnologia em Inform=E1tica
4386 2A6F FFD4 4D5F 5842  6EA0 7ABE BBAB 9C0E 6B85


--------------enig56E1EA267E1A06638AC9965B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHua6ker67q5wOa4URAynfAJ4pNylQXEMSbUU05XmXIzFXxC3DzgCfX1fx
U4LvFsPvRaGNKeYmCXPC9NY=
=l+Sx
-----END PGP SIGNATURE-----

--------------enig56E1EA267E1A06638AC9965B--

