Date: Tue, 8 Apr 2014 21:12:04 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140408191204.GH16637@...1296...>
References: <20140406083549.GG16637@...1296...>
	<20140406085311.GH16637@...1296...>
	<20140407201711.GN16637@...1296...>
	<53430F50.4040709@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+TKY1OV9ddebX9It"
Content-Disposition: inline
In-Reply-To: <53430F50.4040709@...1227...>
Subject: Re: [Openvpn-devel] getaddrinfo() confusion / way forward?
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

--+TKY1OV9ddebX9It
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Apr 07, 2014 at 10:49:20PM +0200, Arne Schwabe wrote:
> Am 07.04.14 22:17, schrieb Gert Doering:
> > On Sun, Apr 06, 2014 at 10:53:11AM +0200, Gert Doering wrote:
> >> A slightly simpler version of this could go to the beginning of
> >> create_socket() (--> no ai_next chain walking needed, etc.).
> > Arne suggested an even more simple version of this - which is convincin=
g,
> > because it takes away lines of code, instead of adding more :-)
> >
> > Patch attached.  (Tested, works!)
>
> ACK from me to basically my own patch.

Well, it's an interesting turn of events :-) - I'll commit that with
you as an author, and signed-off-by: lines from both of us.  OK?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--+TKY1OV9ddebX9It
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU0RKA6kuBuNlUUl1AQLDuwQAplL1Who6TzEXAMF2WI0yvsvcRJn/6UfU
JXT6Z0O8gNJSDdNhewqLJtZZaoyfyKu+/ALn0MwchRB64fjgPMzNpagiVe31g+gO
pqOSi+K6AKqV+CmWZ+rFdtkWucp6TFbYWJLoP2U90Ip/VFDPyKaNnM3zUqA1MGhR
eZRjBxo7gRY=
=9KZT
-----END PGP SIGNATURE-----

--+TKY1OV9ddebX9It--

