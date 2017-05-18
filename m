Date: Thu, 18 May 2017 22:37:03 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170518203703.GS97029@...1296...>
References: <20170518155020.GN97029@...1296...>
	<20170518192015.28402-1-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Idd68gPqKLz5+Ci0"
Content-Disposition: inline
In-Reply-To: <20170518192015.28402-1-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH] distro: Remove outdated RPM .spec file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--Idd68gPqKLz5+Ci0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, May 18, 2017 at 09:20:15PM +0200, David Sommerseth wrote:
> Each RPM based distro have their own set of packaging guidelines.  We
> don't adhere to any of them and we're bad at keeping this up-to-date.
> Rather let distros take care of this job.

Generally speaking, I'm fine with the change and the reasoning behind
this.

I do wonder, though, where a naive user would / should go looking for
"the right .spec file" for his distribution now?  Say, I download this
tarball, and want to build a RH RPM from it...  does it make sense
to have a "spec-README.rst" or something that points to the spec files
"the major distributions" use?

(In case this is not obvious: I have no idea what I'm talking about,
the only RPMs I've ever built are on AIX... :-) )

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Idd68gPqKLz5+Ci0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZHgXvAAoJEB2Cnv7KVigSgzgMAIsXGQy8tnsJ2cDIBBf7cbLh
wte1Ug+m5FxL3iOePbehdq3yw2JOV2KkjqeT+h8k26r7jXZcvCXYPriVm2/dymJ2
SmjIGAWjaZlCwRUeLBJUgrEXTMM/XKPduyQ9QIIKFlmW1XPnBjugocZ8tyWvzSbW
2jPsQ1oijR3UeMIXKpAkab+Q8/FfQ3yEqN7RlJOOIq0giLee2WlRvesnCSEd4BBI
8exRwA3k6Nz2mwOrV85lOn2F1ie4tNcxYUk/qambX1Xtey1HytmcpUaNv0Xy7o+U
OihJVHIquEAcRaoliZoEgm1tvxqmm2dpBvFccsrZ43Bk9hDmUi/0awgp7sEEWEjr
kyOZGmuyWgu7PnpnJCXf/lpmOCqI46u9daUNcYPkOfUG/kEMpyVSkDH5lQGKWT59
y7rBQYqZyWvZNg9E9Lg1BGwlaj230nNlLnPjxnLt1RmjyCnoYc/2uk3s8qwe6l7Z
L0vfLG0RVO+3mNQdzeXR3CNV70MpULx9hvlpRxXxDA==
=EGCk
-----END PGP SIGNATURE-----

--Idd68gPqKLz5+Ci0--

