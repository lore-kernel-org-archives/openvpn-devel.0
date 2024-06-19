From: Maximilian Fillinger <maximilian.fillinger@...2507...>
Date: Wed, 19 Jun 2024 13:38:46 +0000
Message-ID: <d2a5a966414745e2942f0cfa62db3fdc@...2507...>
References: <20240618120219.5053-1-gert@...1296...>
 <202406181630.45IGU5vu098122@...2054...>
 <ZnKodXfUYfL5LUlJ@...1296...>
In-Reply-To: <ZnKodXfUYfL5LUlJ@...1296...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH applied] Re: mbedtls: Remove support for
 old TLS versions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

I *think* I reproduced the problem you're encountering.

If I put

setenv opt tls-version-min 1.0

in the server config, then *every* connection attempt will trigger a fatal =
error in the server. Doesn't matter what TLS versions the client supports.

If I put that option into the client config, the client will exit with an e=
rror during startup.

It's not clear to me what the expected behavior is when tls-version-min is =
an unsupported version, but if it's an error, it should happen during start=
-up.

> -----Original Message-----
> From: Gert Doering <gert@...1296...>
> Sent: woensdag 19 juni 2024 11:44
> To: Maximilian Fillinger <maximilian.fillinger@...2507...>
> Cc: openvpn-devel@lists.sourceforge.net
> Subject: Re: [Openvpn-devel] [PATCH applied] Re: mbedtls: Remove support
> for old TLS versions
>=20
> Hi,
>=20
> this breaks *all* client connects on my server testbed.  No matter if
> 2.2 or 2.5 client, when building with mbedtls (2.28.7), the resulting
> binary refuses ALL incoming connection with
>=20
> Jun 19 10:21:44 gentoo tap-udp-p2mp[1723]: 2001:608:0:814::f000:16
> tls_version_to_ssl_version: invalid or unsupported TLS version 1
> Jun 19 10:21:44 gentoo tap-tcp-p2p[1770]: tls_version_to_ssl_version:
> invalid or unsupported TLS version 1
> Jun 19 10:21:59 gentoo tun-tcp-p2mp[1708]: tls_version_to_ssl_version:
> invalid or unsupported TLS version 1
> Jun 19 10:22:32 gentoo tun-udp-p2mp[1713]: 194.97.140.21:49229
> tls_version_to_ssl_version: invalid or unsupported TLS version 2
> Jun 19 10:23:05 gentoo tun-udp-p2mp-topology-subnet[1718]:
> 194.97.140.21:45789 tls_version_to_ssl_version: invalid or unsupported
> TLS version 1
> Jun 19 10:24:11 gentoo tun-udp-p2mp-fragment[1746]: 194.97.140.21:14517
> tls_version_to_ssl_version: invalid or unsupported TLS version 1
> Jun 19 10:44:49 gentoo tun-udp-p2mp-112-mask[1741]: 194.97.140.21:42810
> tls_version_to_ssl_version: invalid or unsupported TLS version 1
>=20
> so my guess would be that on mbedTLS builds that *do* support 1.1/1.2,
> incoming client connects with 1.1/1.2 cause "something to get upset"
> in the TLS version printer.
>=20
> Sorry for not testing this more thoroughly before merging.
>=20
> gert
>=20
>=20
>=20
> On Tue, Jun 18, 2024 at 06:30:05PM +0200, Gert Doering wrote:
> > Mildly tested via GHA builds.
> >
> > Not sure we want this in release/2.6 - I tend to "not", because it
> might
> > break someone's (non-recommended) setup...
> >
> > Your patch has been applied to the master branch.
> >
> > commit 013c119af96bc57c41e04e4a8f64b5d80e2e9ba6
> > Author: Max Fillinger
> > Date:   Tue Jun 18 14:02:19 2024 +0200
> >
> >      mbedtls: Remove support for old TLS versions
> >
> >      Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
> >      Acked-by: Arne Schwabe <arne-openvpn@...1227...>
> >      Message-Id: <20240618120219.5053-1-gert@...1296...>
> >      URL: https://www.mail-archive.com/openvpn-
> devel@lists.sourceforge.net/msg28773.html
> >      Signed-off-by: Gert Doering <gert@...1296...>
> >
> >
> > --
> > kind regards,
> >
> > Gert Doering
> >
> >
> >
> > _______________________________________________
> > Openvpn-devel mailing list
> > Openvpn-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> >
>=20
> --
> "If was one thing all people took for granted, was conviction that if
> you
>  feed honest figures into a computer, honest figures come out. Never
> doubted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh
> Mistress
>=20
> Gert Doering - Munich, Germany
> gert@...1296...

