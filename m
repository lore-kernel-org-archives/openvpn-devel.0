Message-ID: <4B2250E4.8090908@...1114...>
Date: Fri, 11 Dec 2009 15:02:12 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4B220E0D.2090908@...41...>
In-Reply-To: <4B220E0D.2090908@...41...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1.0 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 11/12/09 10:17, James Yonan wrote:
> I'm happy to announce the release of OpenVPN 2.1.0.  This release is 
> basically 2.1_rc22 + some last-minute trivial fixes to documentation and 
> plugin sample code.  Enjoy!
> 
> James

I have updated the patch for providing certificate SHA1
digest/fingerprint via the environment table for plug-ins.  This is
needed for the eurephia project I'm working on.

The patch is basically identical to the 2.1_rc22 patch.

The patch is available for download here:
<http://sourceforge.net/projects/eurephia/files/OpenVPN/OpenVPN%20eurephia%20patches/openvpn-2.1.0_eurephia.patch/download>

A pre-patched OpenVPN 2.1.0 release can be downloaded here:
<https://sourceforge.net/projects/eurephia/files/OpenVPN/Pre-patched%20OpenVPN/openvpn-2.1.0_eurephia.tar.bz2/download>

The openvpn source tree with and without this patch can be fetched here:
<git://eurephia.git.sourceforge.net/gitroot/eurephia/openvpn-eurephia.git>

The git tree can be browsed via:
<http://eurephia.git.sourceforge.net/git/gitweb.cgi?p=eurephia/openvpn-eurephia.git;a=summary>


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAksiUOEACgkQDC186MBRfro8FQCgrF0besE8cipvATt8lNQp7NST
tF8AoJ4x1uwqFq+OqqQgvf6EDlMzi6c3
=cuX9
-----END PGP SIGNATURE-----

