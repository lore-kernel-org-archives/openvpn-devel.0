Date: Sat, 30 Sep 2017 19:28:59 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170930172859.GY70062@...1296...>
References: <1b275182-8551-6100-e3e9-80c966c2b200@...277...>
 <c2fbb372-cbfe-5231-66fa-33403a1566df@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="8bbyobZNN6im4lYw"
Content-Disposition: inline
In-Reply-To: <c2fbb372-cbfe-5231-66fa-33403a1566df@...277...>
Subject: Re: [Openvpn-devel] Too much output at --verb 0 (bug?)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: fragmentux <fragmentux@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--8bbyobZNN6im4lYw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Sep 28, 2017 at 01:18:20PM +0100, fragmentux wrote:
>=20

Could you please fix your mail client settings so that it writes a proper
name here?

> On 27/09/17 15:57, fragmentux wrote:
> > not sure if this really counts as a bug but ..
> >=20
> > according to the manual --verb 0 =3D "No output except fatal errors"
> >=20
> > This, however, is the output at --verb 0 (2.4.4)
> >=20
> > =3D=3D Start client:
> > Option 'explicit-exit-notify' in [PUSH-OPTIONS]:3 is ignored by previou=
s=20
> > <connection> blocks
> > Option 'explicit-exit-notify' in [PUSH-OPTIONS]:9 is ignored by previou=
s=20
> > <connection> blocks

These two have been taken care of just now ("why is your server pushing=20
it twice?"), but anyway.

> > do_ifconfig, tt->did_ifconfig_ipv6_setup=3D0

This one comes as a bit of surprise - it's logged with M_DEBUG, and I
assumed that this would be something like "verb 3 or 4, or even higher".

Selva, Steffan, or someone else who understands our message levels -=20
what's M_DEBUG for, and what *should* I have used here?

> > WARNING: this configuration may cache passwords in memory -- use the=20
> > auth-nocache option to prevent this
> >=20
> > =3D=3D Reconnect client:
> > WARNING: 'link-mtu' is used inconsistently, local=3D'link-mtu 1550',=20
> > remote=3D'link-mtu 1602'
> > WARNING: 'cipher' is used inconsistently, local=3D'cipher AES-256-GCM',=
=20
> > remote=3D'cipher AES-256-CBC'
> > WARNING: 'auth' is used inconsistently, local=3D'auth [null-digest]',=20
> > remote=3D'auth SHA512'
[..]
> > None of these are Fatal errors ..

Indeed, WARNINGs could also be re-evaluated.  Either we document that
"verb 0" will print errors *and* warnings, or we change the printout
to not print warnings.


Personally, I wouldn't ever run any software with "--verb 0".  I want
to be able to check the log and see "oh, it reconnected tonight at
4:30, so something must have been funny with the network or the server".

Whether I'd use --verb 2 or 4 depends on, indeed, disk space, remote logging
capabilities, unattended operation, and so on.  My servers typically run
with syslog, --verb 4, and logrotate, which takes care of everything.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--8bbyobZNN6im4lYw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZz9RbAAoJEB2Cnv7KVigSTJQL/1XyAuVecBm/Ta8vehjANlA6
KDmQdVOg+0q/aOEYvhxzMYOjz+4hHHkwFWlqQFCGD6u28TN6ABJYfQA1D8ImSyGb
8rTlnZba7eghhdxSo1VjH5NvKtjD5EEA+zbE9e0p+dOKbaXcHllu2rYehxVT1f1J
r+SmHhFPYDYTXDlUetRW+cWDB7yH2eUrpqDdhMPjPbisUOjVEOmH6M4ayxlkYztB
ihaGDmyMKQt8CBqouf8qTA7orwKwnP1tPsGpYW1+tHWDIBhACp5YJhg89gB7t/3I
DzTpvfGUKq0EBqmBxbx9ljSJMUZ6cwx321M3zSYXI3mb7DLSR/L7QSgmnd0PRFEI
ko1sCexMQSJx4Xa1SzC/ORNRw1qwXxjFBRQVHJdK4oqmTRTOXAGR/EcdJUH+hFky
XC94zMMYcznUFAzW6iwOMubbqt0hXDs3bguEEu4SmthlExKvWFdVlwTq5cxG0s2A
4Y9nJciPI1XTFYF5KkV6tx6AdUMDj2YwDvSgGDrgKg==
=mQCZ
-----END PGP SIGNATURE-----

--8bbyobZNN6im4lYw--

