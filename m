Date: Thu, 11 Apr 2013 15:17:49 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130411131748.GR569@...1296...>
References: <1346422753-19520-1-git-send-email-arne@...1227...>
	<201304110933.r3B9XwPT011987@...1729...>
	<20130411105202.GA26778@...1296...>
	<5166B459.9020801@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lG9v85r552aFjg4G"
Content-Disposition: inline
In-Reply-To: <5166B459.9020801@...515...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add the client id (CID) to
	the output of the status command
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--lG9v85r552aFjg4G
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 11, 2013 at 04:02:17PM +0300, Samuli Sepp=E4nen wrote:
> > On Thu, Apr 11, 2013 at 11:33:58AM +0200, Gert Doering wrote:
> >> Your patch has been applied to the master branch (ACK by me).=20=20
> >>
> >> I'm not sure whether we need this in release/2.3, but if people see th=
e=20
> >> need, please speak up and I'll cherry-pick :-)
> >>
> >> commit 662ce6acc065bddf6490b3494725b8b3987b7def (master)
> > ... unfortunately, it breaks --disable-managemnt builds :-( - good that
> > we have buildbots, stupid me for not noticing it before ACK-and-push.
> I wonder if using a "staging" repo would be too much trouble? Buildbots
> could track it, and only after all builds have succeeded, the changes
> would be pushed to master.

You and David explain to me what to do, I do :-)

(Including "how to un-push things pushed to staging if they turn out
to be non-useful")

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--lG9v85r552aFjg4G
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUWa3/KkuBuNlUUl1AQIBCwQAg2qMjbdIi7hDLdyfSpZu6I/9oFeLB/l6
RfXxao72H1vVYVrkseychN22fZ12osrnCUeEavoeMcO4g/DVE5pjsEdgrx+cW9nq
kpUX/SPmAuhVRXmI97FfPfJGdj0H3ZmRhIRGxvcsYy7TPdQwR+rB9yYwKI7VoKJX
rCZMGXQIgpA=
=0V6b
-----END PGP SIGNATURE-----

--lG9v85r552aFjg4G--

