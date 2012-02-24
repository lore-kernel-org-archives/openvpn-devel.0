Message-ID: <4F47E175.3030008@...1114...>
Date: Fri, 24 Feb 2012 20:13:57 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4F438CF2.1060305@...515...>
	<CAEsd45Rw5nYYuMMq_Qy_5tQYagZh+EMHM+2Nugod1_1s-BHthA@...278...>
	<4F44F7F8.4090604@...1114...>
	<eb2837a3-ce55-4f52-b2fe-f822efc661f7@...1662...>
In-Reply-To: <eb2837a3-ce55-4f52-b2fe-f822efc661f7@...1662...>
Subject: Re: [Openvpn-devel] OpenVPN 2.3-alpha1 preview 1 installer now
	available
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
To: debrabander <debrabander@...277...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 22/02/12 20:49, debrabander wrote:
> This is not the a problem when building using the latest Mac OS X
> SDK. I've did a quick search and it seems to be a more common issue on
> some (old) Darwin platforms. Please try building again after applying
> the patch below.
> 
> 
> Signed-off-by: Frank de Brabander <debrabander@...277...> --- socket.c
> |    5 +++++ 1 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/socket.c b/socket.c index 1a772af..6337900 100644 ---
> a/socket.c +++ b/socket.c @@ -893,8 +893,13 @@ create_socket_udp6
> (const unsigned int flags) else if (flags & SF_USE_IP_PKTINFO) { int
> pad = 1; +#ifndef IPV6_RECVPKTINFO /* Some older Darwin platforms
> require this */ +      if (setsockopt (sd, IPPROTO_IPV6,
> IPV6_PKTINFO, +		      (void*)&pad, sizeof(pad)) < 0) +#else if
> (setsockopt (sd, IPPROTO_IPV6, IPV6_RECVPKTINFO, (void*)&pad,
> sizeof(pad)) < 0) +#endif msg(M_SOCKERR, "UDP: failed setsockopt for
> IPV6_RECVPKTINFO"); } #endif

Right now, I'm a bit sceptic to this patch, as the JJO fixed a bug
related to the --multihome feature by moving over to IPV6_RECVPKTINFO

commit 5d6dbb03776de4d38f45e429ef674313a2bda8cc
Author: JuanJo Ciarlante <jjo@...410...>
Date:   Sun Feb 6 09:52:46 2011 +0100

    * fix --multihome for ipv6: IPV6_RECVPKTINFO
      - setsockopt IPV6_RECVPKTINFO (not IPV6_PKTINFO!)  <<<< [1]
      - do check for setsockopt() failures


[1] This is why I'm nervous for this patch.

If we can confirm that --multihome works as expected on platforms without
 IPV6_RECVPKTINFO, then I'm fine with this patch.  Otherwise, we need to
figure out how to make --multihome work too.

JJO, please have a look at this.


kind regards

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9H4XMACgkQDC186MBRfrqpVwCfdX8B62YecoVSdXUQ17K0Ra4o
FC8AoKn+1eI3NNtAFrEs71TjSWXFf2Po
=yRcC
-----END PGP SIGNATURE-----

