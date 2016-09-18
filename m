Date: Sun, 18 Sep 2016 22:15:56 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160918201556.GA78279@...1296...>
References: <20160917132024.12570-1-gert@...1296...>
	<CAKuzo_jqgMNCqcbCHBLO7hHoa9aLDTj3Ed7UmJ446b2J++8BCw@...278...>
	<20160918065956.GY78279@...1296...>
	<CAKuzo_gNnXg+XZh+UCzyvHjN+_L5a6N+dQkO_dQxOdvoYQsKcg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="umFY+EI/+9UScBI1"
Content-Disposition: inline
In-Reply-To: <CAKuzo_gNnXg+XZh+UCzyvHjN+_L5a6N+dQkO_dQxOdvoYQsKcg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Fix win32 building with C99 mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--umFY+EI/+9UScBI1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Sep 18, 2016 at 10:20:16AM -0400, Selva Nair wrote:
> Yeah, to me that only confirms my feeling that #ifdef WIN32 is not
> reliable. Much better to use _WIN32 which appears to be defined by all (?)
> C compilers that support windows and doesn't require any particular header
> to be included.
> http://nadeausoftware.com/articles/2012/01/c_c_tip_how_
> use_compiler_predefined_macros_detect_operating_system#
> WindowsCygwinnonPOSIXandMinGW
>=20
> Anyway, right now the priority being un-break building on windows, your v2
> looks good. I'll test it and report back.

Thanks for testing and ACKing.  Merged.

I think I'll open a trac ticket for the next step, so it isn't lost - we=20
intend to do a major round of formatting cleanup before 2.4, and changing
WIN32 to _WIN32 in the process would nicely fit :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--umFY+EI/+9UScBI1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQCVAwUBV971/KkuBuNlUUl1AQLaIQP+KVHL6CtqfZ4xaQCWzdbOLSeH6qnO5DJd
Dv/E4Zi2woBS+a9EKjuVbYxU+r1JZZ8wIlvAEpCQFU/cWKVV2xOLCV1042Wafpck
e0S5w4LFzo2AP5pOXOzRQD+R7ogwkAsDfIIZ1Tff6OBryADfmFVSH3iJiR/bYINI
lMQvl7/HJBc=
=Lc/A
-----END PGP SIGNATURE-----

--umFY+EI/+9UScBI1--

