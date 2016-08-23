Date: Tue, 23 Aug 2016 14:34:39 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160823123439.GA78279@...1296...>
References: <57A3C76A.1020809@...277...>
	<CAKuzo_h0vMR4jv=iAgT2Vr2kq-nJRDs0Pq=3JC7eydQ-m1Ucpw@...278...>
	<f9d8f147-e3d1-b80b-5646-faba6b853bc2@...277...>
	<76eb908d-b7b3-7425-5340-e4cd5726fbd1@...2080...>
	<3642cff2-6233-0a28-2a39-36513f008ab4@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3pZv5aVBMTAsT+kh"
Content-Disposition: inline
In-Reply-To: <3642cff2-6233-0a28-2a39-36513f008ab4@...277...>
Subject: Re: [Openvpn-devel] Win10 Tun Server +Standard W10 User +OVPN
 Interactive Service +OVPN GUI
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: debbie10t <debbie10t@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--3pZv5aVBMTAsT+kh
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 23, 2016 at 01:55:23AM +0100, debbie10t wrote:
> I need to use --up/--down/--client-connect/disconnect et al ..

You can, but they will run with the user privileges of the user that
runs openvpn-gui by default.  If you need more privileges, you need
to run openvpn.exe or the gui with admin privs.

> How does one run openvpn on *windows* without these "considered"
> security flaws ? or are we all just "lambs to the slaughter"
> from here on in ?

You can use openvpnserv2 to run openvpn.exe with admin privs (and no
gui), or you can set [x] run as admin on the openvpn-gui (as it was done
for 2.3.x).

Most people on windows only need privileges to add/delete routes and
configure IP addresses - this is what the iservice will give you, without
the potential dangers of running openvpn and all scripts with full
admin privs.

(Since you already use git master snapshots, you already have the new
stuff - and since it works for you, nothing to be afraid)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--3pZv5aVBMTAsT+kh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV7xC36kuBuNlUUl1AQKNOgP/ZFp9hLREosu+CgSQCURO0axJauAxXdwb
lVVoEv7rfAThuHFKSSrt9n31iBKMg85oQT0VROlLx4hYk0+QOej0CknrFUWeKoXH
2EcIAeu12xzuofeVEKetfojJLdM+ch38Sp2PdFEcTvR3pTNDZ5ZWLUmB4FUezqVI
nX0I/x/BUOc=
=t4I3
-----END PGP SIGNATURE-----

--3pZv5aVBMTAsT+kh--

