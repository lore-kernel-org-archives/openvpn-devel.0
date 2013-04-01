Date: Mon, 1 Apr 2013 20:48:34 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130401184834.GE428@...1296...>
References: <1364762609-30320-1-git-send-email-arne@...1227...>
	<20130401111231.GD428@...1296...>
	<CAEsd45RW-ueAjEJS5PkecX=MuxLdBXA3uJceyVL6=wrvE9xoeA@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NtwzykIc2mflq5ck"
Content-Disposition: inline
In-Reply-To: <CAEsd45RW-ueAjEJS5PkecX=MuxLdBXA3uJceyVL6=wrvE9xoeA@...278...>
Subject: Re: [Openvpn-devel] building on OSX (for Tunnelblick) (was: [PATCH]
	Add support of utun devices under Mac OS X)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--NtwzykIc2mflq5ck
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

(detouring from tun/utun, but don't let me stop you and Arne from=20
discussing this in the original thread)

On Mon, Apr 01, 2013 at 09:26:04AM -0400, Jonathan K. Bullard wrote:
> I don't have an opinion about including it in 2.3.2 vs. 2.4 -- I still
> can't get anything after 2.3alpha1 to build properly for Tunnelblick!

Uh.  I've seen some issues reported by you, but I thought it had been
resolved in time for 2.3_RC and 2.3.0 - since we're at 2.3.1 now, I
really want to see this fixed :-)

So what is still breaking for you?

(I'm especially surprised since I know Arne is building and testing on
OSX, so it *should* work - but maybe it's "it works on 10.7 and 10.8,
but fails on 10.6", which we might have overlooked as our pool of OSX
machines with various OS releases to build on is a bit limited - how
do other open source projects handle this??)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--NtwzykIc2mflq5ck
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUVnWgqkuBuNlUUl1AQI0YQP/bD8CzQWIBNqH8Bp/DQ8QQ1eLtW3FPsXd
2cAN9k0Lz3bW4SIyd0WoNOOsF7KJ4Y3fLreHBLgJMnyB5anG8zrxIJNUPY5pQ6Pe
pSWbiJMLz3Ls4g1/JuxfuYNkr1vKRnAl8b9Bm6ccN2NHwA1M04FZlut0x5+cYYDk
cI7LQDk+ahA=
=ovYj
-----END PGP SIGNATURE-----

--NtwzykIc2mflq5ck--

