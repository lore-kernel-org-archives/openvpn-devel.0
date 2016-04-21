Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Jens Neuhalfen <openvpn-devel@...2127...>
In-Reply-To: <57189BF4.7040400@...515...>
Date: Thu, 21 Apr 2016 19:40:16 +0200
Message-Id: <5E0364AE-B4E5-45B7-A30D-4CB6C018BF1C@...2127...>
References: <950C8167-A5FF-4F56-9020-C956EED49557@...2127...>
	<5718879E.8050007@...1227...> <57189BF4.7040400@...515...>
Subject: Re: [Openvpn-devel] Unit testing in openvpn?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: =?utf-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: openvpn-devel <Openvpn-devel@lists.sourceforge.net>

Hi Samuli,

[=E2=80=A6]

> I think the first step would be to identify the places where unit tests c=
ould be implemented easily (if any), and where they would do most good. If =
something falls to both of these categories then writing a unit test there =
would probably make sense.

The first candidate would be the U2F integration that I=E2=80=99d like to w=
rite. A proven strategy for starting unit testing is to write tests for all=
 new features. This way the up-front cost is reduced to the invest for =E2=
=80=9Cthe first test=E2=80=9D.

>=20
> Then there's the other codebase (3.x) which, when publicly released, migh=
t be a good/better candidate for writing unit tests.

Please forgive my ignorance: Is this code base already a thing, and what is=
 the time scale we are looking at (regarding =E2=80=9CV3=E2=80=9D)?

>=20
> If we end up writing unit tests, I too would prefer the Git submodule app=
roach.

Great :-)

Jens

>=20
> --=20
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>=20
> irc freenode net: mattock


