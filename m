Date: Tue, 8 Nov 2016 14:19:10 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161108131910.GB28918@...1296...>
References: <1478609729-25222-1-git-send-email-samuli@...515...>
	<1478609729-25222-5-git-send-email-samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i+pmTOJ7usc0SF/I"
Content-Disposition: inline
In-Reply-To: <1478609729-25222-5-git-send-email-samuli@...515...>
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

--i+pmTOJ7usc0SF/I
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Nov 08, 2016 at 02:55:29PM +0200, samuli@...515... wrote:
> -	echo "$cmd -b $bytes -C 20 -p 250 -q $targetlist" >>$LOGDIR/$SUF:fping.=
out
> -	$cmd -b $bytes -C 20 -p 250 -q $targetlist >>$LOGDIR/$SUF:fping.out 2>&1
> +	echo "$cmd $FPING_EXTRA_ARGS -b $bytes -C 20 -p 250 -q $targetlist" >>$=
LOGDIR/$SUF:fping.out
> +	$cmd $FPING_EXTRA_ARGS -b $bytes -C 20 -p 250 -q $targetlist >>$LOGDIR/=
$SUF:fping.out 2>&1

I would put the args at the end, so if needed, "-p 250" or "-C 20"=20
could be overriden.

Thus, feature-NAK.

Code-Change is OK :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--i+pmTOJ7usc0SF/I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBWCHQzakuBuNlUUl1AQLNKgP+Mw3LA77Fs5Pf085lBf4meib5H0r9M4Cz
6O9DFr02VWq7/prC8hwjeFcdUmnsHwgmmxfI7VQgYC6pKdwmrUFLhV+s36lVbP20
FJr2U4JRLBc119bAgUMYGU4+s08fX02eR/ekMe07FP8bisvpQOcbDkipZa/G2HXD
ACCOaArz938=
=pta5
-----END PGP SIGNATURE-----

--i+pmTOJ7usc0SF/I--

