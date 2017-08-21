Reply-To: openvpn-devel@lists.sourceforge.net
References: <CAFHpkQHXhe4UBAePJQXkBYJ+Sahc-3XpVPfPBo5oT6EKbzm3mA@...278...>
 <b524e527-9881-1e25-2ba0-fd7e4117afc4@...1856...>
 <CAFHpkQHbGSsU7gsRcogr+7JzpDXoBd9r669cOpRxp1k8h91Smg@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <0526aa24-77dd-7901-a9c9-1287648fcf9a@...2080...>
Date: Mon, 21 Aug 2017 12:54:21 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQHbGSsU7gsRcogr+7JzpDXoBd9r669cOpRxp1k8h91Smg@...278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="SuvdA8PBM91rLirBLHhj02j9lJJEhTlWA"
Subject: Re: [Openvpn-devel] testing openvpn on gitlab-ci cloud ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SuvdA8PBM91rLirBLHhj02j9lJJEhTlWA
Content-Type: multipart/mixed; boundary="M6xhvgxMmJvl0Q5QjsNqB8qLJXwabhh7f";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>,
 Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <0526aa24-77dd-7901-a9c9-1287648fcf9a@...2080...>
Subject: Re: [Openvpn-devel] testing openvpn on gitlab-ci cloud ?
References: <CAFHpkQHXhe4UBAePJQXkBYJ+Sahc-3XpVPfPBo5oT6EKbzm3mA@...278...>
 <b524e527-9881-1e25-2ba0-fd7e4117afc4@...1856...>
 <CAFHpkQHbGSsU7gsRcogr+7JzpDXoBd9r669cOpRxp1k8h91Smg@...278...>
In-Reply-To: <CAFHpkQHbGSsU7gsRcogr+7JzpDXoBd9r669cOpRxp1k8h91Smg@...278...>

--M6xhvgxMmJvl0Q5QjsNqB8qLJXwabhh7f
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 21/08/17 10:23, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
>=20
>     2) The travis-ci setup for coverity and an early check of github pull
>     requests (which only is an early staging area for patches to be sent =
to
>     the -devel list later).
>=20
>     So I think we have everything that gitlab offers covered.  Let's not =
add
>     another setup to maintain.
>=20
>=20
> what I suggest is not "implement gitlab-ci immediately", I also do not
> want to support more configurations. It's rather "let us take gitlab-ci
> into account and implement it when there'll be appropriate task for it"

I agree that we should not duplicate the Travis/GitHub efforts.  But I
think it is good to look at alternatives to that setup as well from time
to time and spread out how we use various free services.  Not that we
change anything now and today.  But keep the options open to see if
there are better alternatives in a longer run.

One of my biggest concerns regarding both Travis and GitHub is that they
are free services built on proprietary solutions.  Which means, our
usage is completely depending on their willingness and grace.  If they
decide to change their business model, we're back on scratch unless we
decide to follow along and take the consequences of their change - which
may result in needing to cash out or accept fewer features.

GitLab is different, in the sense that in addition to offer a free
service (which is even less restricted than GitHub), they also offer the
software running their service as an open source package you can host
yourself.  Or you can cash out for their enterprise solution, with even
more advanced features and improved support.  On top of that GitLab
allows you to export most of your (meta)data in addition to the source code.

So if GitLab changes their business model, we have an escape route.  And
a company who provide that possibility needs to be much more weary and
careful to how they treat their users so they won't escape (unless they
deliberately want that to happen, as part of a business decision).

If I had to choose today which service provider to use, I would go for
GitLab instantly.  Because of their business model, I trust them more.
And I don't see their solution been worse or better than GitHub.  It is
different, not 100% comparable and doesn't have the same amount of
traction which GitHub does (if that is really important; I'm not
convinced it does).  But GitLab allows users to authenticate with GitHub
credentials, so if you're on GitHub already it doesn't cost you that
much to log into GitLab.

Bottom line: I appreciate the efforts of Ilya. I think it is valuable
work.  I also don't think we should switch right now, but if there are
some clear and obvious benefits of GitLab-CI over GitHub/Travis-CI, I
think we should consider to switch within a reasonable time window
(perhaps 3-6 months after decision is taken?).  _But that decision
cannot be taken without some clear and concise evidence of GitLab-CI
being superior and worth the efforts of switching_.  Without any
evidence, we're just painting the bike shed.  If changing, I prefer
changing to a feature-improved bike shed.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--M6xhvgxMmJvl0Q5QjsNqB8qLJXwabhh7f--

--SuvdA8PBM91rLirBLHhj02j9lJJEhTlWA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZmrvoAAoJEIbPlEyWcf3yuUEP/jwVWkVdl95jybcZHY4tWl0B
AVSlx7v52Ev+YH+6hj2wVAbmZlmSHPm4QMbipHhYzG10zE4LXAksVaBtToXJPf/U
iYYt4W5lHlVCt3gigDKZU74M5NtmyTF6kXWRfU5yBhlvle39hQRn7KGkJc8/gw+i
eofJBTAt0JXQbEH7d6jX/e3+KhGgr844+Sv6MehMLKKLutmk0BfjUH5fyvJfoLRC
almf7wq8UlByiXBSLoD9QfbZiBWeQZoz0k+ALyyrOie2pZxwdO09Bd1zDOpRsF+M
Fv9hPeH10mXqKn7Auza8CWjXUmQnPypJwoRJWoZqpJotguIa2IfT9oQQ53UQdman
vqZ4i8BpJc6UUWUp792jHNNNSa6pZcZTYbV5fFHGwjSF5Bqz/C2HuB0XRdxifRQz
UBlIdUIq1iD75o1tZtS1tuhYohEFpNvjkwaVwZ/PJuC7vRx8Fhy2osA+rr4MyKE9
RsRLnpQgWv/aMX4QBpfbHlZnP3Ipyl7Ou7EX0CqBG0nPIVYj7VmrGeEcbVANcaAU
VlFMYupTxZsXGIukZSSrHnalMo+T4TxJ2fHsjNONUsIH+OK7LU86AyGaBpKF1ISs
TijtdAnMnDOpmrWe06+nTPa3ZPHxmpeIpozagWMRf9qBQtdvF8pWFm1PHvrTnkdJ
lEUi8e1+kRDT3m1elix/
=NQiK
-----END PGP SIGNATURE-----

--SuvdA8PBM91rLirBLHhj02j9lJJEhTlWA--

