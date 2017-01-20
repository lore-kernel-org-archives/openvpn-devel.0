Date: Fri, 20 Jan 2017 22:40:18 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20170120214018.GT78624@...1296...>
References: <1484772172-19758-1-git-send-email-selva.nair@...277...>
	<20170120181647.10199-1-davids@...515...>
	<CAKuzo_iuwKbWwTsRP4PV+-5NRFOkjyY6LtCKEbzT7ETEjysZ+g@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ukxq3d9/SFe4Ri4s"
Content-Disposition: inline
In-Reply-To: <CAKuzo_iuwKbWwTsRP4PV+-5NRFOkjyY6LtCKEbzT7ETEjysZ+g@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Add a check for -Wl,
 --wrap support in linker
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, David Sommerseth <davids@...515...>

--ukxq3d9/SFe4Ri4s
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jan 20, 2017 at 03:38:46PM -0500, Selva Nair wrote:
> I am curious to know whether the opensolaris buildbot (there is one isn't
> it?) run and pass all tests?

There is one, but it uses gcc and GNU ld, so --wrap never was a problem
there...

gert@...2236...:/home/gert$ ld --version
GNU ld version 2.15
Copyright 2002 Free Software Foundation, Inc.

I do not have a machine with the Sun development tools (yet, supposedly
there is a way to get a free license, but I had no time to follow up on
this)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ukxq3d9/SFe4Ri4s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYgoPBAAoJEB2Cnv7KVigSnh4MAJbQk8GdMj8n6+9fn5yBULPS
HpG1+zZDqXOawrgWjf0HDRhXjz+vdx4+gJbiXqszNgKSAzUA3IhRKRtdKHdarHm7
Gg1DCRhKCajl1G5w/jADaiOvTbYb1KOVWO3H70irqyJpFb7EvNc1oWJdqDXiavAx
IyAXJTvYHfSiADW0RL3cLvvY+JbFA+gsici8nLXRcWJcv0BRLOpuH0PPslxMQGMF
hzCjhgLooROOCO83bG/PzEi+xUGr9XcITdwo++KFiicYaXVUVOwWM+/vD3O/qVCf
IHGdDIw7mixwaXtJxgB2hqUNhvpTNwdaUjxtG9kHKk+06Nxr5Zm0Wcjf/d0jlL2M
vuUY4yHyTEvSMB/gSvk2Fr020kWR/d1hzITaPicrcZRQWx29QrwcqKPPyIAH6Xkb
3o4adijyVNEpjIUxN+mLcpdUcIp514E8tQtvjPP8vbhW1U7cglNVCQ6TUk0oRfxe
0bwRjeFvt5Jnqx+BiDxxjRJPNewE+n/NZImbHieXJw==
=Fo+I
-----END PGP SIGNATURE-----

--ukxq3d9/SFe4Ri4s--

