Message-ID: <4DD634DF.4070502@...1114...>
Date: Fri, 20 May 2011 11:31:11 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1305880405-8928-1-git-send-email-xavier@...1461...>
In-Reply-To: <1305880405-8928-1-git-send-email-xavier@...1461...>
Subject: Re: [Openvpn-devel] [PATCH] Add parameter "dev <device>" to
 add_route and delete_route for IPv4, as it is done for IPv6.
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
To: Xavier Franquet <xavier@...1461...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 20/05/11 10:33, Xavier Franquet wrote:
> When openvpn tries to add (or delete) an IPv4 route, doesn't use the parameter "dev <device>" in the command.
> If there's a local subnet that matches the VPN Server network, the route would use a wrong interface.
> Ex:
>    local subnet 10.100.0.0/24 on iface eth2
>    openvpn pool 10.100.0.0/16 on iface tap2 (ifconfig_pool_remote_ip is 10.100.0.1)
>       push "route 10.10.0.1 255.255.255.255"
> 
>    Without the patch, the route will be added with eth2, instead of tap2
> 
> Signed-off-by: Xavier Franquet <xavier@...1461...>
> ---
>  route.c |   23 +++++++++++++++--------
>  1 files changed, 15 insertions(+), 8 deletions(-)

Thanks a lot for a better explanation and resending the patch.  At first
glance this makes sense.  But it will break some features in OpenVPN.

- From the man page for --route:

       --route network/IP [netmask] [gateway] [metric]
	[...snip...]

              gateway default -- taken from --route-gateway  or  the
              second parameter to --ifconfig when --dev tun is spec‐
              ified.

              metric default -- taken from --route-metric  otherwise
              0.

              The  default  can  be  specified  by leaving an option
              blank or setting it to "default".

              The network and gateway parameters can also be  speci‐
              fied  as  a DNS or /etc/hosts file resolvable name, or
              as one of three special keywords:

              vpn_gateway  --  The  remote  VPN   endpoint   address
              (derived  either  from  --route-gateway  or the second
              parameter to --ifconfig when --dev tun is specified).

              net_gateway -- The pre-existing  IP  default  gateway,
              read  from  the  routing  table  (not supported on all
              OSes).

              remote_host -- The  --remote  address  if  OpenVPN  is
              being  run  in client mode, and is undefined in server
              mode.

As you can see, the [gateway] part of the --route statement can also have
the keywords 'vpn_gateway', 'net_gateway' or 'remote_host'.  Your patch in
the current shape will break this feature.

Gert and I have discussed your patch, and we believe a more appropriate
patch would consider the 'vpn_gateway' keyword.  So if the gateway the new
route will use matches with what 'vpn_gateway' expands to, then adding a
'dev' argument to route makes sense.

What do you think?


kind regards,

David Sommerseth

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk3WNN0ACgkQDC186MBRfrqbPACfbnziB9jPepFiVfYlRI7hIsFi
cAwAn0ClniBDn6HY1oV1JIms5TWIBmtO
=Oy1c
-----END PGP SIGNATURE-----

