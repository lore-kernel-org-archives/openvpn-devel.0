Message-ID: <4B7BF17F.4080109@...1114...>
Date: Wed, 17 Feb 2010 14:39:11 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4B7AE8D6.3020304@...1114...>
	<jwvr5okih0h.fsf-monnier+gmane.network.openvpn.devel@...1269...>
In-Reply-To: <jwvr5okih0h.fsf-monnier+gmane.network.openvpn.devel@...1269...>
Subject: Re: [Openvpn-devel] [PATCH] FQDN for routes should expand to all IPs
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
To: Stefan Monnier <monnier@...1268...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 17/02/10 06:17, Stefan Monnier wrote:
> [ I've sent this in the past already, but just trying to make sure it
>   doesn't get lost somewhere. ]
> 
> When specifiying an FQDN for the network part of a route, OpenVPN should
> setup a route for each IP associated with that FQDN.  Currently, it just
> chooses one of the IPs at random instead, which leads to inconsistent
> and unpredictable behavior since subsequent connections to that FQDN will
> sometimes go through the VPN and sometimes not.
> 
> The patch below works for me, and I'd welcome any help in bringing it to
> a state where it can be included in the mainline code.  It was made
> against the openvpn-testing/master code.
> 

Thanks a lot for you patch!  In general, it very looks good.  Can you
elaborate a little bit on how you have tested this patch?  Have you
checked it for memory leaks?  (e.g. using valgrind)  What happens if no
FQDNs are found?

With some good answers and if this gets acceptance from more people in
regards to usability, I'm giving it an ACK.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkt78XoACgkQDC186MBRfroAnQCeJpU1wsEvAF5EvoFGhmlpU6DC
7VIAmgNo0hHLgcr4T+Y6x4HR9COGLQMV
=bAG6
-----END PGP SIGNATURE-----

