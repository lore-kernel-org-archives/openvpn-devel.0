Date: Tue, 12 Jun 2018 14:26:22 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180612122622.GF57262@...1296...>
References: <20180608052017.6696-1-a@...2181...>
 <20180608052017.6696-3-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="WyNRHPUpyWKWHSil"
Content-Disposition: inline
In-Reply-To: <20180608052017.6696-3-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2 2/8] windows: properly configure TAP
 driver when no IPv4 is configured
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>

--WyNRHPUpyWKWHSil
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 08, 2018 at 01:20:11PM +0800, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@...515...>
>=20
> Signed-off-by: Antonio Quartulli <antonio@...515...>

This commit message is a bit... thin.

>  check_add_routes_dowork(struct context *c)
>  {
> -    if (test_routes(c->c1.route_list, c->c1.tuntap))
> +    /* skip route check if no IPv4 was configured */
> +    if (!c->c1.tuntap->did_ifconfig_setup
> +        || test_routes(c->c1.route_list, c->c1.tuntap))
>      {
>          check_add_routes_action(c, false);
>      }

And I'm not sure if that comment is sufficient to explain this increasingly
convoluted function...  (I'm so totally not understanding what is happening
here, and how it's wrapped into the event looping)

Maybe a easier to understand place for the did_ifconfig_setup check would=20
be inside test_routes()?

Like:

-  if (rl)
+  /* we do this test only if we have IPv4 routes to install, and if
+   * the tun/tap interface has seen ipv4 ifconfig - because if we=20
+   * have no IPv4, the check will always fail, failing tun init
+   */
+  if (rl && tt->did_ifconfig_setup)


But really, WTF...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--WyNRHPUpyWKWHSil
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbH7vtAAoJEB2Cnv7KVigS7tgL/R+impMWoINRYfVwXwrKsfNX
jCKNhTrn02d2DvoKoJsrFK62RQor56+iObEz7WsHpMyCtSza03lNmVRU/a4YFeLg
PqvTJfT82VuJGpFrOHcNWkNODCM9bzL1SgO64AFtMkDGIa3HE9mu5kEzlmgztKpt
zDTfDJdXbQUCO8bbPH7KkoSlwewUENfnkKvSCBWmr8KirdcloCZSIWgX+GkIOotd
Citnwc3RbjBWlyq2nZTB/lNMuN0m74SVy/K78L0MNN9rqBzfb0DYZBiCXFDLSEMr
cBdO6ipt4UDI1RxW2Nv4WPhG0Gc2knDYR+RK/Vs5EhcOIDbhEE2KPaAXItcTuzfW
mFXkbrA+taCwYZrnhGEfSr98nibbdh26v12szaoP9D7mK+K4ufXwrU4BsgT/NIYi
B+WECXmBF7mHLUaKJ/eHRrMo6pofrLDNaGq8WXJZeTFGkTnE0uWlNpguvae2+10K
kVlpBT0QAoxM1O+E8f+Zzc8uokUPAWIlF3H+Es107w==
=+waa
-----END PGP SIGNATURE-----

--WyNRHPUpyWKWHSil--

