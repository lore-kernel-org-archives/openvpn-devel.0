Message-ID: <4B8C47FF.2000401@...1114...>
Date: Tue, 02 Mar 2010 00:04:31 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1267364654-12937-1-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1267364654-12937-1-git-send-email-openvpn.list@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Allow 'lport 0' setup for random port
 binding
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
To: Enrico Scholz <enrico.scholz@...1291...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 28/02/10 14:44, David Sommerseth wrote:
> From: Enrico Scholz <enrico.scholz@...1291...>
> 
> I am running a multihomed host where 'local <extip>' must be specified
> for proper operation.  Unfortunately, this implies 'lport 1194' or
> another static port.
> 
> This causes problems with stateful firewalls which register the host/port
> pairs in the internal connection tracking table. On ungraceful reconnects,
> the new TCP connection will have same the host/port pairs but unexpected
> sequence numbers. The new connection will be assumed as invalid hence and
> be dropped.
> 
> It would be nice when local port can be configured to be bound to a
> random port number.  After reading code,
> 
> |    else if (streq (p[0], "lport") && p[1])
> |  ...
> |        port = atoi (p[1]);
> |-       if (!legal_ipv4_port (port))
> |+       if (port != 0 && !legal_ipv4_port (port))
> |          {
> 
> in options.c seems to be the only required change.
> 
> This has been discussed here:
> <http://thread.gmane.org/gmane.network.openvpn.user/28622>
> 
> Signed-off-by: David Sommerseth <dazo@...384...>
> ---
>  options.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 

This patch has been applied to the bugfix2.1 branch
commit 9bd1cd1b0014041ebff2c2bc9d5614d0bec5f6db

It will be merged into the allmerged branch when we get in a few more
patches which are in the pipe now.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkuMR/8ACgkQDC186MBRfrosfwCfbo0XMqE6qshPUyNXA1FnbeKr
/BEAoJbPyBsGnfs8kDHrY4uIN5l9OHPj
=Ojpb
-----END PGP SIGNATURE-----

