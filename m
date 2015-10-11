Date: Sun, 11 Oct 2015 19:44:43 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20151011174443.GN22054@...1296...>
References: <1444571266-6598-1-git-send-email-arne@...1227...>
	<CAA1AbxJ+GvoaeAz4qhyzAN=MNr4wfm2cN_0TRweGzer8cnhCjw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w+rhPQc/K9ract27"
Content-Disposition: inline
In-Reply-To: <CAA1AbxJ+GvoaeAz4qhyzAN=MNr4wfm2cN_0TRweGzer8cnhCjw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Do not set the buffer size by default
 but rely on the operation system default.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--w+rhPQc/K9ract27
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Oct 11, 2015 at 04:25:30PM +0200, Steffan Karger wrote:
> > --- a/ChangeLog
> > +++ b/ChangeLog
> > @@ -1,6 +1,9 @@
> >  OpenVPN Change Log
> >  Copyright (C) 2002-2012 OpenVPN Technologies, Inc. <sales@...515...>
> >
> > +2015.xx.xx -- Version 2.4.0
> > +       - sndbuf and recvbuf default now to OS default instead of 65k
> > +
>=20
> Nice, changelog entries!  But, 65k should be 64k.

ChangeLog entries are good, but I disagree on the format (sorry) - what
we have in ChangeLog *today* is basically "git shortlog $tag..$HEAD"=20
when doing a release - so I think we should not mix the "user visible
changes" in here, but maintain a separate file, eg. "CHANGES(.rst, .md)",=20
for these.

Alternative, rename ChangeLog to "GitShortlog.txt" and put the user visible
changes into ChangeLog - but please do not mix.

(The rest of the patch is fine, but should mention trac #461 in the
commit message - I'll amend if OK)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--w+rhPQc/K9ract27
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVhqeCKkuBuNlUUl1AQKRlQP+PxL+7Dd92X1fFuW3QUXwQi5zSt1mgStx
Ov9q/lEIBE4yG0yY00Lft9D1BOXI2x5inEOavayPwBsI5ceSpJeQWqHApWvTif+h
TJ16x6OqApsQdBnpDkF2jgW7XIfeOy6azBX4p0qTWHzrqMHa8Gzoz7n8s3ON/48j
TVn6y4xKBwA=
=QqVD
-----END PGP SIGNATURE-----

--w+rhPQc/K9ract27--

