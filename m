Date: Thu, 1 May 2014 22:14:06 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140501201406.GS16637@...1296...>
References: <536262FD.1090105@...1901...> <53627F26.1060208@...515...>
	<20140501191514.GQ16637@...1296...>
	<5362A729.3070102@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k4AVHsodD5VyoCOZ"
Content-Disposition: inline
In-Reply-To: <5362A729.3070102@...515...>
Subject: Re: [Openvpn-devel] IRC & Community...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, Timothe Litt <litt@...1901...>

--k4AVHsodD5VyoCOZ
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, May 01, 2014 at 10:57:29PM +0300, Samuli Sepp=E4nen wrote:
> I will have a look at the developer docs to ensure they accurately
> reflects our current practices. I will also try to outline the various
> ways people can use get their patches merged more easily with least
> amount of frustration and delays.

Thanks.

It might be good to also point out our ACK regime ("it does not go in=20
unless reviewed by someone who is trusted to understand the impact of=20
the change"), and the reason why things sometimes just do not seem to=20
be moving - "lack of development time".

I do like Timeothe's enthusiasm, but things like "if nobody said something
for 14 days, it goes *in*" is just not realistic with the amount of
potential ACKers we have right now - and at some times, we all have very
very busy phases, where we can barely follow the list, let alone give
meaningful advice about patches.  This approach is also dangerous - our
ACK policy is there to ensure that patches are reviewed for security
critical side effects, and in doubt, well-tested.  So far, this succeeded=20
quite well - even if it's a major pain at times, because it truly slows
down everything...

Also, someone would actually have to "put it in" in that case, and as
the only one actively committing stuff right now is *me*, somethings=20
things just don't happen.  Like, for the next few weeks, I will be busy
with paid-for work that is not openvpn related, so I won't be very
active unless some sort of emergency patch comes up.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--k4AVHsodD5VyoCOZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU2KrDqkuBuNlUUl1AQLFlQQAuFTNH3tfDaVA/JEVgILnxZSddDGIxQiI
Ddh13UEggH04fOhQZ7Q+NmtgE5DBLiaZdLPs1gw4WTM/i+gN0TylFP+fi09UvCiQ
Dd3VjXpdGCBk1UkQ6j96JJ86Srqb663Ppy2JtKBlC59tnnN8oaeCQoHIoObH8JOn
p9aseKP1Aic=
=FbZt
-----END PGP SIGNATURE-----

--k4AVHsodD5VyoCOZ--

