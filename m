Date: Thu, 28 Jun 2018 08:57:03 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180628065703.GS57262@...1296...>
References: <DM5PR08MB36429068FCBF60610B6E85CFB94F0@...2422...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="WR10eapE+9rkqyFM"
Content-Disposition: inline
In-Reply-To: <DM5PR08MB36429068FCBF60610B6E85CFB94F0@...2422...>
Subject: Re: [Openvpn-devel] OpenVPN GUI, and routes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Morris, Russell" <rmorris@...1315...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--WR10eapE+9rkqyFM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

HI,

On Thu, Jun 28, 2018 at 12:54:23AM +0000, Morris, Russell wrote:
> This may be by design ??? if so just say that and I???ll go away ??? ????=
. But that said ??? it seems I have to run the OpenVPN GUI (manually) as an=
 administrator, for routes to be set / added as directed by the server. Is =
this expected? Unfortunately it won???t even allow the client to connect if=
 this step fails.

With 2.4.x, the GUI is supposed to run with normal user privs.  Route
handling is done by the "OpenVPN Interactive Service", which needs to
be running.

If you install the normal installer provided by us, everything will be=20
set up so it just works.

If not, provide platform details, logs, etc.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--WR10eapE+9rkqyFM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbNIa+AAoJEB2Cnv7KVigSMo8MAI1euEu+6asVQ8XvOCVMwBAw
LuY4T1kQg1n/RdQzTBCSVG+79Sst6+XHfn578vB0R3aT6nvpJHvQq1VehBG7sruR
gAmGA/msh3bKo8nDkr4F6n20Nf9trREETF3dCFCnXy2Xy+VNzbTTZb7rjooxCykD
qooMOlk5hxPITDW3pCEdSlL6SJQX570H76WRwRkPimgYrVkkGgfMaZRMS441vL4u
zHwqM9YshVrf1kD1yu1ejbkX3En7MJOxhzUinJkeQt/x9NL/KbzYeC0RlXnnXmy2
exe0BWMVD3IaBHcFdgppEpJa7jUUKJz6xr7rG/nkHvl6kZ5RJOe7/1u4/kkSb5vq
rzeTFa8FPG/WKdIBk16ZW4mjXBWZs/Jkshy422MRaE+ucjgIud5KB0gPER4e7X/f
Uh7wH1hMcu5HckoP0bt6rpAY14EekJhhZRSsLTI6cohf3++B6UOKaKRMjRNwtc5R
aI+QI87xEgkrv5QsbRd++sVPLBXmV4RU5d1DJhBtCA==
=Dabi
-----END PGP SIGNATURE-----

--WR10eapE+9rkqyFM--

