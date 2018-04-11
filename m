Reply-To: openvpn-devel@lists.sourceforge.net
References: <20180401131615.12567-1-a@...2181...>
 <e3d48a12-7f25-1ec0-ad7a-52c1330f43c0@...2181...>
 <20180411091542.39c8c01d@...1799...>
 <5299586c-24cb-d2ff-c12d-404b4a139377@...2181...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <e3d20075-a97e-d968-ab1b-5915e8e85e53@...2080...>
Date: Wed, 11 Apr 2018 13:50:09 +0200
MIME-Version: 1.0
In-Reply-To: <5299586c-24cb-d2ff-c12d-404b4a139377@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="rHK36YIutf3YelcxeH14l1CDl8zIeb5ot"
Subject: Re: [Openvpn-devel] [RFC 0/4] add netlink support for Linux: update
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, Christian Hesse <list@...1798...>
Cc: David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rHK36YIutf3YelcxeH14l1CDl8zIeb5ot
Content-Type: multipart/mixed; boundary="tPs9SzkyYLamiRXMOAfHfaKrpHpGNw5s4";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Antonio Quartulli <a@...2181...>, Christian Hesse <list@...1798...>
Cc: David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net
Message-ID: <e3d20075-a97e-d968-ab1b-5915e8e85e53@...2080...>
Subject: Re: [Openvpn-devel] [RFC 0/4] add netlink support for Linux: update
References: <20180401131615.12567-1-a@...2181...>
 <e3d48a12-7f25-1ec0-ad7a-52c1330f43c0@...2181...>
 <20180411091542.39c8c01d@...1799...>
 <5299586c-24cb-d2ff-c12d-404b4a139377@...2181...>
In-Reply-To: <5299586c-24cb-d2ff-c12d-404b4a139377@...2181...>

--tPs9SzkyYLamiRXMOAfHfaKrpHpGNw5s4
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 11/04/18 09:43, Antonio Quartulli wrote:
>=20
>> This kicks into the discussion we had about supporting newer systemd fea=
tures
>> selectively... Shipping different static files for distributions and/or
>> systemd versions duplicates the number of files.
>
> I am not into systemd, therefore I am not able to comment on the
> strategy we need to adopt.
>=20
> However, what I imagine is that each distribution, when deciding what
> library to use (sitnl vs iproute2), will also decide which of the
> provided unit files to ship (if we have multiple precompiled files).
> Or our Makefile should generate the right ones based on the
> --enable-iproute2 switch (maybe this is what you meant with templates?).

Systemd is developing quite fast, and is consistently improving on the
security side - with more and more interesting lock-down features, most whi=
ch
can be automated if enabled correctly in the unit files.  But newer features
may not work so well on older systemd releases.

So this is actually a two-fold challenge

- How to figure out which features systemd supports?  We can here presume t=
he
  host building the package runs the systemd version OpenVPN needs to
  integrate against.

- How to output/generate unit files which are consistent with the available
  features?

We will most likely need some kind of template solution to achieve this.  T=
he
template approach used with Makefile.am/Makefile.in is too limited for our
need - that's essentially just a wrapped in sed, which replaces defined
variables with something else.

There's plenty of other alternatives as well.  But that can easily mean
increasing the build time dependencies.  I'm not convinced that is the right
approach for this need.

I've been pondering on what would be the best approach ... using plain bash
with friends (awk, sed, etc), using Python (lots of template engine
alternatives, some are built-in) or even possibilities with XML+XSLT.  All =
of
these required tools for either approach are mostly available by default on
most Liux distributions.  Since systemd is Linux only, that's the base
restriction.  All of these alternatives have some pros, but more cons.

But in the end, I believe that currently it is probably better to have a
simple shell script doing the generation.

A unit file typically consists of three sections (Unit, Service and Install=
).
Now, the Service section is the one which will be mostly modified.  In the
Unit section, only the description is slightly modified between server and
client variants.

Such a generator script typically need to have some kind of "feature matrix"
which enlists which features we're interested in using in the currently
available systemd version on the system.  Then pass this "detected features"
to a function which creates the [Service] section on-the-fly and dumps
everything to stdout.  The [Unit] section to use would be determined by the
role (client or server), which could be an argument to the script.  This ro=
le
would need to also be used when creating the [Service] section too.


Thoughts?


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--tPs9SzkyYLamiRXMOAfHfaKrpHpGNw5s4--

--rHK36YIutf3YelcxeH14l1CDl8zIeb5ot
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJazfZ1AAoJEIbPlEyWcf3yCPEP+QEc2fezDFLVK3/6LnhJaXs4
6BIbcfhRpYVpfiQpBOsJu2jKKLHoMN6ev3LtTKrfJaSaNQ1SBTSHpTOnFLzXR7XW
2rPn0j8ZcONg2GBQB9AOUUl+kAVsFFRH67TZP/8j0QfhZzJxc1qKNeKLkkuksGHW
GrPxI4OgKlvKE8trIPcoS/x0kw8qIn70d4IZEsVf7N/D5yv1iYIlP5wXSbY7OCuS
HAh3I2RZbHowg/25PYfc7bBXZ9ur6Jk7xAB6FaA4DpAW54VRoe+qY5/C2b2QqWbr
hjhTe3cY8oriofYt0RkYtsSfbJ+9ZW+7N5vKbV5qjciH2Ak8vuXVte4Daees/WnL
oeQuy2eZ4ko9vzeZtO+PP86QVKpTA7m04aZ1fEkcQz8BlEeQVSmWfh6AWL/kAg64
Zx5ZhBT+YI1JLfOpvCf3IWd6a/A7jss40rNB2w24OGyoKK7m53w+pv6nPbgXOl9r
inj8pSxRQ5XxwYgFcMJVGLHsfUkG4ADKfu7J4M2bxTLUwV+vZ70EuNE5t0LPrlHD
yWPsfibkzHc1ftMODBNKzViPtbb+6SUlNpfT7myd+kW7Vjn8lOSltAcBaNhfClZr
RKH8WN1BZ/7QHoq2XG3Ch6SwlY3T+LlgsL7rvD3fBZrDvACIby/slqqtozCL8z40
VfXhp0HurWt7kAtUarqO
=X1A6
-----END PGP SIGNATURE-----

--rHK36YIutf3YelcxeH14l1CDl8zIeb5ot--

