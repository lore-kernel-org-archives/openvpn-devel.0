From: "Brane F. =?utf-8?q?Gra=C4=8Dnar?=" <bfg@...1012...>
Date: Fri, 30 Mar 2007 00:55:10 +0200
MIME-Version: 1.0
Message-Id: <200703300055.10951.bfg@...1012...>
Subject: [Openvpn-devel] ADDON: openvpn authentication server,
	LDAP-aware --client-connect script
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net, OpenVPN ML <openvpn-users@lists.sourceforge.net>

Hello there :)

I've been frustrated about additional authentication options of OpenVPN=20
server, so i wrote authentication server, which provides very flexible=20
authentication. I also wrote authentication client, which connects to=20
authentication server (via unix domain socket or tcp/ip) and verifies user=
=20
credentials on authentication server. This authentication client can be use=
d=20
as --auth-user-pass-verify argument of openvpn server.

I also wanted to completely manage my vpn client accounts using LDAP=20
directory, therefore i also wrote perl script, which can be used=20
as --client-connect script for openvpn server to configure vpn clients at=20
connect time, or can be used to dump client configuration to --ccd-dir.

I also wrote openldap schema extension to simplify account management.=20
However, openvpnClientConnectLDAP.pl is not limited to specified schema,=20
becouse you can also use your own schema if you want. Provided schema alows=
=20
you to set all openvpn configuration parameters that can be pushed to vpn=20
client (~ 20)...

... and last... Becouse you want to manage your ldap server over web browse=
r i=20
also created vpn account template for phpldapadmin and small patch for it t=
o=20
make the magic work. Patch applies against version 1.0.2.

Software is available as single package on my website:

http://frost.ath.cx/software/openvpn_auth/

--- snip ---
OpenVPN authentication server/client features

    * Very flexible authentication configuration
    * Chainable authentication backends. You can mix several authentication=
=20
backends
    * Authentication server written in perl
    * Authentication server can run completely in chroot (recommended)
    * Authentication client written in C
    * Authentication client can run completely in chroot if OpenVPN server =
is=20
chrooted
    * Supports almost all existing authentication backends.
    * Supported authentication backends:
          o LDAP
          o Kerberos5 (works also with Microsoft AD)
          o any SQL database supported by perl DBI driver
          o IMAPv4 server
          o POP3 server
          o plain file
          o SASL library
          o PAM library
          o Radius service
          o custom certificate validation algorithm.

openvpnClientConnectLDAP features

    * Can be run as --client-connect script
    * Can be run as batch job to create per-client configuration files=20
in --ccd-dir
    * Comes with it's own LDAP schema extension
    * Supports all options which can be pushed to client (21)
    * Supports TLS/SSL, SASL auth

--- snip ---

Testimonials (authentication server):
	- openvpn 2.0.9 (linux, 32bit) :: chrooted both openvpn and openvpn_authd
	- openvpn 2.1-rc1 (linux, 64bit) :: chrooted both openvpn and openvpn_authd
	- authenticating against microsoft 2003 AD (Krb5), openldap using TLS/SSL

Testimonials (client connect script):
	- openvpn 2.0.9 (linux, 32bit)
	- openvpn 2.1-rc1 (linux, 64bit)


Software has been tested with 32 and 64bit version of Openvpn (2.0.9 and=20
2.1-rc1).

Anyone is welcome to try this software. Ofcourse any contributors (especial=
ly=20
documentation) are welcome!

Please send me feedback :)


Best regards, Brane

--=20
Brane F. Gra=C4=8Dnar
Sistemski administrator za UNIX okolje
Interseek d.o.o., Stegne 31, SI-1000 Ljubljana
e-mail > bfg@...1012...
www.interseek.si, www.najdi.si

