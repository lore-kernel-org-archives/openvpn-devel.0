References: <1476996158-5390-1-git-send-email-davids@...515...>
	<6c3649c3-75e0-df8a-d910-73441af695d9@...515...>
	<a2f226df-89b0-f8de-0af1-225351a90edd@...2080...>
	<20161112150047.GE28918@...1296...>
	<7908667e-9f3d-aaa8-00d6-e265841e90a0@...2080...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <94ec5172-bb3f-2cfc-e2f3-e67b9ac9bdb6@...2080...>
Date: Mon, 14 Nov 2016 11:52:28 +0100
MIME-Version: 1.0
In-Reply-To: <7908667e-9f3d-aaa8-00d6-e265841e90a0@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="iIBBH1is2ptsDDasmnm1nc3eIH5SB3moq"
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
To: openvpn-devel@lists.sourceforge.net, Gert Doering <gert@...1296...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iIBBH1is2ptsDDasmnm1nc3eIH5SB3moq
Content-Type: multipart/mixed; boundary="V8k5tsi73UExWMDDXT6mDup2h5Therhmv";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: openvpn-devel@lists.sourceforge.net, Gert Doering <gert@...1296...>
Message-ID: <94ec5172-bb3f-2cfc-e2f3-e67b9ac9bdb6@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Improve the systemd unit files
References: <1476996158-5390-1-git-send-email-davids@...515...>
	<6c3649c3-75e0-df8a-d910-73441af695d9@...515...>
	<a2f226df-89b0-f8de-0af1-225351a90edd@...2080...>
	<20161112150047.GE28918@...1296...>
	<7908667e-9f3d-aaa8-00d6-e265841e90a0@...2080...>
In-Reply-To: <7908667e-9f3d-aaa8-00d6-e265841e90a0@...2080...>

--V8k5tsi73UExWMDDXT6mDup2h5Therhmv
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 14/11/16 11:44, David Sommerseth wrote:
> On 12/11/16 16:00, Gert Doering wrote:
>> Hi,
>>=20
>> On Fri, Nov 11, 2016 at 01:35:57PM +0100, David Sommerseth
>> wrote:
>>> We can of course investigate if we should enable systemd to
>>> restart OpenVPN, at least the server profile, if it dies
>>> unexpectedly. Currently, I am not fully convinced we want
>>> that.
>>=20
>> I think this would be useful to have.  Server processes are
>> expected to be there - if they are not, it needs to be
>> investigated why not, but with some reasonable delay, they should
>> be restarted.
>=20
> Let's take the easiest part first ... what is a reasonable delay?=20
> RestartSec=3D defines how long systemd should wait before restarting
> the service.  Default is 100ms.  Would 30 seconds, 1 minute, 5
> minutes, 15 minutes or 1 hour be a reasonable delay?  Or another
> value?  I honestly don't know.
>=20
>=20
> So to the slightly harder part ... under which conditions should
> systemd restart the server?  The Restart=3D setting can have a few
> alternatives.
>=20
> - on-success?  Only when openvpn exits with exit code 0.  Probably
> not.
>=20
> - on-failure?  When openvpn exits with exit code !=3D 0 or "unclean"=20
> exit signals. [1] Probably.
>=20
> - on-abnormal? When openvpn is killed by a signal, a timeout event
> or watchdog timeout event happens. [1] Perhaps.
>=20
> - on-abort?    Only when an uncaught signal not considered as a
> "clean exit" occurs.  Perhaps.
>=20
> - on-watchdog? Only when a watchdog timeout occurs.  Most likely
> not.
>=20
> - always?      Whenever OpenVPN stops running regardless of reason=20
> why it stopped, it will be restarted.  Most likely not what we
> want.
>=20
> - no?          This is the default, which we already have.
>=20
> And you can only choose one of these alternatives.
>=20
> In regards to those triggers including a watchdog, that needs the=20
> OpenVPN process to signal to the systemd daemon that it will
> provide a watchdog signal.  So unless we add that in our OpenVPN
> code, watchdog is not relevant for us.
>=20
> The systemd.service man page [2] recommends:
>=20
> Setting this to on-failure is the recommended choice for
> long-running services, in order to increase reliability by
> attempting automatic recovery from errors. For services that shall=20
> be able to terminate on their own choice (and avoid immediate
> restarting), on-abnormal is an alternative choice.
>=20
> [1] Also includes terminated by signal, including core dump but
> excludes SIGHUP, SIGINT, SIGTERM adn SIGPIPE (those four signals
> are considered clean exits)
>=20
> [2]=20
> <https://www.freedesktop.org/software/systemd/man/systemd.service.html#Re=
start=3D>

Btw,
>=20
I forgot to mention that there are more tweaks possible, to more
fine grained define successful and failing exit codes and signals.
This is done through the SuccessExitStatus=3D (what is considered
successful exiting), RestartPreventExitStatus=3D (do not restart in
these scenarios) and RestartForceExitStatus=3D (always restart when
these things happens).  All of them takes a list of exit codes and/or
signals.

I think we should avoid tweaking them right now, unless we have a
clear exit strategy in our code which falls outside of the default -
where exit code 0, SIGHUP, SIGINT, SIGTERM adn SIGPIPE are the
successful exits all others are failed exits.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--V8k5tsi73UExWMDDXT6mDup2h5Therhmv--

--iIBBH1is2ptsDDasmnm1nc3eIH5SB3moq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYKZdsAAoJEIbPlEyWcf3ys9UP/16qmwEp3/LVeHj4+7tg+vF+
LrgEN9+Qj207yPrQOKewXrr533lELEaF4LW7tQGFmsmWnz3FNX7M2vag4pbG3/jK
Lc7L5n1XblpZ2O0rMEXcZB+SZ3o3V+oivSna5pyvgO+b+Fr3iVa1ZUaNZr6Z67P3
dtreWGFJBIG2U5wdewpuO/tYA6b9WtVa8bgcvIImpe3CnBQJTNUeQ8gKMHvs33Lj
iXVDdfpGGph5vzIUqLbHjjghYIQqVJRtIT1i5bn/7RnJnDPNIdiwCwl8CfnBJhHE
3NkSDh+cUK1nwdrdugScGOXBp5OX89Ru4135GoAixUHUauHfsVphnXyW82T2D/eE
4s7Rnttca3voHkv9Rxc48gPU7pAYBB2HRkqJBBr4C/a2HMztn4LSzPr4FWqchHNO
7xVm6bpeEYlzq/deyy2xwox1/1uaN+1Cgk8/3dYHeu5oFeQmZIwXdd0P5VT1jjAK
YcX8+yje/LXfcY0JXNn6wS916UI6AGtU+vmKbkoL02izJdk7cPJHIaSNkV/wUeRn
72Zh2wzXNzLVpPz6GbIqMMH4MAuvmI681VItSWeYJTgTF76DvNVU/1gLo6hbGuJt
aTygsvq2qHS42Pz5x7j7XEz7olSQJBhc+zf4tlUaaOcy3mezGjgktftdpjSG8M75
ozYuUCEt+vjwI6TBeg1D
=erjG
-----END PGP SIGNATURE-----

--iIBBH1is2ptsDDasmnm1nc3eIH5SB3moq--

