Message-ID: <4B7177C4.5020909@...1114...>
Date: Tue, 09 Feb 2010 15:57:08 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20100209132645.GX9430@...1302...>
In-Reply-To: <20100209132645.GX9430@...1302...>
Subject: Re: [Openvpn-devel] Openvpn on Symbian?
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
To: Ruben Puettmann <ruben@...1302...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/02/10 14:26, Ruben Puettmann wrote:
> 
>             hy,
> 
> I will ask you if there is any work in progress porting openvpn to
> symbian os. Since 4.Feb 2010 the source code from is free available see
> http://www.symbian.org. It would be very nice to see openvpn on my E71
> running.
> 

Hi Ruben,

There are no Symbian effort afaik, at least at the moment.  One of the
main problems have been to figure out how to actually create the virtual
tunnelling device (tun/tap driver).  But as you nicely pointed out, the
Symbian source code is getting open which might provide the needed
information for someone to write or port a tun/tap driver to Symbian.
With that in place, the rest should be rather simple.


kind regards,

David Sommerseth



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAktxd8AACgkQDC186MBRfrpcMgCfc63wloGwigvu1Uu5fuMn0JDQ
HBwAn2Hu0mcriCGVPB7mJGooMTAcQcF7
=1ZBi
-----END PGP SIGNATURE-----

