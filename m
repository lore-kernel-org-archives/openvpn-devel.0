Mime-Version: 1.0 (1.0)
From: =?utf-8?Q?Adam_=C5=A0tevko?= <adam.stevko@...277...>
In-Reply-To: <20170517191418.GF97029@...1296...>
Date: Wed, 17 May 2017 21:29:04 +0200
Message-Id: <CFB3FE1A-05A5-474E-8298-30CE1D89020E@...277...>
References: <8925EED7-0E13-4DEE-B3F8-1A5E3E970F4A@...277...>
	<20170517191418.GF97029@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] OpenVPN rpm packaging - iproute2 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

> On 17 May 2017, at 21:14, Gert Doering <gert@...1296...> wrote:
>=20
> Hi,
>=20
>> On Wed, May 17, 2017 at 10:53:58AM +0200, Adam ??tevko wrote:
>> this patch adds support to build openvpn rpms with iproute2 support. It'=
s a rather simple change, which defaults to off. Please review.
>=20
> Is there a particular reason not to *always* build with iproute2 support?

I personally think that iproute should be default as mainstream distributio=
ns removed nettools and ship iproute exclusively. However, i want this merg=
ed and shipping by default to off is the path of least resistance. Those wh=
o need it now have a way how to enable it.

> David, what can a program expect to find on RPM based distributions?
>=20
> (Is this .spec file what Fedora builds use?)
>=20
> gert
> --=20
> USENET is *not* the non-clickable part of WWW!
>                                                           //www.muc.de/~g=
ert/
> Gert Doering - Munich, Germany                             gert@...1296...
> fax: +49-89-35655025                        gert@...1297...

