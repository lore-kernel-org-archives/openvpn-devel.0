Reply-To: openvpn-devel@lists.sourceforge.net
References: <1530581086-7825-1-git-send-email-selva.nair@...277...>
 <CAEsd45SC3aXgJYX33gFyF53A3njcbokK8ho_G7-6VDVG84zNfA@...278...>
 <CAKuzo_i0rGsDOpEdoFe-SRSDVQY7raSZhjyOLh-pa34FWxtXjQ@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <95d437e1-73db-99bb-0aed-11335956db47@...2080...>
Date: Tue, 3 Jul 2018 11:23:16 +0300
MIME-Version: 1.0
In-Reply-To: <CAKuzo_i0rGsDOpEdoFe-SRSDVQY7raSZhjyOLh-pa34FWxtXjQ@...278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="9lRyhA954Q0K6e3SKYrcGShg0Rcixo2N7"
Subject: Re: [Openvpn-devel] [PATCH] Make up/down script errors not FATAL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>, "Jonathan K. Bullard" <jkbullard@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9lRyhA954Q0K6e3SKYrcGShg0Rcixo2N7
Content-Type: multipart/mixed; boundary="V0MaOSWyFFkyDwnRn58lEqPjj6Yewhx7h";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Selva Nair <selva.nair@...277...>,
 "Jonathan K. Bullard" <jkbullard@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <95d437e1-73db-99bb-0aed-11335956db47@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Make up/down script errors not FATAL
References: <1530581086-7825-1-git-send-email-selva.nair@...277...>
 <CAEsd45SC3aXgJYX33gFyF53A3njcbokK8ho_G7-6VDVG84zNfA@...278...>
 <CAKuzo_i0rGsDOpEdoFe-SRSDVQY7raSZhjyOLh-pa34FWxtXjQ@...278...>
In-Reply-To: <CAKuzo_i0rGsDOpEdoFe-SRSDVQY7raSZhjyOLh-pa34FWxtXjQ@...278...>

--V0MaOSWyFFkyDwnRn58lEqPjj6Yewhx7h
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 03/07/18 09:49, Selva Nair wrote:
> Hi Jon,
>=20
> On Mon, Jul 2, 2018 at 11:13 PM, Jonathan K. Bullard <jkbullard@...277...
> <mailto:jkbullard@...277...>> wrote:
>> Hi.
>>
>> On Mon, Jul 2, 2018 at 9:24 PM, <selva.nair@...277...
> <mailto:selva.nair@...277...>> wrote:
>>>
>>> From: Selva Nair <selva.nair@...277... <mailto:selva.nair@...277...>>
>>>
>>> Instead log only a warning.
>>>
>>> This helps user interfaces enforce a safer script-security setting
>>> without causing a FATAL error.
>>
>>
>> Can you expand on that? What "safer script secuity settings' do you
>> have in mind? Tunnelblick (and I think all Linux) use script-security
>> 2 to allow for up/down scripts that implement DNS and other settings.
>>
>> My initial reaction is that I'd rather a problem in the up/down
>> scripts generates a fatal error, so if there's a problem in the
>> Tunnelblick scripts somebody will report it. In my experience, almost
>> nobody pays attention to warnings, and mostly, those who do are
>> worried about warning that don't matter.

+1

>=20
> This is in reaction to
>=20
> https://medium.com/tenable-techblog/reverse-shell-from-an-openvpn-configu=
ration-file-73fd8b1d38da
> <https://medium.com/tenable-techblog/reverse-shell-from-an-openvpn-config=
uration-file-73fd8b1d38da>
>=20
> In OpenVPN Windows GUI I'm considering to enforce "--script-security 1"
> (SSEC_BUILT_IN). See the discussion here:
>
> https://github.com/OpenVPN/openvpn-gui/issues/270


This I am much more in favour of.  I've already added a longer GitHub comme=
nt
with a bit different perspective, as well as looking more into the future of
what we're doing with OpenVPN 3 - where OpenVPN processes generally will not
run any scripts or even support it.

TL;DR: Reduce the possibility to run scripts to an absolute minimum (if at
all).  If having this possibility run them with as few privileges as possib=
le,
and scripts to run is preferred to be configured outside of the OpenVPN
configuration file.

The latter argument of configuring scripts outside of the configuration file
is simply trying to end up with a single configuration file which would be
functional on all devices.  A configuration file with Windows scripts won't
work on a non-Windows box and vice versa - some configuration files might n=
ot
even work across Linux distributions even.  So let the OpenVPN configuration
files be as generic as possible, focusing on getting a connection to a remo=
te
server.  And configure the rest outside of the OpenVPN configuration profil=
e.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--V0MaOSWyFFkyDwnRn58lEqPjj6Yewhx7h--

--9lRyhA954Q0K6e3SKYrcGShg0Rcixo2N7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJbOzJ8AAoJEIbPlEyWcf3yAGMP/0VHHgvF1ZIFMdQPUqq17QiB
yus2zG6NZyrARrTnuwfTO1MDtgaPgyuX7hI3BZAXQBKLtCfg3VOVwE2fPCxV4cHF
cDyznQ/CBMbGeneWKdb/uZx6X2SfqKGNxalWLCLEfQzJzDxqDYNwGXGQ85lEnDmQ
+j4AyBsMhFbaeahsLOjWk/lB+9LcOS1XjQEO6/T1yQ20jL3TswcaC8k2J0sJwNM8
GIIJEADX4sru119D4Sm1k4LFW+3l9AMzE0l1gpUYkBl9p2d/Xux2BPIQ2iH8VbeS
f/hSQNxx3gsbOV5fcNaFI58SejRYR+6NFD0uy1rYXSPI6gBiVP6m/S78majL/SF6
G8K0/ZqU2IoiuRkcmhPuNb6MEAqjKu6//fVZJQrlEY/GCjfaS7/Yr+esp2oNeZMs
KXaU2azBdQgUgp7U8bcdhK5XHm1IwT+Gbw4hkDi4slPhwnyVXZG36lSzFvfM7epd
W6pvg6T+uiBwTBqpb2LUkJYqES9awYNMBt3S7hRk+fh80lqZ3sMAZseTOWidm/Qp
2HoD7zGnIZ9nF5CK2uHgnqbFKU/F74R10UfWKZezNJ/iRSPTs17nF02dTTsyQS8B
xDb7mJ7R3n248hZvkUyAtF2tCyw7hshzRhuCFdDHv7fImpGNIwJRKZxz3LDhWla+
WQIWmG26BAQGKg8qYChI
=42xa
-----END PGP SIGNATURE-----

--9lRyhA954Q0K6e3SKYrcGShg0Rcixo2N7--

