Message-ID: <4D78AE2A.6050308@...1114...>
Date: Thu, 10 Mar 2011 11:55:38 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4D713CD3.3000606@...515...>
	<4D779123.8060303@...1432...>
In-Reply-To: <4D779123.8060303@...1432...>
Subject: Re: [Openvpn-devel] OpenVPN 2.2-RC released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
To: Markus Koetter <koetter@...1432...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/03/11 15:39, Markus Koetter wrote:
> Hi,
>=20
> On 03/04/2011 08:26 PM, Samuli Sepp=E4nen wrote:
>>      * Make the --x509-username-field feature an opt-in feature
>=20
> given the x509 username field is optional now, any chance to get x509 v3 =

> extensions as username [1] merged if they are made opt-in too?
>=20

commit 1e5a8a8d4461c1fb58b16760a7ac1aaf422fa396
Author: Markus Koetter <koetter@...1432...>
Date:   Fri Dec 10 20:30:09 2010 +0100

    Add extv3 X509 field support to --x509-username-field

    This allows using other X509 certificate fields for the certificate
    authentication.  To use altSubjectName, use
    --x509-username-field ext:altSubjectName

    This feature requires OpenVPN to be built with --enable-x509-alt-userna=
me

    This patch is slightly modified, to honour --enable-x509-alt-username
    compile time configuration.  Two #ifdef's are added.

    Signed-off-by: Markus Koetter <koetter@...1432...>
    Signed-off-by: David Sommerseth <davids@...1347...>
    Acked-by: David Sommerseth <davids@...1347...>
    Signed-off-by: David Sommerseth <davids@...1347...>


It will appear in OpenVPN 2.3.  It's already in allmerged, so by using the
development snapshots [1] or git source it can be tested already.  I expect
us to start pushing 2.3 beta in 2-3 months.  It all depends when v2.2 is
declared golden.


kind regards,

David Sommerseth




[1] <ftp://ftp.secure-computing.net/pub/FreeBSD/ports/openvpn-devel/>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk14ricACgkQDC186MBRfrpj6wCgmW2lUysLnH5pUbHwIA3BLznf
r/EAoJOk3wPtpcAI3e8XoS/ya0PCjC4P
=3DJpup
-----END PGP SIGNATURE-----

