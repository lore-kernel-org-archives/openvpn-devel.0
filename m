Date: Wed, 12 Sep 2012 11:40:01 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120912094001.GQ742@...1296...>
References: <1345211355-26513-1-git-send-email-heiko.hund@...1489...>
	<1347377664-15462-1-git-send-email-dazo@...384...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bzq2cJcN05fcPrs+"
Content-Disposition: inline
In-Reply-To: <1347377664-15462-1-git-send-email-dazo@...384...>
Subject: Re: [Openvpn-devel] [PATCH v3] Add --compat-names option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <dazo@...384...>
Cc: openvpn-devel@lists.sourceforge.net

--Bzq2cJcN05fcPrs+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Sep 11, 2012 at 05:34:24PM +0200, David Sommerseth wrote:
> From: Heiko Hund <heiko.hund@...1489...>
>=20
> With this option, users can basically undo the changes of the UTF-8
> support commit 5e86fd93779482b90a191f929edebe414cd78a4f. It's here for
> short term compatibility and should be removed again as soon as possible.

ACK.  Reviewed, and looks good.  Have not actually test-compiled and run
it as I do not have client certificates in place that contain UTF-8 or
other funny characters - but I trust Heiko to have seen enough of that
in his environment :-)

(I *do* think that the bit-shifting in compat_flags() is "slightly"=20
overengineered, but programmers have the tendency to invest lots of
brains and some code into saving a single bit... :-) - it will do the
job, though, so no need to spin a v4 for that)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Bzq2cJcN05fcPrs+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUFBYcakuBuNlUUl1AQImYwP+LPWR8zlAaN8rWwDUu38ohWpfAGYXompo
AuIOwtjo8ecWx5BAWyfvOm3poey4Rgzq7WINquKnAhS/3H+tLk774aXlZZHejze3
MTTdWt1pNdyjVYtSABhxAahHc04/s+4Luu+3r2AKZjbx1qWofEPQT1FIdBlF7OlW
Hj+UlH3WTHg=
=rePt
-----END PGP SIGNATURE-----

--Bzq2cJcN05fcPrs+--

