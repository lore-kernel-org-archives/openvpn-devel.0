Date: Tue, 26 Jan 2016 22:26:14 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160126212614.GX24952@...1296...>
References: <2215306.x9ci9DhAZ9@...2001...>
	<1453835508-26119-1-git-send-email-gert@...1296...>
	<20160126191913.GV24952@...1296...>
	<CAKuzo_g3X1yTDV8MrstynxCqZWOy1GBqHyi_jTVRM+jJwU9Xog@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LDT3Q2P3TMIRsRO1"
Content-Disposition: inline
In-Reply-To: <CAKuzo_g3X1yTDV8MrstynxCqZWOy1GBqHyi_jTVRM+jJwU9Xog@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] interactive service v3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--LDT3Q2P3TMIRsRO1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jan 26, 2016 at 03:20:38PM -0500, Selva Nair wrote:
> Still alive, though things are a bit hectic at work.=20

Cool.  Was afraid you went silent after I neglected to follow up on=20
your configure.ac patch in November (*sigh* - too busy myself)

> Its a fairly large
> chunk of code and I had only glanced through parts of it in the past. Will
> try to take a look.

I'll go and look at the "do network stuff" and "parse messages from the
socket" bits - those are "just plain C stuff".  Just the service and
event handling eludes me...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--LDT3Q2P3TMIRsRO1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVqfkdqkuBuNlUUl1AQLgHAP9HRphQybclzoDIih7/MZgiNv9K2Jkw5eG
iX0tVkbn/+emQ6i0d0kIGHAXQXkJFgCSrP4WyRt06m0PYA9FGFIFPmzIgV6hhZM+
5WgS/iXTtSE/rPX85U3Sbr5qV0G5oRvL90ENkbk5MKV26CMVWZH5S55J4Gkc+J0Z
YrffSctaorU=
=M1V2
-----END PGP SIGNATURE-----

--LDT3Q2P3TMIRsRO1--

