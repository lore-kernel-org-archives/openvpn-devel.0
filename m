Date: Tue, 12 Jun 2018 11:29:37 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180612092937.GA57262@...1296...>
References: <20180608052017.6696-2-a@...2181...>
 <20180612074240.18865-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="GuCODRLlE2VjZS/b"
Content-Disposition: inline
In-Reply-To: <20180612074240.18865-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3] **Android** note: tun: ensure
 interface can be configured with IPv6 only
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Gert Doering <gert@...1296...>, Antonio Quartulli <antonio@...515...>

--GuCODRLlE2VjZS/b
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

another reply to the same mail, on purpose, to keep thoughts in
separate threads...

On Tue, Jun 12, 2018 at 03:42:40PM +0800, Antonio Quartulli wrote:
> This change ensures that an interface is properly brought
> up even when only IPv6 settings are configured/pushed.
>=20
> At the same time, the do_ifconfig() function has been rearranged by
> splitting the logic into a v4 and a v6 specific part. Each part has
> then been moved into an idependent helper that can be invoked as
> needed.
[..]

The existing Android code is different from all the other platforms,
as it sends IPv6 info ("IFCONFIG6") *before* IPv4 info.

Arne, do I have to assume that this is intentional, and your client will
explode if it receives IFCONFIG first and IFCONFIG6 second, or no
IFCONFIG at all?

gert


--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--GuCODRLlE2VjZS/b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbH5KAAAoJEB2Cnv7KVigShM0L/i5s1gqROJlbPnigY7/l3FgD
H9nhbB6grAnrHT9x2wGdvsksqhriWqGUG9zAVMZJHMpbWdJuP5supLdmiGMpRnB4
jSNuFAdowlJY215XIgYIcTxDeyz3cDO59Tq10yh/0n21ymCXciii8BQlxQ6ozy3y
tOZ8iF9Zpol2paH9L5Fv/NPiYzVWB8ID0/ZJu81byxCftWipEVZ1yzJXlGCtbCc1
gVFaPHyXBQRRVF1+yPqnp3fXiY2Nx5jPpsNTAtWx7HMdmdlBomlxIhylTuyKH82t
sX0lXuIxvTpK6uKrq9c1CTAYyVYTD5SMA//lXKgYYCS51MUBIkMEFX4GxSp4iyxx
81/MK+0q2RO7N2sO+r/EIcCaeDQ46BslSnqq9ILtpfCnIbCe/6UvVUCzM+KbaE1H
Jdb4dVDt03N8IYZFYWR6VVSlVaGLNsDkuitFcfNjxGrB3ubSFp1Pzy/NWkjlKP7O
v6QIyZxGwv9LeOkcTQqGEfa4xJ1cigDepqqbiHGtEA==
=F1/t
-----END PGP SIGNATURE-----

--GuCODRLlE2VjZS/b--

