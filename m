Date: Tue, 4 Dec 2007 09:13:49 +0100
From: Volker Sauer <volker@...1065...>
Message-ID: <20071204081349.GA9568@...1065...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
Subject: [Openvpn-devel] openvpn-auth-pam.so together with pam_access.so
	broken if openvpn	is daemonized
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

here's a strange behaviour of openvpn-auth-pam.so in openvpn-2.0.9-4:

If I run openvpn from the shell without daemonizing it, openvpn-auth-pam.so
works well even with pam_access.so enabled.

My openvpn config contains:
plugin /usr/lib/openvpn/openvpn-auth-pam.so openvpn

/etc/pam.d/openvpn is like this:
# Standard Un*x authentication.
@include common-auth
account  required       pam_access.so
# Standard Un*x account and session
@include common-account
@include common-session
@include common-password

which enabled me to grant or deny access by /etc/security/access.conf:
+:root vsauer:ALL
-:ALL:ALL

As I already said, this perfectly works when openvpn is not daemonized.


*If* openvpn *is* daemonized, I get:

Dec  3 23:58:22 suez ovpn-01-default-dvs1_bridging-port_53[1421]:
130.83.208.238:32771 PLUGIN_CALL: PRE type=3DPLUGIN_AUTH_USER_PASS_VERIFY

Dec  3 23:58:22 suez ovpn-01-default-dvs1_bridging-port_53[1421]:
130.83.208.238:32771 ARGV[0] =3D '/usr/lib/openvpn/openvpn-auth-pam.so'

Dec  3 23:58:22 suez ovpn-01-default-dvs1_bridging-port_53[1421]:
130.83.208.238:32771 ENVP[0] =3D 'untrusted_port=3D32771'

Dec  3 23:58:22 suez ovpn-01-default-dvs1_bridging-port_53[1421]:
130.83.208.238:32771 ENVP[1] =3D 'untrusted_ip=3D130.83.208.238'

Dec  3 23:58:22 suez ovpn-01-default-dvs1_bridging-port_53[1421]:
130.83.208.238:32771 ENVP[2] =3D 'password=3DXXXXXXXXXXX'

Dec  3 23:58:22 suez ovpn-01-default-dvs1_bridging-port_53[1421]:
130.83.208.238:32771 NOTE: --mute triggered...

Dec  3 23:58:23 suez ovpn-01-default-dvs1_bridging-port_53[1421]:
130.83.208.238:32771 11 variation(s) on previous 5 message(s) suppressed
by --mute

Dec  3 23:58:23 suez ovpn-01-default-dvs1_bridging-port_53[1421]:
130.83.208.238:32771 PLUGIN_CALL: POST
/usr/lib/openvpn/openvpn-auth-pam.so/PLUGIN_AUTH_USER_PASS_VERIFY
status=3D1

Dec  3 23:58:23 suez ovpn-01-default-dvs1_bridging-port_53[1421]:
130.83.208.238:32771 PLUGIN_CALL: plugin function
PLUGIN_AUTH_USER_PASS_VERIFY failed with status 1:
/usr/lib/openvpn/openvpn-auth-pam.so

Dec  3 23:58:23 suez ovpn-01-default-dvs1_bridging-port_53[1421]:
130.83.208.238:32771 TLS Auth Error: Auth Username/Password verification
failed for peer


Removing "account  required       pam_access.so" from /etc/pam.d/openvpn
solves the problem, but disables me to limit access to certain
nis-groups, which is not good.=20

I looked into the source code of openvpn-auth-pam.so and I see, that
there's a method=20

static void daemonize (const char *envp[])

which seems to be called when openvpn is daemonized. But I don't
understand it.

Maybe someone could give me a hint what's going on here?

Regards
Volker

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHVQw9fjVOTV3V0OARAgRkAKCg6EVQn3ejGDzjBfl9DVIlp7oJjgCePoLr
IL0zYDtqk6UFLoYlo0CRI9g=
=4WLi
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--

