Date: Fri, 24 Aug 2018 14:57:23 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180824125723.GG997@...1296...>
References: <149619ba-265f-1a7a-6403-f99c6f4b7eac@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="VSVNCtZB1QZ8vhj+"
Content-Disposition: inline
In-Reply-To: <149619ba-265f-1a7a-6403-f99c6f4b7eac@...1227...>
Subject: Re: [Openvpn-devel] Discussion: Moving forward with compression and
 voracle
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--VSVNCtZB1QZ8vhj+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 24, 2018 at 01:11:44PM +0200, Arne Schwabe wrote:
> On top of that, a lot of the traffic that the VPN carry today is either
> already compressed or encrypted and cannot be compressed any more. So
> benefits are diminishing.

This part is true for the "I use a VPN to safely surf the web" use
cases, but not for all cases where OpenVPN is used today.  So please do
not make this a "we can stop using compression because it has no benefit
anyway" argument.

[..]
> So my proposal for OpenVPN is:
>=20
> - Introduce compress-direction asym|full This will control if we
> actively try to compress or just allow receiving of compressed packets
> - change the default mode to be asymmetrical.
> - If compress-direction is missing from the config but comp-lzo/compress
> are present inform the user "WARN: Compression mode set to assymetrical
> to avoid VORACLE like attacks. See the man page on compress-direction
> for more details".

I can live with that, though.=20=20

In cases where you know you have compressible data (because not everything=
=20
inside the VPN is "https"), and you trust the endpoints ("LAN to LAN", or
"VPN client to corporate servers only") compression can be turned on, but=20
the default for unsuspecting users is "safe".

> Open Points:
>=20
> - Gert strongly thinks that some people might want to continue having
> full compression despite the risks. I think it is reasonable to expect
> them to add 'compress-direction full' and push "compress-direction full"
>  to the server configuration, so touching clients is not needed.

Agree.


(To repeat my main argument here, for the sake of the archives: OpenVPN
2.x is a toolbox that suits many different purposes.  One of them is=20
"make web surfing for clients safe, via VPN service providers" - this
is an important purpose, and making OpenVPN robust against malicious
software on the client is an important goal.  But I am convinced that=20
OpenVPN 2.x has much bigger usefulness than this, and so we should not
only look at possible code changes and "stop users from shooting their
own feet" from this particular angle.  More blunt: follow the unix
matra - "do not stop people from doing stupid stuff, because that would
also stop them from doing smart stuff")

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--VSVNCtZB1QZ8vhj+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbgACyAAoJEB2Cnv7KVigSj+8MAKWUWkA5hQhBNRRQ1Skd2zVA
kWE36nt79YB7zBZJu3gd3sSr3Bu7eZ87GpgepfbrfTaFEWyK87mEbJ0w3Lep9dxR
KiD0N/qwuI/MzPnoaYaghSlxvyKcDqRDKi5/OwOGB+uwiriMBW814QpJasrd02vG
+fq/ziXTKPQg1YZHOkxDoMqMfbfZ0JDOqcp4epc88eD+IhS3Ct/15uH4MKQyg0Ge
wtSWABNVLw9ralPUEZ6YXybJxP4xLEH9a+5Bmd8Fc6ytC9uifnJbZH20F8RWfdXa
r2A8Afk4uB2Pbq/QEq+4Ii+RlDwVA0/viu03vowYfPXRrLHIgsJENuZIdblfG8Yt
3WZS+B9RreYYyY7W1qAfqWNtD0BJJL96+UwV86hlUqiWUextF76mT/vCTFKHDz0Y
v891swi3T0Svkk4nmynLWm3y8+tSzeodlW+nNuLqVpCsVLXV4HFdrc2a7o2+0BPb
4BwWYsMldNzl/CoclxKLLVycQ68JAtIaNIH83kMzJQ==
=eYd8
-----END PGP SIGNATURE-----

--VSVNCtZB1QZ8vhj+--

