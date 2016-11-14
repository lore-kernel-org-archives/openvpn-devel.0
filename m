References: <1476996158-5390-1-git-send-email-davids@...515...>
	<6c3649c3-75e0-df8a-d910-73441af695d9@...515...>
	<a2f226df-89b0-f8de-0af1-225351a90edd@...2080...>
	<20161112150047.GE28918@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <7908667e-9f3d-aaa8-00d6-e265841e90a0@...2080...>
Date: Mon, 14 Nov 2016 11:44:44 +0100
MIME-Version: 1.0
In-Reply-To: <20161112150047.GE28918@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="PJcfNB8kgCW9B3UDMb3AQ3QHpCxThpd3U"
Subject: Re: [Openvpn-devel] [PATCH] systemd: Improve the systemd unit files
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <davids@...515...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PJcfNB8kgCW9B3UDMb3AQ3QHpCxThpd3U
Content-Type: multipart/mixed; boundary="8ViFc9SsMh1FrSCuOdAF50fP3A09i1F7V";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <davids@...515...>
Message-ID: <7908667e-9f3d-aaa8-00d6-e265841e90a0@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Improve the systemd unit files
References: <1476996158-5390-1-git-send-email-davids@...515...>
	<6c3649c3-75e0-df8a-d910-73441af695d9@...515...>
	<a2f226df-89b0-f8de-0af1-225351a90edd@...2080...>
	<20161112150047.GE28918@...1296...>
In-Reply-To: <20161112150047.GE28918@...1296...>

--8ViFc9SsMh1FrSCuOdAF50fP3A09i1F7V
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 12/11/16 16:00, Gert Doering wrote:
> Hi,
>=20
> On Fri, Nov 11, 2016 at 01:35:57PM +0100, David Sommerseth wrote:
>> We can of course investigate if we should enable systemd to restart
>> OpenVPN, at least the server profile, if it dies unexpectedly.
>> Currently, I am not fully convinced we want that.
>=20
> I think this would be useful to have.  Server processes are expected to
> be there - if they are not, it needs to be investigated why not, but
> with some reasonable delay, they should be restarted.

Let's take the easiest part first ... what is a reasonable delay?
RestartSec=3D defines how long systemd should wait before restarting the
service.  Default is 100ms.  Would 30 seconds, 1 minute, 5 minutes, 15
minutes or 1 hour be a reasonable delay?  Or another value?  I honestly
don't know.


So to the slightly harder part ... under which conditions should systemd
restart the server?  The Restart=3D setting can have a few alternatives.

- on-success?  Only when openvpn exits with exit code 0.  Probably not.

- on-failure?  When openvpn exits with exit code !=3D 0 or "unclean"
               exit signals. [1] Probably.

- on-abnormal? When openvpn is killed by a signal, a timeout event or
               watchdog timeout event happens. [1] Perhaps.

- on-abort?    Only when an uncaught signal not considered as a "clean
               exit" occurs.  Perhaps.

- on-watchdog? Only when a watchdog timeout occurs.  Most likely not.

- always?      Whenever OpenVPN stops running regardless of reason
               why it stopped, it will be restarted.  Most likely not
               what we want.

- no?          This is the default, which we already have.

And you can only choose one of these alternatives.

In regards to those triggers including a watchdog, that needs the
OpenVPN process to signal to the systemd daemon that it will provide a
watchdog signal.  So unless we add that in our OpenVPN code, watchdog is
not relevant for us.

The systemd.service man page [2] recommends:

    Setting this to on-failure is the recommended
    choice for long-running services, in order to
    increase reliability by attempting automatic
    recovery from errors. For services that shall
    be able to terminate on their own choice (and
    avoid immediate restarting), on-abnormal is an
    alternative choice.

[1] Also includes terminated by signal, including core dump but excludes
    SIGHUP, SIGINT, SIGTERM adn SIGPIPE (those four signals are
    considered clean exits)

[2]
<https://www.freedesktop.org/software/systemd/man/systemd.service.html#Rest=
art=3D>


> (I thought this was what systemd was all about?  "Because sysvinit cannot
> restart stuff!" - which was never true, but standard rc.d scripts do not
> support it)

Flame bait?  ;-)

I don't know exactly why this isn't enabled by default, but there are
probably plenty of reasons.  One could be that because the vast majority
of rc.d scripts don't do this, so it would be a very unexpected change
for very many services and/or sys-admins.  As you see from above, the
feature is easily available, fairly flexible and it is far easier to
enable it than adding extra code to an rc.d script.

For the "this was what systemd was all about?" ... not just this, but it
is one area of all the stuff systemd wants to improve or simplify.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--8ViFc9SsMh1FrSCuOdAF50fP3A09i1F7V--

--PJcfNB8kgCW9B3UDMb3AQ3QHpCxThpd3U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYKZWmAAoJEIbPlEyWcf3yJnYP/0+RFq2b8/MqnInbBegt+wiH
+OFDpyzSnj11t5p7lr3nSwHUW4M4waUFYlSSCZlZH1MFJ6516FyA82TcyhF79N/H
tlHvDt4DKhpAMTrUTa/QHZnCvjzku9Dr8ZTBe+b5/p/BzIvcUoBKrlxobRSvMBZv
/v+rvg2z2NA399CUa2KcPUBKAnOJR9h/vmgrJ9yEGSelYVRqrKc9PukMb73y3e31
xC+JUFdTEXh4tL8zErWV6YAjOLptcwBBogSoxzsYxLEL1IrOzoIBmd/EIxF1G7hg
MRSgrELjXgh6p5Rf7GfWK0ZXswAZ8sK1dAjgg56flznRjIEkQmfHe1Rj1z8qXqec
leOmbqo+KE1jsHq0Iu3gX4AuZaindsqod1tNVB1Kj1EDKhcry2ZxdrC3PXEXTHFi
m9oCY6FkVUQFEIX0xMH+4C1qLi/0XSjLgv2FAlWCowr+duc8oh7aTyRPkHp6wOqp
KPnlCgwCgS5eZMqfDbNreRpbcr5tiqCx8YOuc6qPn1svU1wZqH9BULExA3N9LsUm
ArZ0LKp08iwzUcLmNDs20TxDsgNEgx7JSebCEC7IGfx60NWf/L2p3R8ZNkslZhqN
iKv5+Z5MSV89nDF5H+09+F20OWoRJJpVE8v7+uu9aTIzlYQ9f3sNLhbszQn6r9ol
pNL66ojfyE9dyGirpmWp
=kcOk
-----END PGP SIGNATURE-----

--PJcfNB8kgCW9B3UDMb3AQ3QHpCxThpd3U--

