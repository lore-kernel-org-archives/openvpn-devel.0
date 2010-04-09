Message-ID: <4BBFA6F5.8090303@...1114...>
Date: Sat, 10 Apr 2010 00:15:17 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4BBF0AE8.6090705@...515...>
	<51530802.20100409143821@...449...>	<4BBF2E96.80408@...515...>
	<685194187.20100409162718@...449...>
	<alpine.LRH.2.00.1004091415590.23080@...1344...>
In-Reply-To: <alpine.LRH.2.00.1004091415590.23080@...1344...>
Subject: Re: [Openvpn-devel] Summary of the IRC meeting (8th Apr 2010)
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
To: R P Herrold <herrold@...43...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/04/10 20:18, R P Herrold wrote:
> On Fri, 9 Apr 2010, Carsten Kr=FCger wrote:
>=20
>> Where is the problem?
>> Signing could be easily integrated in build process.
>=20
> umm -- Signing requires unlocking the GnuPG key to get a human=20
> set of eyes, and confirmation that all seems to be well into=20
> the process
>=20
> -- an autosigning from a non-protected key cannot sensibly be=20
> trusted, particularly with a process that has to run at some=20
> point with root access rights
>=20

Just to clarify here.  We are talking about one particular situation
here.  This is for the openvpn-testing based drivers - meaning, the
"unstable" development version, aimed for testing primarily and not
production environments.  In addition, this driver signing will only be
relevant for Windows environments for now.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAku/pvUACgkQDC186MBRfrpblQCgpyY+10vnfJXXWJSWvBCmCc2l
GJAAoJ9748YGWt9r2HEzzB+QjMf89dKY
=3DdumJ
-----END PGP SIGNATURE-----

