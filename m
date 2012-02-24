Date: Fri, 24 Feb 2012 18:15:30 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120224171528.GD7024@...1296...>
References: <4F438CF2.1060305@...515...> <4F4601A5.3080203@...1549...>
	<4F4610F1.7020002@...1114...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DOr+hlVy7JMLa9bO"
Content-Disposition: inline
In-Reply-To: <4F4610F1.7020002@...1114...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN 2.3-alpha1 preview 1
	installer now available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

--DOr+hlVy7JMLa9bO
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 23, 2012 at 11:12:01AM +0100, David Sommerseth wrote:
> [...snip...]
> > My recommendation is to:
> >=20
> > 1. Remove the "NOTE: explicit support for IPv6 tun devices is not
> > provided for this OS"
>=20
> Please try the attached patch and see if this works better.  I've flipped
> the flag about explicit IPv6 support for OSX/Darwin.  Your tests obviously
> shows the support is present.

I've added it, so it's definitely there :-) seems I just overlooked the
message.  And the "OSX platform cleanup" didn't happen yet.

> We probably could do some more checks to give a more exact error.  But as
> this is highly platform specific, I didn't dare touching the OSX code more
> as I don't have access to that platform at all.

I have a 10.5 box here, which is sufficient to do simple changes.

gert


--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--DOr+hlVy7JMLa9bO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT0fFsKkuBuNlUUl1AQK/EQP8CQtM8Ztb0zEmZEfc8vNQq2eid6sUa0Ew
iGr6bRTr7bhuEnQSWVAVFzuJdyHPtYlYdeTily64EYJDP92XiE5cKjFYlkkJNR9g
aiIx+KMGQccYZqJ+eCfRctoQdKSakgGQHafPdUMBEl0jDKBj/CzqZKIAn76JEgA9
Q2uDkpgj8CQ=
=QMhe
-----END PGP SIGNATURE-----

--DOr+hlVy7JMLa9bO--

