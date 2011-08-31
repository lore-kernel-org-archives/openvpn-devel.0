MIME-Version: 1.0
In-Reply-To: <1314813915-30115-1-git-send-email-heiko.hund@...1489...>
References: <1314813915-30115-1-git-send-email-heiko.hund@...1489...>
Date: Wed, 31 Aug 2011 21:27:34 +0300
Message-ID: <CAOazyz0eyfp7kkvMZrnUwPiOc23UYFVp+RnA2mGe_Ba5yt5nVA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] add --mark option to set SO_MARK sockopt
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

Maybe should extend the usage of parameter "socket-flags"?

On Wed, Aug 31, 2011 at 9:05 PM, Heiko Hund <heiko.hund@...1489...> wrote:
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
> =C2=A0init.c =C2=A0 =C2=A0| =C2=A0 =C2=A01 +
> =C2=A0openvpn.8 | =C2=A0 =C2=A06 ++++++
> =C2=A0options.c | =C2=A0 14 ++++++++++++++
> =C2=A0options.h | =C2=A0 =C2=A03 +++
> =C2=A0socket.c =C2=A0| =C2=A0 13 +++++++++++++
> =C2=A0socket.h =C2=A0| =C2=A0 =C2=A01 +
> =C2=A06 files changed, 38 insertions(+), 0 deletions(-)
>
> diff --git a/init.c b/init.c
> index 0530b10..e8c9aab 100644
> --- a/init.c
> +++ b/init.c
> @@ -2640,6 +2640,7 @@ do_init_socket_1 (struct context *c, const int mode)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 c->options.mtu_discover_type,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 c->options.rcvbuf,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 c->options.sndbuf,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0c->options.mark,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 sockflags);
> =C2=A0}
>
> diff --git a/openvpn.8 b/openvpn.8
> index dc76464..55a9b80 100644
> --- a/openvpn.8
> +++ b/openvpn.8
> @@ -1371,6 +1371,12 @@ Set the TCP/UDP socket receive buffer size.
> =C2=A0Currently defaults to 65536 bytes.
> =C2=A0.\"*********************************************************
> =C2=A0.TP
> +.B \-\-mark value
> +Mark encrypted packets being sent with value. The mark value can be
> +matched in policy routing and packetfilter rules. This option is
> +only supported in Linux and does nothing on other operating systems.
> +.\"*********************************************************
> +.TP
> =C2=A0.B \-\-socket-flags flags...
> =C2=A0Apply the given flags to the OpenVPN transport socket.
> =C2=A0Currently, only
> diff --git a/options.c b/options.c
> index a6230de..d410782 100644
> --- a/options.c
> +++ b/options.c
> @@ -280,6 +280,10 @@ static const char usage_message[] =3D
> =C2=A0 " =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0or=
 --fragment max value, whichever is lower.\n"
> =C2=A0 "--sndbuf size =C2=A0 : Set the TCP/UDP send buffer size.\n"
> =C2=A0 "--rcvbuf size =C2=A0 : Set the TCP/UDP receive buffer size.\n"
> +#ifdef TARGET_LINUX
> + =C2=A0"--mark value =C2=A0 =C2=A0: Mark encrypted packets being sent wi=
th value. The mark value\n"
> + =C2=A0" =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c=
an be matched in policy routing and packetfilter rules.\n"
> +#endif
> =C2=A0 "--txqueuelen n =C2=A0: Set the tun/tap TX queue length to n (Linu=
x only).\n"
> =C2=A0 "--mlock =C2=A0 =C2=A0 =C2=A0 =C2=A0 : Disable Paging -- ensures k=
ey material and tunnel\n"
> =C2=A0 " =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0da=
ta will never be written to disk.\n"
> @@ -1473,6 +1477,9 @@ show_settings (const struct options *o)
> =C2=A0#endif
> =C2=A0 SHOW_INT (rcvbuf);
> =C2=A0 SHOW_INT (sndbuf);
> +#ifdef TARGET_LINUX
> + =C2=A0SHOW_INT (mark);
> +#endif
> =C2=A0 SHOW_INT (sockflags);
>
> =C2=A0 SHOW_BOOL (fast_io);
> @@ -4520,6 +4527,13 @@ add_option (struct options *options,
> =C2=A0 =C2=A0 =C2=A0 VERIFY_PERMISSION (OPT_P_SOCKBUF);
> =C2=A0 =C2=A0 =C2=A0 options->sndbuf =3D positive_atoi (p[1]);
> =C2=A0 =C2=A0 }
> + =C2=A0else if (streq (p[0], "mark") && p[1])
> + =C2=A0 =C2=A0{
> +#ifdef TARGET_LINUX
> + =C2=A0 =C2=A0 =C2=A0VERIFY_PERMISSION (OPT_P_GENERAL);
> + =C2=A0 =C2=A0 =C2=A0options->mark =3D atoi(p[1]);
> +#endif
> + =C2=A0 =C2=A0}
> =C2=A0 else if (streq (p[0], "socket-flags"))
> =C2=A0 =C2=A0 {
> =C2=A0 =C2=A0 =C2=A0 int j;
> diff --git a/options.h b/options.h
> index e723b66..d792872 100644
> --- a/options.h
> +++ b/options.h
> @@ -342,6 +342,9 @@ struct options
> =C2=A0 int rcvbuf;
> =C2=A0 int sndbuf;
>
> + =C2=A0/* mark value */
> + =C2=A0int mark;
> +
> =C2=A0 /* socket flags */
> =C2=A0 unsigned int sockflags;
>
> diff --git a/socket.c b/socket.c
> index 76c760c..a2f9511 100644
> --- a/socket.c
> +++ b/socket.c
> @@ -779,6 +779,15 @@ socket_set_tcp_nodelay (int sd, int state)
> =C2=A0#endif
> =C2=A0}
>
> +static void
> +socket_set_mark (int sd, int mark)
> +{
> +#ifdef TARGET_LINUX
> + =C2=A0if (mark && setsockopt (sd, SOL_SOCKET, SO_MARK, &mark, sizeof (m=
ark)) !=3D 0)
> + =C2=A0 =C2=A0msg (M_WARN, "NOTE: setsockopt SO_MARK=3D%d failed", mark);
> +#endif
> +}
> +
> =C2=A0static bool
> =C2=A0socket_set_flags (int sd, unsigned int sockflags)
> =C2=A0{
> @@ -1599,6 +1608,7 @@ link_socket_init_phase1 (struct link_socket *sock,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 int mtu_discover_type,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 int rcvbuf,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 int sndbuf,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0int mark,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 unsigned int sockflags)
> =C2=A0{
> =C2=A0 ASSERT (sock);
> @@ -1716,6 +1726,9 @@ link_socket_init_phase1 (struct link_socket *sock,
> =C2=A0 =C2=A0 =C2=A0 /* set socket buffers based on --sndbuf and --rcvbuf=
 options */
> =C2=A0 =C2=A0 =C2=A0 socket_set_buffers (sock->sd, &sock->socket_buffer_s=
izes);
>
> + =C2=A0 =C2=A0 =C2=A0/* set socket to --mark packets with given value */
> + =C2=A0 =C2=A0 =C2=A0socket_set_mark (sock->sd, mark);
> +
> =C2=A0 =C2=A0 =C2=A0 resolve_bind_local (sock);
> =C2=A0 =C2=A0 =C2=A0 resolve_remote (sock, 1, NULL, NULL);
> =C2=A0 =C2=A0 }
> diff --git a/socket.h b/socket.h
> index b385fb2..a9a29c5 100644
> --- a/socket.h
> +++ b/socket.h
> @@ -324,6 +324,7 @@ link_socket_init_phase1 (struct link_socket *sock,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 int mtu_discover_type,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 int rcvbuf,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 int sndbuf,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0int mark,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 unsigned int sockflags);
>
> =C2=A0void link_socket_init_phase2 (struct link_socket *sock,
> --
> 1.7.4.1
>
>
> -------------------------------------------------------------------------=
-----
> Special Offer -- Download ArcSight Logger for FREE!
> Finally, a world-class log management solution at an even better
> price-free! And you'll get a free "Love Thy Logs" t-shirt when you
> download Logger. Secure your free ArcSight Logger TODAY!
> http://p.sf.net/sfu/arcsisghtdev2dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

