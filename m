MIME-Version: 1.0
In-Reply-To: <4AC5C604.3010908@...41...>
References: <4AC5C604.3010908@...41...>
From: Jonathan Petersson <jpetersson@...1214...>
Date: Fri, 2 Oct 2009 07:14:51 -0700
Message-ID: <fa2e1350910020714h9b293ccj76cd2ddc2d68e536@...278...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1_rc20 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: James Yonan <jim@...41...>
Cc: Openvpn-devel@lists.sourceforge.net, OpenVpn-Users <openvpn-users@lists.sourceforge.net>

Great work guys, keep up the good work!

/Jonathan

On Fri, Oct 2, 2009 at 2:21 AM, James Yonan <jim@...41...> wrote:
> 2009.10.01 -- Version 2.1_rc20
>
> * Fixed a bug introduced in 2.1_rc17 (svn r4436) where using the
> =A0 redirect-gateway option by itself, without any extra parameters,
> =A0 would cause the option to be ignored.
>
> * Fixed build problem when ./configure --disable-server is used.
>
> * Fixed ifconfig command for "topology subnet" on FreeBSD (Stefan Bethke).
>
> * Added --remote-random-hostname option.
>
> * Added "load-stats" management interface command to get global server
> =A0 load statistics.
>
> * Added new ./configure flags:
>
> =A0 --disable-def-auth =A0 =A0 =A0Disable deferred authentication
> =A0 --disable-pf =A0 =A0 =A0 =A0 =A0 =A0Disable internal packet filter
>
> * Added "setcon" directive for interoperability with SELinux (Sebastien
> =A0 Raveau).
>
> * Optimized PUSH_REQUEST handshake sequence to shave several seconds
> =A0 off of a typical client connection initiation.
>
> * The maximum number of "route" directives (specified in the config
> =A0 file or pulled from a server) can now be configured via the new
> =A0 "max-routes" directive.
>
> * Eliminated the limitation on the number of options that can be pushed
> =A0 to clients, including routes. =A0Previously, all pushed options needed
> =A0 to fit within a 1024 byte options string.
>
> * Added --server-poll-timeout option : when polling possible remote
> =A0 servers to connect to in a round-robin fashion, spend no more than
> =A0 n seconds waiting for a response before trying the next server.
>
> * Added the ability for the server to provide a custom reason string
> =A0 when an AUTH_FAILED message is returned to the client. =A0This
> =A0 string can be set by the server-side managment interface and read
> =A0 by the client-side management interface.
>
> * client-kill management interface command, when issued on server, will
> =A0 now send a RESTART message to client.
> =A0 This feature is intended to make UDP clients respond the same as TCP
> =A0 clients in the case where the server issues a RESTART message in
> =A0 order to force the client to reconnect and pull a new options/route
> =A0 list.
>
> -------------------------------------------------------------------------=
-----
> Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
> is the only developer event you need to attend this year. Jumpstart your
> developing skills, take BlackBerry mobile applications to market and stay
> ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#3=
3;
> http://p.sf.net/sfu/devconf
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

