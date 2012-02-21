MIME-Version: 1.0
In-Reply-To: <4F43EE92.50802@...515...>
References: <CAOazyz34oFXrQ8vh5qXcEFPC3wA8Qhn7ivzLKasB=B9mOCKyZQ@...278...>
	<4F43BEB5.6050404@...1114...>
	<CAOazyz2rRpsKzitWS5bWe8Ug7ut=ODQy9PDkq7v4Aa7E1ygHHA@...278...>
	<4F43D9B0.6010900@...1114...>
	<CAOazyz0Z4Lv=qDN1r_W504vBOgaF1YWiNs+9j_MCorACOzfyzQ@...278...>
	<4F43EE92.50802@...515...>
Date: Tue, 21 Feb 2012 22:10:03 +0200
Message-ID: <CAOazyz3HJpv_thGRNhHBrGxfUzBja45AX9Eq_HK53ZXQ5FmMyA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [RFC] openssl minimum supported version
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
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>, James Yonan <jim@...41...>

2012/2/21 Samuli Sepp=C3=A4nen <samuli@...515...>:
> I would be inclined to focus on cutting down complexity as much as
> possible. I think the best way to gauge real need for old autotools is
> to scrap support for it. We can always fix things afterwards, if
> necessary. I can ask James' opinion if he does not step in soonish.

Never mind.
I've updated build to support >=3Dautoconf-2.59, >=3Dautomake-1.9, >=3Dlibt=
ool-1.5.22
I hope it won't get more complex than this.
Please try it[1] out.

But you must promise me that formal tarballs will be relased using
>=3Dautoconf-2.65, >=3Dautomake-1.11, >=3Dlibtool-2.4.

Why? So people won't be required to autoreconf if they like to do cross com=
pile.

Alon.

https://github.com/alonbl/openvpn/downloads

