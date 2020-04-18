Date: Sat, 18 Apr 2020 09:16:26 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200418071626.GK1431@...1296...>
References: <CAMdhJQ2qj0+uXsXJFs5DVf5WBk9ZZB6B6KXk=Nu6R=OC+qZ=WA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="raJwLrX2Hrz326Dr"
Content-Disposition: inline
In-Reply-To: <CAMdhJQ2qj0+uXsXJFs5DVf5WBk9ZZB6B6KXk=Nu6R=OC+qZ=WA@...278...>
Subject: Re: [Openvpn-devel] OpenVPN Connect Client 3.1.0 (890) - DNS Issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Kincade <david.kincade@...2554...>
Cc: openvpn-devel@lists.sourceforge.net

--raJwLrX2Hrz326Dr
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Apr 17, 2020 at 03:54:00PM -0400, David Kincade wrote:
> I work for a small company and I am running OpenVPN Connect Client 3.1.0
> (890) on Mac OS Catalina 10.15.4. I have the following issue:
>=20
> When I connect to the company VPN (OpenVPN but I don't know version info)=
 I
> lose my DNS information from my normal network and I also do not get any
> DNS information for the secured network either. If I reset my network DNS
> information (Network -> Advances -> DNS -> Add default DNS Server and then
> remove it -> OK -> Apply (so no change ... just a reset) I will get my ho=
me
> network DNS back. But I still do not have any secure network DNS
> information.

Without a log file it's hard to say what is going on.

Also, for OpenVPN Connect, we're not the right forum to ask for help -
this is the commercial offering, and they do have a very friendly=20
customer support for it.

If your company wants you to run Connect, I assume they are using the
OpenVPN AS commercial product, and could go the customer support route.

If not, you might want to try Tunnelblick on MacOS instead of Connect,
which is the open source option - and with that, we can help much better.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--raJwLrX2Hrz326Dr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJemqlKAAoJEB2Cnv7KVigSBTcL/0q+ZGhzk9W36S8o2gHFfDTz
12Jgi21V0tdLB3KHdGM/EvB/RYeHGh0OYkpuLI2ou1TWvzrkqhRr6+txhN1xm0Sa
kaMaxzK4120wSeDvJka1kKhbg+uIfIhtDmpxfR/o2N2vRJ3ZUq5X5MN2ZR4ibEQO
rbeV3z5KUkhjMnP9IL/Z70VYMiPQ3HaN6Ck8OtcwvrX6PwxlRFzn9f5NDRUsueLd
9TuifWB7SX1LTxMk1wGABTOmaTGIwLBSrWWA2izHhduCZQaImWR04V9uV7qBdsre
Oc008rk4gdLTkcuidqjADDlk9CJhYTACd1o792Bh5yPIRx/yB5paPJ4lwol2lps3
zzwIUtTUs6hnK15Pd7ACOwmNXpElkUb2cPB5OJJKFJoElIMaxYxUbnFBIFS6FxVk
Eww/KJADIv06Xr5zlU+6RQVkp48yC9r9IXoUvV29pO58/wSmgsvXEAsjwFnpjqHY
dKbdqh5Q0fr9kDkAKsNDO6mpmM56hMOQzwF8c1sZaQ==
=psJn
-----END PGP SIGNATURE-----

--raJwLrX2Hrz326Dr--

