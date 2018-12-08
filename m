From: David Sommerseth <openvpn@...2080...>
Message-ID: <c1c90dfe-c6b6-3304-3c1b-703bbdc54133@...2080...>
Date: Sat, 8 Dec 2018 04:03:26 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="DjWokQOBlQvl4xCatsEb4lWQQgzo5Oxw9"
Subject: [Openvpn-devel] Release of OpenVPN 3 Linux v1 (Beta)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, OpenVPN Users <Openvpn-users@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DjWokQOBlQvl4xCatsEb4lWQQgzo5Oxw9
Content-Type: multipart/mixed; boundary="UoSb1gZvFqvAABsYzmM67ec8KHapxY4Nj";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>,
 OpenVPN Users <Openvpn-users@lists.sourceforge.net>
Message-ID: <c1c90dfe-c6b6-3304-3c1b-703bbdc54133@...2080...>
Subject: Release of OpenVPN 3 Linux v1 (Beta)

--UoSb1gZvFqvAABsYzmM67ec8KHapxY4Nj
Content-Type: multipart/mixed;
 boundary="------------E415C88ACA4EFA9B7B15D60C"
Content-Language: en-GB

This is a multi-part message in MIME format.
--------------E415C88ACA4EFA9B7B15D60C
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


OpenVPN 3 Linux v1 (beta) release
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D

The first beta release of the new OpenVPN 3 Linux client is now available.
This is release is considered reasonably stable and is suitable for daily
usage by people willing to test new cutting edge software.

The OpenVPN 3 Linux client is a very different way of interfacing with
VPN tunnels than the previous OpenVPN 2.x releases, where privilege
separation and runtime security is tightened a lot more.  This is done
by building on the capabilities D-Bus provides.  The result is that
unprivileged end-users are capable of starting and managing their own
VPN connections and sessions without needing any additional privileges.

This is also the first release to provide a new API (over D-Bus) used to
create, configure and manage TUN devices, including DNS configuration.
This new interface has been modelled after the Android VPN API.

What is really the biggest change is the handling of DNS configurations.
Currently, the DNS handling is done by taking control over /etc/resolv.conf
directly; similar to what the update-resolv-conf approach OpenVPN 2 needs
to use.  But the difference is that this works out-of-the-box with the
default install.  In coming releases we will extend this to support
more backends for DNS configuration, such as systemd-resolved and similar.
Unfortunately, currently NetworkManager does not provide an external API
for doing similar approaches.

Another big difference is the provided Python 3 module for OpenVPN 3.  This
is a reference implementation of how to write your own tooling in Python
to manage VPN configurations as well as starting and managing VPN sessions.
Since this builds on the D-Bus API enabled in OpenVPN 3 Linux, this is not
restricted to Python itself, but the Python implementation can be
considered a reasonable study case for other platforms supporting D-Bus.

Finally, this OpenVPN 3 Core library provided in this release very recently
been extended with tls-crypt-v2 support, which can be tested against
OpenVPN 2 git master branch builds, which contains the coming v2.5 release.

The OpenVPN 3 Linux release needs to be heavily tested.  But there are some
features which are not available in OpenVPN 3 in general.  There are no TAP
device support planned, further features like --fragment is unsupported.
Other missing features are the script hooks and plug-in interface (which
can use the D-Bus interface to trigger external events).

In general, if your existing VPN client configuration works with OpenVPN
Connect or OpenVPN for Android with the OpenVPN 3 backend enabled, then it
will work with the Linux client.


Source code
-----------
- Source package:
<https://swupdate.openvpn.net/community/releases/openvpn3-linux-1_beta.tar.=
xz>
- PGP signature:
<https://swupdate.openvpn.net/community/releases/openvpn3-linux-1_beta.tar.=
xz.asc>

- GitLab: <https://gitlab.com/openvpn/openvpn3-linux>
- GitHub: <https://github.com/OpenVPN/openvpn3-linux>


Binary packages
---------------
Fedora 28, 29 and EPEL:
<https://copr.fedorainfracloud.org/coprs/dsommers/openvpn3/>
The Fedora EPEL repository provides packages for Red Hat Enterprise Linux 7
which also works on CentOS 7 and Scientific Linux 7.

Debian and Ubuntu packages are in the pipe and we will announce their
availability as soon as they are ready.


Known issues
------------

- man-pages are far from completed.  Currently man-pages for openvpn2 and
  openvpn3-autoload are generated as well as a brief overview of the
  openvpn3 front-end.  But this will be improved with time.

- mbed TLS v2.7.0 or newer is required
  Quite recently the OpenVPN 3 Core library added a fix to avoid using
  a deprecated function.  It was not noticed at that point that this
  change would break the building of OpenVPN 3 on Debian 9 or similar
  distributions which ships an older mbed TLS library.
  Current workaround is to apply the attached patch, which will restore
  the old API present in older mbed TLS versions.

  To apply the attached patch:

    $ tar xvJf openvpn3-linux-1_beta.tar.xz
    $ cd openvpn3-linux-1_beta
    $ patch -p1 < /path/to/fix-openvpn3-linux-mbedtls-older-than-2.7.patch

  Then follow the build instructions in the README.md file.

- Lacking OpenSSL build support.  In a coming release, the OpenSSL library
  will be replacing the current mbed TLS library as the default.  But
  it will be possible to build with both of them.

- Read the README.md file carefully when building OpenVPN 3 Linux yourself.
  One important detail which might make things simpler for you, is to
  ensure the 'openvpn' user and group accounts are created before you
  start building and in particular run 'make install'.

- On Debian and Ubuntu, the OpenVPN 3 Python library is installed in
  the wrong directory.  Most distributions use
  /usr/lib/python3.Y/site-packages, while Debian 9 uses just
  /usr/lib/python3.Y.  Quick workaround is to just install a symlink:

     # cd /usr/lib/python3.X && ln -sf site-packages/openvpn3

  The Python module must be functional for the 'openvpn2' and
  'openvpn3-autoload' tools can work.

- *Some* systems *might* not reload the D-Bus policy as quickly as expected.
  Sometimes it works better when forcing the dbus-daemon to reload its
  configuration.  This can be done via: systemctl reload dbus
  (Do _NOT_ attempt to _restart_ dbus-daemon on a running system, it
  might make your system misbehave afterwards)


--=20
kind regards,

David Sommerseth
OpenVPN Inc


--------------E415C88ACA4EFA9B7B15D60C
Content-Type: text/x-patch;
 name="fix-openvpn3-linux-mbedtls-older-than-2.7.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="fix-openvpn3-linux-mbedtls-older-than-2.7.patch"

--- a/openvpn3-core/openvpn/mbedtls/ssl/sslctx.hpp.orig	2018-12-07 23:35:=
14.288411887 +0100
+++ b/openvpn3-core/openvpn/mbedtls/ssl/sslctx.hpp	2018-12-07 23:35:27.64=
8043080 +0100
@@ -1224,11 +1224,7 @@
 	    {
 	      const int SHA_DIGEST_LEN =3D 20;
 	      static_assert(sizeof(AuthCert::issuer_fp) =3D=3D SHA_DIGEST_LEN, =
"size inconsistency");
-	      if(mbedtls_sha1_ret(cert->raw.p, cert->raw.len, ssl->authcert->is=
suer_fp))
-		{
-		  OPENVPN_LOG_SSL("VERIFY FAIL -- SHA1 calculation failed.");
-		  fail =3D true;
-		}
+	      mbedtls_sha1(cert->raw.p, cert->raw.len, ssl->authcert->issuer_fp=
);
 	    }
 	}
       else if (depth =3D=3D 0) // leaf-cert

--------------E415C88ACA4EFA9B7B15D60C--

--UoSb1gZvFqvAABsYzmM67ec8KHapxY4Nj--

--DjWokQOBlQvl4xCatsEb4lWQQgzo5Oxw9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJcCzR+AAoJEIbPlEyWcf3yKnQQALeVWX9epYhG4G/IBqFy83tS
hc1863sA2hHHUC2tdiSHb+oRqmUvnmP5+NvMM1ycogoBfOOnGoLopxYYKwJgCHZ5
wlz9bsvCiFSbA9UwbEC93NVvdCKM5znpH8ZYHIGcosUNjAgDi4RLnDuwqSZDdeeW
CPZDjFtmx8Z0yrtMIlQDHQZ2cEfSKnpDOGMtJsUUt66VKabSWFgzFATTwQwVTVyp
6v4FTRn0mTMjN0ILlEsbC2unBaJUoCM5LjwVszyDJ25IOMXjq/lQ7WEmUflyHWx5
LJkZZ9YZhZhx0yAoqnnGJXm/JGe+ScLpl5kqmietvIsV6Ae7+ng/vAt+/CsNWWDw
PFelt5ZsR2D4rglyy0mL0g8afkJ0LK+/03MBYOPu4r37CD6O2GV0WdO9wNskOXOW
Ugu+z7h/u1n9YoGWOjL7ro1bOqM8QBGQ58c4IiDvyRBWhmGdLd6dONLkOsv/wePx
2S0P6yrzYlQ5wBta0oM84eLnOT2I5fT3+Jw2va83nq2xYJrd11t7gEiEqUp2RUWe
IdlCU5m1hi3G+di4SdbSG6UZLXwVMbOhhnIMTAwt2Q7Y1BOXc4q7vUOlUu+HDZPo
XSrlxNcKaBh7euPiUSz1pge8CSB6gSneeuOBqYl0gdFVhzHyRyapdTMSfoQpOoD1
RQxGvrMDTVmrDM4y2DrN
=8Gv2
-----END PGP SIGNATURE-----

--DjWokQOBlQvl4xCatsEb4lWQQgzo5Oxw9--

