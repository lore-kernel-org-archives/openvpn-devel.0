Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Jens Neuhalfen <openvpn-devel@...2127...>
In-Reply-To: <c99aa195-c433-4843-dde2-789a636572d4@...2080...>
Date: Tue, 30 Aug 2016 09:08:56 +0200
Message-Id: <5EA92030-4B30-48EF-975B-4D3AD073393B@...2127...>
References: <1472413323-21723-1-git-send-email-steffan@...1856...>
	<5109e5e1-bdc9-4920-fe3e-72461a3ed546@...2080...>
	<22844900-214f-b69f-ef15-ace77cf56bbe@...2080...>
	<CAA1AbxJ_e+7Jjk=FNsgGzPNOrrTXdyf7VGyicOJpSxTbVdi7dA@...278...>
	<22cfbc88-7a12-f039-ff12-4e1c971de4b0@...2080...>
	<c99aa195-c433-4843-dde2-789a636572d4@...2080...>
Subject: Re: [Openvpn-devel] [PATCH (master)] Drop gnu89/c89 support,
	switch to c99
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
To: openvpn-devel@lists.sourceforge.net

Hi all,

hopefully this message is not completely garbled by Apple Mail ...

>=20
>=20
> [=E2=80=A6]

>=20
> Just some more benchmarks.  I just compiled successfully with -std=3Dc99
> on an old Scientific Linux 6.5 (RHEL 6.5 clone) I found.  Another
> important detail, RHEL5 will reach the "End of Production" phase March
> 2017, OpenVPN have generally stopped supporting the oldest RHEL
> releases once it hits EOL.  RHEL 5 subscribers may purchase an
> extended life cycle, but we have not cared too much about that so far.
>=20
> [=E2=80=A6]

I just checked. Extended Support is basically =E2=80=9Cyou can download the=
 old files, and maybe we help you=E2=80=9D [1], so yes indeed, we can total=
ly ignore RHEL5:=20

    For versions of products in the Extended Life Phase, Red Hat will provi=
de limited ongoing technical support. No bug fixes, security fixes, hardwar=
e enablement or root-cause analysis will be available during this phase, an=
d support will be provided on existing installations only.

[1] https://access.redhat.com/support/policy/updates/errata/#Extended_Life_=
Cycle_Phase

Jens
