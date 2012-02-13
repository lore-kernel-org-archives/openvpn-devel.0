MIME-version: 1.0
Message-id: <0LZC00BTC12PDO10@...1551...>
Date: Mon, 13 Feb 2012 13:32:39 +0100
From: David Sommerseth <openvpn.list@...1114...>
References: <7c22eb11c37c167998cc7975576fe585@...1550...>
In-reply-to: <7c22eb11c37c167998cc7975576fe585@...1550...>
Subject: Re: [Openvpn-devel] [PATCH] Check for ENABLE_MANAGEMENT
	for	ENABLE_CLIENT_CR
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: igor@...1550...
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 12/02/12 19:40, igor@...1550... wrote:
> When building a very minimal OpenVPN for OpenWRT with 
> --disable-management among others, the compilaton fails due to 
> ENABLE_CLIENT_CR being defined, although the management interface, 
> which makes use of it, has been disabled.
> 
> The attached simple patch checks for ENABLE_MANAGEMENT before defining
> ENABLE_CLIENT_CR.

Which version are you compiling?  I tried a couple of compile with the
latest version in git (master branch) in combination with
- --disable-management and --enable-small ... And I could not manage to
trigger this one.  Our buildbot (even though, not testing all
combinations) have also not triggered this one.

Could you provide more version information and the configure arguments
you use?


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk85AuIACgkQDC186MBRfroHEACfbJfdxCqMM0rp+wqlWx6yxc6F
T+UAnAkQ1T7n0vb4F1cOqxaLTmQyQ4Zh
=Gwvf
-----END PGP SIGNATURE-----

