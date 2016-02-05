Date: Fri, 5 Feb 2016 07:49:46 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160205064946.GE24952@...1296...>
References: <2215306.x9ci9DhAZ9@...2001...>
	<1453835508-26119-1-git-send-email-gert@...1296...>
	<CAKuzo_iSwvk8MTW0ACT+n5JRkNDNyOoHHvmYw+fonN=ASUPuCw@...278...>
	<CAKuzo_hLdWaxZau_KtBhO1LvTivmurinrdqPsNTrjUfWnrZBvA@...278...>
	<20160204093823.GX24952@...1296...>
	<CAKuzo_isz+mde2P6=D=mMPQNEmcRQKmU-XNySVJxBK2eNzU-CA@...278...>
	<CAA1Abx+PCBhZM_wt_UTN6Kw=JZNJ7eUYt_tOpvVAuHqwnnmZbw@...278...>
	<CAPTYJtsrqCCSfdTEtUkWGw7T-YPqJ3foQROvCDu-byeDA43F3g@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MWE1g6mj7JKv+u7I"
Content-Disposition: inline
In-Reply-To: <CAPTYJtsrqCCSfdTEtUkWGw7T-YPqJ3foQROvCDu-byeDA43F3g@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] interactive service v3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Daniel Sim <daniel.ssq89@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--MWE1g6mj7JKv+u7I
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Feb 05, 2016 at 01:44:38PM +0800, Daniel Sim wrote:
> May I ask a more generic question about the implementation of the
> interactive service?
>=20
> So I understand that the patch allows clients to instruct the service to
> modify the routing table.=20

Yes and no.  It allows clients to instruct the service to run OpenVPN
on a pre-installed config file - and the service will pass a pipe handle
to OpenVPN on which it's willing to receive route change instructions.

Part of the discussion we had was to have a checkbox at installation time
that restricts the service to only run .ovpn profiles from a well-defined
and admin-only-writeable directory (and also change the argument handling
between gui and service to refuse to accept arbitrary command line=20
arguments).

> In short, it allows ordinary users (since any
> program could impersonate the openvpn client) to modify the routing table.

Not by impersonating the openvpn client, but by running a "rogue profile"
via true openvpn - but for your c&c example, you need more than "just=20
routing" anyway.

[..]
> Wouldn't it be better as debbie10t suggested to restrict ordinary users to
> only the VPN configurations that are permitted by the administrator?

Which is the plan.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--MWE1g6mj7JKv+u7I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVrRGCakuBuNlUUl1AQI9jQQAnqSbBnh1pARmWf9YPqBXuAka9OX33t0l
d/abFUskJXb6DTBDqS/6IOBVT7ZnEYPGZw+OOoLZWSJUyrnqzAmnRrMJHEUy7DWP
9OQCNxDgkvHGQtzQVgZWo3ImOYmJ7aABR86QEcoLJF5D7ybNPgUK0k3hMVzMzTOY
lfQK6xkyDsY=
=DaFS
-----END PGP SIGNATURE-----

--MWE1g6mj7JKv+u7I--

