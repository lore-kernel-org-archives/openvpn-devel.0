Message-ID: <4F6C89F4.9000806@...1114...>
Date: Fri, 23 Mar 2012 15:34:28 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4F6C68AE.60003@...1702...>
In-Reply-To: <4F6C68AE.60003@...1702...>
Subject: Re: [Openvpn-devel] [openvpn-devel] OpenVPN 2.1.4/Linux:
 route-gatewy not working
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
To: Samuel CUELLA <samuel.cuella@...1702...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 23/03/12 13:12, Samuel CUELLA wrote:
> Hi list,
> 
> I've been struggling with OpenVPN bridge mode an entire day before
> going down to the source code:
> 
> The documentation (man page) says that the server-bridge
> configuration directive expands to more directives, including a
> "route-gateway" push. The push is actually done and is received on
> client side, but does nothing, i.e no default route is added on the
> client.
> 
> I've tracked down the issue in the source code and it seems that this 
> option as no effect when no route list have been created: 
> do_open_tun() only calls do_init_route_list if c->options.routes has 
> been initialized. This seems to be done by rol_check_alloc() in 
> add_option during option parsing. This is done only for the 
> "redirect-gateway" gateway option and never for "route-gateway", 
> resulting in this option being a no-op.
> 
> I've also tried (client-side and server-side) to use dummy routes(the 
> route that would be automatically added upon tap creation) to make 
> OpenVPN to create a route list without more success.
> 
> I don't know if this is the desired behavior or if I'm missing
> something here, but at least the documentation should be more clear on
> this feature.

Hi Samuel,

Interesting finding you've found here.  However, we're not developing the
2.1 branch any more.  So if you could try the latest git master branch
[1], that'd be great ... And if that still fails, try to apply your patch
to see if that improves it.

There has been some fixes to the whole routing part in 2.2 and 2.3, so we
need to be sure we're not fixing something which is fixed in a different way.


kind regards,

David Sommerseth



[1]
<https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation#Coderepositories>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9sifIACgkQDC186MBRfroZgQCfRTJQCONz6O5C+AVzSibOktTF
YbAAnA1zpAIXx1SesGU0a4cxbd3tmQ31
=e1YT
-----END PGP SIGNATURE-----

