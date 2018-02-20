Date: Tue, 20 Feb 2018 16:22:18 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180220152218.GM69387@...1296...>
References: <1511026858-23281-1-git-send-email-selva.nair@...277...>
 <201802201223.w1KCNrwC066890@...2054...>
 <CAKuzo_jfNBA2MrsSmhVGp+muGBHP61VdGbY92p7uEQbVtWePvw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="56jnwYyHVsKJlmXZ"
Content-Disposition: inline
In-Reply-To: <CAKuzo_jfNBA2MrsSmhVGp+muGBHP61VdGbY92p7uEQbVtWePvw@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Ensure strings read from
 registry are null-terminated
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--56jnwYyHVsKJlmXZ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Feb 20, 2018 at 09:47:43AM -0500, Selva Nair wrote:
> > There was one issue with your patch that you might want to look into - =
it
> > seems to be based on a private branch that has a "#define REG_KEY" which
[..]
>=20
> That line got removed by the following commit (multiple service instances=
):
>=20
> commit f3fec49b1c916a701058ef2445b4c07005c30673
> Author: Simon Rozman <simon@...2293...>
> Date:   Sun Dec 3 22:16:54 2017 +0100
> openvpnserv: Add support for multi-instances

Ah.  I thought it looked like Simon, but searched in the wrong place :-)

> So it was a rebase conflict. I scanned through the patch as applied
> and all look ok.

Thanks for double-checking.

gert

--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--56jnwYyHVsKJlmXZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJajD0qAAoJEB2Cnv7KVigSchoMALAl58hjqM+30YoNFcOEmNLE
7CZvZ8c+2qNHWMXx8s1DuH2chg0A37ZXBY1n4ED7Ua8+hUK3EQKNIZGJEnpbshbn
PA4msdxxV3wrlX83a5oVxPpd86qJcA0PWfWT9tZ+9wsCQ6RyluPlujhCpULxvNRk
iari5tx9l46ncZfJYcb1OQ90rTlN9hRbhP64YZLsalos7IXA5OXpvxtqUQ2y2DTG
0y0dnfFOSi8XhpxjK6MHTMFEGTa2sCgRakRL7yWfzpqo7oJ/K5VAiaNgd/lbW72r
rVUr+FS8L8hgRLeQgfbrM4kIVMnnzwhW59foIq5KIM7r/BO2P027Hzb65WT5ZEMY
2UpFbbVDccbC3NcMea+PHpN+cnPZqsX4k+YUpKPm5xC6Ugnxzab4OUdbhikge+7n
Agd6Dx7+xqtLQgww7fpVI+2m3TDsPB81gRWv1aP7qIMJnW38pmOe4rvKgMB21fKE
9rkcgDZekA0QEUdS6Rj3kirf/AnSrfMlFdb5HFZdag==
=d55e
-----END PGP SIGNATURE-----

--56jnwYyHVsKJlmXZ--

