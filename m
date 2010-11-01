Date: Mon, 1 Nov 2010 22:12:26 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20101101211226.GL10703@...1296...>
References: <54C854C313159D429F344FB1DE1A6526110D96A5@...1403...>
	<4C8E9E7B.9020308@...1299...>
	<20100914074032.GA10703@...1296...>
	<4C8F3C04.8020904@...1147...>
	<20100914113722.GB10703@...1296...>
	<4C8F79BC.7090602@...1114...> <4C9C5002.4070806@...1147...>
	<4C9C59A9.5090804@...1114...> <4C9C76E4.7070800@...1147...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SQyqYgH1w2JhGqGl"
Content-Disposition: inline
In-Reply-To: <4C9C76E4.7070800@...1147...>
Subject: Re: [Openvpn-devel] Enhancements.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

--SQyqYgH1w2JhGqGl
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Sep 24, 2010 at 12:01:08PM +0200, Jan Just Keijser wrote:
> >> 3385 #ifdef ENABLE_PUSH_PEER_INFO
[..]
> just toyed with it for about an hour or so and I can't get it to work -=20
> I even ran
>   openvpn --cipher none --auth none
> to see if I could see the IV_ and UV_ variables fly over the wire and I=20
> don't even see that.

Are you sure it has been compiled in?  The code block is #ifdef'ed...

(Yes, this sounds like a dumb question, but sometimes we overlook the
obvious)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--SQyqYgH1w2JhGqGl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTM8tOqkuBuNlUUl1AQLHIAP8DKnvo4cElj5eo7F8CjnVldnIlwv45sSI
xKKm2BkYtym75VlnKPVxh4vgEgx7b9vaTeK2aPzb8r8Y3ZnbtPhHmXEtCUg0zZFG
k30gcut0K9IjpVZcqUIR0H4yxNe94qGkU1xWib5WQyZDbtMkbXbTc5Ehe68Jtok2
UUcPYRFHu9w=
=YWhf
-----END PGP SIGNATURE-----

--SQyqYgH1w2JhGqGl--

