Date: Wed, 28 Sep 2016 13:09:05 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160928110905.GU78279@...1296...>
References: <1475055231-1778-1-git-send-email-steffan@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KfXI8UIjd/jaDaxZ"
Content-Disposition: inline
In-Reply-To: <1475055231-1778-1-git-send-email-steffan@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] Make sure options->ciphername and
 options->authname are always defined
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--KfXI8UIjd/jaDaxZ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Sep 28, 2016 at 11:33:51AM +0200, Steffan Karger wrote:
> The NCP code does a strcmp(options->ciphername, ...) without first checki=
ng
> whether options->ciphername is NULL.  This could cause a crash when using
> "--cipher none".  This patch fixes that problem by ensuring that
> options->ciphername (and options->authname) are never NULL.  Ensuring that
> options->ciphername is never null prevents us from having to write null
> checks everywhere.

Another ACK from me.  Looks reasonable :-) - and passes all tests.  (Which
means I need more tests to actually catch the next "cipher none" breakage
quicker)

Your patch has been applied to master.  Due to differences in surrounding
code (which do not affect this change) I had to do it manually - code change
is the same, patch looks different.  Please verify that it's all as it
should be :-)

commit 348c416face9a025b618ebcae9d3a74c5a4a242b
Author: Steffan Karger <steffan@...1856...>
Date:   Wed Sep 28 12:40:51 2016 +0200

    Make sure options->ciphername and options->authname are always defined

    Signed-off-by: Steffan Karger <steffan@...1856...>
    Acked-by: Arne Schwabe <arne@...1227...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: <1475055231-1778-1-git-send-email-steffan@...1856...>
    URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/m=
sg12576.html

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--KfXI8UIjd/jaDaxZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV+ukz6kuBuNlUUl1AQJqIQP/QlVvplRsf1VNRQmModWCXBIL2vvblKgy
mK6dl+dECvMW25zWfgTauMtulNIGEW0YcdYl0d72hNiq/qIPar+iJBQCgmUInff3
fJtyVb38j5MfA44QfLfVXb6GcCyP5BRLk/jD8rgh7VIuiKV5EGZyFkbDYJCXfwbP
Ggu9/CepiZ0=
=IOmE
-----END PGP SIGNATURE-----

--KfXI8UIjd/jaDaxZ--

