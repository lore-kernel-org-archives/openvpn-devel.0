Date: Tue, 21 Oct 2014 12:43:08 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20141021104308.GZ396@...1296...>
References: <54450921.30501@...515...> <54461F20.5060908@...1147...>
	<20141021091159.GY396@...1296...>
	<CAEsd45SOhJcowu27gs6Be5YShph91pUBwq4eBfhGtpCT2MXo1w@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f3n33hPtqmWgzvaY"
Content-Disposition: inline
In-Reply-To: <CAEsd45SOhJcowu27gs6Be5YShph91pUBwq4eBfhGtpCT2MXo1w@...278...>
Subject: Re: [Openvpn-devel] New OpenVPN Windows installers (I004 and I604)
	released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--f3n33hPtqmWgzvaY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Jonathan,

On Tue, Oct 21, 2014 at 05:45:11AM -0400, Jonathan K. Bullard wrote:
> On Tue, Oct 21, 2014 at 5:11 AM, Gert Doering <gert@...1296...> wrote:
> > This will hopefully be fixed in 2.4 with the interactive service, we ju=
st
> > need to find time for Heiko to find the code and send it to us :-) (but
> > I've already seen it last year)
>=20
> Is there any documentation for the new "interactive service"? I assume
> it is part of the separation of privileges that was discussed a while
> ago.=20

Yes, exactly.  In essence, you have a windows service running with full
privileges, which is instructed by the GUI to run an openvpn.exe process
(with user privs, so OpenVPN can't do damage) and OpenVPN communicates
back to the service what should be ifconfig'ed and what routes should
be installed.  So the network config is done by the service, and=20
undone when OpenVPN exits or crashes.

> If no docs, can anyone point me to the commits, or the names of
> the modules / routines involved, or anything else that might help me
> integrate this into Tunnelblick? Thanks.

Unfortunately, right now, there is nothing at all yet - there is most of
the code, but it's still living in Heiko's private tree.  We plan to meet=20
in person in November ("Munich Hackathon") and hopefully this will unravel
the knot that's holding up this change.

How do you handle things in Tunnelblick today?  Run OpenVPN "as root"?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--f3n33hPtqmWgzvaY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVEY4vKkuBuNlUUl1AQL4HAP+JcZxRbyBaxgYJwr6+B7oCIgZjvLbM4eO
4eGGnQI9YeT+6rAo3LbzireklpoZbWw+QsCmJLwD6F40l/WoxAGX9IWABmbYpF8t
E0pDpbrEd2ZUUKv27ODAdnvqWgNMoiEkMRPKXHUGwCfPCpYv7bDZC3HxyF2vmg5K
QNvfPuU1M4c=
=CQmz
-----END PGP SIGNATURE-----

--f3n33hPtqmWgzvaY--

