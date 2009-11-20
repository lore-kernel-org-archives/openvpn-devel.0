Message-ID: <4B06C633.6060906@...1114...>
Date: Fri, 20 Nov 2009 17:39:15 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4B06ABED.8090800@...41...>
In-Reply-To: <4B06ABED.8090800@...41...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1_rc22 released
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
To: Openvpn-devel@lists.sourceforge.net
Cc: James Yonan <jim@...41...>, OpenVpn-Users <openvpn-users@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 20/11/09 15:47, James Yonan wrote:
> Change log:
> 
> 2009.11.20 -- Version 2.1_rc22
> 
> * Fixed a client-side bug on Windows that occurred when the
>    "dhcp-pre-release" or "dhcp-renew" options were combined with
>    "route-gateway dhcp".  The release/renew would not occur
>    because the Windows DHCP renew function is blocking and
>    therefore must be called from another process or thread
>    so as not to stall the tunnel.
> 
> * Added a hard failure when peer provides a certificate chain
>    with depth > 16.  Previously, a warning was issued.
> 
> James

I have updated the patch for providing certificate SHA1
digest/fingerprint via the environment table for plug-ins.  This is
needed for the eurephia project I'm working on.

The patch is available for download here:
<http://sourceforge.net/projects/eurephia/files/OpenVPN/OpenVPN%20eurephia%20patches/openvpn-2.1_rc22_eurephia.patch/download>

The openvpn source tree with and without this patch can be fetched here:
<git://eurephia.git.sourceforge.net/gitroot/eurephia/openvpn-eurephia.git>

The git tree can be browsed via:
<http://eurephia.git.sourceforge.net/git/gitweb.cgi?p=eurephia/openvpn-eurephia.git;a=summary>


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAksGxi8ACgkQDC186MBRfrruMwCdHPAwrLUx7BbUxlGojE8MN66S
IaQAnizf5dRn4bIRKFuUzV0WM2Pc2NoV
=GQCZ
-----END PGP SIGNATURE-----

