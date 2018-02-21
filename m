Date: Wed, 21 Feb 2018 08:42:59 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20180221074259.GT69387@...1296...>
References: <1511026858-23281-1-git-send-email-selva.nair@...277...>
 <1511026858-23281-2-git-send-email-selva.nair@...277...>
 <20180220161429.GB69696@...1296...>
 <CAKuzo_iDwg6YJX4GaXPOU8tGhRoKL3-025N9=a+jNwDaZWSy2A@...278...>
 <20180220195920.GQ69387@...1296...>
 <CAKuzo_iiv+3GJXuAV1rD+ZH9ijUybqVVNBW1iaV5KzNTDZgyfQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="6rTh04rb0J9qQhfe"
Content-Disposition: inline
In-Reply-To: <CAKuzo_iiv+3GJXuAV1rD+ZH9ijUybqVVNBW1iaV5KzNTDZgyfQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Make most registry values optional
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--6rTh04rb0J9qQhfe
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Feb 20, 2018 at 06:33:35PM -0500, Selva Nair wrote:
> > (It does happen for my own binary and for the installers Samuli builds,
> > so it's not "my build environment" - theoretically it could be part 1/2
> > of that patch set, which I haven't run yet)
>=20
> Yeah, I could reproduce it on Windows 7. And, at last,  after several
> painful Windows builds, it turns out:
>=20
> RegGetValue with RRF_RT_REG_EXPAND_SZ|RRF_RT_REG_SZ is broken on
> Windows 7 (and most likely Vista too).

Thanks for investigating and finding the root cause.  "This is not what
the documentation says...!" -> I need to actually *run* these things, not
just test compile.

> But once you know what to look for, just google:
>=20
> https://stackoverflow.com/questions/47096940/reggetvalue-for-value-that-m=
ay-be-either-reg-sz-or-reg-expand-sz
>=20
> Will send a patch later.

Thanks!

PS: when you say "several painful Windows builds" - I found that things
are actually working quite nicely using "build-snapshot --use-depcache",
pointing this to a private git repo which has the code I want to test.
Still a bit annoying because the machinery insists on "fetch all, clean
all, rebuild all" instead of "there's the source directory, just run=20
make!"... shall we try to spend a bit time on this, to make interactively
working on source changes nicer?

gert
--=20
now what should I write here...

Gert Doering - Munich, Germany                             gert@...1296...

--6rTh04rb0J9qQhfe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJajSMCAAoJEB2Cnv7KVigSpvEMAJMynS+xm/KTOEmA0Y7LOI6Q
Rab5H0zWrAgMEf/LqwGq/6y7thhT0UZjQsvVqXt16ZtYcBAngtdb0THM8N/w2KVT
lyLNnxFedmBbnoKTx8qyA1MaxbUpd5/Ytomy+1oWHGF1LmiXNhYH4x7yimkd3o5G
ekAbQI1QdHXVWmBL8X3n9sWWgDBwv2IaHrK0A4uyT1QHP7EM9J+lOkRGjbTBooep
jPiKTFpfz9MtlFI9asfStspG9kg+/thC0v2Y8uTD2NsAXPGJcBsPGlv0hyyAEraC
de/uAcmfAS5NmauyofGt23h9x5rLK15jh6+2I9/3sjKa/BqIIzpG1i2NoP4RG5dt
F9WMR26I9JnkN/qAlkM7kGDuWkPnXmW2I4hfwDIQdrt1suU6N6rO4BQshhBVY7wP
8GdO1naWxu1NS/NrC/BFUc6cYVLFuFjBNHLGkHKX2M/UZKH4PzyNvbmzICuj27dI
7yPHVSYTccQvxmuDcNqJ4PpGaw2Hj9CyIUnjQwxRlw==
=SzjQ
-----END PGP SIGNATURE-----

--6rTh04rb0J9qQhfe--

