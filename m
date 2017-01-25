References: <20161227222406.931-1-list@...1798...>
	<20170125160428.19928-1-list@...1798...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <5285c33f-98e5-4e06-0ed8-95728a74f755@...2080...>
Date: Wed, 25 Jan 2017 18:06:19 +0100
MIME-Version: 1.0
In-Reply-To: <20170125160428.19928-1-list@...1798...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="fUAXfNVqjQlacBQf80R9AKe4BWHtCaMKo"
Subject: Re: [Openvpn-devel] [PATCH v3 1/1] Clean up plugin path handling
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Christian Hesse <list@...1798...>, OpenVPN Development <openvpn-devel@lists.sourceforge.net>
Cc: Christian Hesse <mail@...1798...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fUAXfNVqjQlacBQf80R9AKe4BWHtCaMKo
Content-Type: multipart/mixed; boundary="1nGETGIhCbJ8h58m3R66O3qqss6ithQv1";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Christian Hesse <list@...1798...>,
	OpenVPN Development <openvpn-devel@lists.sourceforge.net>
Cc: Christian Hesse <mail@...1798...>
Message-ID: <5285c33f-98e5-4e06-0ed8-95728a74f755@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v3 1/1] Clean up plugin path handling
References: <20161227222406.931-1-list@...1798...>
	<20170125160428.19928-1-list@...1798...>
In-Reply-To: <20170125160428.19928-1-list@...1798...>

--1nGETGIhCbJ8h58m3R66O3qqss6ithQv1
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 25/01/17 17:04, Christian Hesse wrote:
> From: Christian Hesse <mail@...1798...>
>=20
> Drop --with-plugindir, instead use an environment variable PLUGINDIR
> to specify the plugin directory.
>=20
> This generates a header file src/openvpn/plugindir.h which contains a
> define file the plugindir.
>=20
> v2: The configure script can not evaluate the final $libdir path. So
>     use make to create a header file on the containing the final path.
>=20
> v3: Fix whitespace errors and gitignore location.
>=20
> Signed-off-by: Christian Hesse <mail@...1798...>
> ---
>  .gitignore                 |  1 +
>  configure.ac               | 14 ++++++--------
>  src/openvpn/Makefile.am    | 11 +++++++++--
>  src/openvpn/plugin.c       |  1 +
>  src/openvpn/plugindir.h.in | 34 ++++++++++++++++++++++++++++++++++
>  5 files changed, 51 insertions(+), 10 deletions(-)
>  create mode 100644 src/openvpn/plugindir.h.in


Okay, some more feedback to this thread :)

As I've said, I think this makes sense.  It provides a predictable
plug-in directory which is easily accessible within the C code ... and
it will always be set.  So, Feature-ACK.

But I am wondering about the rationale of adding another header file
(plugindir.h).  Why not just add this information to
openvpn-plugin.h.in, which results into openvpn-plugin.h ... and which
plugin.c already includes via plugin.h ...  I actually think this path
can be quite useful for third-party plug-ins, being built outside of the
openvpn source tree.

Further, we should then also kick out the #ifdef PLUGIN_LIBDIR in
plugin_init_item() [plugin.c:237].  And we need to check what the
#if defined(ENABLE_PLUGIN_SEARCH) is all about ... I do not see any
possibilities to define the ENABLE_PLUGIN_SEARCH macro without changing
a .c/.h file.  Does this block even make sense to enable at all?

So, as this patch got "clean-up" and "plugin path handling" in the
subject, lets cover a few more aspects of this clean-up :)


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--1nGETGIhCbJ8h58m3R66O3qqss6ithQv1--

--fUAXfNVqjQlacBQf80R9AKe4BWHtCaMKo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYiNsMAAoJEIbPlEyWcf3ytEYP/AxnJzDtCbHneLi+J42U901x
hCGjt92jYlXdDXdtuvbfaRJWN/azebURJj+ij3NCp71PTANvg5dRLjUSsVk6h3IH
M/Q96yueHbXnH9oanCTe5d/NtK8euPx9aVb+0RoEqTXgJyvqCURUrHVPslRI8vvp
ASqsNf+T7oOvRdVPb+iemT2hDOkG+Y2hU9FbQG/Q3pRdqO29d/ldP19PVcWDPkIY
i5Ams7hkun8fco42TSznJiNihM2p5o05fuOuWCNLkZKh6mLysR78/XwBbfXh/MHJ
doGm13YSxn1zhI6n/D482xcYwpDAAyXf41tiwLiHihqskjUFv5Sl+wLP9wsUe2yv
WOBzoiqa8axQmHKnjn4nykss7vgD/KAtHUwLwhuQ7+yFFxzv43VQbpRb90GIHu6X
bVnrUdayuxaL740vgxjnKLYwX4dnuB5rn+4AGvymdAjJ8J5MtORpQfUi1+4s/9WE
d5B7W/EtKuafoih/qXyvD98VXhhP4ehOhQ15YDXZk0TjRiaIhC5v1GRby5wpxgJo
OWZotpmUih910fCVqzlch66nnJL7ZpBdCRA8fGF+NILg64+8MUSq2UcO3kk+E9HN
lK6lJW7rkcHIMqk9ok7rWgXBa0nP+Hv907zJ6hKvf3tK8mNvC+zQYwIg8bevii3+
lA/lcUXS0Yxyn3FuIFdj
=UhwP
-----END PGP SIGNATURE-----

--fUAXfNVqjQlacBQf80R9AKe4BWHtCaMKo--

