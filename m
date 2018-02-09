Reply-To: openvpn-devel@lists.sourceforge.net
From: David Sommerseth <openvpn@...2080...>
Message-ID: <a181790c-4385-4062-62b4-2658e4539c76@...2080...>
Date: Fri, 9 Feb 2018 19:52:49 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="dDab5wkhdKbFpWR8yaPW6pEfL5BgVed3y"
Subject: [Openvpn-devel] Test builds of OpenVPN 3 Linux client (Fedora/EPEL)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dDab5wkhdKbFpWR8yaPW6pEfL5BgVed3y
Content-Type: multipart/mixed; boundary="DOjecHsNtPOmZDGoedxhrpjOXwwAJapbg";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <a181790c-4385-4062-62b4-2658e4539c76@...2080...>
Subject: Test builds of OpenVPN 3 Linux client (Fedora/EPEL)

--DOjecHsNtPOmZDGoedxhrpjOXwwAJapbg
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Hi,

I've just recently prepared a Copr build of the new OpenVPN 3 Linux client,
which provides pre-built binaries for Fedora 26, 27 and EPEL-7 (RHEL/CentOS=
).

To get started quickly, ensure you have the copr plugin for yum/dnf install=
ed.
 Then do:

   # {yum,dnf} copr enable dsommers/openvpn3
   # {yum,dnf} install openvpn3-client

If you do not have a copr plug-in available, you can download the .repo file
from here: <https://copr.fedorainfracloud.org/coprs/dsommers/openvpn3/>

Once installed, you will have access to both the openvpn2 and openvpn3 comm=
and
line front-ends to this new client.

A few words of caution though:

 * This is bleeding edge code, still under heavy development.  It is far fr=
om
   perfect, still lacks features and there will be bugs here and there.

 * This new client does not look like the more commonly used OpenVPN 2.x
   clients.  It is different in almost every way.  The closest you will get=
 to
   the more common OpenVPN 2.x, is via the openvpn2 command line interface.

 * It is built with the OpenVPN 3 Core library, which is essentially protoc=
ol
   compatible with OpenVPN 2 servers.  But it does lack some features.  If
   your VPN connection works with the official OpenVPN Connect clients on
   Android or iOS, chances are that it will work just fine with this new
   client too.

 * Options, arguments, etc used by openvpn3 is not set in stone yet.  They =
may
   change.

 * And, this is a pure _VPN_ _client_ _only_ currently.  Sorry, no server
   support yet.


To quickly get started.

 - Logging: Start this in a separate terminal
     $ /usr/libexec/openvpn3-linux/openvpn3-service-logger \
		--timestamp --session-manager --vpn-backend

 - Start a VPN tunnel:

     $ openvpn2 --config $CFGFILE [--daemon]
     $ openvpn3 session-start --config $CFGFILE

   (openvpn2 is capable of parsing PKCS12 files, openvpn3 is not)

 - More fine grained tunnel management:
     $ openvpn3 config-import --config $CFGFILE
     $ openvpn3 configs-list
     $ openvpn3 session-start --config-path $CFG_PATH
       ($CFG_PATH can be found with configs-list)
     $ openvpn3 sessions-list

   And see also:
     $ openvpn3 session-manage --help
     $ openvpn3 session-stats --path ${SESSION_PATH}
     $ openvpn3 log --session-path ${SESSION_PATH}
     $ openvpn3 help

 - Ensure you have bash-completion installed, then tab-completion will work
   for most of the options and arguments in openvpn3.

And yes, you can do all this as an unprivileged user.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--DOjecHsNtPOmZDGoedxhrpjOXwwAJapbg--

--dDab5wkhdKbFpWR8yaPW6pEfL5BgVed3y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJafe4BAAoJEIbPlEyWcf3yzvsQAKSeCnjNVCC9itlD3rmAqGgN
lmKUXrmcDTY7XX5BsyY8cgCpEoIA3IhqbM5DeDHmHjkjsOeciwiWHCsmzHDEn9u4
YIlSGoovZKC683xd/DJaPiW9bzZcc97bc40CRN29zmt24y1Dmp+TOSPCn633nTPp
+PIQwZAFB+o2SHmNwBpIspw7XWymNpupfjHC+88NRVaAJ9lW3m2UTI53nnvXBB33
vF+zUyy2zQKJ4ANNveQyRwgmjtRFz4zF/hkqO1UA1d+aSMk/nxeU/GbuaddtFA4t
518s8MqBH1+Xdzi2i03ziL9eofw6i9xyfeBDprTy7qcZ/KGnevZ1s1q/1lZgdY23
G3tUrPAHjfEmeS2WSk6dyMa6u0mzi3uXzf+/LIhAT3F3zxnI3J2CgknmxfPEXOx2
3Z2f0HNdvQ6UQvANK4J/L8bUQy/+LzhcMj7szgLDbIQG5YHzq0TBEGUTDq09L+4n
j9ini97ozkcs5kIq3hanF+WSmsqTZZwkrLlWrTklR4M+J03ZOnh5CRu1KbaMPsBN
VpKoJC6ykszl+ET77FJqrNTd6yO5weWw16lowz62UvEj1ik6sRMgiTadfc8hZBFK
1e03P4Hd00pD7KDkR9QdwnWQJ/OHdHxR9VY8ixXT8HqUgKkS1E43/yIbHOO5KyEE
tBA1/KnV7wpoDdscR1Ek
=1EIp
-----END PGP SIGNATURE-----

--dDab5wkhdKbFpWR8yaPW6pEfL5BgVed3y--

