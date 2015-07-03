Date: Fri, 3 Jul 2015 13:56:39 +0200
From: =?utf-8?B?SsOBS8OTIEFuZHLDoXM=?= <jako.andras@...2041...>
Message-ID: <20150703115639.GC57772@...2041...>
References: <55966BE0.5090400@...1147...> <55966F4A.7010008@...1114...>
	<559672D0.1030904@...1147...>
MIME-Version: 1.0
In-Reply-To: <559672D0.1030904@...1147...>
Subject: Re: [Openvpn-devel] Adding routes on Windows using DHCP
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
Content-Disposition: inline
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

 Hi JJK,

> > * Can you push several routes via DHCP?  Or just a single one?
> > If you can push multiple routes, then I'd say we should look into adding
> > a check if --redirect-gateway + non-admin privileged user =3D> provide =
an
> > solid warning in the logs that redirecting won't work without proper
> > privileges.
> >=20=20=20
> yes this is possible; it's possible to push multiple gateways and=20
> multiple (classless) routes (dhcp options 121 & 249).
> If the metric on the tap-win adapter is set manually and is set low=20
> enough the redirecting the gateway will also work.
> However, changing the metric requires evelated access...

Sorry for the noise if that has been discussed before: Instead of
modifying the metric, how about pushing two /1 routes (0.0.0.0/1 and
128.0.0.0/1)?

Andr=C3=A1s

