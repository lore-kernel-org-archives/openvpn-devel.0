Date: Tue, 18 Jul 2017 23:16:00 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170718211600.GB70062@...1296...>
References: <20170718132030.19820-1-a@...2181...>
	<20170718134612.10695-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xB0nW4MQa6jZONgY"
Content-Disposition: inline
In-Reply-To: <20170718134612.10695-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] route: improve error message
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jul 18, 2017 at 09:46:12PM +0800, Antonio Quartulli wrote:
> - fix typ0 in message: NLSMG -> NLMSG
> - use strerror() to print a human readable message

Thanks.  What about "not printing an error for ENETUNREACH", if
that's the new "no error, but there is no such route"?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--xB0nW4MQa6jZONgY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZbnqQAAoJEB2Cnv7KVigSWiEL/3s1EmAlVj8lX+LaCIkEz6vs
Ep9+x2KPE6p3WgZ0CaoItytR4cJeC9a3Ns52BEENdNdJzHT8he0gRdN7GpmOY5P1
me65frHnaCGme/FIM0t2N8kC3Nxl8dGrk3rMTh8iXHG0xhQnuiciRYmWujwLdUEq
zO8T1/0UFgaJNSX7ul5EbZ4fne+Mof/sbYdLd6+s7S3YLaS7haYlTHXlH+YjfVE+
Mca3ndWf9Aq4NROm7Tf5DCeFI2S2lYx/BhQclQKQEWFtBk9I+hohmYkJcwaeX8NJ
sdoFYQb7HcJspCf+cxSVbVyrcjtD3I3+zHZxHPIEUhTlQjFJEq+LBzelrptIkkDe
HppwCPKdz5VyLC7+WI0kQoNKt9It5Wnjr89kluzUrMibfpWRiFGqlFyRJc6VOtUY
GMAVRmxMHaSswUH7MVs6k26tfl9T3bDyO2ZBDoPE5e2KJRYPAWhIKwoXRKhzauV4
gyVO4NgstPyH6KIFi4tGSQS4dtDBH12yBbzkU2Q64A==
=/z4e
-----END PGP SIGNATURE-----

--xB0nW4MQa6jZONgY--

