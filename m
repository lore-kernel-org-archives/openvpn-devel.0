Date: Wed, 23 Oct 2013 19:49:05 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20131023174905.GQ161@...1296...>
References: <CABDcBMk1BvzgOx+8pexTssmmFLgNNWjxxCYqj2nPxOW+iA8AYg@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VB8cwN2oRT/o81UX"
Content-Disposition: inline
In-Reply-To: <CABDcBMk1BvzgOx+8pexTssmmFLgNNWjxxCYqj2nPxOW+iA8AYg@...278...>
Subject: Re: [Openvpn-devel] Linux client cant connect through socks proxy -
	any known workaround?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steve Cook <stevecookhk@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--VB8cwN2oRT/o81UX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Oct 23, 2013 at 10:50:11PM +0800, Steve Cook wrote:
> I can't get openvpn to connect through my socks proxy server, and searchi=
ng
> around seem to find other users with the same problem, but no known
> solution.

It "should" work.  Does the Android client work?

(I'm asking because it's basically "the Linux client" with lots of socket
fixes that we do want to integrate into git master "ASAP", even though
"P" has been "not now" for the longest time :-/).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--VB8cwN2oRT/o81UX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUmgMEakuBuNlUUl1AQLelwP9HE9q0veT3TC2Z/Dx8ImQbFZtintfOpSB
7NdJVMia0TJ9XYCjNAO0cwoofEq/RZeDpbceLS5GwTXr2nd/YPjFXE68CPdXCCDt
8ozQfeT7yZCru/0nO92o4rFa49PdzGOg+sEyd87Nv920Uqojb+FOA8M89wf2z9v1
/PMsTy4e87A=
=RmQA
-----END PGP SIGNATURE-----

--VB8cwN2oRT/o81UX--

