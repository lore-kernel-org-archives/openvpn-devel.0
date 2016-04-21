Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Jens Neuhalfen <openvpn-devel@...2127...>
In-Reply-To: <20160421172555.GI53051@...1296...>
Date: Thu, 21 Apr 2016 19:48:01 +0200
Message-Id: <1C1BCB62-CE17-4A33-BC64-B05B5839EA38@...2127...>
References: <B32C1FDE-D0CF-49A7-A231-28267BB89B46@...2127...>
	<CAA1AbxL3ZRGrig+j9uTdn17NDaM=WGbE4XgZf1nAyvXBxTwfBg@...278...>
	<A4F03DE4-3E70-4815-B4B4-CC185E35CF2C@...2127...>
	<20160421172555.GI53051@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] auth-pam:Fix buffer overflow by user
	supplied data
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <Openvpn-devel@lists.sourceforge.net>

Hi Gert,

[=E2=80=A6]

*sigh*. Thanks for finding out && providing the patch!

Learning: Try on multiple machines (It =E2=80=9Ccompiles on my machine [Mac=
]=E2=80=9D apparently is not enough)

My test vm (precise) fails with the same error.

Jens=20


> While this looks totally reasonable, it does not compile...  both in
> master and release/2.3, both on linux and FreeBSD, I get
>=20
> libtool: compile:  cc -DHAVE_CONFIG_H -I. -I../../../../openvpn/src/plugi=
ns/auth-pam -I../../.. -I../../../include -I../../../../openvpn/include -g =
-O2 -MT auth-pam.lo -MD -MP -MF .deps/auth-pam.Tpo -c ../../../../openvpn/s=
rc/plugins/auth-pam/auth-pam.c  -fPIC -DPIC -o .libs/auth-pam.o
> ../../../../openvpn/src/plugins/auth-pam/auth-pam.c:141:53: error: use of
>      undeclared identifier 'SIZE_MAX'
>  bool is_potential_integer_overflow =3D  (templen =3D=3D SIZE_MAX) || (te=
mple...
>=20
> ... you need to #include <stdint.h> to get that symbol...
>=20
> Steffan: for the sake of "avoid yet another full loop and a v3", could=20
> you just ACK this change as well?
>=20
> gert
>=20
> --=20
> USENET is *not* the non-clickable part of WWW!
>                                                           //www.muc.de/~g=
ert/
> Gert Doering - Munich, Germany                             gert@...1296...
> fax: +49-89-35655025                        gert@...1297...


