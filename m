From: =?UTF-8?Q?booyakasha?= <booyakasha@...1309...>
In-Reply-To: <20100304213523.GF25238@...1296...>
References: <6c75f86b.6552e8f7.4b8bad61.2e7bd@...1309...>
	<eba800c91003011101v61fb1415l68146f00916b1c7@...278...>
	<7cd17813.52db77fa.4b901800.4e59d@...1309...>
	<20100304213523.GF25238@...1296...>
Mime-Version: 1.0
Message-ID: <2123d059.17d4e8c4.4b90298a.5c789@...1309...>
Date: Thu, 04 Mar 2010 22:43:38 +0100
Subject: Re: [Openvpn-devel]
	=?utf-8?q?Openvpn_2=2E1=2E1_bad_tcp_performance_b?=
	=?utf-8?q?ut_good_pingwhen_-l_1472_=28with_packet_size_=3D_MTU=29?=
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net


Hi,
yes i tried this setting among many others and it didn't changed nothing at=
 all. But really i would be more than pleased if it was just some switch in=
 config file..

Regards
Ucho

Dnia 4 marca 2010 22:35 Gert Doering <gert@...1296...> napisa=C5=82(a):

> Hi,
>=20
> On Thu, Mar 04, 2010 at 09:28:48PM +0100, booyakasha wrote:
> > magic number 2952 (ping ?l 2952). It wasn?t only the 1472 ping
> > packet which worked OK. All packets over 2952 are OK !!!  I am
> > waiting for your opinions why packets from 1 byte to 2952 bytes
> > (without 1472 byes package) are going extremely slowly and others not.
>=20
> TCP_NODELAY
>=20
> David has already suggested that you should try setting
>=20
>   "socket-flags TCP_NODELAY"
>=20
> - did you?
>=20
> gert
> --=20
> USENET is *not* the non-clickable part of WWW!
>                                                            //www.muc.de/~=
gert/
> Gert Doering - Munich, Germany                             gert@...1296...
> fax: +49-89-35655025                        gert@...1297...
>=20

