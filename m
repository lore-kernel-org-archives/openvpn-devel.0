References: <CAKuzo_jj4H3toE0JXp-HNKBH5=Y_iXqVPKOndkycFTYmQoL0=g@...278...>
	<CAFHpkQEj2h4wwV056vy3dk4BBE=LuOoRtSqwMFonstY8RPNLYA@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <ac786c37-b52a-cb6d-dc5b-31764db832d5@...2080...>
Date: Mon, 5 Dec 2016 00:20:17 +0100
MIME-Version: 1.0
In-Reply-To: <CAFHpkQEj2h4wwV056vy3dk4BBE=LuOoRtSqwMFonstY8RPNLYA@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="eNrQP3xcpa0lJjPbS3UeP8Rs1jEVqotqi"
Subject: Re: [Openvpn-devel] The windows installer and interactive service
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eNrQP3xcpa0lJjPbS3UeP8Rs1jEVqotqi
Content-Type: multipart/mixed; boundary="glgrn5XJU3wjEwwG08Fq5aAT5CLnC38mm";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>,
	Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <ac786c37-b52a-cb6d-dc5b-31764db832d5@...2080...>
Subject: Re: [Openvpn-devel] The windows installer and interactive service
References: <CAKuzo_jj4H3toE0JXp-HNKBH5=Y_iXqVPKOndkycFTYmQoL0=g@...278...>
	<CAFHpkQEj2h4wwV056vy3dk4BBE=LuOoRtSqwMFonstY8RPNLYA@...278...>
In-Reply-To: <CAFHpkQEj2h4wwV056vy3dk4BBE=LuOoRtSqwMFonstY8RPNLYA@...278...>

--glgrn5XJU3wjEwwG08Fq5aAT5CLnC38mm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 04/12/16 15:42, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
>=20
>=20
> 2016-12-03 23:48 GMT+05:00 Selva Nair <selva.nair@...277...
> <mailto:selva.nair@...277...>>:
>=20
>     Hi,
>=20
>     In the installer, interactive service is tied to the installation of
>     automatic service (openvpnserv2) --- if you opt not to install
>     openvpnserv2, interactive service is also disabled. You can install
>     openvpnserv2 without installing the interactive service, but not the
>     other way.
>=20
>     I think we should consider interactive service as a requirement for
>     properly running the GUI (note that we do not set the GUI to request
>     admin rights anymore). So I suggest:
>=20
>     1. Always install the interactive service along with openvpn core
>     (and set up the required HKLM registry entries) OR at least
>     automatically select interactive service if the GUI is selected.
>=20
>     I prefer the first option as that service doesn't do anything unless
>     a client connects to its service pipe, and has some uses even
>     without the GUI.
>=20
>     2. Make it possible to uncheck automatic service (openvpnserv2)=20
>     without unchecking interactive service.
>=20
>     A vast majority of installations would need only openvpn core, the
>     GUI and interactive service. Most users will not use the automatic
>     service (openvpnserv2) at all. Given that the latter requires .NET
>     4.0 which means an additional 50MB+ download for some, a very slow
>     installation and possible restarts, forcing it on to get interactive
>     service is not good.
>=20
>     That said we could still leave openvpnserv2 selected by default as
>     changing that at this stage may be unwise. Hopefully many Windows
>     users may already have .NET 4.0 or higher installed.
>=20
>=20
> thank you very much for your efforts.
>=20
> however, it seems to get more and more complicated ("what if we install
> new version after old version ... and checkboxes are set in different
> ways...").
>=20
> what do I suggest, is to simplify things, i.e.
>=20
> 1) add "send installation statistics anonymousely" (we will see checkboxe=
s)

No.  Do not ever add such statistics.  Many OpenVPN users are privacy
aware and they will make a lot of noise if we ever do something like this.

Further do not add additional check-boxes.  Give users as few options as
possible, presume users are stupid (and I include everyone in this
statement, even including sys-admins and developers) and they will do
random choices on such options based on their mood of the day.  We who
develop OpenVPN have the best condition in most cases to recommend sane
defaults, provide that and ignore the rest.  If we are wrong on these
defaults, we will get to know it soon enough and can re-evaluate the
defaults and fix it for everyone.

And rather put advanced tweaks behind some more hidden command line
switches/options for those users who truly understands these details.

Seriously, just start to ponder on the success of iOS over many other
mobile OSes.  They provide as few options as possible (but no less!).
That is, the bare minimum to provide a simple and great user experience
for even inexperienced users.  Yes, advanced users may hate it, but the
majority of users love this simplicity - even technical ones.

> 2) run some kind of questionary

Such questionnaire will only be valuable if those who fill it out have
the needed experience and/or understanding to give educated answers.
For the rest it will just be a mixture of "this sounds clever", "this
sounds cool" and "No way, I will hate that".


Be brave, settle for some really reasonable defaults we would prefer.
Ship it and see how it is perceived.  If there are issues, we can respin
a new installer with modified defaults regardless of the core OpenVPN
release schedule.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--glgrn5XJU3wjEwwG08Fq5aAT5CLnC38mm--

--eNrQP3xcpa0lJjPbS3UeP8Rs1jEVqotqi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYRKSxAAoJEIbPlEyWcf3yr2IQALJqSXWMJgr9gcwM9DaIJMuR
V/BAOODM/FRUJFEutTRvXy/6+jpDLZf9OQtFgGi/nv5DmGWthO1qGy+4qqr2Z1hx
8s/rl/d4Qt7LByDyHoiF9cv/D5WvN+h6lLAs2crW49s+Z4SqDzl0lHZy1t4zc4bf
TBf9L+3UDtbBjppiC96DyH4epi5X7434VcwgYO4O+IXAktb1pjo0RWm5HrzKnuck
jMyXa74ujL7CM293Wibp/rrfOb5p5MUtzt+Ugr8hbTLEE6AIqUQfBdNUKtsO3MZS
NDDX+P1w/SLwcl2W1Ej4aySmfWlcuMt1aBgB/AxuQu/lSWttfR6Wisjxf9gHAOx3
FZdeojZJMPVKO0qn6WgX4BbrLQqFjaXKHj+UZ7SxskPf5XJyXzAWQbv7hDnmPwSx
PM58yMpBppPapD1b/1r8YbJhmil8t4HzYAAZH7zxiOQFCs8ZJ/a2uLkPIACWxDyR
KJX/ozzjVMMurssbOI0swLguONiCWRikRsGepUjVHbBxrhv2xocmi238QMVcL9QC
HPkQ6bkhRVjhFE1b5451JUn/zXdIUfQQSf/96cEihEHQZHeFWD4FYOZreA2fIJWT
mGkssjk/pK2SCq6C3oCmpauQRSO0itsthDqX+JlgY+N6rjr0PuyCewagOvY0H4iK
soezBkP2rHHaUWrWwDhg
=mQUc
-----END PGP SIGNATURE-----

--eNrQP3xcpa0lJjPbS3UeP8Rs1jEVqotqi--

