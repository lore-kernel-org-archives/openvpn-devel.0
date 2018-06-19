Date: Tue, 19 Jun 2018 11:07:47 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180619090747.GK57262@...1296...>
References: <42bafab6-9e6f-56b5-2c44-b449ec503ce7@...515...>
 <20180611075242.GF57262@...1296...>
 <bb55cab5-2523-b899-0ead-6f34886c4d2b@...515...>
 <DM5PR2101MB1112279487CBA7B6DE9A3ABDB0710@...2412...>
 <20180618205610.GI57262@...1296...>
 <20180618205916.GJ57262@...1296...>
 <40307566-0fe7-81cc-773b-3f50aef1b5ef@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="70vtA4ZRF8MmM5t7"
Content-Disposition: inline
In-Reply-To: <40307566-0fe7-81cc-773b-3f50aef1b5ef@...515...>
Subject: Re: [Openvpn-devel] Regarding tap-windows6 driver signatures and
 driver distribution
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: Gert Doering <gert@...1296...>, Jon Kunkee <jkunkee@...2393...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--70vtA4ZRF8MmM5t7
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 19, 2018 at 10:43:53AM +0300, Samuli Sepp=E4nen wrote:
> > Most likely this release will be "get things out with compromises" -=20
> > that is, have one attestation signed driver for Win10+Server 2016> and =
one driver for "Win7 + 8 + 8.1", and two .exe installers.  Win10
> > is still waiting for bugfixed + signed tap drivers for the fix in
> > commit 7d6a1335bfe7a...
>=20
> Minor correction. We will have a separate installer for Windows Server
> 2016, which refuses to load any drivers whose attestation signing
> submission did not include HLK test results.

Yeah, sorry.  This stuff gets me confused again and again.  This is why
I just break the sources and you get to compile it afterwards ;-)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--70vtA4ZRF8MmM5t7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbKMfjAAoJEB2Cnv7KVigSuh4L/0Q4YTMneqfnhQFjQOgNP4FC
8xPOUowavgMxIND/SIqmHZ0q4ioQzopctyw9fMfTKIRtqTMQ5pM+prDAvOtxaq9l
dn4mcqSJziGnZpuVV3OmqCqQvNcg/JgzHJS4pgud3CjJ85ETHvwV2bpEIYLwBjIG
jlRzXkQijxHTURFrdqVilXSxgS/r6JsIxnNkNTRDOSdw5DacjHD3ReFYVochmyuE
RGR+wvH/E5TXRVw2n9qC4KbxOBDF7Z8F071NavFstRjRBC9mwpFwPKzcms/3w+Uo
YG6etR77D5miNdiKV0uNsGL5ZgG9jaV6zjVqlXd8eMvbgOayjRWkoBrICEXxsnMQ
Kuk2dFXrEIAkW3uRx90ehq++OqcZcLN4p7WNb7s9MYT4mzxwRnyBKuaglIGmLgiA
SVsDYtfa+pVhWM6KCR8/+0x4oQWFK4b+wtG6vwYb37Glj0ezRFd40ORXcM4F2AGG
EEjqq5jVzKOZ5RSxKslh2C2zD/qF3dnL6JLmKRlflA==
=cTM0
-----END PGP SIGNATURE-----

--70vtA4ZRF8MmM5t7--

