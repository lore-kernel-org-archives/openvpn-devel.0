Message-ID: <4DE9167F.5030503@...1114...>
Date: Fri, 03 Jun 2011 19:14:39 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <552C1CE8297C9A408B3F0EEE515F3F2C013D109D0442@...1464...>
In-Reply-To: <552C1CE8297C9A408B3F0EEE515F3F2C013D109D0442@...1464...>
Subject: Re: [Openvpn-devel] OemWin2k.inf specify network adapter name
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Flaviano Maricotti <Flaviano.Maricotti@...1463...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 03/06/11 14:40, Flaviano Maricotti wrote:
> Hi,
> Is it possibile to have the name of network adapter as "OpenVPN" instead of default "Local area network" ?
> I would like to automatize the installation without rename the "Local area network".
> I can modify OemWin2k.inf or the winddk source of the driver.
> 

I'm no Windows developer, so I can't help out with a technical solution
here.  But if you can provide a patch with a proper fix, I will happily
merge it if it gets an ACK from people who understand this.

Pure feature wise, this really sounds like a reasonable thing to change.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk3pFnwACgkQDC186MBRfroLAgCfVRDqYB8g4skX8cu8HWE+cWXV
ZK8An1mKnnygqnLn4veYrimQImp/zRNy
=iGgt
-----END PGP SIGNATURE-----

