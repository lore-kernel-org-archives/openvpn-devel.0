From: Kristof Provost <kprovost@...2661...>
Date: Fri, 12 Aug 2022 15:40:28 +0200
Message-ID: <9F274BF6-5921-48EB-9EBA-30BD6DB9D17A@...2661...>
In-Reply-To: <YvPdlCSxQ6wvfIna@...1296...>
References: <20220808143424.65924-1-kprovost@...2661...>
 <20220808143424.65924-3-kprovost@...2661...>
 <YvPdlCSxQ6wvfIna@...1296...>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Remarks inline. Mostly ACK.

I=E2=80=99ll post an updated version soon. (I=E2=80=99ve also added a check=
 for UDP in dco_check_option_conflict_ce().

On 10 Aug 2022, at 18:32, Gert Doering wrote:
> On Mon, Aug 08, 2022 at 04:34:23PM +0200, Kristof Provost via Openvpn-dev=
el wrote:
>> diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
>> new file mode 100644
>> index 00000000..a8a53fe3
>> --- /dev/null
>> +++ b/src/openvpn/dco_freebsd.c
>> @@ -0,0 +1,636 @@
> [..]
>> +static nvlist_t *
>> +sockaddr_to_nvlist(const struct sockaddr *sa)
>> +{
> [..]
>> +        default:
>> +            abort();
>
> please use "ASSERT(0);" here.  It will do the same thing, but if ever
> hit, it will print a __FILE__, __LINE__ message to the log, so it's
> easier for us to see *where* it triggered a "this must never happen"
> condition.
>
Fixed.

>> +int
>> +dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
>> +             struct sockaddr *localaddr, struct sockaddr *remoteaddr,
>> +             struct in_addr *remote_in4, struct in6_addr *remote_in6)
>> +{
>> +    struct ifdrv drv;
>> +    nvlist_t *nvl;
>> +    int ret;
>> +
>> +    nvl =3D nvlist_create(0);
>
> We use C99 these days, so this could be written as
>
>> +    nvlist_t *nvl =3D nvlist_create(0);
>
> but this is a matter of personal preference.  Both are fine, just wanted
> to point out that the option exists.
>
That=E2=80=99s FreeBSD=E2=80=99s style(9) showing here. If it=E2=80=99s acc=
eptable to OpenVPN I=E2=80=99m just going to keep it as-is.

>> +
>> +    nvlist_add_number(nvl, "fd", sd);
>> +    nvlist_add_number(nvl, "peerid", peerid);
>> +
>> +    bzero(&drv, sizeof(drv));
>> +    snprintf(drv.ifd_name, IFNAMSIZ, "%s", dco->ifname);
>> +    drv.ifd_cmd =3D OVPN_NEW_PEER;
>> +    drv.ifd_data =3D nvlist_pack(nvl, &drv.ifd_len);
>> +
>> +    ret =3D ioctl(dco->fd, SIOCSDRVSPEC, &drv);
>> +    free(drv.ifd_data);
>
> What happens should nvlist_pack() fail here?  Manpage says it returns
> NULL, will the ioctl() handle this gracefully, or will something crash?
>
That=E2=80=99d really only happen if a memory allocation fails, and given m=
odern OS=E2=80=99s overcommit behaviour that=E2=80=99s also not going to ha=
ppen. (If you manage to run the system out of memory malloc() will still gi=
ve you virtual memory, but the OOM killer will come to visit when you get a=
round to actually using it.)

> (If the ioctl() returns something like EINVAL in this case, perfectly fin=
e)
>
The copyin() in the kernel will fail, and that=E2=80=99d return an error, w=
ithout crashing things.
So, yes, that=E2=80=99s what=E2=80=99d happen.

>> +    nvlist_destroy(nvl);
>> +    if (ret)
>> +    {
>> +        msg(D_DCO, "Failed to create new peer %d", errno);
>> +        return ret;
>> +    }
>> +
>> +    return 0;
>> +}
>
> Most functions in OpenVPN that do use a "ret" variable would look
> more like this:
>
>> +    if (ret)
>> +    {
>> +        msg(D_DCO, "Failed to create new peer %d", errno);
>> +    }
>> +
>> +    return ret;
>> +}
>
> we do have all sorts of variants (*sigh*), but since you also used both
> versions, let's go for this one.
>
Fixed.

>> +        msg(D_DCO, "Failed to create new peer %d", errno);
>
> this can be written as
>
>> +        msg(D_DCO|M_ERRNO, "Failed to create new peer");
>
> M_ERRNO will automatically append the strerror(errno) stuff.
>
Oh neat. I=E2=80=99ve made that change.

> D_DCO is "--verb 3", so that message won't be visible in normal operation
> - if we consider this an error, then it should be
>
>> +        msg(M_WARN|M_ERRNO, "Failed to create new peer");
>
> instead (or if it's "fatal error, give up" -> M_ERR).
>
These are generally fatal errors, yes.
There are follow-up error messages from the calling code that do get logged=
, but they=E2=80=99re usually less clear about what the actual problem is. =
I=E2=80=99ll see about changing D_DCO -> M_ERR or M_WARN.

> Now, I'm not sure if accessing errno after the free() call is guaranteed
> to be save - so maybe move the msg() call up?
>
I=E2=80=99m pretty sure free() doesn=E2=80=99t mess with errno (as in, I=E2=
=80=99ve looked at the jemalloc code), but it=E2=80=99s better to not have =
to check.
Happily, thanks to your earlier suggestion it=E2=80=99s much easier to just=
 move the free after the log, so I=E2=80=99ll do that.

>> +bool
>> +ovpn_dco_init(int mode, dco_context_t *dco)
>> +{
>> +    if (open_fd(dco) < 0)
>> +    {
>> +        msg(D_DCO, "Failed to open socket");
>
> Same here - if you want this to be heard, D_DCO should be M_WARN|M_ERRNO.
>
> If this is just informational, because the caller will make sufficient
> noise, D_DCO|M_ERRNO is good (but you might want to point out that this
> is the "DCO socket" that couldn't be opened).
>
Yeah, Iv=E2=80=99e gone through and made them all a bit louder. It=E2=80=99=
s all failure conditions, so being overly verbose there isn=E2=80=99t reall=
y an issue.

>> +static int
>> +create_interface(struct tuntap *tt, const char *dev)
>> +{
>> +    int ret;
>> +    struct ifreq ifr;
>> +
>> +    bzero(&ifr, sizeof(ifr));
>
> There is a convenience macro here, CLEAR(ifr)  (which does exactly
> this - #define CLEAR(x) memset(&(x), 0, sizeof(x)).
>
Neat. Changed.

>> +    /* Create ovpnx first, then rename it. */
>> +    snprintf(ifr.ifr_name, IFNAMSIZ, "ovpn");
>> +    ret =3D ioctl(tt->dco.fd, SIOCIFCREATE2, &ifr);
>> +    if (ret)
>> +    {
>> +        msg(D_DCO, "Failed to create interface %s: %d", ifr.ifr_name, e=
rrno);
>> +        return ret;
>> +    }
>
> -> M_ERRNO
Done.
>
>> +    /* Rename */
>> +    if (!strcmp(dev, "tun"))
>> +    {
>> +        ifr.ifr_data =3D "ovpn";
>> +    }
>> +    else
>> +    {
>> +        ifr.ifr_data =3D (char *)dev;
>> +    }
>
> I'm not sure I understand this code part.  When would dev be "tun"
> here, triggering a rename to "ovpn"?
>
> The call chain leading to this is (now)
>
>  - tun.c:open_tun_dco_generic()
>    - open_tun_dco()
>      - create_interface(tt,dev)
>
> and tun_dco_generic() should never pass in a bare "tun" name (because
> in that case, it would iterate "tun0, tun1, tun2").
>
> Is this a safeguard against "bad things will happen in kernel land if
> we use the unqualified name of another driver"?
>
No, it=E2=80=99s that OpenVPN lets you pick the interface name, and FreeBSD=
 figures out which driver it needs to call based on the interface name.
So as long as users decide they want the interface to be ovpnX it=E2=80=99l=
l be fine, but if they want =E2=80=98vpn0=E2=80=99 or even something silly =
like =E2=80=98vlan1=E2=80=99 the kernel isn=E2=80=99t going to create an if=
_ovpn interface.

So we create opvnX first, and then rename it to whatever the user wants it =
to be.

>> +    ret =3D ioctl(tt->dco.fd, SIOCSIFNAME, &ifr);
>> +    if (ret)
>> +    {
>> +        /* Delete the created interface again. */
>> +        (void)ioctl(tt->dco.fd, SIOCIFDESTROY, &ifr);
>> +        msg(D_DCO, "Failed to create interface %s: %d", ifr.ifr_data, e=
rrno);
>
> -> M_ERRNO
>
> (there's more, but no need to point them out individually :-) )
>
Fixed.

>> +static int
>> +remove_interface(struct tuntap *tt)
>> +{
>> +    int ret;
>> +    struct ifreq ifr;
>> +
>> +    bzero(&ifr, sizeof(ifr));
>> +    snprintf(ifr.ifr_name, IFNAMSIZ, "%s", tt->dco.ifname);
>> +
>> +    ret =3D ioctl(tt->dco.fd, SIOCIFDESTROY, &ifr);
>> +    if (ret)
>> +    {
>> +        msg(D_DCO, "Failed to remove interface %s: %d", ifr.ifr_name, e=
rrno);
>> +        return ret;
>> +    }
>> +
>> +    tt->dco.ifname[0] =3D 0;
>> +
>> +    return 0;
>> +}
>
> Maybe always clear the ifname, and do "return ret;" here too?
>
Good idea.

>> +static int
>> +start_tun(dco_context_t *dco)
>> +{
>> +    struct ifdrv drv;
>> +    int ret;
>> +
>> +    bzero(&drv, sizeof(drv));
>
> CLEAR(drv);
>
Fixed.

>> +int
>> +dco_do_read(dco_context_t *dco)
>> +{
>> +    struct ifdrv drv;
>> +    uint8_t buf[4096];
>> +    nvlist_t *nvl;
>> +    const uint8_t *pkt;
>> +    size_t pktlen;
>> +    int ret;
>> +
>> +    /* Flush any pending data from the pipe. */
>> +    (void)read(dco->pipefd[1], buf, sizeof(buf));
>> +
>> +    bzero(&drv, sizeof(drv));
>> +    snprintf(drv.ifd_name, IFNAMSIZ, "%s", dco->ifname);
>> +    drv.ifd_cmd =3D OVPN_GET_PKT;
>> +    drv.ifd_data =3D buf;
>> +    drv.ifd_len =3D sizeof(buf);
>> +
>> +    ret =3D ioctl(dco->fd, SIOCGDRVSPEC, &drv);
>> +    if (ret)
>> +    {
>> +        msg(D_DCO, "Failed to read control packet %d", errno);
>> +        return errno;
>
> Documentation (dco.h) says "0 on success or a negative error code otherwi=
se",
> so this needs to be "return -errno;" to behave the same as dco_linux
>
Fixed.
>> +    }
>> +
>> +    nvl =3D nvlist_unpack(buf, drv.ifd_len, 0);
>> +    if (!nvl)
>> +    {
>> +        msg(D_DCO, "Failed to unpack nvlist");
>> +        return EINVAL;
>
> -EINVAL
>
Fixed.

>> +int
>> +dco_do_write(dco_context_t *dco, int peer_id, struct buffer *buf)
>> +{
>> +    struct ifdrv drv;
>> +    nvlist_t *nvl;
>> +    int ret;
>> +
>> +    nvl =3D nvlist_create(0);
>> +
>> +    nvlist_add_binary(nvl, "packet", BSTR(buf), BLEN(buf));
>> +    nvlist_add_number(nvl, "peerid", peer_id);
>> +
>> +    bzero(&drv, sizeof(drv));
>> +    snprintf(drv.ifd_name, IFNAMSIZ, "%s", dco->ifname);
>> +    drv.ifd_cmd =3D OVPN_SEND_PKT;
>> +    drv.ifd_data =3D nvlist_pack(nvl, &drv.ifd_len);
>> +
>> +    ret =3D ioctl(dco->fd, SIOCSDRVSPEC, &drv);
>> +    free(drv.ifd_data);
>> +    nvlist_destroy(nvl);
>> +    if (ret)
>> +    {
>> +        msg(D_DCO, "Failed to send control packet %d", errno);
>> +        return ret;
>> +    }
>> +
>> +    return BLEN(buf);
>> +}
>
> The return code of dco_do_write() is not clearly defined in dco.h
> (Antonio, looking at you...!) but the linux version seems to do
> "negative is error, positive is buffer length written", so this should
> be fine.  Might need a change to "return -errno".
>
Makes sense. Done.

>> +bool
>> +dco_available(int msglevel)
>> +{
>> +    struct if_clonereq ifcr;
>> +    char *buf =3D NULL;
>> +    int fd;
>> +    int ret;
>> +    bool available =3D false;
>> +
>> +    /* Attempt to load the module. Ignore errors, because it might alre=
ady be
>> +     * loaded, or built into the kernel. */
>> +    (void)kldload("if_ovpn");
>> +
>> +    fd =3D socket(AF_INET, SOCK_DGRAM | SOCK_CLOEXEC, 0);
>> +    if (fd < 0)
>> +    {
>> +        return false;
>> +    }
>> +
>> +    bzero(&ifcr, sizeof(ifcr));
>
> CLEAR(ifcr)
>
Fixed.

>> +    ret =3D ioctl(fd, SIOCIFGCLONERS, &ifcr);
>> +    if (ret !=3D 0)
>> +    {
>> +        goto out;
>> +    }
>> +
>> +    buf =3D malloc(ifcr.ifcr_total * IFNAMSIZ);
>> +
>> +    ifcr.ifcr_count =3D ifcr.ifcr_total;
>> +    ifcr.ifcr_buffer =3D buf;
>> +    ret =3D ioctl(fd, SIOCIFGCLONERS, &ifcr);
>> +    if (ret !=3D 0)
>> +    {
>> +        goto out;
>> +    }
>> +
>> +    for (int i =3D 0; i < ifcr.ifcr_total; i++)
>> +    {
>> +        if (strcmp(buf + (i * IFNAMSIZ), "openvpn") =3D=3D 0)
>
> This looks fairly magic to me - am I reading this right that the first
> call returns a number of "somethings", then we malloc(something * IFNAMSI=
Z),
> and the second call returns a list of strings that describe "something",
> and if there is one of them named "openvpn", we know that DCO is
> available?
>
Correct. The first call is to figure out how much space we need, we then al=
locate that and get the list.

> Why is it called "openvpn", not "ovpn" (if_ovpn, man ovpn)?
>
That=E2=80=99s what the driver chose to do. It=E2=80=99s a bit cheap of me =
to blame the driver author, but he=E2=80=99s an ass anyway ;)
More seriously, that=E2=80=99s mostly because that also ensures that the in=
terfaces are automatically in the =E2=80=98openvpn=E2=80=99 netif group, wh=
ich is something that makes pfsense=E2=80=99s life easier.

> (A few lines of comment on what SIOCIFGCLONERS does - or which manpage
> to look at - would be appreciated here :-) )
>
It=E2=80=99s a BSD-ism. Some types of interfaces (essentially any interface=
 that=E2=80=99s not actual hardware) is created through =E2=80=98cloning=E2=
=80=99. The relevant code is in sys/net/if_clone.c in the kernel.

You can list them with =E2=80=9Cifconfig -C=E2=80=9D.

We use it as a way to figure out if DCO is supported or not. We could poten=
tially also enumerate the loaded kernel modules and check for if_ovpn.ko, b=
ut that=E2=80=99d break if someone built that into the kernel.

>> +const char *
>> +dco_get_supported_ciphers()
>> +{
>> +    return "none:AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305";
>> +}
>
> Is "none" indeed supported?  I find that useful to test, but Arne and
> Antonio refuse(d) to support it in linux DCO :-)
>
It is, yes, although I have to admit that it=E2=80=99s certainly the least =
tested mode. (Because if you really want to tunnel without crypto you can j=
ust use if_gif, without needing the OpenVPN userspace code.)

>> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
>> index 55c939c4..14ad24fa 100644
>> --- a/src/openvpn/forward.c
>> +++ b/src/openvpn/forward.c
>
> ... these are all very straightforward "LINUX" -> "LINUX || FREEBSD" :-)
>
If at some point someone adds OpenBSD or NetBSD or Illumos or .. it=E2=80=
=99s going to be worth thinking about a =E2=80=98PLATFORM_HAS_DCO=E2=80=99,=
 or =E2=80=98UNIX_Y_HAS_DCO=E2=80=99 or similar define for these.

>> diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
>> index 54f7d72c..e84d5a27 100644
>> --- a/src/openvpn/tun.c
>> +++ b/src/openvpn/tun.c
> [..]
>> @@ -2917,20 +2917,24 @@ void
>>  open_tun(const char *dev, const char *dev_type, const char *dev_node, s=
truct tuntap *tt,
>>           openvpn_net_ctx_t *ctx)
>>  {
>> -    open_tun_generic(dev, dev_type, dev_node, tt);
>> -
>> -    if (tt->fd >=3D 0 && tt->type =3D=3D DEV_TYPE_TUN)
>> -    {
>> -        int i =3D IFF_POINTOPOINT | IFF_MULTICAST;
>> +    if (tun_dco_enabled(tt)) {
>> +        open_tun_dco_generic(dev, dev_type, tt, ctx);
>> +    } else {
>> +        open_tun_generic(dev, dev_type, dev_node, tt);
>
> This one will upset the whitespace dragon and it will eat all of
> the patch :-)
>
> OpenVPN bracket convention requires this to be:
>
> +    if (tun_dco_enabled(tt))
> +    {
> +        open_tun_dco_generic(dev, dev_type, tt, ctx);
> +    }
> +    else
> +    {
> +        open_tun_generic(dev, dev_type, dev_node, tt);
>
> (I run uncrustify on merge, so this would get fixed - but it would
> be good to have it properly formatted right away)
>
Whoops. I thought I=E2=80=99d been good about following local style, but I =
seem to have missed one. Fixed.

Best regards,
Kristof

