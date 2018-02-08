References: <CAFHpkQEFPO+TsXdqva=OGg_9FnErDH7Uw9fs876Co_q2A4=rmA@...278...>
 <CAKuzo_hdyx3MH5Cw=gEujHhEvQ1wnOaZ2r0n7=j3GSsv_C1Z2Q@...278...>
 <CAFHpkQFtN6jk5bNcksmoBDjjMd3UbW4sN+y5rH0zUb2sgDq=gg@...278...>
 <6febf54c-f7ab-2297-2c75-72235e14e1c5@...2080...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <17c77ed3-840e-7624-9e23-6ae8de04bf3e@...515...>
Date: Thu, 8 Feb 2018 10:15:40 +0200
MIME-Version: 1.0
In-Reply-To: <6febf54c-f7ab-2297-2c75-72235e14e1c5@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Qs6SdmjgeXaX2bx6AZpBMOwp5tRow6Drl"
Subject: Re: [Openvpn-devel] [Openvpn-users] "Reconnect" button in
 openvpn-gui
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, David Sommerseth <openvpn@...2080...>, =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, Selva Nair <selva.nair@...277...>
Cc: "openvpn users list (openvpn-users@lists.sourceforge.net)" <openvpn-users@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Qs6SdmjgeXaX2bx6AZpBMOwp5tRow6Drl
Content-Type: multipart/mixed; boundary="jRP2kifYO9XtVmq4QhOUkrlzkOtzRzhQn";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel@lists.sourceforge.net,
 David Sommerseth <openvpn@...2080...>,
 =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>,
 Selva Nair <selva.nair@...277...>
Cc: "openvpn users list (openvpn-users@lists.sourceforge.net)"
 <openvpn-users@lists.sourceforge.net>
Message-ID: <17c77ed3-840e-7624-9e23-6ae8de04bf3e@...515...>
Subject: Re: [Openvpn-devel] [Openvpn-users] "Reconnect" button in openvpn-gui
References: <CAFHpkQEFPO+TsXdqva=OGg_9FnErDH7Uw9fs876Co_q2A4=rmA@...278...>
 <CAKuzo_hdyx3MH5Cw=gEujHhEvQ1wnOaZ2r0n7=j3GSsv_C1Z2Q@...278...>
 <CAFHpkQFtN6jk5bNcksmoBDjjMd3UbW4sN+y5rH0zUb2sgDq=gg@...278...>
 <6febf54c-f7ab-2297-2c75-72235e14e1c5@...2080...>
In-Reply-To: <6febf54c-f7ab-2297-2c75-72235e14e1c5@...2080...>

--jRP2kifYO9XtVmq4QhOUkrlzkOtzRzhQn
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Il 07/02/2018 21:58, David Sommerseth ha scritto:
> On 07/02/18 20:32, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
>> After auth-token were introduced, when user press "Reconnect", it leads =
to
>> auth fail (saved password is forgotten), we run about 1000 users, nobody
>> complains.
>=20
> This is actually expected, I'd say - but smells like a bug on the server =
side
> authentication.
>=20
> Selva may correct me if I'm wrong, but my understanding of it when clicki=
ng
> "Reconnect", the local OpenVPN process which caches the auth-token is sto=
pped
> and a new OpenVPN process is started.  The client should in this case ask=
 for
> username/password again.  So in this case, the server side should treat t=
his
> connection as a fresh connection with no initial state.
>=20
> The step of stopping the local client and starting a new and fresh one is
> definitely not a bad feature to have on clients.
>=20
>> It looks like nobody uses that button.
>>
>> So, I asked several users, they confirmed they do not use Reconnect.
>=20
> This is no good argument for me.  This is one specific setup with 1000 us=
ers.
> It would be more valuable with 50 different setups having 20 users each. =
 Your
> conclusion is based on a very homogeneous environment.

I agree. I also agree that the underlying problem should be fixed.

That said, Ilya's message was sent to both openvpn-users and
openvpn-devel and nobody has screamed "do not remove the Reconnect
button" :). The only additional thing we can do is post a message to the
forums. As usual, the only sure way to get feedback (read: complaints)
is to release the changes in an official build/installer.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--jRP2kifYO9XtVmq4QhOUkrlzkOtzRzhQn--

--Qs6SdmjgeXaX2bx6AZpBMOwp5tRow6Drl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlp8BzUACgkQKVhNn0CG
RXhmpwf9HN2s4dGSnLVeD6/Wj5VX5uKTo0OFlxQnt9/FMomf3VH5ME6gDZO/8APo
IDAcTq1LgilGN0+XBbv6mcZtouRbx12+NtH7o9bEJ0lNw604+t/GttHJoXBsrzOt
RbHLAeFa3rbsjnv0OWvFFy2T+DkPqVVWtYqmLva/RvW2kPVyD8ziYWfukkoi1CQk
dH0RbnIKo4FYoV6bbmyyZ/fQg5cCl+W+rd7VcB2PplnjAqTqTk5t78kvIlZpDd9t
KDQLw+Zn8zR/xy6nl1gFML1+AqeDvWvyPh51fcKj9kuAcBi5wTyoaLdcpvHzISGs
3JPVc5X2zGeqItzwwvyWTt5QdQY8BQ==
=0WVQ
-----END PGP SIGNATURE-----

--Qs6SdmjgeXaX2bx6AZpBMOwp5tRow6Drl--

