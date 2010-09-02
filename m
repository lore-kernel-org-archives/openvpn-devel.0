Message-ID: <4C801145.9050409@...1114...>
Date: Thu, 02 Sep 2010 23:04:05 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <20100902192624.GN10703@...1296...>
In-Reply-To: <20100902192624.GN10703@...1296...>
Subject: Re: [Openvpn-devel] PATCH/PULL: IPv6 check for TAP driver version
 on	windows
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 02/09/10 21:26, Gert Doering wrote:
> Hi,
> 
> as discussed just now on IRC, I have adapted the IPv6 check in tun.c
> to the version number used by the 2.2-beta3 tap driver.
> 
> David: could you please pull from 
> 
>   git://compile.svr01.mucip.net/openvpn-gert.git  "master"
> 
> to feat_ipv6_payload?
> 

git tree updated and pushed with your latest updates.  All changes have
been merged into allmerged as well.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkyAEUUACgkQDC186MBRfrp9tQCfZND/t3w8J+uHv63gjjWxr4Oy
Ee8An2qmtiWMehtKpCQTf+HFSbfALlXu
=K5O3
-----END PGP SIGNATURE-----

