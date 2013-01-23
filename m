Message-ID: <50FFDC58.3050202@...1114...>
Date: Wed, 23 Jan 2013 13:49:28 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CAM2vnFOwy-1=5VzUYFnssAMavmGgFYiqO7=GiEUNs2n+EpC-BQ@...278...>
In-Reply-To: <CAM2vnFOwy-1=5VzUYFnssAMavmGgFYiqO7=GiEUNs2n+EpC-BQ@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig2DCD800A347CFC946C3629BA"
Subject: Re: [Openvpn-devel] [PATCH] OpenVPN Obfuscation
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: 77 77 <siren1117@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2DCD800A347CFC946C3629BA
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 23/01/13 11:21, 77 77 wrote:
> Hi all,
>=20
> I wrote a patch to obfuscate OpenVPN's traffic to avoid protocol
> identification. Compared with other traffic obfuscation methods like
> using static keys or obfsproxy, it only adds one more config parameter,
> and supports both TCP and UDP. If OpenVPN releases support this, lots of
> devices will benefit from traffic obfuscation without installing
> additional softwares -- for exsample, the newly released OpenVPN Connect
> for iOS or Openvpn for Android.
>=20
> The patch is based on openvpn-2.2.1, but works fine with openvpn-2.2.2.

Gert said one very important thing about openvpn 2.2.  Even though, he
said to bring it up to openvpn-2.3 or git-master .... I'm saying
git-master is the natural point.  If you need to have it in openvpn-2.3,
backporting it from git-master is far easier than going the other way.

I've looked quickly at your patch.   And the first instinct is that,
yes, this looks reasonably well.  This is also a feature which I think
will be very useful in the coming future.

Just a few comments ...

- Have you looked at the obfsproxy project from TOR?  That does pretty
much a similar thing and does work together with OpenVPN (but only via
TCP, as it uses the socks5 proxy mode of obfsproxy).  Could it be
considered a better approach to integrate tighter against obfsproxy?
obfsproxy provides a more "plug-in" oriented approach where there
obfuscator logic can be changed at runtime, and doesn't necessarily
depend on a encryption/obfuscation key.  What you basically do is to RC4
encrypt the data.

- Have you looked into issues related with the RC4 algorithm?  IIRC, the
first 256 bytes of a RC4 stream should always be discarded and the
keying material should at minimum be hashed, otherwise weaknesses in RC4
makes it easier to crack the encryption.  I know and understand that
this is purely for obfuscation, but this encrypting isn't even
obfuscation if you can crack the key fairly easily.  Which again makes
me think of obfsproxy, which have established a fairly well stabilised
code base for traffic obfuscation.

- Have your patch been tested in both UDP and TCP mode?

- What is the purpose of the obfuscation_preprocess_incomming_link() and
obfuscation_preprocess_outgoing_link() functions?  Why isn't
obfuscation_process_incoming() or obfuscation_process_outgoing() used
directly?

- In OpenVPN 2.3 (including git-master) we also added support for
PolarSSL as an alternative to OpenSSL.  It would be good if the code
base could add PolarSSL support by using the SSL wrapper layer we now
have implemented.

For further information on the OpenVPN development methods, please look
here:

<https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation>

And if you're not familiar with git ... here's a git crash course, which
hopefully will help you get started quicker.

<https://community.openvpn.net/openvpn/wiki/GitCrashCourse>

Our code repositories can be found here:

<https://community.openvpn.net/openvpn/wiki/CodeRepositories>


--=20
kind regards,

David Sommerseth


--------------enig2DCD800A347CFC946C3629BA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlD/3FoACgkQDC186MBRfrqK3ACghuqPEvg3fGCC08nTsX+AHxC0
ju0An2wQUwrAb+bWebuJY8un57OMoWNo
=KHV3
-----END PGP SIGNATURE-----

--------------enig2DCD800A347CFC946C3629BA--

