Reply-To: openvpn-devel@lists.sourceforge.net
References: <20170906235202.26551-1-davids@...515...>
 <20170907061646.GD70062@...1296...>
 <79762b44-c8c8-b765-1711-22ba3f210af0@...515...>
 <1e1b1ed5-5a4e-5234-1e57-06a609a6f2b9@...515...>
 <20170907081340.GG70062@...1296...>
 <8f028968-1263-af79-4b49-863a202b9d93@...515...>
 <188385e3-e632-5ae4-4b16-4c724bcec6b1@...2080...>
 <20170922212554.GC70062@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <f16e3302-bcd8-e239-54f0-44451f3981f1@...2080...>
Date: Fri, 22 Sep 2017 23:28:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170922212554.GC70062@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="kr3OG76cVPN3TMJ5QfDWCKAxdTp3o8H8h"
Subject: Re: [Openvpn-devel] [PATCH] systemd: Enable systemd's auto-restart
 feature for server profiles
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <davids@...515...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kr3OG76cVPN3TMJ5QfDWCKAxdTp3o8H8h
Content-Type: multipart/mixed; boundary="7PunOMcIkvra2TeOx0ESMFwcQ4g0CM2VM";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <davids@...515...>
Message-ID: <f16e3302-bcd8-e239-54f0-44451f3981f1@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] systemd: Enable systemd's auto-restart
 feature for server profiles
References: <20170906235202.26551-1-davids@...515...>
 <20170907061646.GD70062@...1296...>
 <79762b44-c8c8-b765-1711-22ba3f210af0@...515...>
 <1e1b1ed5-5a4e-5234-1e57-06a609a6f2b9@...515...>
 <20170907081340.GG70062@...1296...>
 <8f028968-1263-af79-4b49-863a202b9d93@...515...>
 <188385e3-e632-5ae4-4b16-4c724bcec6b1@...2080...>
 <20170922212554.GC70062@...1296...>
In-Reply-To: <20170922212554.GC70062@...1296...>

--7PunOMcIkvra2TeOx0ESMFwcQ4g0CM2VM
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 22/09/17 23:25, Gert Doering wrote:
> Hi,
>=20
> On Thu, Sep 07, 2017 at 03:16:45PM +0200, David Sommerseth wrote:
>> So the RestartForceExitStatus/RestartPreventExitStatus is not going to
>> be helpful if all graceful errors results in 1, which is the most common
>> way OpenVPN stops - through the M_FATAL.  So that leaves us with
>> SIGSEGV, SIGABRT and similar unclean exit signals.
>>
>> To avoid restarts on faulty configurations or if we can define scenarios
>> where we do not want OpenVPN to be restarted automatically, we need to
>> introduce more exit codes.  This way we can implicitly tell systemd if
>> it should restart OpenVPN or not.
>=20
> Indeed.  Just to agree publically here :-) - it seems we'll need to
> revisit exit codes as well, for "restarting this won't do any good"
> (fatal config errors, for example) vs. "we have crashed, and please do
> restart!!" (out of memory as something obvious we can't easily catch,
> most other error situations wrt network *should* not cause a M_FATAL,
> even if some still do).
>=20
> Where do we keep this as "we need to look into it, but it's complicated"
> reminder?  trac?

Yeah, a trac ticket is probably the best.

--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--7PunOMcIkvra2TeOx0ESMFwcQ4g0CM2VM--

--kr3OG76cVPN3TMJ5QfDWCKAxdTp3o8H8h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZxYCbAAoJEIbPlEyWcf3ylKoQAIvFdZ5CjL2c9Yi36aK23h4P
nIUe+7YYV+5i8JLvj+3z77Sdj8u25hqAtxi3gpFW+r8lqJWA3iPXHJ4FcZ7sybc6
BYSg1v05arEdJULJQrt69vWNdPPM9T6qUtQ8UxZrDRqDipdHS0LkpO2c5wLG5knS
6ngS1XD/NVbA8JZO4v7YxUOzDZqSo79K0xs01vXhu+NMflKpVSHQFTVLGO7wK+GY
Lmjt5gh+4Zg83hcnZN+aU5a9EWC0AZWc5taWIWCvb+IgsYR+oDPi4Jjw5tPUsJXj
sRw8ZW7MGojzq+LdSNIe8qKv/OwCePzBqrCGUenvIpoSZB+hMGPiZVSI/DjVCzTM
wS67z8cBV0RTr8qEXuLNr9N6kSxKE3fVAmHELajiMgBDT2z71/rwzb6izoTY4GZJ
ZAa83tx2FDP0n9YYy7rdk/TdMqyviw0kfHxS/hu3QKUI2x8QBXrq4Gn+EPJ8540W
71ACVpDdW6XzbKWPl/KMrTasPSdFLcFlhqPbIk3qXfzrHKtVEXd/XpVyrJFQ89tJ
xT/UYE2VgADSiw6UrtRR27mOl/+dz7Qdp8A7XGzTf/vRk1mP/1qtm5K04SyVGP7a
r2ezOVF/8wSXsEWq1LC/HdFbymLCCnNSms8uZl7bShdam9yEkEUiPGamlQ+PNoem
J+2Ml7TZGE33HgxYqka2
=dreo
-----END PGP SIGNATURE-----

--kr3OG76cVPN3TMJ5QfDWCKAxdTp3o8H8h--

