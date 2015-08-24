Date: Mon, 24 Aug 2015 20:18:26 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150824181826.GD34798@...1296...>
References: <551A5509.702@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DRfr/2Y1Zz/5r+Kb"
Content-Disposition: inline
In-Reply-To: <551A5509.702@...277...>
Subject: Re: [Openvpn-devel] Increasing TUN_MTU_MIN to make connection
 establishment faster
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jiri Horky <jiri.horky@...277...>
Cc: FF Systems <ff-system@...2025...>, openvpn-devel@lists.sourceforge.net

--DRfr/2Y1Zz/5r+Kb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Mar 31, 2015 at 10:04:25AM +0200, Jiri Horky wrote:
> continuing yesterday's IRC discussion. I would like to ask whether you
> can think of a reason why TUN_MTU_MIN is set to only 100 bytes, and
> maybe more importantly, why this value is effectively enforced in function

I'm not sure if you've been following the list and/or git master
commits, but we have somehing in master for a while now...

commit fc91d4b0071178e298052078431fb86f03be84fc (master)

Author: Steffan Karger
Date:   Tue Jun 30 21:44:56 2015 +0200

     Increase control channel packet size for faster handshakes

     Signed-off-by: Steffan Karger <steffan@...1856...>
     Acked-by: Gert Doering <gert@...1296...>
     Message-Id: <1435693496-10931-1-git-send-email-steffan@...1856...>
     URL: http://article.gmane.org/gmane.network.openvpn.devel/9841
     Signed-off-by: Gert Doering <gert@...1296...>


... and as far as we can see, this "just works" (and OpenVPN 3 on iOS
and Android also uses larger packets for the control channel, so we're
just following suit here).

So, if you run git master, you already have it :-) - and if you run 2.3.x,
you can just cherry-pick the patch, it should apply easily.

(It will eventually hit 2.3.9 or 2.3.10, but I want to wait for a bit
more feedback from the "early testers")

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--DRfr/2Y1Zz/5r+Kb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVdtf8KkuBuNlUUl1AQJQnwP9FMgBrOMJ3YFe3dB6/ly4Ep9waDYfQwTd
urQSDDwHGENpyWbdsVQ9aktsjQmbcQPt1l2UgoWx+MNa+aiLA5XFvm7Qn8lMw0Bp
4hWVZJU6MbcuV2oYMqZ+zROHZZ4+9nZhPq6/zQ0NOl7M/cu+fVDcryuRx5D6DN+H
eYTwlwJKpjM=
=72Cp
-----END PGP SIGNATURE-----

--DRfr/2Y1Zz/5r+Kb--

