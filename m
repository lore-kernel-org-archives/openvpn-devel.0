Date: Tue, 22 Oct 2013 11:23:51 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20131022092351.GB161@...1296...>
References: <1346422753-19520-1-git-send-email-arne@...1227...>
	<201304110933.r3B9XwPT011987@...1729...>
	<20130411105202.GA26778@...1296...>
	<5166B459.9020801@...515...> <5166C2B1.8050707@...1114...>
	<20130411151131.GX569@...1296...> <52663B03.6080809@...1294...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ikqct/fZAlyRpWN7"
Content-Disposition: inline
In-Reply-To: <52663B03.6080809@...1294...>
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
To: Eike Lohmann <e.lohmann@...1294...>
Cc: openvpn-devel@lists.sourceforge.net

--ikqct/fZAlyRpWN7
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Oct 22, 2013 at 10:44:51AM +0200, Eike Lohmann wrote:
> In the Changelog of 2.2 and 2.3 is no entry about CID and I want to ask i=
f=20
> this feature went into the code or not?

It went into master as commit 662ce6acc065bddf6490b3494725b8b3987b7def,
but not into 2.3 (as that train is in "bug fixes and only limited set of=20
new features" mode).


commit 662ce6acc065bddf6490b3494725b8b3987b7def
Author: Arne Schwabe <arne@...1227...>
Date:   Fri Aug 31 16:19:13 2012 +0200

    Add the client id (CID) to the output of the status command
=20=20=20=20
    This add adds CID which is needed by a few other management commands to
    the status output. This will change the output of status in the same way
    commit ca18a638aa7cf316611f893127ba44131e57083c did.
=20=20=20=20
    Signed-off-by: Arne Schwabe <arne@...1227...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: <1346422753-19520-1-git-send-email-arne@...1227...>
    URL: http://article.gmane.org/gmane.network.openvpn.devel/7021
    Signed-off-by: Gert Doering <gert@...1296...>


The code base we have in master today is fairly well tested, so if I=20
needed that feature on one of my servers, I'd just run "master" (which
I *do*, because I want the "export peer-info data to client-connect"=20
functionality - different feature, same argument).

OTOH, you could cherry-pick that commit to the 2.3 branch and use that -
it should apply fine (have not checked, but as far as I remember, we=20
didn't do much other work in that area of the code in the time between
so there shouldn't be conflicts).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ikqct/fZAlyRpWN7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUmZEJqkuBuNlUUl1AQJh+wP/TqwvqZzIssh8d1WG2m6Taj+e4IACH+i8
qh8AU4L5l2gJ1/t1FES1joYTro8DABFiTgswR30veLapgPpQdprGEmwaleSOVmPT
1y2nikhJ0EpRNy2ONyaA9lZOhZjwouxjXlAOB+O5PfdVkPto4/OGQ1J+bi7eKsGb
NPDVjMu53ME=
=JE5J
-----END PGP SIGNATURE-----

--ikqct/fZAlyRpWN7--

