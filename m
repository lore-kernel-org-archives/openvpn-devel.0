Date: Tue, 8 Nov 2016 14:20:13 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161108132013.GA34092@...1296...>
References: <1478609729-25222-1-git-send-email-samuli@...515...>
	<1478609729-25222-5-git-send-email-samuli@...515...>
	<20161108131910.GB28918@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <20161108131910.GB28918@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 4/4] Allow passing extra arguments to
 fping/fping6 in t_client.rc
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: samuli@...515...
Cc: openvpn-devel@lists.sourceforge.net

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Nov 08, 2016 at 02:19:10PM +0100, Gert Doering wrote:
> > +	echo "$cmd $FPING_EXTRA_ARGS -b $bytes -C 20 -p 250 -q $targetlist" >=
>$LOGDIR/$SUF:fping.out
> > +	$cmd $FPING_EXTRA_ARGS -b $bytes -C 20 -p 250 -q $targetlist >>$LOGDI=
R/$SUF:fping.out 2>&1
>=20
> I would put the args at the end, so if needed, "-p 250" or "-C 20"=20
> could be overriden.

Well, "at the end" would be "before $targetlist", obviously :-)

Thus:

+	$cmd -b $bytes -C 20 -p 250 -q $FPING_EXTRA_ARGS $targetlist >>$LOGDIR/$S=
UF:fping.out 2>&1

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--BOKacYhQ+x31HxR3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWCHRDakuBuNlUUl1AQLw0AP/Y9Roj5eVPOcZvKLQfkLD5v8T/JJ58Mbh
Lf8gyriWWcuv21j13GfwoC9fNBpjBseQHKmFYAk+SKCPJMTpxEBfxeN2oCjzePnB
WUdDNHHEEXT3vSF2FEOqrFqWvE21BsovyIAdAGcw5GlzEjtfhWHSLzbB0uTdZ0E+
AFj+fOd1f9c=
=Bygk
-----END PGP SIGNATURE-----

--BOKacYhQ+x31HxR3--

