Date: Fri, 22 Sep 2017 23:25:54 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170922212554.GC70062@...1296...>
References: <20170906235202.26551-1-davids@...515...>
 <20170907061646.GD70062@...1296...>
 <79762b44-c8c8-b765-1711-22ba3f210af0@...515...>
 <1e1b1ed5-5a4e-5234-1e57-06a609a6f2b9@...515...>
 <20170907081340.GG70062@...1296...>
 <8f028968-1263-af79-4b49-863a202b9d93@...515...>
 <188385e3-e632-5ae4-4b16-4c724bcec6b1@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="SCk9FC6hAD6beNza"
Content-Disposition: inline
In-Reply-To: <188385e3-e632-5ae4-4b16-4c724bcec6b1@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Enable systemd's auto-restart
 feature for server profiles
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>, Gert Doering <gert@...1296...>, David Sommerseth <davids@...515...>

--SCk9FC6hAD6beNza
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Sep 07, 2017 at 03:16:45PM +0200, David Sommerseth wrote:
> So the RestartForceExitStatus/RestartPreventExitStatus is not going to
> be helpful if all graceful errors results in 1, which is the most common
> way OpenVPN stops - through the M_FATAL.  So that leaves us with
> SIGSEGV, SIGABRT and similar unclean exit signals.
>=20
> To avoid restarts on faulty configurations or if we can define scenarios
> where we do not want OpenVPN to be restarted automatically, we need to
> introduce more exit codes.  This way we can implicitly tell systemd if
> it should restart OpenVPN or not.

Indeed.  Just to agree publically here :-) - it seems we'll need to
revisit exit codes as well, for "restarting this won't do any good"
(fatal config errors, for example) vs. "we have crashed, and please do
restart!!" (out of memory as something obvious we can't easily catch,
most other error situations wrt network *should* not cause a M_FATAL,
even if some still do).

Where do we keep this as "we need to look into it, but it's complicated"
reminder?  trac?

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--SCk9FC6hAD6beNza
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZxX/hAAoJEB2Cnv7KVigS8XcL/RnzoHkPhZkEUdiUBx377ufm
v84E1eXWfZuXqQQYR6Fh7HYkuAPOUzKAvXgun0ssEsPC+iRp28Y3fF8U3PoIMtzH
uUmhfCT8tfJb5Tkzym6hlvDljWdm+x6M/KEXR4m+hxevzSfhl7NpIpUSxE/4ZazA
6JCRuhHC2o+Y0fGafsnmqNmxCO54b3ockrDtZ1vqiXMBvzzat9unBcZtUoTcZWu4
3OtkF80tUx1YiEJTZaJMQx3H5/KelEEjmkitLDxorSWJwMdLCShhgaNBxaKdh66u
RqooKysHbJF7FWd5K1h7kGZftgpNJn8MdiUnRRxsgYrLQRvk6XnQOFAxKSDFPolD
5odIZc+Fb2RvDDcJhl2yAS7hdEf46qVXX+SnEPyZcW23Mgh43wEXVuFg3EONyNlN
RIO21AldxAsKWM9SkRS+XpaMU0t5Hd7O26tXmMP50oLT6IzuEmaUfTCoMZKdjZCy
vAEK0xLS2NVVRdsF9INexaMY8o4dCI9t+9UFzh5H3A==
=NE+o
-----END PGP SIGNATURE-----

--SCk9FC6hAD6beNza--

