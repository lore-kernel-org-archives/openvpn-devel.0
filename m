From: Jeremie Courreges-Anglas <jca@...2272...>
References: <20230426094931.1168078-1-arne@...1227...>
Date: Mon, 15 May 2023 19:26:49 +0200
In-Reply-To: <20230426094931.1168078-1-arne@...1227...> (Arne Schwabe's
 message of "Wed, 26 Apr 2023 11:49:31 +0200")
Message-ID: <87zg65mrom.fsf@...2733...>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH v3] Add Apache2 linking with for new
 commits
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 26 2023, Arne Schwabe <arne@...1227...> wrote:
> After first round of mailing people with more than 10 commits we have
> almost all committers have agreed. This put this license in the realm
> of having a realistic change to work. Had any of these contributers
> disagreed, rewriting all their code might have been not feasible.
>
> The rationale of adding this exception now is to avoid having to
> have a second round of agreement for new contributers and ensure
> that all new code will include the exemption.

The proposal here (already committed) merely adds an exception for
linking with Apache 2 libraries.  As discussed privately with Arne, the
proposal that I have received was to *replace* the OpenSSL linking
exception with the Apache 2 linking exception.  The rationale being that
OpenSSL 3 has moved to Apache 2, and that OpenVPN plans to drop support
for OpenSSL 1.X at some point.

The LibreSSL project has not moved to Apache 2 and doesn't plan to do
so.  OpenVPN currently builds and runs fine using LibreSSL, without any
patch.  I don't know about the state of OpenSSL 3 APIs in LibreSSL, but
I suggest not to tie together licensing matters and technical matters.

I think the existing OpenSSL linking exception should be kept as is.
For the (admittedly few and uncomplicated) changes I have contributed to
the OpenVPN code base, I would agree with a licensing change that
doesn't remove this exception.

For convenience, here's the current OpenSSL linking exception:
--8<--
  Special exception for linking OpenVPN with OpenSSL:

  In addition, as a special exception, OpenVPN Inc gives
  permission to link the code of this program with the OpenSSL
  library (or with modified versions of OpenSSL that use the same
  license as OpenSSL), and distribute linked combinations including
  the two.  You must obey the GNU General Public License in all
  respects for all of the code used other than OpenSSL.  If you modify
  this file, you may extend this exception to your version of the
  file, but you are not obligated to do so.  If you do not wish to
  do so, delete this exception statement from your version.
-->8--

Regards,
--=20
jca | PGP : 0x1524E7EE / 5135 92C1 AD36 5293 2BDF  DDCC 0DFA 74AE 1524 E7EE

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEUTWSwa02UpMr393MDfp0rhUk5+4FAmRia1oPHGpjYUB3eGN2
Ym4ub3JnAAoJEA36dK4VJOfuE88QAJa2buNbxOSKl9o1PVQ1EfW0Mp62zTsWH9oL
QGWQXtSpwRb8N5CUnGsesW7adprCdwcqyAx/Pot2k0r2Wqc7TPY9rd8wodoIX2sN
6O7Cukb3I40zbmpdPXOIDkP/+P/GA4JGSUdLFykO2iNyIfeU6xT6C04Ugiqm6D+R
tqNV37fyP+OGj6tTCAOhmIGu2hf1bMcH6/L3IyfN/ZElFDJelCBVMdqiJnauA8Aq
aB33G0NA2lmIR0z0Y25sIZq63318rOImXw3+tOVLXO7N6xk+vfpl0ZTrQLItt1Dx
RsHsA2QGItLIw03DS3Z5IyiI/L1YYHeAzVU/oA6ZoV5LdVc8Z+HKjwfmE5Op0jmO
2ZAx7/OjcnELsJNBd6C7eqzFPAKsLHKFP8SXSOzO7lP3KQ2iPzoI82+yQ7Qnj2ov
XO0itpKxvv37S8YarCa3FgCEI2BfixJqexFUPkqtsVA8po0vdC86Q2Lz/Tjn26m3
1lN9T6hm6OSdvqIj8nNhdQvY6mpzQN7GU31JiPhZW14XEV8cZPyrac2UXq9VkM7L
8CBwZHFWibCPWmdvquwegKBPrJG+sxbOUYPchxBxniR+W+dEYNt/I4ucoFiskmXC
CFVTeqaTZwZtgFIAGkrqpdGuCj2kAXQfo98PnaNaWl6sVxowUZW66m6ds06DzbUR
6nb6DQSN
=l7d9
-----END PGP SIGNATURE-----
--=-=-=--

