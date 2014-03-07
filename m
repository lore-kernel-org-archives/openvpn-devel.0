Date: Fri, 7 Mar 2014 13:20:43 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140307122043.GL16637@...1296...>
References: <1394186298-226674-1-git-send-email-vvk@...1868...>
	<53199C4F.6050006@...1227...> <255951394194357@...1873...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5El/nexOlxEtImhD"
Content-Disposition: inline
In-Reply-To: <255951394194357@...1873...>
Subject: Re: [Openvpn-devel] [PATCH] Flood unicast packet with unknown
	destination to all clients
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Vladimir Kamarzin <vvk@...1868...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--5El/nexOlxEtImhD
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Mar 07, 2014 at 06:12:37PM +0600, Vladimir Kamarzin wrote:
> > FEATURE ack from me. The code looks good, but I git am does not apply
> > the patch cleanly. Is the patch again master?
>=20
> Right, it's not against master, I've made it on top of ubuntu package 2.3=
.2-7ubuntu3. I'll rework it to master.

Thanks.  Policy is to only include bug fixes and "long-term compatibility
changes" into 2.3 at this point, new features go to master.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--5El/nexOlxEtImhD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUxm5m6kuBuNlUUl1AQLBUwQAqGF4VzEXHqP7wYY2Qi/Bq7+sSLSdZBJ+
+sdfGCfPcpHM3IwLrg9L1VLt/iUvgsgfxvB21s4hvohYAXy7/4xJrzMc9Np+VMkv
/j6jBpIi2xAtBWTZ2NHjM45/AOl8C9Tg+ZbDRK148dYWP3+hIcCqPIWBhwbreW8Q
WLrj1VQ1M70=
=Pb3T
-----END PGP SIGNATURE-----

--5El/nexOlxEtImhD--

