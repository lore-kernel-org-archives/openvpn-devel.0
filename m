Date: Wed, 11 Jan 2023 08:39:51 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Y75nx/NPVwZZePEr@...1296...>
References: <20230110170257.113527-1-frank@...2641...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="QCFGfzkQiWeAiHIR"
Content-Disposition: inline
In-Reply-To: <20230110170257.113527-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH] check_engine_keys: make pass with
 OpenSSL 3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

--QCFGfzkQiWeAiHIR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jan 10, 2023 at 06:02:57PM +0100, Frank Lichtenheld wrote:
> @@ -27,7 +27,7 @@ ${top_builddir}/src/openvpn/openvpn --cd ${top_srcdir}/=
sample --config sample-co
>  # first off check we died because of a key mismatch.  If this doesn't
>  # pass, suspect openssl of returning different messages and update the
>  # test accordingly
> -loggrep '(X509_check_private_key:key values mismatch|func\(128\):reason\=
(116\))' log.txt || { echo "Key mismatch not detected"; exit 1; }
> +loggrep '(x509 certificate routines:(X509_check_private_key)?:key values=
 mismatch|func\(128\):reason\(116\))' log.txt || { echo "Key mismatch not d=
etected"; exit 1; }

This change does not convince me - assuming normal regex here, the
original grep would have found any lines with

  X509_check_private_key:key values mismatch

in them, while the new one would find

  X509_check_private_key::key values mismatch
  X509_check_private_key:X509_check_private_key:key values mismatch

but not "the old one with just one :"

Should this be

  (x509 certificate routines:(X509_check_private_key:)?key va...

with the second ":" part of the (...:)? zero-or-once match?


(... as a side note, I hate this test... it's easily the test with the
most commits to make it behave across platforms and SSL library versions)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--QCFGfzkQiWeAiHIR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjvmfHAAoJEB2Cnv7KVigS8jAL/AzvojiX/8vkqab58v6Y1VCm
e5hzvPGZOTw2ZNtY6rvCjkkniD4L1kQXEa0dLomSPwKZ2YDEEt23yp6YCgL5u7gP
5K2WLsmq1zNPRK7knVGmOoV6/ZWVwBlxY541qFrbeuCkc32XTNs2MGBgZeCLeQYJ
hee98coeBX8c5z+rPs7H0+36OWoOraXNal6+IQvRjLAUDuf9d+51GiZhmXDzRFvM
s7h8jDIRkBCdxpEQ/GaHBU5uVzfkV49Wpq144uz3LXwHZ8Q52/kw+OZGHTjQCrs1
x9rpkrDUsMCoAP7qjARqaWrU5/17csmFGiljIBZyHCVQ91zqR2XAt0XtsabjMCNV
B+VzYrNnj3rlqjrmPRBECeyDNZsZRv356/l73JFg2S44qTDRO3Ugx+tQ3FTUcIDV
jhmsUWs0dWNV/bNh/NCNsAljR8DlH2PkQ1/vvM7XrzmQt4PUZ0Ysx2fVwaHj7cj7
V61hq3odez2GP1ovCNuwah4bz7VBa1JELSIxQtHuBQ==
=MIRE
-----END PGP SIGNATURE-----

--QCFGfzkQiWeAiHIR--

