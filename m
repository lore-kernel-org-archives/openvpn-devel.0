Date: Wed, 10 Aug 2022 18:39:21 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YvPfOR/iU3lY2bvc@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="e50ttJTI9nnhzgsg"
Content-Disposition: inline
In-Reply-To: <20220808143424.65924-3-kprovost@...2661...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] ovpn-dco: introduce FreeBSD
 data-channel offload support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--e50ttJTI9nnhzgsg
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

(Re-sending, as the first one had a .png attached which exceeded what
sourceforge is willing to forward)

Hi,

as promised, here's test results and code review.

Test results:

 - running openvpn over TCP gives me a kernel panic - this is not so
   nice... (see attached .png from the vmware console) - userland seems
   to assume "kernel can do TCP", kernel panics on "if !udp, panic()"
   (so intentional panic, not corruption panic).

   This is on freebsd git FreeBSD 14.0-CURRENT #1 main-n257130-c0665d5c824

 - running openvpn over UDP has issues with fragmentation - almost all
   t_client tests that *do* use DCO fail the "big ping" test

	run IPv4 ping tests (want_ok), 64 byte packets...
	run IPv4 ping tests (want_ok), 1440 byte packets...
	run IPv4 ping tests (want_ok), 3000 byte packets...

	FAIL: IPv4 ping test (3000 bytes) failed, but should succeed.
	run IPv6 ping tests (want_ok), 64 byte packets...
	run IPv6 ping tests (want_ok), 1440 byte packets...
	run IPv6 ping tests (want_ok), 3000 byte packets...

	FAIL: IPv6 ping test (3000 bytes) failed, but should succeed.

   this is "with no special mtu related options to OpenVPN", so the
   tun interface is MTU 1500, and the pings are created by

        fping -b 3000 -C 20 -p 250 -q -C 5 -p 400 10.194.5.1 10.194.0.1
        fping6 -b 3000 -C 20 -p 250 -q -C 5 -p 400 fd00:abcd:194:5::1 fd00:=
abcd:194:0::1

   (testing the host "on the p2p link" and "something behind a --route
    pushed by the server")

   I have not investigated exactly what happens at which point yet, but
   with Linux DCO, we had a similar effect where a fragmented *inside*
   packet ("ICMP") carried over a flag in the sk_buff that resulted in
   the kernel refusing to fragment the resulting *outside* packet.

   (Inside MTU 1500 -> fping -s 3000 -> 3 "inside" fragments,=20
    1500+1500+68, adding openvpn overhead -> packet > 1500 ->=20
    external fragmentation needed for the first two)

   Inside tcpdump (tun0):

17:28:37.342050 IP (tos 0x0, ttl 64, id 50758, offset 0, flags [+], proto I=
CMP (1), length 1500)
    10.194.5.222 > 10.194.5.1: ICMP echo request, id 2433, seq 0, length 14=
80
17:28:37.342142 IP (tos 0x0, ttl 64, id 50758, offset 1480, flags [+], prot=
o ICMP (1), length 1500)
    10.194.5.222 > 10.194.5.1: ip-proto-1
17:28:37.342270 IP (tos 0x0, ttl 64, id 50758, offset 2960, flags [none], p=
roto ICMP (1), length 68)
    10.194.5.222 > 10.194.5.1: ip-proto-1

   Outside tcpdump (em0):

17:28:37.342103 IP (tos 0x0, ttl 64, id 50759, offset 0, flags [+], proto U=
DP (17), length 1500)
    194.97.140.5.15738 > 199.102.77.82.51197: UDP, bad length 1528 > 1472
17:28:37.342123 IP (tos 0x0, ttl 64, id 50759, offset 1480, flags [none], p=
roto UDP (17), length 76)
    194.97.140.5 > 199.102.77.82: ip-proto-17
17:28:37.342185 IP (tos 0x0, ttl 64, id 50760, offset 0, flags [+], proto U=
DP (17), length 1500)
    194.97.140.5.15738 > 199.102.77.82.51197: UDP, bad length 1528 > 1472
17:28:37.342228 IP (tos 0x0, ttl 64, id 50760, offset 1480, flags [none], p=
roto UDP (17), length 76)
    194.97.140.5 > 199.102.77.82: ip-proto-17
17:28:37.342300 IP (tos 0x0, ttl 64, id 50761, offset 0, flags [none], prot=
o UDP (17), length 132)
    194.97.140.5.15738 > 199.102.77.82.51197: UDP, length 104


   ... this *does* look correct, but there is never a reply from the other
   end, so something is not right.  Either inside or outside.

   This happens with IPv4 or IPv6 UDP outside, and IPv4 or IPv6 inside.


- tcpdump'ing on the DCO interface gave me complains from the kernel
  about locking on ctrl-c'ing

    Aug 10 17:28:41 fbsd14 kernel: lock order bpf global lock -> iflib ctx =
lock attempted at:
    Aug 10 17:28:41 fbsd14 kernel: #0 0xffffffff80c5c3dd at witness_checkor=
der+0xbfd
    Aug 10 17:28:41 fbsd14 kernel: #1 0xffffffff80bf5303 at _sx_xlock+0x63
    Aug 10 17:28:41 fbsd14 kernel: #2 0xffffffff80d3874f at iflib_if_ioctl+=
0x2df
    Aug 10 17:28:41 fbsd14 kernel: #3 0xffffffff80d19b5e at if_setflag+0xde
    Aug 10 17:28:41 fbsd14 kernel: #4 0xffffffff80d19a2a at ifpromisc+0x2a
    Aug 10 17:28:41 fbsd14 kernel: #5 0xffffffff80d0e72b at bpf_detachd_loc=
ked+0x27b
    Aug 10 17:28:41 fbsd14 kernel: #6 0xffffffff80d111f7 at bpf_dtor+0x87
    Aug 10 17:28:41 fbsd14 kernel: #7 0xffffffff80a7818b at devfs_destroy_c=
devpriv+0xab
    Aug 10 17:28:41 fbsd14 kernel: #8 0xffffffff80a7bda4 at devfs_close_f+0=
x64
    Aug 10 17:28:41 fbsd14 kernel: #9 0xffffffff80b876eb at _fdrop+0x1b
    Aug 10 17:28:41 fbsd14 kernel: #10 0xffffffff80b8af3b at closef+0x1db
    Aug 10 17:28:41 fbsd14 kernel: #11 0xffffffff80b8ec97 at closefp_impl+0=
x77
    Aug 10 17:28:41 fbsd14 kernel: #12 0xffffffff810c733e at amd64_syscall+=
0x12e
    Aug 10 17:28:41 fbsd14 kernel: #13 0xffffffff8109ae0b at fast_syscall_c=
ommon+0xf8

   ... so while this is outside "openvpn source code patches", it's=20
   still something that smells like it needs to be addressed.


Now, coding style ;-) - as promised, I went through the code for things
that need to be done in a certain way in OpenVPN land, due to agreed
convention... inline (things I do not comment could go in "as is").


On Mon, Aug 08, 2022 at 04:34:23PM +0200, Kristof Provost via Openvpn-devel=
 wrote:
> diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
> new file mode 100644
> index 00000000..a8a53fe3
> --- /dev/null
> +++ b/src/openvpn/dco_freebsd.c
> @@ -0,0 +1,636 @@
[..]
> +static nvlist_t *
> +sockaddr_to_nvlist(const struct sockaddr *sa)
> +{
[..]
> +        default:
> +            abort();

please use "ASSERT(0);" here.  It will do the same thing, but if ever
hit, it will print a __FILE__, __LINE__ message to the log, so it's
easier for us to see *where* it triggered a "this must never happen"
condition.


> +int
> +dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
> +             struct sockaddr *localaddr, struct sockaddr *remoteaddr,
> +             struct in_addr *remote_in4, struct in6_addr *remote_in6)
> +{
> +    struct ifdrv drv;
> +    nvlist_t *nvl;
> +    int ret;
> +
> +    nvl =3D nvlist_create(0);

We use C99 these days, so this could be written as=20

> +    nvlist_t *nvl =3D nvlist_create(0);

but this is a matter of personal preference.  Both are fine, just wanted
to point out that the option exists.

> +
> +    nvlist_add_number(nvl, "fd", sd);
> +    nvlist_add_number(nvl, "peerid", peerid);
> +
> +    bzero(&drv, sizeof(drv));
> +    snprintf(drv.ifd_name, IFNAMSIZ, "%s", dco->ifname);
> +    drv.ifd_cmd =3D OVPN_NEW_PEER;
> +    drv.ifd_data =3D nvlist_pack(nvl, &drv.ifd_len);
> +
> +    ret =3D ioctl(dco->fd, SIOCSDRVSPEC, &drv);
> +    free(drv.ifd_data);

What happens should nvlist_pack() fail here?  Manpage says it returns
NULL, will the ioctl() handle this gracefully, or will something crash?

(If the ioctl() returns something like EINVAL in this case, perfectly fine)

> +    nvlist_destroy(nvl);
> +    if (ret)
> +    {
> +        msg(D_DCO, "Failed to create new peer %d", errno);
> +        return ret;
> +    }
> +
> +    return 0;
> +}

Most functions in OpenVPN that do use a "ret" variable would look
more like this:

> +    if (ret)
> +    {
> +        msg(D_DCO, "Failed to create new peer %d", errno);
> +    }
> +
> +    return ret;
> +}

we do have all sorts of variants (*sigh*), but since you also used both=20
versions, let's go for this one.

> +        msg(D_DCO, "Failed to create new peer %d", errno);

this can be written as

> +        msg(D_DCO|M_ERRNO, "Failed to create new peer");

M_ERRNO will automatically append the strerror(errno) stuff.

D_DCO is "--verb 3", so that message won't be visible in normal operation
- if we consider this an error, then it should be

> +        msg(M_WARN|M_ERRNO, "Failed to create new peer");

instead (or if it's "fatal error, give up" -> M_ERR).


Now, I'm not sure if accessing errno after the free() call is guaranteed
to be save - so maybe move the msg() call up?


> +bool
> +ovpn_dco_init(int mode, dco_context_t *dco)
> +{
> +    if (open_fd(dco) < 0)
> +    {
> +        msg(D_DCO, "Failed to open socket");

Same here - if you want this to be heard, D_DCO should be M_WARN|M_ERRNO.

If this is just informational, because the caller will make sufficient
noise, D_DCO|M_ERRNO is good (but you might want to point out that this=20
is the "DCO socket" that couldn't be opened).

> +static int
> +create_interface(struct tuntap *tt, const char *dev)
> +{
> +    int ret;
> +    struct ifreq ifr;
> +
> +    bzero(&ifr, sizeof(ifr));

There is a convenience macro here, CLEAR(ifr)  (which does exactly
this - #define CLEAR(x) memset(&(x), 0, sizeof(x)).

> +    /* Create ovpnx first, then rename it. */
> +    snprintf(ifr.ifr_name, IFNAMSIZ, "ovpn");
> +    ret =3D ioctl(tt->dco.fd, SIOCIFCREATE2, &ifr);
> +    if (ret)
> +    {
> +        msg(D_DCO, "Failed to create interface %s: %d", ifr.ifr_name, er=
rno);
> +        return ret;
> +    }

-> M_ERRNO

> +    /* Rename */
> +    if (!strcmp(dev, "tun"))
> +    {
> +        ifr.ifr_data =3D "ovpn";
> +    }
> +    else
> +    {
> +        ifr.ifr_data =3D (char *)dev;
> +    }

I'm not sure I understand this code part.  When would dev be "tun"
here, triggering a rename to "ovpn"?

The call chain leading to this is (now)

 - tun.c:open_tun_dco_generic()
   - open_tun_dco()
     - create_interface(tt,dev)

and tun_dco_generic() should never pass in a bare "tun" name (because
in that case, it would iterate "tun0, tun1, tun2").

Is this a safeguard against "bad things will happen in kernel land if
we use the unqualified name of another driver"?

> +    ret =3D ioctl(tt->dco.fd, SIOCSIFNAME, &ifr);
> +    if (ret)
> +    {
> +        /* Delete the created interface again. */
> +        (void)ioctl(tt->dco.fd, SIOCIFDESTROY, &ifr);
> +        msg(D_DCO, "Failed to create interface %s: %d", ifr.ifr_data, er=
rno);

-> M_ERRNO

(there's more, but no need to point them out individually :-) )

> +static int
> +remove_interface(struct tuntap *tt)
> +{
> +    int ret;
> +    struct ifreq ifr;
> +
> +    bzero(&ifr, sizeof(ifr));
> +    snprintf(ifr.ifr_name, IFNAMSIZ, "%s", tt->dco.ifname);
> +
> +    ret =3D ioctl(tt->dco.fd, SIOCIFDESTROY, &ifr);
> +    if (ret)
> +    {
> +        msg(D_DCO, "Failed to remove interface %s: %d", ifr.ifr_name, er=
rno);
> +        return ret;
> +    }
> +
> +    tt->dco.ifname[0] =3D 0;
> +
> +    return 0;
> +}

Maybe always clear the ifname, and do "return ret;" here too?

> +static int
> +start_tun(dco_context_t *dco)
> +{
> +    struct ifdrv drv;
> +    int ret;
> +
> +    bzero(&drv, sizeof(drv));

CLEAR(drv);


> +int
> +dco_do_read(dco_context_t *dco)
> +{
> +    struct ifdrv drv;
> +    uint8_t buf[4096];
> +    nvlist_t *nvl;
> +    const uint8_t *pkt;
> +    size_t pktlen;
> +    int ret;
> +
> +    /* Flush any pending data from the pipe. */
> +    (void)read(dco->pipefd[1], buf, sizeof(buf));
> +
> +    bzero(&drv, sizeof(drv));
> +    snprintf(drv.ifd_name, IFNAMSIZ, "%s", dco->ifname);
> +    drv.ifd_cmd =3D OVPN_GET_PKT;
> +    drv.ifd_data =3D buf;
> +    drv.ifd_len =3D sizeof(buf);
> +
> +    ret =3D ioctl(dco->fd, SIOCGDRVSPEC, &drv);
> +    if (ret)
> +    {
> +        msg(D_DCO, "Failed to read control packet %d", errno);
> +        return errno;

Documentation (dco.h) says "0 on success or a negative error code otherwise=
",
so this needs to be "return -errno;" to behave the same as dco_linux

> +    }
> +
> +    nvl =3D nvlist_unpack(buf, drv.ifd_len, 0);
> +    if (!nvl)
> +    {
> +        msg(D_DCO, "Failed to unpack nvlist");
> +        return EINVAL;

-EINVAL


> +int
> +dco_do_write(dco_context_t *dco, int peer_id, struct buffer *buf)
> +{
> +    struct ifdrv drv;
> +    nvlist_t *nvl;
> +    int ret;
> +
> +    nvl =3D nvlist_create(0);
> +
> +    nvlist_add_binary(nvl, "packet", BSTR(buf), BLEN(buf));
> +    nvlist_add_number(nvl, "peerid", peer_id);
> +
> +    bzero(&drv, sizeof(drv));
> +    snprintf(drv.ifd_name, IFNAMSIZ, "%s", dco->ifname);
> +    drv.ifd_cmd =3D OVPN_SEND_PKT;
> +    drv.ifd_data =3D nvlist_pack(nvl, &drv.ifd_len);
> +
> +    ret =3D ioctl(dco->fd, SIOCSDRVSPEC, &drv);
> +    free(drv.ifd_data);
> +    nvlist_destroy(nvl);
> +    if (ret)
> +    {
> +        msg(D_DCO, "Failed to send control packet %d", errno);
> +        return ret;
> +    }
> +
> +    return BLEN(buf);
> +}

The return code of dco_do_write() is not clearly defined in dco.h
(Antonio, looking at you...!) but the linux version seems to do
"negative is error, positive is buffer length written", so this should
be fine.  Might need a change to "return -errno".

> +bool
> +dco_available(int msglevel)
> +{
> +    struct if_clonereq ifcr;
> +    char *buf =3D NULL;
> +    int fd;
> +    int ret;
> +    bool available =3D false;
> +
> +    /* Attempt to load the module. Ignore errors, because it might alrea=
dy be
> +     * loaded, or built into the kernel. */
> +    (void)kldload("if_ovpn");
> +
> +    fd =3D socket(AF_INET, SOCK_DGRAM | SOCK_CLOEXEC, 0);
> +    if (fd < 0)
> +    {
> +        return false;
> +    }
> +
> +    bzero(&ifcr, sizeof(ifcr));

CLEAR(ifcr)

> +    ret =3D ioctl(fd, SIOCIFGCLONERS, &ifcr);
> +    if (ret !=3D 0)
> +    {
> +        goto out;
> +    }
> +
> +    buf =3D malloc(ifcr.ifcr_total * IFNAMSIZ);
> +
> +    ifcr.ifcr_count =3D ifcr.ifcr_total;
> +    ifcr.ifcr_buffer =3D buf;
> +    ret =3D ioctl(fd, SIOCIFGCLONERS, &ifcr);
> +    if (ret !=3D 0)
> +    {
> +        goto out;
> +    }
> +
> +    for (int i =3D 0; i < ifcr.ifcr_total; i++)
> +    {
> +        if (strcmp(buf + (i * IFNAMSIZ), "openvpn") =3D=3D 0)

This looks fairly magic to me - am I reading this right that the first
call returns a number of "somethings", then we malloc(something * IFNAMSIZ),
and the second call returns a list of strings that describe "something",
and if there is one of them named "openvpn", we know that DCO is=20
available?

Why is it called "openvpn", not "ovpn" (if_ovpn, man ovpn)?

(A few lines of comment on what SIOCIFGCLONERS does - or which manpage
to look at - would be appreciated here :-) )

> +const char *
> +dco_get_supported_ciphers()
> +{
> +    return "none:AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305";
> +}

Is "none" indeed supported?  I find that useful to test, but Arne and
Antonio refuse(d) to support it in linux DCO :-)

> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index 55c939c4..14ad24fa 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c

... these are all very straightforward "LINUX" -> "LINUX || FREEBSD" :-)

> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
> index 54f7d72c..e84d5a27 100644
> --- a/src/openvpn/tun.c
> +++ b/src/openvpn/tun.c
[..]
> @@ -2917,20 +2917,24 @@ void
>  open_tun(const char *dev, const char *dev_type, const char *dev_node, st=
ruct tuntap *tt,
>           openvpn_net_ctx_t *ctx)
>  {
> -    open_tun_generic(dev, dev_type, dev_node, tt);
> -
> -    if (tt->fd >=3D 0 && tt->type =3D=3D DEV_TYPE_TUN)
> -    {
> -        int i =3D IFF_POINTOPOINT | IFF_MULTICAST;
> +    if (tun_dco_enabled(tt)) {
> +        open_tun_dco_generic(dev, dev_type, tt, ctx);
> +    } else {
> +        open_tun_generic(dev, dev_type, dev_node, tt);

This one will upset the whitespace dragon and it will eat all of
the patch :-)

OpenVPN bracket convention requires this to be:

+    if (tun_dco_enabled(tt))
+    {
+        open_tun_dco_generic(dev, dev_type, tt, ctx);
+    }
+    else
+    {
+        open_tun_generic(dev, dev_type, dev_node, tt);

(I run uncrustify on merge, so this would get fixed - but it would
be good to have it properly formatted right away)

>=20=20
> -        if (ioctl(tt->fd, TUNSIFMODE, &i) < 0)
> +        if (tt->fd >=3D 0 && tt->type =3D=3D DEV_TYPE_TUN)
>          {
> -            msg(M_WARN | M_ERRNO, "ioctl(TUNSIFMODE)");
> -        }
> -        i =3D 1;
> -        if (ioctl(tt->fd, TUNSIFHEAD, &i) < 0)
> -        {

... this looks like a massive diff, but actually it's just an indenting
change that git diff does not present nicely (checked with "git show -w").


That's it for today :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--e50ttJTI9nnhzgsg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi8985AAoJEB2Cnv7KVigSgE4MAIkGxtg6aMSH9rVeDQBohzRu
4/9k9Qh46kR9UdwC6V4UC2IUuZgsQ6+v4FL2fR6JMWvQwwrvQGIxwHV3ad55W8q4
VbBYq7BCUZlNn4tJ/pye0czdrCyjf5fkDOQR9HC//GBtqE87/hB7QXRaJLGgJivM
tubtq17CXzYp8j5bW1AJIiTsEIIamh5LbG2G78dOSRpMf3mNMXveXiWM2JcjNMw+
byjW3Aq/S0XzDV88UXzJNLQGgsC/6tbue65/HKbUAXS0As9qbb6tPzqo9pJm0pCp
posW3tBidGnaDP0b/EqnjQQkJozpZegdgsdj4b/KNd7/TuUu9NiuU03pdHDnW1OL
Jryld41Wb/e8Bv2jpbxrfF0qENZ4RCeLjt/6yoPJhrcvPhweahyA2zQy8tW0XUHi
DJMxokIZt2XJdwe+beUbjwN0Z51R+VWPUN786sDIvNpztnaMVYyEMr3Q8r6hczpS
IBWLqc4ad5pii+Dea6oZSSjx187mDdeM6MpGDfugOg==
=LBUz
-----END PGP SIGNATURE-----

--e50ttJTI9nnhzgsg--

