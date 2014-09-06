Date: Sat, 6 Sep 2014 14:31:48 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140906123148.GE1118@...1296...>
References: <5408494D.7050407@...1435...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EiSSoD3jrYkcqL01"
Content-Disposition: inline
In-Reply-To: <5408494D.7050407@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] Remove quadratic complexity from
	openvpn_base64_decode()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--EiSSoD3jrYkcqL01
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Sep 04, 2014 at 01:13:17PM +0200, Steffan Karger wrote:
> Attached a patch for a change suggested by Jann Horn, to remove the
> quadratic complexity from openvpn_base64_decode().
[..]
> That said, I do like the suggestion to make the code constant time. I'd
> say it should be applied to both master and 2.3 branches as a bugfix.

ACK.  Will merge to both branches ASAP.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--EiSSoD3jrYkcqL01
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVAr+tKkuBuNlUUl1AQIIkQP/fNNOJXCPRNkvyIFMq2XUprb5RIyx3FYF
Rekl1XExtWK55ZuZurT1fH0b5u/ln+oAYNZzYx0Hn37gZ1XdUfdNdFWXt6iV4WUO
Rkv5c0bjIDhn7NG7du9CS0LnO+8jzu8/VG/Wl1ckX+zM+4f8y3CFJXoM2qZJIEkt
3hB8D2YW37U=
=Oe4X
-----END PGP SIGNATURE-----

--EiSSoD3jrYkcqL01--

