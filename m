Date: Wed, 25 Jan 2017 18:37:17 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170125173717.GA940@...1296...>
References: <20161227222406.931-1-list@...1798...>
	<20170125160428.19928-1-list@...1798...>
	<5285c33f-98e5-4e06-0ed8-95728a74f755@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3VRmKSg17yJg2MZg"
Content-Disposition: inline
In-Reply-To: <5285c33f-98e5-4e06-0ed8-95728a74f755@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v3 1/1] Clean up plugin path handling
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: Christian Hesse <mail@...1798...>

--3VRmKSg17yJg2MZg
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jan 25, 2017 at 06:06:19PM +0100, David Sommerseth wrote:
> But I am wondering about the rationale of adding another header file
> (plugindir.h).  Why not just add this information to
> openvpn-plugin.h.in, which results into openvpn-plugin.h ... and which
> plugin.c already includes via plugin.h ...  I actually think this path
> can be quite useful for third-party plug-ins, being built outside of the
> openvpn source tree.

+1

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--3VRmKSg17yJg2MZg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYiOJLAAoJEB2Cnv7KVigSv7sMAKRaRGOFBPfuDJyR7TR4SZL/
xGCq8lxobaoBLFYeufMag1CwJTAeR7o0QLi6Q3XQMay49SbUQfZFNK0yKe1hjPB7
c2vvH2405R5JUIcizkshYPDhCEw7Zts8SSiAY1T6UcmDtAJ5cC69GXdtfeK+SjHz
LX8I7VPe9Y7XwBP8FWJjwutsIB/+B/6NrR1Lenf7W59Q+xC9tJbBo/3YpPea25Fi
mzNptNbYhI3pIqivhPr4W7EgjCG8Y5EcwmAarDYBny0Zx/BZEpbdfo2Z5wC6KVQl
yGdIwjgU73mdfB2xN+tn/81nncILJlZxNifdWwMIcN+zDFgTIYUdjZmC8RFSOdJo
uFFVFWUZ7kPbJIWC5WO37dpil+i/ayuwFB8GBgcHL89XYqkmJ4YtZzgJXwVqEIaK
/js1sZyHz3jvOBB20L5jtxCMcSW4L0FIxxhBt1hP8N8isfaKThtZFs+8mv/6fiO6
7BBJSh1RUyp1GPs4+0BsMxNKKq7XcvjDIAF93YfJiA==
=tHhI
-----END PGP SIGNATURE-----

--3VRmKSg17yJg2MZg--

