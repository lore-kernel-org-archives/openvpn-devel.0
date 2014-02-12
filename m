Date: Wed, 12 Feb 2014 12:11:36 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140212111136.GG16637@...1296...>
References: <1392201439.4875.15.camel@...1865...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IaUZxh88POJYDtkv"
Content-Disposition: inline
In-Reply-To: <1392201439.4875.15.camel@...1865...>
Subject: Re: [Openvpn-devel] Failure to configure TAP device under Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Woodhouse <dwmw2@...1866...>
Cc: openvpn-devel@lists.sourceforge.net

--IaUZxh88POJYDtkv
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Feb 12, 2014 at 10:37:19AM +0000, David Woodhouse wrote:
> I am not particularly familiar with Windows ??? is this just the kind of
> unreliable behaviour one normally expects with it, and not worth
> mentioning? Or is there some bug here that we could actually deal with?

It actually *should* work just fine.

I've never used the control panel to set up IPv6 addresses, but using
netsh worked nicely for me (and OpenVPN) - look into the openvpn sources=20
to see the necessary invocations.

We had our share of issues if tap adapter names included non-7bit-character=
s,
but that was completely different to what you are describing.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--IaUZxh88POJYDtkv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUvtW56kuBuNlUUl1AQLufwQAvWZ4pcE9YEVd/H1BUWxjZNRgu0sB7FBZ
MUGd5C9SqxMON8svUHlCSZx4Ev2m71RfeIyAJl6fbgMbYWxbJlHe50/zOQy7g3OR
tRhOHA8NrlGi4MEsYmkTRV28Mqcnp2jfLO/uLICyN/WHCW0heuhnFZ92BOX5WNNr
4BXAACjjFKk=
=p2Mh
-----END PGP SIGNATURE-----

--IaUZxh88POJYDtkv--

