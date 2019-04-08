From: David Sommerseth <openvpn@...2080...>
Message-ID: <e377e65f-bdce-54d2-45f2-5280156ff40d@...2080...>
Date: Mon, 8 Apr 2019 22:14:54 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Nd3NmicO120WjJJNBssUaLN6RwmBOTen8"
Subject: [Openvpn-devel] OpenVPN 3 Linux client - v5 beta released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Nd3NmicO120WjJJNBssUaLN6RwmBOTen8
Content-Type: multipart/mixed; boundary="vD1dt263InSs4JbBBldpheEM5benBubvP";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>,
 "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>
Message-ID: <e377e65f-bdce-54d2-45f2-5280156ff40d@...2080...>
Subject: OpenVPN 3 Linux client - v5 beta released

--vD1dt263InSs4JbBBldpheEM5benBubvP
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Hi,

The OpenVPN 3 Linux v5 beta release has just been made available.  This is
available in our git repositories [0] and URLs for source tarballs are list=
ed
later in this e-mail.  RPM binaries for Fedora and RHEL/CentOS/Scientific
Linux [1] completed the build process quite recently too.  Debian and Ubuntu
packages will come in releases just need a few rounds of internal testing a=
nd
we will hopefully be able to release them soon too.

The highlights of this release includes:

 # Built against OpenSSL by default
   The previous release allowed to build against OpenSSL 1.0 by switching to
   this explicitly at compile time, keeping mbed TLS as the default.  We ha=
ve
   now flipped this around, so OpenSSL is the new default and mbed TLS is t=
he
   alternative.

 # Improved configurations without client certificate
   Previous releases required a configuration override to be set to allow
   configuration profiles not containing any client certificates.  The
   configuration processing will now automatically detect this scenario and
   ensure the configuration is processed accordingly when starting the VPN
   session.  This change also removes the override feature.

 # Network Configuration service could complain about a missing backup file
   When the Network Configuration service did *not* modify the DNS resolver
   settings on the system, it would often complain about missing backup file
   when disconnecting.  This is something it should not complain about, as
   there is no backup to restore as nothing did change in this case.  This
   has been corrected.

 # Network Configuration service could restore the DNS settings too early
   If running multiple VPN sessions where one or more sessions would modify
   the DNS resolver settings, it could occasionally restore the settings ba=
ck
   to the state before the first VPN session had started when disconnecting
   one of more running VPN sessions.  This was due to a reference counter n=
ot
   being initialized correctly.  This has been fixed and the DNS resolver
   settings are now restored correctly.

 # openvpn2 command line interface improvements
   The openvpn2 command line program is an OpenVPN 2.x "look-alike" interfa=
ce
   for openvpn3-linux.  This has been extended to work better with a few mo=
re
   VPN configuration profiles which where reported as dysfunctional.

 # The openvpn3 Python module gained support for LookupConfigName()
   Both the Configuration Manager and the Session Manager supports a D-Bus
   method for looking up configuration or session objects based on a
   configuration profile name.  The support for these methods was missing in
   the openvpn3 Python module, but is now implemented.

 # Improve OpenVPN 3 Core Library version reporting
   The openvpn3-linux client will normally attempt to report back the versi=
on
   of the Core Library it is built against.  This did however not work
   properly when building out of the tar.xz tarballs.  This has been fixed =
and
   the Core Library will now always report an accurate version reference.

 # autoconf portability warnings fixed
   When building from the git tree, autoreconf would complain about
   portability issues related to the openvpn3-linux using a few GNU
   extensions.  This is not something we currently have a big concern about,
   so these warnings have been muted.

In addition there are several minor improvements and bug fixes.


OpenVPN 3 Linux is with this release beginning to be ready for prime-time
production.  We will have a few more beta releases, extending the command
line interfaces with a few more administration features and similar.  Once
we feel the client is feature complete in this round, we will move over to
"release candidate" releases.

If you are using openvpn3-linux, please report back if there are issues you
have or improvements you feel is important for the stable release.  We do
know there are several users deploying openvpn3-linux already, and some
have provided valuable feedback which has been=20


* Quick-start with OpenVPN 3 Linux once it has been installed

  $ openvpn2 --config my-vpn-config.conf --verb 6

This will start a VPN configuration profile with the most verbose logging. =
 If
the configuration does not contain --daemon, all logging will also be prese=
nt
in the console and the tunnel will be torn down with a simple CTRL-C.
Otherwise the VPN session will be running in the background and you get your
command prompt back again, and you need to manage this session using
`openvpn3 session-manage --config my-vpn-config.conf`

For more information see the various man-pages available [2].


* Install Fedora Copr packages for Fedora, RHEL, CentOS and Scientific Linux

Ensure you have the yum-plugin-copr or dnf copr plugin installed.  For
RHEL/CentOS/Scientific Linux you will also need to have the Fedora EPEL
repository enabled [3].  Then run the following commands:

For yum users:

   $ yum copr enable dsommers/openvpn3
   $ yum install openvpn3-client

or for dnf users:

   $ dnf copr enable dsommers/openvpn3
   $ dnf install openvpn3-client



[0] <https://gitlab.com/openvpn/openvpn3-linux>
    <https://github.com/OpenVPN/openvpn3-linux>

[1] <https://copr.fedorainfracloud.org/coprs/dsommers/openvpn3/>
[2] <https://github.com/OpenVPN/openvpn3-linux/tree/master/docs/man/>
[3] <https://fedoraproject.org/wiki/EPEL>


---- Source tarballs ----------------------------------------------------
* OpenVPN 3 Linux v5 beta

  <https://swupdate.openvpn.net/community/releases/openvpn3-linux-5_beta.ta=
r.xz>
  <https://swupdate.openvpn.net/community/releases/openvpn3-linux-5_beta.ta=
r.xz.asc>

---- SHA 256 Checksums --------------------------------------------------
8e7fae354f127b007ee2a7ddddb4c08aa9db5b2be34bc3dec514d63b4f60c866  openvpn3-=
linux-5_beta.tar.xz
d054401d90131eab662be0c62358860e94a6a0c7da0222b37aedab7e894365df  openvpn3-=
linux-5_beta.tar.xz.asc

---- git references -----------------------------------------------------
git tag: v5_beta
git commit: 16dd2acdf3343e6180e005a229dbd4bd40c9f644

---- Changes from v4 to v5 ----------------------------------------------
Arne Schwabe (2):
      Rename bash completion script
      build: Allow configure.ac also to work with submodules and out of dir=
 git repos

David Sommerseth (23):
      build: Provide an accurate OpenVPN 3 Core Library version
      build: Fix make VPATH builds
      build: Clean up autoconf warnings
      docs: Update openvpn3-config-import man page
      docs: Fix incorrect indenting on command lines
      docs: Add man page and D-Bus API references to README.md
      docs: Rearranged README.md, moving front-ends higher up
      docs: Add missing single-quotes on some binaries
      build: Switch to build with OpenSSL by default
      dbus/proxy: Treat internal ACL denials similar to D-Bus denials
      python: Add LookupConfigName method to SessionManager
      python: Extended ConfigurationManager with LookupConfigName method
      python: Added simple unit test for watching StatusChange signals
      python: Add more OpenVPN 2 options to the ignore list
      client: Auto-detect if client certificate is present
      netcfg: Fix unexpected DNS resolver setup restore
      netcfg: Don't try to restore DNS without active backup
      vendor: Update ASIO to 1.13.0
      Update OpenVPN 3 Core Library
      client: Remove unused private variable
      client: Fix missing override tags to some Log methods
      tests: Fix incorrecty variable type in syslog-facility-mapping test
      docs: Update README.md with proper Deb/Ubu OpenSSL packages

-------------------------------------------------------------------------


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--vD1dt263InSs4JbBBldpheEM5benBubvP--

--Nd3NmicO120WjJJNBssUaLN6RwmBOTen8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJcq6vGAAoJEIbPlEyWcf3yLpwQAKPqhjj/u8nffb54Q4oZ9ood
biQ2kwa9c2I7QYkj+qTBU9y/fFOVkDRE0wutm/QjOgNujDLMjyCOvzU+6dCK9h8A
75WZPdfOpfaJpkSMy/pRPyQd8RtNnQxpUB5i3gwpWfvxa4oW07WBFrOp0VfX2UDS
fAEunYPPLzwm0vjhVxGZ1KoNXgfm2GL9/PpD3jdPecs75Gm9MDJJHLqI9wwQt09C
S0FVb2hnnVO3FDXH94J1MyX0NCqM7bjC2gs0c3cuCAF05zwzAbM/LZHLzMXyAfO+
MZevAlNv13kN+qTphcdc5nfU5R51zQt78GSqdirWxJfyZDZNp5CG8goKXXZgCyV6
oTRsDxq/nJNOUAOC69sPaWy+0YslLHYR1y10mW+cW/jQMf7D2GhDMT/cjaZJxcDn
RrvJA44/G9tYfdt5VpXKyCOxt8PIw13RSY6kBHrKTdbag83FFTHiBEKy6owAvJ1u
CuFoVFg6WixmTR/VVy9ybMIsNjpIHmBkAZXa7szcY9cngJfNeLNHsT2By8WEIYTE
lR11vRaShmIJGRbjXMq1jnxKkJzCiw43wUdCkUiARJp+N0xsOmB4xUUGdG+EaFPU
msko84JN6MT/bNezp4mlHoYE5uGzWv+67sk0OdlJZfw10mF+dPRxyHpGtiv4KUCj
MDBt88A+7UryPcjWLR8n
=1nBI
-----END PGP SIGNATURE-----

--Nd3NmicO120WjJJNBssUaLN6RwmBOTen8--

