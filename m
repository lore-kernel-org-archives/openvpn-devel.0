Date: Thu, 12 Apr 2018 16:50:52 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180412145052.GC69387@...1296...>
References: <8a2c220c-e169-0cb1-c8b4-3c8af5fab82a@...515...>
 <c573880b-af3b-0876-d00f-70e7a06c69fa@...515...>
 <003a7779-3f07-5335-4fd4-8f62aadf6134@...1918...>
 <20180412082603.GT69387@...1296...>
 <CAKuzo_g9Pabn1JSCXJxTse2u9-Laj+Ejc3mG94xQk=UOT4GUNw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="7m9CHdxeBipTaBWu"
Content-Disposition: inline
In-Reply-To: <CAKuzo_g9Pabn1JSCXJxTse2u9-Laj+Ejc3mG94xQk=UOT4GUNw@...278...>
Subject: Re: [Openvpn-devel] Viscosity patch to TAP driver (was: Summary of
 the community meeting) 2018)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, Eric Thorpe <eric@...1918...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--7m9CHdxeBipTaBWu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Apr 12, 2018 at 10:27:08AM -0400, Selva Nair wrote:
> > > This change was made not because of any actual performance gains, but
> > > because of user reports that certain firewall or AV software tries to
> > > QoS the adapter based on its reported adapter speed, which is of cour=
se
> > > a problem if the VPN connection is capable of more than 100 Mbit.
[..]
> Or am I mistaken -- does this setting really affect the max throughput?

Not normally, but when certain 'helpful' software is around...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--7m9CHdxeBipTaBWu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaz3JMAAoJEB2Cnv7KVigS61gMAIqGFxtkoF49AdTqK9+m8unP
2xS+6LCvKfNu0Xtr6zelSTJw/s/PxqhkG0nCriAj1jB21DAOClYIJbB1RbfpYjXu
iSZjY4sa3kHAXxsmRmMT4/6uukZyJUenpP3bd+0SHXuIqkIpCPkfiFyubIF4nw6D
/rRxNbv+fJNUlSsRxJwHdLl1RdrOeKbmgaHAYOA/gHEHsjzQZVTqJFnDgmuYqbmR
0+Jo/737+1+qJG8XqY0tcflIJyE/Wbg1x4WTROVtTnM7gp0bGd9+01N51Kt41kGq
/nsMhYW2cGA9277fh3KEuOnDKu63uYp/AwEIWHwi7G57641PXBgZ5SUfnJl484vV
cPf+eQ/x57mE6vBrrpai4zQUWSp+c7vBAGdZvKfcwqb6ieT1uWl9VdcTWnL4DyVa
py1xdSpHBoZ6F1Ewpvm/p0vP1zq6QYK9BLDefWN5KHFDdXzMgN80HsHuOzNhjeY9
d+ANZgEfa6+nPIay6UvuuHkMh93M597FWM5ahoeqWA==
=arCt
-----END PGP SIGNATURE-----

--7m9CHdxeBipTaBWu--

