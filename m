Date: Fri, 26 Jan 2018 14:36:56 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180126133656.GX69387@...1296...>
References: <1509930876-30728-1-git-send-email-selva.nair@...277...>
 <1516815105-17882-1-git-send-email-selva.nair@...277...>
 <2f187b23-c53f-94cb-6a58-d5c9c14b5da1@...1147...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="3T4dLCyS4EPlIT+v"
Content-Disposition: inline
In-Reply-To: <2f187b23-c53f-94cb-6a58-d5c9c14b5da1@...1147...>
Subject: Re: [Openvpn-devel] [PATCH v3] Use lowest metric interface when
 multiple interfaces match a route
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

--3T4dLCyS4EPlIT+v
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jan 26, 2018 at 02:11:52PM +0100, Jan Just Keijser wrote:
> the route was added with the default GW of fe80::8 : should I be worried ?

fe80::8 is our/my tun-over-tap hack.

On "proper" tun devices, there is no ARP or IPv6 neighbour discovery, so
you can point routes toward the *interface* - or towards "an IP address
that the system knows is on the tun interface" (which we do for IPv4,
because that's how it was coded in the dark ages).  Since there is no
ARP, "a route towards tun" leads to "packet sent to tun fd, no further
processing, let openvpn deal with it".  Easy.

On TAP there is "ethernet underneath", so for each route destination,
an ARP or IPv6 neighbour discovery lookup needs to be done, and then
the packet is sent towards that MAC address.  Also fairly easy, since=20
OpenVPN only deals with MAC address forwarding and lets the OSes on
both sides sort out the L2 discovery.


Now, tun-on-windows is "tun" as far as OpenVPN is concerned, and "TAP"
as far as Windows is concerned - so there needs to be an explicitely
named gateway address (v4 as v6), and ARP / IPv6 ND.  Since OpenVPN
doesn't deal with MAC stuff here, magic happens in the Windows tap=20
driver - namely, if Windows sends an ARP request for "the ipv4 route=20
gateway", the TAP driver answers it (openvpn tells it via ioctl() what
the gateway address is, so the TAP driver knows what addresses to=20
listen for).  For IPv6, we have link-local, so I did not bother to=20
implement a new ioctl() and logic on the OpenVPN side, but always set
the next-hop route to "fe80::8" - and the tap driver knows "oh, this
is magic, answer the ND query".


Long story short:=20
 - for tap interfaces in tun mode, fe80::8 is what you want to see.=20=20
 - For tap interfaces in *tap* mode, "a real IPv6 address of the gateway=20
   on the other end" is what you want (ND goes back and forth over=20
   OpenVPN/tap layer).

 - LAN routes (/128 bypass routes to the VPN server, for example)=20
   should never use fe80::8 but the real link-local or global address
   of the gateway -> now with "it works if you have two interfaces!" :-)

 - your log file looks like it should :-)

gert

--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--3T4dLCyS4EPlIT+v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJaay73AAoJEB2Cnv7KVigSUJ8MAKK5x/UeRlfxM7qO+CFWtU0x
NCF9ZKzIS7rITJYswB/m1O4NXqFTbk3TJfE3+ypu/35TddlUFnXHhcqlI4p64vKf
CaVmECKpjA2Cf87ySnjU7etEneW0aTkdSUOe4yVzFlzyez/MClPeye0KcbFDWrvd
nQd/DdX+8fzKXK2SGz6uUqOjwBvW9PIaobTuXIbd8LFjXYHhwbrV4NWHSGdq215s
7AJmBDsZzFU/ArPodd1iPtXXfl6KkLbjG3JLf55eenaMyLa+s57RamXCygNSwgwO
naW1vnweLBwOC/F+HKrQ91qWDZccZ5swK4jmSuUvDhxTdAcLQMqIOeyE8GUKEf+r
oX9fThlDOb6Par0qt8GeHTaKd3fqgCR5cZdLjMpLzmHz1uQork21blhAp+s2GOfl
y+SE+AriOSjcfzEgaph3qn5QRUy5gHstw8i710LvkUD3tyh+rMdCpfTABPpaioWR
13YpFM5N8EO/rk7YyawclAx/FJLYnBJYYYx3FCHYFQ==
=kBxT
-----END PGP SIGNATURE-----

--3T4dLCyS4EPlIT+v--

