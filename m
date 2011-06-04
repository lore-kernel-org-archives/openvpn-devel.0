Date: Sat, 4 Jun 2011 11:54:01 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110604095401.GF8496@...1296...>
References: <1307102025-18627-1-git-send-email-davids@...1347...>
	<20110603172224.GC8496@...1296...>
	<4DE923BF.3030409@...1114...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vrw1DaqqwcH9Ar2H"
Content-Disposition: inline
In-Reply-To: <4DE923BF.3030409@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Remove support for Linux
	2.2	configuration fallback
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

--vrw1DaqqwcH9Ar2H
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 03, 2011 at 08:11:11PM +0200, David Sommerseth wrote:
> Thanks!  Yeah, this is just something I stumbled upon lately, but I saw
> that there are more stuff which can be cleaned up!=20=20

Indeed.  I think this is actually something for the rest of the v2.3
preparation time... cleaning up plattform after plattform.  With the
t_client test frame work, and Samuli's build cluster, we can be=20
reasonably sure that things still work...

[..]
> I think James once said Red Hat Enterprise Linux 4.6.  However, the
> officially supported RHEL4 release is to my knowledge 4.9.  That's based =
on
> a Linux 2.6.9 kernel, iirc.

I think it would be useful to have RHEL4 buildslave - so we can see right
away if we break that system.  Even older systems would then have to be fix=
ed
on-demand if really needed...

Even the embedded world (OpenWRT) moved to 2.6 a while ago :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--vrw1DaqqwcH9Ar2H
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTeoAuakuBuNlUUl1AQLNtQP9G8eCUgWprm0o9wT8Mh49UE9dIwCzDecP
WXX5bwOWccMyr50XY9uL4vAyev0FctMGUN+RBS9N4niF3X0SCBcdIEU8U769zlAN
O1zjmFvs/oZ71QUgQetV9KWtXVnb1cD7D7TtjReryoxW4VCcluBGiBT9zr/aDfM8
spf/d6UzYFU=
=VXiL
-----END PGP SIGNATURE-----

--vrw1DaqqwcH9Ar2H--

