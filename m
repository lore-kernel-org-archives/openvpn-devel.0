Date: Sun, 21 Jun 2015 16:42:19 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150621144219.GV382@...1296...>
References: <20150617100752.GG382@...1296...> <55843EAD.6010305@...1147...>
	<20150621135503.GO3678@...2038...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NRam5+CokH1YmQkV"
Content-Disposition: inline
In-Reply-To: <20150621135503.GO3678@...2038...>
Subject: Re: [Openvpn-devel] why is "route add failure" considered not an
	error?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--NRam5+CokH1YmQkV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Jun 21, 2015 at 03:55:03PM +0200, Maximilian Wilhelm wrote:
> Bonus points for pointing out OpenVPN has not been started with
> administrative rights and that that might be the problem.

Patch welcome :-) - this is somewhere on my todo list, but I'm not a
windows programmer, so I never got started in actually figuring out
*which* privileges are needed, and how to check whether they are present=20
or not...

IOW: I agree that it's useful functionality and will happily merge it,
but won't be able to code it any time soon.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--NRam5+CokH1YmQkV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVYbNS6kuBuNlUUl1AQLh+gP9Gw1qg09621wH3J4b4RPoAPnVMzQUxVK0
PzWSXF5IM4yNCjxGlFrjiVCh783twLo1SjVw4bTQfSJ/eQMEBJxBwCoAZnRDqOel
rDl2q0FhNcwsUqWW18swZvfi72qjeBkIr/Xxr0Ld29XeCmtGY9ETWpNaVGfYiuPA
Rdholl1cIcM=
=z1UN
-----END PGP SIGNATURE-----

--NRam5+CokH1YmQkV--

