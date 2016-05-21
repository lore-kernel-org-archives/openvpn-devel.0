Date: Sat, 21 May 2016 13:10:16 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160521111016.GS53051@...1296...>
References: <1463822525-2532-1-git-send-email-openvpn-devel@...2127...>
	<1463822525-2532-2-git-send-email-openvpn-devel@...2127...>
	<20160521095424.GQ53051@...1296...>
	<BF0BE230-3DDA-4CF6-A8DB-CABBE0825CF4@...2127...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k/CX8isIRYlIKXvG"
Content-Disposition: inline
In-Reply-To: <BF0BE230-3DDA-4CF6-A8DB-CABBE0825CF4@...2127...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] Refactor t_client.sh
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jens Neuhalfen <openvpn-devel@...2127...>
Cc: openvpn-devel@lists.sourceforge.net

--k/CX8isIRYlIKXvG
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, May 21, 2016 at 12:10:04PM +0200, Jens Neuhalfen wrote:
> > This script needs to run on all platforms we support, and that includes
> > more esoteric ones like AIX and Solaris - OpenSolaris /bin/sh is a ksh93
> > variant (nowadays), so if it works in ksh and dash (Debian /bin/sh), I'=
m=20
> > fine???
>=20
> Arrays are indeed not POSIX compliant. Do we have some hard baseline=20
> of systems we need our tests to run on? I have SmartOS (Solaris derivate),
> I could get my hands on a Solaris VM (10 or 11, I???ll need to check with=
 Oracles
> license) for local testing.

My buildbots test on "all the BSDs" (Free, Net, Open, and they have a
/bin/sh which is "It only supports features designated by POSIX plus a few=
=20
Berkeley extensions") and OpenSolaris 11 (ksh93).  Samuli's buildbot
test on various Linux variants, so "dash" should work.

> I have virtually no experience with AIX though.

Generally speaking, AIX is major pains :-) - but the /bin/sh is a ksh,
so if it works in ksh93, AIX should be fine.

> As these tests are only run on development machines I assume that we can=
=20
> require some additional packages to be installed?

We already need fping/fping6 for t_client, so yes.  Autoconf wants Perl,
so if it makes sense to rewrite t_client.sh to use that, it might be
another option (but we shouldn't require extra perl *modules*).

> I???ll make sure that it works on
>=20
> * Ubuntu Precise Pangolin
> * Mac OS
> * Solaris 11 (btw: Do we use gcc or Solaris Studio?)

If these all work, we should be in good shape - I was mostly worried
about Solaris, but MacOS might have some surprises as well.

I compile using gcc on Solaris, but haven't received any reports about
Solaris Studio *not* working - whatever that means ("nobody uses Solaris"
or "it just works") :-)

> Can you do a final test on AIX after I am done?

Happy to.  I can't give other people access to the AIX systems (customer),
so can't run a buildslave there - but running openvpn tests is fine.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--k/CX8isIRYlIKXvG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV0BCGKkuBuNlUUl1AQLSTgP+NHR3NvTd5QY2y3hzX1OHyoEq821Bv+cJ
cBYVNPm9pMB+wM3hiazFHCQVHrSl1Hn/pgBsbVB4DPBD8aWlt4KmMXlZwAaHRgjb
EKydpeD3a+2CFWdbdwjpKtKhXbtTCMcq8rzHQWYNnRJ5vO2cpnWN9Bb/RSkXmqIG
rtOLLWoq9IM=
=9fie
-----END PGP SIGNATURE-----

--k/CX8isIRYlIKXvG--

