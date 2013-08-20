Date: Tue, 20 Aug 2013 11:29:00 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130820092900.GA16543@...1296...>
References: <CAFHpkQHAAdBdPdtrtVpzUzwT5WdeEwWYpqPag=mLnSX-pMLaEw@...278...>
	<20130819104455.GH16543@...1296...>
	<5212620F.3060106@...515...>
	<20130819210137.GS16543@...1296...>
	<5213306D.2050205@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RdOi/MCTP6675j71"
Content-Disposition: inline
In-Reply-To: <5213306D.2050205@...515...>
Subject: Re: [Openvpn-devel] [Openvpn-users] pull requests on github
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--RdOi/MCTP6675j71
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Aug 20, 2013 at 12:01:33PM +0300, Samuli Sepp=E4nen wrote:
> > We've had questions on #openvpn-devel about pull request 7, which was t=
he
> > first time (on request *7*) that anyone was taking note that we offer
> > pull requests at all - so there's 7 pull requests out there that are ig=
nored.
> Well, we don't have the manpower to look at Trac bug reporting, and we
> still don't disable bug reporting, do we? :)

This is a problem, indeed.  But it's not an argument for adding yet another
queue that we don't look at.

> Anyways, I can keep an eye on the pull requests and if something
> interesting pops up, I can forward those people to openvpn-devel. Or, if
> we really want to disable pull requests, we should monitor the OpenVPN
> forks in GitHub for something interesting, and encourage people to push
> their stuff to main development line.

I've never understood the hype around github, tbh.  If you see value in
adding to your workload, feel free to - but really, evidence speaks against
enabling pull requests.

Also, Dazo and I won't actually *use* git-pull to fetch those, so one
of the big reasons why you would want that ("to enable git pull") wouldn't
apply anyway.  We have agreed on a workflow how to integrate patches, and
"pull" is not part of it.  "git am" and "git push" are...

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--RdOi/MCTP6675j71
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUhM23KkuBuNlUUl1AQIebQP/SqYbFZ4ZemKJpU8N5tLnAY7iwwnJJrU/
skTDPUjZnJijOlgSxhSIhL+oRLMVYgTKTs6R2onQseNSJ84fN9ah/lRvH8k1+S5Z
ltuckmR+FJeDqLGpTigVw0YoI00LkVMD7zk5+EfbPhpBZY2xIKAZ+aPOt4yva71d
UyLFsi8xWaE=
=f4Ed
-----END PGP SIGNATURE-----

--RdOi/MCTP6675j71--

