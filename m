Date: Fri, 9 Apr 2021 17:19:59 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210409151959.GP976@...1296...>
References: <20210408140229.31824-1-arne@...1227...>
 <20210408140229.31824-3-arne@...1227...>
 <4f9a99ba-031d-43c7-c17f-8f842a519ddd@...1147...>
 <b0ecdfa9-7d53-35a9-cc98-cfbd23b7b4a4@...1227...>
 <3ec6cc2f-8d2f-4821-5265-8ec25267df88@...1147...>
 <20210408155251.GX976@...1296...>
 <d4420114-64e7-e0ea-127f-af7752b3a799@...1147...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="qS0MVW9+2BEhmRLB"
Content-Disposition: inline
In-Reply-To: <d4420114-64e7-e0ea-127f-af7752b3a799@...1147...>
Subject: Re: [Openvpn-devel] [PATCH 2/3] Remove --ncp-disable option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

--qS0MVW9+2BEhmRLB
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Apr 09, 2021 at 11:24:01AM +0200, Jan Just Keijser wrote:
> On 08/04/21 17:52, Gert Doering wrote:
> > On Thu, Apr 08, 2021 at 05:30:52PM +0200, Jan Just Keijser wrote:
> >> I don't have any evidence with 2.5 right now but this is just a matter
> >> of use/principle to me: I can very well see that I would like to have a
> >> setup *without* NCP as I simply do not need it (e.g. my cipher is
> >> hardwired to aes-256-gcm)=A0 and in that case I don't *want* NCP to en=
sure
> >> my setup is 100% predictable.
> > By setting "--data-ciphers AES-256-GCM" on the client side, you achieve
> > a 100% predictable outcome.  No other cipher will be offered or accepte=
d.
> Ah a new 2.5 option - I assume the same thing is true for adding this on=
=20
> the server side?
>=20
> And I see that --data-ciphers works only in combination with NCP, that=20
> is, if you do
>  =A0 --data-ciphers aes-256-gcm --ncp-disable
> then --data-ciphers is effectively ignored.=A0 Nice=A0 ;)

--data-ciphers is the option to tell the client what to announce as accepta=
ble
ciphers to the server, and what to accept if pushed (in case a server is
not well-behaved).=20=20

This is part of NCP, and if you turn off NCP, it is no longer active.

And because this confuses people, the idea is, for 2.6, to remove that=20
knob with changes the flow "config -> operational session" in ways that
most people are not aware.


[..]
> On the client side I now see even more confusing fun:
>=20
> Server has --ncp-disable set:
> - with=A0 --cipher aes-256-cbc=A0 the client side MTU is 1428
> - with=A0 --cipher aes-256-gcm=A0 the client side MTU is 1376=A0 <--- huh?
>=20
> Server does not have --ncp-disable set:
> - with=A0 --cipher aes-256-cbc=A0 the client side MTU is 1428
> - with=A0 --cipher aes-256-gcm=A0 the client side MTU is 1448
> (ok I understand the latter).

The MTU/frame overhead calculation, depending on configured and negotiated
ciphers, is a big source of pain (just grep the source for "frame") - and
yes, we are aware of it, but it's actually close to impossible to fix
without really ripping it all out and doing it anew.

Arne is currently busy with ripping out all the renegotiation / half-
authenticated keys / session stuff, and I understand that MTU is not=20
far down his list.

My server test rig has a few cases where "large ping" fails due to exactly
this, MTU miscalculations.  Which is good, because it reminds me every
day that this needs fixing.

> What I'd really like to see is a way to get the server-side MTU to also=20
> be 1428/1448 using the right magic options - any idea if that's possible?
> The lower the MTU on either side, the lower the maximum bandwidth -=20
> which will hurt especially over low-bandwidth links.

Just set --tun-mtu 1448, done.

The "automatic" way is "take link-mtu, default 1500, and calculate tun-mtu
from it depending on cipher/auth overhead".  Which fails more often than
not, but --tun-mtu can also be set directly.

> Also, when this option is dropped, does that mean that a 2.4/2.5 client=20
> with the option set can no longer connect to a 2.6 server?

No.  My test bed talks happily to 2.2 and 2.3 clients, some instances
with --ncp-disable, most with NCP enabled (=3D as if there were no option
to disable NCP).

You don't need that option today to make them talk, so they won't stop
talking if you take the option away.


> Conclusion: a further overhaul of the ncp/cipher/data-ciphers logic=20
> might be in order...
> Which is one of my gut reasons for saying : don't remove --ncp-disable=20
> until this mess is thoroughly sorted out.

ncp/cipher/data-cipher is fine, and well-documented.

frame/mtu is where the pain is.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--qS0MVW9+2BEhmRLB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgcHCeAAoJEB2Cnv7KVigSXbwL/jRp/SJ0IsNYs6AldYXzObwo
2aPzsZ2KwzM6rHzEAARQ0Wc8JjhNUozBllPRibY2pCowZga0JfqaESSU+ebv6abS
cFshos2WwlYIiGw3RvUqtwWcQoGmo1I3pAxiCqLk+TzdlbXMllrK3RTbNDzCTEqR
IheksYjHjv3K3j1TJywiXod00YEFwO3Hg0amK2b7ijchtN6YrcOO3hsXhHPT+jVo
QW8TgMWmgG6H13THjMlDJBShUYz4+8c7xZkkucUcgl8hCpKlAcjD1tJEU3v4MRim
uZpqVxC7LamlQQTr+Zxrwk1LYKJz8zJNw71HseRNwVfLNEOBAfYgY2ekEuSSsZoT
VEXE9P0vwPdJvAJXAea2Lec9UAiuvCo1z1/W8X107QxDMbiPAJCjGllpFV3b2Ahi
xmH2oDXwWcsxaZKMeSZlWxD/gnNCuNXYmeCFIW4oFckNFEuUT14kCCp60LZWP7WE
vUfNl0YvDHxWubYnT5VMDU3BkGk9wzw/8EvpJZykpw==
=Zkc9
-----END PGP SIGNATURE-----

--qS0MVW9+2BEhmRLB--

