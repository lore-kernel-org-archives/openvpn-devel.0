Date: Sat, 24 Aug 2019 21:40:37 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190824194037.GA1349@...1296...>
References: <bd464d61-d16e-4a9b-de38-f96891e65368@...2525...>
 <7b72d228-e801-b490-86d5-6e763919d317@...1227...>
 <cb0d489a-b2e2-bab8-b774-bdfb6e20376d@...2525...>
 <54a17061-3fdd-5097-a59c-56a55d43c447@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="9Jdw4pA1x1k2W7MG"
Content-Disposition: inline
In-Reply-To: <54a17061-3fdd-5097-a59c-56a55d43c447@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Adding support for wolfSSL backend
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Juliusz Sosinowicz <juliusz@...2525...>, openvpn-devel@lists.sourceforge.net, Todd Ouska <todd@...2525...>, Sean Parkinson <sean@...2525...>

--9Jdw4pA1x1k2W7MG
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Aug 24, 2019 at 06:04:21PM +0200, Arne Schwabe wrote:
> I want to give you an honest opionion of mine to merging WolfSSL in
> OpenVPN. Please note, that this is my personal opinion and not to be
> confused to be an official OpenVPN community project or OpenVPN Inc
> position.

Arne summarized things quite well.  New and large additions need to
balance "what *our* users want/need", "what the core team finds=20
interesting enough to spend time on" and "how expensive in terms of=20
maintainer lifetime will it be to maintain that stuff".

Since we're currently short on contributors that can review crypto
related code changes, and we do not have anyone in the team today
that can review WolfSSL interface code at all, this isn't likely=20
going to happen in the near future.

gert,
   herder of cats, aka "trying to keep development somewhat on track"

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--9Jdw4pA1x1k2W7MG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdYZK1AAoJEB2Cnv7KVigStGAMAKR4rVom1+WUc9CD6YkKdV0b
eEhHK1GheMfxhiV2KJcofu1wVZR47D0yA5VVVaEFJl8QP780DAf5kbgcQChQRfEH
c0siJhOVK3ENTWBeRLOFHixV9dcMgayRAt2qeuC0BBuDZqUhIZd4r2AAcMyLPyex
TgP5cfnCkbGyfg3pO+2iVHR1rVfUR4Eww31e8WJ8GQRw1n/vN+cBrdXCIpRGRM8s
tCE7Wxc9EHFvOMM2ggfHeJyRUPWV4tucnWb011vhX04lBGSr+ZkZcIniwPLDqk5F
uMekDQcbEyFNaImf+idYnB2+rMDgNCKidd98/CDHJJE9aaRgVMynfUj7cvZ43AsN
YavVgRm6pIWwb0W/71Gjc/hw/pFFcj8+2EW/lLKG5wWVGKf3XWTq5EBMVR7GcoIQ
EBFLkkFbH9kP9ql6e267Flhj4fJI8q/Qa8B+CSSW3xvF5CA0+EjYwsafvQby7Ugb
DlpokHJlZw+M/ALEhrWyUZGZ2cs2oR3gsERGkrHBBg==
=Xzys
-----END PGP SIGNATURE-----

--9Jdw4pA1x1k2W7MG--

