Date: Fri, 4 Nov 2016 16:34:17 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161104153417.GJ28918@...1296...>
References: <a76fef6e-6cc6-0878-4cf6-293d84b4edd3@...277...>
	<deb274b8-709f-9bec-40f3-279d75d114a0@...2070...>
	<20161030101616.GV28918@...1296...>
	<1a5fa7e8-d359-9128-c9b5-bb7049339aef@...1227...>
	<CAKuzo_ihMpz6bYjcV1T8v6e8yhU+iWNsHOb7ngM_bxPL583LDg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DbCiEIZK/ffHkrHm"
Content-Disposition: inline
In-Reply-To: <CAKuzo_ihMpz6bYjcV1T8v6e8yhU+iWNsHOb7ngM_bxPL583LDg@...278...>
Subject: Re: [Openvpn-devel] dhcp-option DNS IPv6 server address for windows
 client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--DbCiEIZK/ffHkrHm
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Oct 30, 2016 at 03:23:06PM -0400, Selva Nair wrote:
> > >> ?probably not only DHCPv6, but also Router Advertisement too. I doubt
> > that DHCPv6 could be used without RA on Windows.
> > >
> > > It's a somewhat multi-stage thing
> > >
> > >  - first, define a new dhcp-option (like, "DNS6") that will take a
> > >    v6 address, and put it into the environment variables on the client
> > >    (so scripts and networkmanger etc. can pick it up and do the right
> > >    thing wrt resolv.conf)
[..]

Just as side note - there's trac#243 already for this, which is tagged
as "release 2.4" :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--DbCiEIZK/ffHkrHm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWByqeakuBuNlUUl1AQLfGgP+IDFPjyV+GCKg6i8tBAfJOqUXRTVoHxvy
HpGEmprsn4lJNgLvUeciO/J5VPeLbth2s8fvwSJCzrfmVctDuFfdaUDFUWEzopQB
gTM3PgrqcDoISNIXxAZnU4eBTJwS8pLTfw4E0Q/j2bSN14OildDgHMJfSBPvKZ+K
UyrfqNkSojk=
=akCf
-----END PGP SIGNATURE-----

--DbCiEIZK/ffHkrHm--

