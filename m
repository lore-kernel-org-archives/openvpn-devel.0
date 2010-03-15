Message-ID: <4B9E03B6.1010604@...1114...>
Date: Mon, 15 Mar 2010 10:53:58 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4B9DF98F.3040902@...515...>
In-Reply-To: <4B9DF98F.3040902@...515...>
Subject: Re: [Openvpn-devel] [TESTING NEEDED] OpenVPN --passtos option
 support for 802.1Q tagged ethernet frames
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 15/03/10 10:10, Samuli Seppänen wrote:
> Hello,
> 
> Could somebody test if this new feature works - testing instructions are
> here:
> 
> http://www.secure-computing.net/wiki/index.php/OpenVPN/802.1Q_--passtos_patch
> 
> If we don't get any positive ("works for me") test reports we'll have to
> reject the patch for now. We'd be especially interested in test reports
> from environments which actually make use of 802.1Q.

Just to clarify one little detail.

We are indeed interested in test report from environments using 802.1Q.
 But we also do need to know if this implemented feature also work for
people *not* using this feature.  The patch itself is trivial, but it
touches some of the general code paths.

We just want to be sure that 1) the 802.1Q feature works as expected, 2)
that it does not change the current behaviour for those not needing the
802.1Q feature.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkueA7IACgkQDC186MBRfrp3eACghq0gJkt/L8AU9pjdGhiQSzmf
rn8AoKEsjbfpEfUJO8CayHF/ymMzTh1O
=ZZ51
-----END PGP SIGNATURE-----

