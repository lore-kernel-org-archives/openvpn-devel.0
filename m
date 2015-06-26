Date: Fri, 26 Jun 2015 19:10:34 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150626171034.GC382@...1296...>
References: <1435248080-12670-1-git-send-email-Holger.Kummert@...1516...>
	<20150626073544.GT382@...1296...> <558D2D98.70905@...1516...>
	<20150626112401.GU382@...1296...>
	<20150626143636.GY382@...1296...> <558D8597.2040501@...1516...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BKYHe3FJ4WE+sAbV"
Content-Disposition: inline
In-Reply-To: <558D8597.2040501@...1516...>
Subject: Re: [Openvpn-devel] [PATCH] Del ipv6 addr on close of linux tun
	interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Holger Kummert <Holger.Kummert@...1516...>
Cc: openvpn-devel@lists.sourceforge.net

--BKYHe3FJ4WE+sAbV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 26, 2015 at 07:02:15PM +0200, Holger Kummert wrote:
> >Mulling over this for a while, I think I've come to a conclusion on
> >"what we should do", and "what we should do in the 'persistant tun'
> >case" (#141)
> >
> >  - normal case: we do "ip addr add" and "delete" - proper housekeeping,
> >    and having IPv4 and IPv6 in sync  (so, Holger's patch for Linux,
> >    and possible similar additional code for all the other OSes)
>=20
> I looked at some other OSes in tun.c and found no other with this flaw
> at a first glance (other do simply a 'destroy' or 'unplumb' of the=20
> interface). But probably I oversaw something here.

"destroy" is only done if we actually created it - if we found the
device to be "already there", we leave it alone (so that might end up
with a newly acquired v6 address, then).


> >  - if someone really wants/needs a persistant device (created with
> >    "openvpn --mktun --dev tun3" on Linux / "ifconfig tun3 create"
> >    on *BSD), and expect it to always keep the addresses on it, they
> >    should call "openvpn --ifconfig-noexec".
>=20
> Yes, this sounds like a good idea to me. Had also something like
> "--ifconfig-notouch" in mind, but your proposal is shorter.

Since --ifconfig-noexec is already there... .-)


But I'm still interested to understand why your setup triggers this issue,
and mine doesn't.  The only reason I can see (really!) is that tunX has
been created outside OpenVPN... - which might actually make sense if
a firewall is involved, so you can tie rules to the interface right
away, which won't work if the interface does not exist yet... (does it?)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--BKYHe3FJ4WE+sAbV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVY2HiqkuBuNlUUl1AQKskgP/bdZI+aMzw7ZwrRHGb3c2/zRB3MTJQ+vY
J7gvKDWrvQHWBoXW9h0fB/GcJcefP3BxQrsk3L8f/TtW8WSxBFhrZcTmBwR6WOU+
uTOXPkJ+NP8Dvx8Z6de4jbf0aV78RuN/KR7z8H1ddLktaFVQn7BUL0/ex8XKDASR
y7M8dw4Bfnc=
=X4Vm
-----END PGP SIGNATURE-----

--BKYHe3FJ4WE+sAbV--

