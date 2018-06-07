Date: Thu, 7 Jun 2018 18:57:05 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180607165705.GP57262@...1296...>
References: <CAKuzo_gfgG=6LxX-s0aPReZeaXDwEBM0zfrtWxZR9JzNvkraOA@...278...>
 <20180605185352.GR57262@...1296...>
 <CAKuzo_gaiCL1Y_zbHUBjaQwxtU2WYzg5Z4zv9tDUS-J4oeoLVg@...278...>
 <20180605195935.GU57262@...1296...>
 <CAKuzo_jP1F13rw2pdRx9zF0n-7+N29u3d4FE53tL9SrwxMwk9w@...278...>
 <9a878b99-12ef-47b4-fc85-a16ecc196363@...2181...>
 <CAKuzo_hU64ML71iL7Xdt5_k08QLXwDytXd1W2TVze=7SUhLLSQ@...278...>
 <CAKuzo_gp9jcVocxgf79TNQpgP-ScioC1pM_3oTq9+SHHAhEonw@...278...>
 <665fcdae-dad7-b6c8-14ee-512ff7992963@...2181...>
 <CAKuzo_jLhL=pLrkRoqWXHPRLzBGBiUCgq20Wzxd+DiidoAmOJA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="59coWm5189RNS6mf"
Content-Disposition: inline
In-Reply-To: <CAKuzo_jLhL=pLrkRoqWXHPRLzBGBiUCgq20Wzxd+DiidoAmOJA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 1/5] tun: ensure interface can be
 configured with IPv6 only
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Antonio Quartulli <a@...2181...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--59coWm5189RNS6mf
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jun 07, 2018 at 12:14:51PM -0400, Selva Nair wrote:
> Note: All that said, I can't seem to connect to the server via ipv6
> when there is no v4 address. tracert fails before the first hop.
> v6 does work when ifconfig is not filtered out.

This "should not happen".=20=20

v6 should work no matter what we break in v4 land.

But this is windows, and "should work" land...

Thanks for testing & reporting back ;-)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--59coWm5189RNS6mf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbGWPhAAoJEB2Cnv7KVigSrMsL/i8S24KSrCT87yVh1jGPLthg
+dLv4GnGWIlKmmKpoCsemn7T9E7KV1Fzg+4pQMfct7SXasZGXbgPG93guzSKxEKY
pHKv1JDL5XlK220vHJOSgKTFjIHa7pdZUQnJnAaCwoL/zE+m9BP9fWdQly5JiCVN
FesITwcEZyssFI56Ja2cd2Qn1X/77IH0m2T+YlLVe+YHTSL0wskCgPzc/w+O5hF4
jzFUponZX//guCxKtYtI/iccZYMv2wrIZoXSeGBwHdUk+x2DbitmTkq66F5KvDlI
7hjLlRLSWWc72GM5fVYziu0NABgBpYS05NN4cKbrET1YovjJLFYkuvFOuUYWC/VK
Z6PqnL4i2FfxwQIXBgjnQ7e0mkbr8GScN0nV4v5wRVxMRMO9SiJjDTE+Z/d4WlzC
E2vfcD31mW+n7yOke6fMcqTDQE1rjSOM/SUf5aYYh7qg4ULtQ6btP1/ZTblz/b2H
uS+hIHnkgquKrda7PWP3ThSgdPVl0bazWEUxwGH7Dg==
=fYnv
-----END PGP SIGNATURE-----

--59coWm5189RNS6mf--

