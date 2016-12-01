Date: Thu, 1 Dec 2016 17:27:29 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161201162729.GP78624@...1296...>
References: <1480466372-2396-1-git-send-email-selva.nair@...277...>
	<201611301858.uAUIwRPD071804@...2054...>
	<bcec447a-d77b-996e-e1ed-b2daf9a88696@...1227...>
	<20161201080741.GE78624@...1296...>
	<CAKuzo_jKubExZUh0C-Ta5tOgqdrJ8Hhwu06JHuvtFmyPk3O_VA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ik0NlRzMGhMnxrMX"
Content-Disposition: inline
In-Reply-To: <CAKuzo_jKubExZUh0C-Ta5tOgqdrJ8Hhwu06JHuvtFmyPk3O_VA@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Force 'def1' method when
 --redirect-gateway is done through service
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

--ik0NlRzMGhMnxrMX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Dec 01, 2016 at 11:19:56AM -0500, Selva Nair wrote:
> Did I overlook something?

Sounds too complex to me :-) - "just use def1" is good.

> Not that I like it. Wonder how android does it.

Well, there's a VPN API - you tell the API "these networks is what I want
to connect to" and then it will do routing table / routing policy magic
to get *your* packets into the tun (and nobody else's) - and on close
of the API, that stuff gets removed again.

Which is in a way similar to "def1" :-) - except that openvpn doesn't
have to do any cleanup (as far as I'm aware) and doesn't need to bother
about redirecting the existing gateway (install host route) and anything
because the API takes care of that.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ik0NlRzMGhMnxrMX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYQE9wAAoJEB2Cnv7KVigSuVwL/jdWM0BL4ckf5UNrjVZzGyrY
Azi+B/JxRh78Pp0eSpQ1FD7cGcqMM/z8NuFYNOlX/mRwie8wqLbcurhMiBi3/td9
nHWx+xDCO74Mmb0++OpLk6X1mJ2+4wNlL+80D5tan7pFpgK78r2x6YsRi8lIu0SN
dQEvfj3pYWN6PUMQNEVXIf3NpB153+TJqeswkb2x6yPahMXOJ/XAKMSHIeUzznSD
MJxTSrMVF18ndmbTf8E5qipYgzD0JgQzMFDSx84oIgpCn4vlXRkRV4tdnXMm3C8Q
uCn7h9tQtuWdruApBJOnE+mxMqm3l9RUHsm9hDo2sLaIIWwfqqIKJCP9QECW7msr
YprHrEMcKsoojN+rq0ZHwJJ4x40GTRjPqIENvaoKKryq30xOrCwo08bmiqU0NVYR
gXAKMHtY9vsVauxsYEahY7rBxqjGMZ8L0jZSnw9rx9T77vgQkMlSmH19CcEIjoNC
dCg89oSwPSyBpQBvpFeFVKSpRTeqItd2M/gIiAjDsw==
=xGRR
-----END PGP SIGNATURE-----

--ik0NlRzMGhMnxrMX--

