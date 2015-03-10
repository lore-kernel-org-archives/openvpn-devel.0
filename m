Date: Tue, 10 Mar 2015 09:08:15 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20150310080815.GI21893@...1296...>
References: <20140827093409.GA659@...1900...> <20150223155132.GA28440@...2018...>
	<20150223161832.GN8134@...1296...>
	<54EB5549.9050108@...1114...> <54EE4F19.1000108@...1856...>
	<CAEW7GUvzbvR1FFSVA86pcY7tM4owucU88xTpLrUybDDCErpnTQ@...278...>
	<20150306184547.GY21893@...1296...>
	<CAEW7GUsx5JrASMJK1EnWaBRUwbv4jMx82-Sh8t=3b5HU73UEhA@...278...>
	<20150309190242.GF21893@...1296...>
	<CAEW7GUvz6gLkj4maQbsbSEFcYRr45yu-U_5RDyGBDsoMDZVvrg@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pFej7zHSL6C5fFIz"
Content-Disposition: inline
In-Reply-To: <CAEW7GUvz6gLkj4maQbsbSEFcYRr45yu-U_5RDyGBDsoMDZVvrg@...278...>
Subject: Re: [Openvpn-devel] Add support for Keying Material Exporter [RFC
	5705]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: daniel kubec <niel@...1898...>
Cc: openvpn-devel@lists.sourceforge.net

--pFej7zHSL6C5fFIz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 09, 2015 at 08:46:10PM +0100, daniel kubec wrote:
> It is nothing more then generating same keying material for client and
> server plugins (OPENVPN_PLUGIN_TLS_FINAL callback)
> without the need of transfer that key throught (D)TLS channel and/or app =
layer.

Why is it so hard to describe a good use case along the lines of what=20
I described here?

> On 9 March 2015 at 20:02, Gert Doering <gert@...1296...> wrote:
[..]
> > No code needed.  Just describe the parts that would be needed to make
> > this work - like "on the server, you need a plugin that talks to
> > foobar service to get a blinkenlight, on the client, you need a plugin
> > that uses EKM to make the light blink, via..."
[..]


You have written a lot of crypto speak, and added a bit of handwaving why
this is totally useful - but no specific example, how the bits and pieces
have to be combined to make it work.

Of course, single-sign-on would be extremely great - but I lack the crypto
background (or the imagination) to see how this could be implemented using=
=20
EKM - so, please explain it to us.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--pFej7zHSL6C5fFIz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVP6mb6kuBuNlUUl1AQI77wQAoP4UdlQjh6+UtfAsAceumjMFnxc1DiB9
67obI8XWxcgz0VRtwS9YIpdK5jBSdgTGH1hiqS2zgq14meftRwU8aJ+jmjQOntWS
0hzjpC1iHqmKgvtjBtq5e1xiEGKgs3Sd2V7R9dWLv6LSoKzO0dpBuJ9Mnwjq1FLU
btckj9ckB2Q=
=c1Ud
-----END PGP SIGNATURE-----

--pFej7zHSL6C5fFIz--

