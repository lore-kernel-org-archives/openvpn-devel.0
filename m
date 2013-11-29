Date: Fri, 29 Nov 2013 20:53:20 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20131129195320.GM161@...1296...>
References: <1385382680-5912-1-git-send-email-arne@...1227...>
	<1385382680-5912-6-git-send-email-arne@...1227...>
	<20131129194258.GL161@...1296...> <5298EF88.20609@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pwW8IBo4NIs8GnoP"
Content-Disposition: inline
In-Reply-To: <5298EF88.20609@...1227...>
Subject: Re: [Openvpn-devel] [Patch v2 6/9] Implement dual stack client
	support for OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--pwW8IBo4NIs8GnoP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 29, 2013 at 08:48:24PM +0100, Arne Schwabe wrote:
> > So - amended patch below.  Arne, could you please verify that these cha=
nges
> > are all good and formally ACK again?  Transparency, and such :-)
>
> ACK and thanks for doing my work :)

Well, without your previous work, we've never reached this point - the
changes are quite big (but necessary).  So thank you!

Anyway.  It is official now, dual-stack client support pushed out...

commit 23d61c56b9fd218c39ad151b01b7e2d6690e6093
Author: Arne Schwabe <arne@...1227...>
Date:   Mon Nov 25 13:31:17 2013 +0100

    Implement dual stack client support for OpenVPN

    Signed-off-by: Arne Schwabe <arne@...1227...>
    Acked-by: Gert Doering <gert@...1296...>
    Message-Id: <1385382680-5912-6-git-send-email-arne@...1227...>
    URL: http://article.gmane.org/gmane.network.openvpn.devel/8058
=20=20=20=20
    Signed-off-by: Gert Doering <gert@...1296...>
    Message-ID: <20131129194258.GL161@...1296...>
    Acked-by: Arne Schwabe <arne@...1227...>
    URL: http://article.gmane.org/gmane.network.openvpn.devel/8071
=20=20=20=20
    Signed-off-by: Gert Doering <gert@...1296...>


gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--pwW8IBo4NIs8GnoP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUpjwr6kuBuNlUUl1AQKDpgP+Ij/a/hoaROxQqUqV9O9JKXcNjVyBB3rX
Q6jzIF+WyCiKkMifHpekUPYV2YQrW45h1+7wikPcmHoo4GHvjkRzgCtgWI14xwnz
bN2oDESxu2vKxN1lxo76AuB+DerFvmpkffR0yRx6V3kfHWXp5HbWOJYo6bIY1aVL
+8lwQJ088h0=
=7V3+
-----END PGP SIGNATURE-----

--pwW8IBo4NIs8GnoP--

