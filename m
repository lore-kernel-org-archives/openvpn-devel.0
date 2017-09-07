Reply-To: openvpn-devel@lists.sourceforge.net
References: <20170906235202.26551-1-davids@...515...>
 <20170907061646.GD70062@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <feb52e8f-971d-bdc8-2320-9eefe647356e@...2080...>
Date: Thu, 7 Sep 2017 16:38:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170907061646.GD70062@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="UoH3IBTACmwOolDCLRcPCuCVMiWToegD3"
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
To: Gert Doering <gert@...1296...>, David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UoH3IBTACmwOolDCLRcPCuCVMiWToegD3
Content-Type: multipart/mixed; boundary="JkLvcIKiKp16w3OLnkSIsa2SJDPNqs3RP";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <feb52e8f-971d-bdc8-2320-9eefe647356e@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Enable systemd's auto-restart
 feature for server profiles
References: <20170906235202.26551-1-davids@...515...>
 <20170907061646.GD70062@...1296...>
In-Reply-To: <20170907061646.GD70062@...1296...>

--JkLvcIKiKp16w3OLnkSIsa2SJDPNqs3RP
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 07/09/17 08:16, Gert Doering wrote:
>=20
> Restarting is good, but if there is something faulty that leads to
> "the process always dies right away", this can lead to very quickly
> filling disks with not-so-useful logging...
Oh, I overlooked this one.  Just one comment in regards to the "filling
disks".  That naturally depends on how logging is configured on the
system, and that varies a lot.  But my experience based on defaults in
the environments I use:

* systemd journal have some reasonably sane defaults to avoid this to
  happen; IIRC it defaults to rotate the journal when reaching 10-15% of
  available disk space *or* 4GB of log data.

* RHEL (and clones) usually have rsyslog installed too, which the
  journal forwards log data too.  And it most commonly it also have
  logrotate installed too (at least on the server variant) which runs
  on a regular basis.  But it also depends on how big the partition
   where /var/log resides is.

So the risks for such restarts to cause full disks should be fairly
minimal.  And for those who have enabled remote logging, that is often
to pay more attention to log events, so then such scenarios would
probably be detected even quicker.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--JkLvcIKiKp16w3OLnkSIsa2SJDPNqs3RP--

--UoH3IBTACmwOolDCLRcPCuCVMiWToegD3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZsVnhAAoJEIbPlEyWcf3yDyYP/1jO+pUHFng23yIwqrc745K7
JNiRZwaD+FXkXfo0TH/qGWcL9iK0tB6abZf8zDTjiJY40Pdxy8iMQYEjI94t2TS9
50tH/QHdcHoPRGqMpXdsHsWnj5bjOmNoTarl7dlA68fauwEuoIpySSeDYZbdioKI
xtTdbrzA5AU3VXdSkvJ0fvYGLJRCELK5pQENRjiAUpVoB/bvRbdM+LfvfKn2tLH7
+nlMPXM81YhtPXtNc8nNULH73giEkyopQJhfxN/CAofLs0ACAZGHveNjfr/5luU+
O3S2wXS0AegTTYpUygP4volcfhmLmaXhT3GJrNVExmyNoVKArDrNybrFJvP6Fm4y
ZKKGgiD9Lnqj7A6hX+oNYlq6SBvP+OqrQ7O3Zd29Bris21PcCLQCmmtnElIyPpVV
+Gc7zRVh28qgbkIzOvAWgrUGmJVlGl2NmN6fQusq9WaDISkYkdJPfJhCsGhfUq6s
MPLtEdnz2+RsaHRnEoCCmq/3xnAbCgq4QlfMsF9Kuy42EudBEBSdI0xxoMqnZt9Q
la0tZAZ9w3oMvwtx3YTNQwqzRl+kyEl0UzIQNz9gunqG+gP/C0prywHgUK2g/tMn
KgTofLEQTKIIegVbnhNJIOYhNUeWuV2qyfb+35umDQHhIcOCbVjMyvVD3stTWvqj
v6tUvWSveTmNQnnWA7Wo
=7gTR
-----END PGP SIGNATURE-----

--UoH3IBTACmwOolDCLRcPCuCVMiWToegD3--

