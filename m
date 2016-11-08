References: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
	<1477672963-5724-2-git-send-email-heiko.hund@...1489...>
	<da3ee3dd-9aef-1554-53ca-8760d87fa08b@...2080...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <5741cbe1-46c0-aba1-6dd4-03a16537ac99@...1435...>
Date: Tue, 8 Nov 2016 09:12:42 +0100
MIME-Version: 1.0
In-Reply-To: <da3ee3dd-9aef-1554-53ca-8760d87fa08b@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="usuFLJJ1qRnSkULOfLa1FxaqVbOrVTVAb"
Subject: Re: [Openvpn-devel] [PATCH 1/7] put argv_* functions into own file,
 add unit tests
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--usuFLJJ1qRnSkULOfLa1FxaqVbOrVTVAb
Content-Type: multipart/mixed; boundary="no8WXR0rcKhQXLoqojgOH1JGqMFe3jVdB";
	protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <5741cbe1-46c0-aba1-6dd4-03a16537ac99@...1435...>
Subject: Re: [Openvpn-devel] [PATCH 1/7] put argv_* functions into own file,
	add unit tests
References: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
	<1477672963-5724-2-git-send-email-heiko.hund@...1489...>
	<da3ee3dd-9aef-1554-53ca-8760d87fa08b@...2080...>
In-Reply-To: <da3ee3dd-9aef-1554-53ca-8760d87fa08b@...2080...>

--no8WXR0rcKhQXLoqojgOH1JGqMFe3jVdB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 08-11-16 00:28, David Sommerseth wrote:
> I will wait with applying this patch to the git tree until all the other
> patches in this series have been reviewed and ACKed.

Actually, this patch does not need the follow-up patches, right?  In
that case, I would strongly prefer if we didn't wait with applying it. I
say this because my --tls-crypt patch set also includes src/openvpn/*
unit tests, and it would be a lot better if I could rebase that patch
set on this patch before sending it to the list.  (Less work for the
maintainers, and makes my patch set slightly easier to review.)

-Steffan


--no8WXR0rcKhQXLoqojgOH1JGqMFe3jVdB--

--usuFLJJ1qRnSkULOfLa1FxaqVbOrVTVAb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYIYj/AAoJEEEwndWOY1w5A10H/A/9XH/lqoZkOwHLWmUNNMLs
aUhlnvzmYISGNMvo5/MYTz1y5gHrtlL47Jt7ZsIXjcOiMbueMYqEQ/9EocW38KSX
d0JF3iRyfvM4s+zeeJDutcUFoP/Dp/qkcNfzzAhhF+4o2Jysf1Dbd0gk6YmbCpS3
VCezfcGRcX/Jrhi15dYLjPjqi+9nL3l0II0UIrKFNvm/jtE1OW3PRlCSo2iiG3hR
8c+xyto52W/vfVS6MWXditoslcXSnG2r+u6HpwY4sMqyuBGLsGqvk341dDTZRkKc
Ixp3lFO9r/AjUFB7ZKcEAUKiURZTzvTU9W4vYYZ2wukeTWArlhhkDOABgnGea6o=
=x9/p
-----END PGP SIGNATURE-----

--usuFLJJ1qRnSkULOfLa1FxaqVbOrVTVAb--

