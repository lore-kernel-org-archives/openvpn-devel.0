MIME-Version: 1.0
References: <20181230112901.29241-1-a@...2181...>
 <20181230112901.29241-5-a@...2181...>
In-Reply-To: <20181230112901.29241-5-a@...2181...>
From: Justin Henck <henck@...410...>
Date: Mon, 28 Jan 2019 13:11:50 -0500
Message-ID: <CAN-AkJtcNDmgXGL3BKJYSOBbmnrJPtYf-ovSkCyPtA+f1nkgzg@...278...>
Content-Type: multipart/alternative; boundary="0000000000001ca9600580889d8c"
Subject: Re: [Openvpn-devel] [PATCH 4/4] transport-plugin: add sample
 obfs-test plugin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>, Robin Tarsiger <rtt@...2484...>

--0000000000001ca9600580889d8c
Content-Type: text/plain; charset="UTF-8"

Bumping this as well given the holiday hiatus - it seems like there was
feedback on the patches 2 & 3. Does anyone have any feedback for this one?

Thanks!
Justin

Justin Henck
Product Manager
212-565-9811
google.com/jigsaw

PGP: EA8E 8C27 2D75 974D B357 482B 1039 9F2D 869A 117B


On Sun, Dec 30, 2018 at 6:31 AM Antonio Quartulli <a@...2181...> wrote:

> From: Robin Tarsiger <rtt@...2484...>
>
> Add a sample plugin to explain how the new transport API is expected to
> be implemented and work. It can be used for testing.
>
> Signed-off-by: Robin Tarsiger <rtt@...2484...>
> [antonio@...515...: refactored commits, restyled code]
> ---
>  configure.ac                              |   9 +
>  src/plugins/Makefile.am                   |   2 +-
>  src/plugins/obfs-test/Makefile.am         |  29 ++
>  src/plugins/obfs-test/README.obfs-test    |  26 +
>  src/plugins/obfs-test/obfs-test-args.c    |  60 +++
>  src/plugins/obfs-test/obfs-test-munging.c | 129 +++++
>  src/plugins/obfs-test/obfs-test-posix.c   | 207 ++++++++
>  src/plugins/obfs-test/obfs-test-win32.c   | 579 ++++++++++++++++++++++
>  src/plugins/obfs-test/obfs-test.c         |  94 ++++
>  src/plugins/obfs-test/obfs-test.exports   |   4 +
>  src/plugins/obfs-test/obfs-test.h         |  42 ++
>  11 files changed, 1180 insertions(+), 1 deletion(-)
>  create mode 100644 src/plugins/obfs-test/Makefile.am
>  create mode 100644 src/plugins/obfs-test/README.obfs-test
>  create mode 100644 src/plugins/obfs-test/obfs-test-args.c
>  create mode 100644 src/plugins/obfs-test/obfs-test-munging.c
>  create mode 100644 src/plugins/obfs-test/obfs-test-posix.c
>  create mode 100644 src/plugins/obfs-test/obfs-test-win32.c
>  create mode 100644 src/plugins/obfs-test/obfs-test.c
>  create mode 100644 src/plugins/obfs-test/obfs-test.exports
>  create mode 100644 src/plugins/obfs-test/obfs-test.h
>
> diff --git a/configure.ac b/configure.ac
> index 1e6891b1..b4196812 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -200,6 +200,13 @@ AC_ARG_ENABLE(
>         ]
>  )
>
> +AC_ARG_ENABLE(
> +       [plugin-obfs-test],
> +       [AS_HELP_STRING([--disable-plugin-obfs-test], [disable obfs-test
> plugin @<:@default=platform specific@:>@])],
> +       ,
> +       [enable_plugin_obfs_test="no"]
> +)
> +
>  AC_ARG_ENABLE(
>         [pam-dlopen],
>         [AS_HELP_STRING([--enable-pam-dlopen], [dlopen libpam
> @<:@default=no@:>@])],
> @@ -1344,6 +1351,7 @@ AM_CONDITIONAL([WIN32], [test "${WIN32}" = "yes"])
>  AM_CONDITIONAL([GIT_CHECKOUT], [test "${GIT_CHECKOUT}" = "yes"])
>  AM_CONDITIONAL([ENABLE_PLUGIN_AUTH_PAM], [test
> "${enable_plugin_auth_pam}" = "yes"])
>  AM_CONDITIONAL([ENABLE_PLUGIN_DOWN_ROOT], [test
> "${enable_plugin_down_root}" = "yes"])
> +AM_CONDITIONAL([ENABLE_PLUGIN_OBFS_TEST], [test
> "${enable_plugin_obfs_test}" = "yes"])
>  AM_CONDITIONAL([HAVE_LD_WRAP_SUPPORT], [test "${have_ld_wrap_support}" =
> "yes"])
>
>  sampledir="\$(docdir)/sample"
> @@ -1403,6 +1411,7 @@ AC_CONFIG_FILES([
>         src/plugins/Makefile
>         src/plugins/auth-pam/Makefile
>         src/plugins/down-root/Makefile
> +       src/plugins/obfs-test/Makefile
>         tests/Makefile
>          tests/unit_tests/Makefile
>          tests/unit_tests/example_test/Makefile
> diff --git a/src/plugins/Makefile.am b/src/plugins/Makefile.am
> index f3461786..848bac03 100644
> --- a/src/plugins/Makefile.am
> +++ b/src/plugins/Makefile.am
> @@ -12,4 +12,4 @@
>  MAINTAINERCLEANFILES = \
>         $(srcdir)/Makefile.in
>
> -SUBDIRS = auth-pam down-root
> +SUBDIRS = auth-pam down-root obfs-test
> diff --git a/src/plugins/obfs-test/Makefile.am
> b/src/plugins/obfs-test/Makefile.am
> new file mode 100644
> index 00000000..4cc8d183
> --- /dev/null
> +++ b/src/plugins/obfs-test/Makefile.am
> @@ -0,0 +1,29 @@
> +MAINTAINERCLEANFILES = \
> +       $(srcdir)/Makefile.in
> +
> +AM_CFLAGS = \
> +       -I$(top_srcdir)/include \
> +       $(OPTIONAL_CRYPTO_CFLAGS)
> +
> +if ENABLE_PLUGIN_OBFS_TEST
> +plugin_LTLIBRARIES = openvpn-plugin-obfs-test.la
> +endif
> +
> +openvpn_plugin_obfs_test_la_SOURCES = \
> +       obfs-test.c \
> +       obfs-test-munging.c \
> +       obfs-test-args.c \
> +       obfs-test.exports
> +
> +if WIN32
> +openvpn_plugin_obfs_test_la_SOURCES += obfs-test-win32.c
> +openvpn_plugin_obfs_test_la_LIBADD = -lws2_32 -lwininet
> +else !WIN32
> +openvpn_plugin_obfs_test_la_SOURCES += obfs-test-posix.c
> +# No LIBADD necessary; we assume we can access the global symbol space,
> +# and core OpenVPN will already link with everything needed for sockets.
> +endif
> +
> +openvpn_plugin_obfs_test_la_LDFLAGS = $(AM_LDFLAGS) \
> +       -export-symbols "$(srcdir)/obfs-test.exports" \
> +       -module -shared -avoid-version -no-undefined
> diff --git a/src/plugins/obfs-test/README.obfs-test
> b/src/plugins/obfs-test/README.obfs-test
> new file mode 100644
> index 00000000..5492ee02
> --- /dev/null
> +++ b/src/plugins/obfs-test/README.obfs-test
> @@ -0,0 +1,26 @@
> +obfs-test
> +
> +SYNOPSIS
> +
> +The obfs-test plugin is a proof of concept for supporting protocol
> +obfuscation for OpenVPN via a socket intercept plugin.
> +
> +BUILD
> +
> +You must specify --enable-plugin-obfs-test at configure time to
> +trigger building this plugin. It should function on POSIX-y platforms
> +and Windows.
> +
> +USAGE
> +
> +To invoke this plugin, load it via an appropriate plugin line in the
> +configuration file, and then specify 'proto indirect' rather than any
> +other protocol. Packets will then be passed via UDP, but they will
> +also undergo a very basic content transformation, and the bind port
> +will be altered (see obfs-test-munging.c for details).
> +
> +CAVEATS
> +
> +This has undergone basic functionality testing, but not any kind of
> +full-on stress test. Extended socket or I/O handling options are not
> +supported at all.
> diff --git a/src/plugins/obfs-test/obfs-test-args.c
> b/src/plugins/obfs-test/obfs-test-args.c
> new file mode 100644
> index 00000000..e6756f8f
> --- /dev/null
> +++ b/src/plugins/obfs-test/obfs-test-args.c
> @@ -0,0 +1,60 @@
> +#include "obfs-test.h"
> +
> +openvpn_transport_args_t
> +obfs_test_parseargs(void *plugin_handle,
> +                    const char *const *argv, int argc)
> +{
> +    struct obfs_test_args *args = calloc(1, sizeof(struct
> obfs_test_args));
> +    if (!args)
> +    {
> +        return NULL;
> +    }
> +
> +    if (argc < 2)
> +    {
> +        args->offset = 0;
> +    }
> +    else if (argc == 2)
> +    {
> +        char *end;
> +        long offset = strtol(argv[1], &end, 10);
> +        if (*end != '\0')
> +        {
> +            args->error = "offset must be a decimal number";
> +        }
> +        else if (!(0 <= offset && offset <= 42))
> +        {
> +            args->error = "offset must be between 0 and 42";
> +        }
> +        else
> +        {
> +            args->offset = (int) offset;
> +        }
> +    }
> +    else
> +    {
> +        args->error = "too many arguments";
> +    }
> +
> +    return args;
> +}
> +
> +const char *
> +obfs_test_argerror(openvpn_transport_args_t args_)
> +{
> +    if (!args_)
> +    {
> +        return "cannot allocate";
> +    }
> +    else
> +    {
> +        return ((struct obfs_test_args *) args_)->error;
> +    }
> +}
> +
> +void
> +obfs_test_freeargs(openvpn_transport_args_t args_)
> +{
> +    free(args_);
> +    struct obfs_test_args *args = (struct obfs_test_args *) args_;
> +}
> diff --git a/src/plugins/obfs-test/obfs-test-munging.c
> b/src/plugins/obfs-test/obfs-test-munging.c
> new file mode 100644
> index 00000000..37d27039
> --- /dev/null
> +++ b/src/plugins/obfs-test/obfs-test-munging.c
> @@ -0,0 +1,129 @@
> +#include <string.h>
> +#include <errno.h>
> +#include <stdbool.h>
> +#include "obfs-test.h"
> +#ifdef OPENVPN_TRANSPORT_PLATFORM_POSIX
> +#include <sys/socket.h>
> +#include <netinet/in.h>
> +typedef in_port_t obfs_test_in_port_t;
> +#else
> +#include <winsock2.h>
> +#include <ws2tcpip.h>
> +typedef u_short obfs_test_in_port_t;
> +#endif
> +
> +static obfs_test_in_port_t
> +munge_port(obfs_test_in_port_t port)
> +{
> +    return port ^ 15;
> +}
> +
> +/* Reversible. */
> +void
> +obfs_test_munge_addr(struct sockaddr *addr, openvpn_transport_socklen_t
> len)
> +{
> +    struct sockaddr_in *inet;
> +    struct sockaddr_in6 *inet6;
> +
> +    switch (addr->sa_family)
> +    {
> +        case AF_INET:
> +            inet = (struct sockaddr_in *) addr;
> +            inet->sin_port = munge_port(inet->sin_port);
> +            break;
> +
> +        case AF_INET6:
> +            inet6 = (struct sockaddr_in6 *) addr;
> +            inet6->sin6_port = munge_port(inet6->sin6_port);
> +            break;
> +
> +        default:
> +            break;
> +    }
> +}
> +
> +/* Six fixed bytes, six repeated bytes. It's only a silly transformation.
> */
> +#define MUNGE_OVERHEAD 12
> +
> +size_t
> +obfs_test_max_munged_buf_size(size_t clear_size)
> +{
> +    return clear_size + MUNGE_OVERHEAD;
> +}
> +
> +ssize_t
> +obfs_test_unmunge_buf(struct obfs_test_args *how,
> +                      char *buf, size_t len)
> +{
> +    int i;
> +
> +    if (len < 6)
> +    {
> +        goto bad;
> +    }
> +    for (i = 0; i < 6; i++)
> +    {
> +        if (buf[i] != i + how->offset)
> +        {
> +            goto bad;
> +        }
> +    }
> +
> +    for (i = 0; i < 6 && (6 + 2*i) < len; i++)
> +    {
> +        if (len < (6 + 2*i + 1) || buf[6 + 2*i] != buf[6 + 2*i + 1])
> +        {
> +            goto bad;
> +        }
> +        buf[i] = buf[6 + 2*i];
> +    }
> +
> +    if (len > 18)
> +    {
> +        memmove(buf + 6, buf + 18, len - 18);
> +        len -= 12;
> +    }
> +    else
> +    {
> +        len -= 6;
> +        len /= 2;
> +    }
> +
> +    return len;
> +
> +bad:
> +    /* TODO: this really isn't the best way to report this error */
> +    errno = EIO;
> +    return -1;
> +}
> +
> +/* out must have space for len+MUNGE_OVERHEAD bytes. out and in must
> + * not overlap. */
> +size_t
> +obfs_test_munge_buf(struct obfs_test_args *how,
> +                    char *out, const char *in, size_t len)
> +{
> +    int i, n;
> +    size_t out_len = 6;
> +
> +    for (i = 0; i < 6; i++)
> +    {
> +        out[i] = i + how->offset;
> +    }
> +    n = len < 6 ? len : 6;
> +    for (i = 0; i < n; i++)
> +    {
> +        out[6 + 2*i] = out[6 + 2*i + 1] = in[i];
> +    }
> +    if (len > 6)
> +    {
> +        memmove(out + 18, in + 6, len - 6);
> +        out_len = len + 12;
> +    }
> +    else
> +    {
> +        out_len = 6 + 2*len;
> +    }
> +
> +    return out_len;
> +}
> diff --git a/src/plugins/obfs-test/obfs-test-posix.c
> b/src/plugins/obfs-test/obfs-test-posix.c
> new file mode 100644
> index 00000000..826381c5
> --- /dev/null
> +++ b/src/plugins/obfs-test/obfs-test-posix.c
> @@ -0,0 +1,207 @@
> +#include "obfs-test.h"
> +#include <stdbool.h>
> +#include <string.h>
> +#include <err.h>
> +#include <errno.h>
> +#include <unistd.h>
> +#include <fcntl.h>
> +#include <sys/socket.h>
> +#include <netinet/in.h>
> +
> +struct obfs_test_socket_posix
> +{
> +    struct openvpn_transport_socket handle;
> +    struct obfs_test_args args;
> +    struct obfs_test_context *ctx;
> +    int fd;
> +    unsigned last_rwflags;
> +};
> +
> +static void
> +free_socket(struct obfs_test_socket_posix *sock)
> +{
> +    if (!sock)
> +    {
> +        return;
> +    }
> +    if (sock->fd != -1)
> +    {
> +        close(sock->fd);
> +    }
> +    free(sock);
> +}
> +
> +static openvpn_transport_socket_t
> +obfs_test_posix_bind(void *plugin_handle, openvpn_transport_args_t args,
> +                     const struct sockaddr *addr, socklen_t len)
> +{
> +    struct obfs_test_socket_posix *sock = NULL;
> +    struct sockaddr *addr_rev = NULL;
> +
> +    addr_rev = calloc(1, len);
> +    if (!addr_rev)
> +    {
> +        goto error;
> +    }
> +    memcpy(addr_rev, addr, len);
> +    obfs_test_munge_addr(addr_rev, len);
> +
> +    sock = calloc(1, sizeof(struct obfs_test_socket_posix));
> +    if (!sock)
> +    {
> +        goto error;
> +    }
> +    sock->handle.vtab = &obfs_test_socket_vtab;
> +    sock->ctx = (struct obfs_test_context *) plugin_handle;
> +    memcpy(&sock->args, args, sizeof(sock->args));
> +    /* Note that sock->fd isn't -1 yet. Set it explicitly if there are
> ever any
> +     * error exits before the socket() call. */
> +
> +    sock->fd = socket(addr->sa_family, SOCK_DGRAM, IPPROTO_UDP);
> +    if (sock->fd == -1)
> +    {
> +        goto error;
> +    }
> +    if (fcntl(sock->fd, F_SETFL, fcntl(sock->fd, F_GETFL) | O_NONBLOCK))
> +    {
> +        goto error;
> +    }
> +
> +    if (bind(sock->fd, addr_rev, len))
> +    {
> +        goto error;
> +    }
> +    free(addr_rev);
> +    return &sock->handle;
> +
> +error:
> +    free_socket(sock);
> +    free(addr_rev);
> +    return NULL;
> +}
> +
> +static void
> +obfs_test_posix_request_event(openvpn_transport_socket_t handle,
> +                              openvpn_transport_event_set_handle_t
> event_set, unsigned rwflags)
> +{
> +    obfs_test_log(((struct obfs_test_socket_posix *) handle)->ctx,
> +                  PLOG_DEBUG, "request-event: %d", rwflags);
> +    ((struct obfs_test_socket_posix *) handle)->last_rwflags = 0;
> +    if (rwflags)
> +    {
> +        event_set->vtab->set_event(event_set, ((struct
> obfs_test_socket_posix *) handle)->fd,
> +                                   rwflags, handle);
> +    }
> +}
> +
> +static bool
> +obfs_test_posix_update_event(openvpn_transport_socket_t handle, void
> *arg, unsigned rwflags)
> +{
> +    obfs_test_log(((struct obfs_test_socket_posix *) handle)->ctx,
> +                  PLOG_DEBUG, "update-event: %p, %p, %d", handle, arg,
> rwflags);
> +    if (arg != handle)
> +    {
> +        return false;
> +    }
> +    ((struct obfs_test_socket_posix *) handle)->last_rwflags |= rwflags;
> +    return true;
> +}
> +
> +static unsigned
> +obfs_test_posix_pump(openvpn_transport_socket_t handle)
> +{
> +    obfs_test_log(((struct obfs_test_socket_posix *) handle)->ctx,
> +                  PLOG_DEBUG, "pump -> %d", ((struct
> obfs_test_socket_posix *) handle)->last_rwflags);
> +    return ((struct obfs_test_socket_posix *) handle)->last_rwflags;
> +}
> +
> +static ssize_t
> +obfs_test_posix_recvfrom(openvpn_transport_socket_t handle, void *buf,
> size_t len,
> +                         struct sockaddr *addr, socklen_t *addrlen)
> +{
> +    int fd = ((struct obfs_test_socket_posix *) handle)->fd;
> +    ssize_t result;
> +
> +again:
> +    result = recvfrom(fd, buf, len, 0, addr, addrlen);
> +    if (result < 0 && errno == EAGAIN)
> +    {
> +        ((struct obfs_test_socket_posix *) handle)->last_rwflags &=
> ~OPENVPN_TRANSPORT_EVENT_READ;
> +    }
> +    if (*addrlen > 0)
> +    {
> +        obfs_test_munge_addr(addr, *addrlen);
> +    }
> +    if (result > 0)
> +    {
> +        struct obfs_test_args *how = &((struct obfs_test_socket_posix *)
> handle)->args;
> +        result = obfs_test_unmunge_buf(how, buf, result);
> +        if (result < 0)
> +        {
> +            /* Pretend that read never happened. */
> +            goto again;
> +        }
> +    }
> +
> +    obfs_test_log(((struct obfs_test_socket_posix *) handle)->ctx,
> +                  PLOG_DEBUG, "recvfrom(%d) -> %d", (int)len,
> (int)result);
> +    return result;
> +}
> +
> +static ssize_t
> +obfs_test_posix_sendto(openvpn_transport_socket_t handle, const void
> *buf, size_t len,
> +                       const struct sockaddr *addr, socklen_t addrlen)
> +{
> +    int fd = ((struct obfs_test_socket_posix *) handle)->fd;
> +    struct sockaddr *addr_rev = calloc(1, addrlen);
> +    void *buf_munged = malloc(obfs_test_max_munged_buf_size(len));
> +    size_t len_munged;
> +    ssize_t result;
> +    if (!addr_rev || !buf_munged)
> +    {
> +        goto error;
> +    }
> +
> +    memcpy(addr_rev, addr, addrlen);
> +    obfs_test_munge_addr(addr_rev, addrlen);
> +    struct obfs_test_args *how = &((struct obfs_test_socket_posix *)
> handle)->args;
> +    len_munged = obfs_test_munge_buf(how, buf_munged, buf, len);
> +    result = sendto(fd, buf_munged, len_munged, 0, addr_rev, addrlen);
> +    if (result < 0 && errno == EAGAIN)
> +    {
> +        ((struct obfs_test_socket_posix *) handle)->last_rwflags &=
> ~OPENVPN_TRANSPORT_EVENT_WRITE;
> +    }
> +    /* TODO: not clear what to do here for partial transfers. */
> +    if (result > len)
> +    {
> +        result = len;
> +    }
> +    obfs_test_log(((struct obfs_test_socket_posix *) handle)->ctx,
> +                  PLOG_DEBUG, "sendto(%d) -> %d", (int)len, (int)result);
> +    free(addr_rev);
> +    free(buf_munged);
> +    return result;
> +
> +error:
> +    free(addr_rev);
> +    free(buf_munged);
> +    return -1;
> +}
> +
> +static void
> +obfs_test_posix_close(openvpn_transport_socket_t handle)
> +{
> +    free_socket((struct obfs_test_socket_posix *) handle);
> +}
> +
> +void
> +obfs_test_initialize_vtabs_platform(void)
> +{
> +    obfs_test_bind_vtab.bind = obfs_test_posix_bind;
> +    obfs_test_socket_vtab.request_event = obfs_test_posix_request_event;
> +    obfs_test_socket_vtab.update_event = obfs_test_posix_update_event;
> +    obfs_test_socket_vtab.pump = obfs_test_posix_pump;
> +    obfs_test_socket_vtab.recvfrom = obfs_test_posix_recvfrom;
> +    obfs_test_socket_vtab.sendto = obfs_test_posix_sendto;
> +    obfs_test_socket_vtab.close = obfs_test_posix_close;
> +}
> diff --git a/src/plugins/obfs-test/obfs-test-win32.c
> b/src/plugins/obfs-test/obfs-test-win32.c
> new file mode 100644
> index 00000000..46c95f55
> --- /dev/null
> +++ b/src/plugins/obfs-test/obfs-test-win32.c
> @@ -0,0 +1,579 @@
> +#include "obfs-test.h"
> +#include <stdbool.h>
> +#include <string.h>
> +#include <stdio.h>
> +#include <stdarg.h>
> +#include <windows.h>
> +#include <winsock2.h>
> +#include <assert.h>
> +
> +static inline bool
> +is_invalid_handle(HANDLE h)
> +{
> +    return h == NULL || h == INVALID_HANDLE_VALUE;
> +}
> +
> +typedef enum {
> +    IO_SLOT_DORMANT,            /* must be 0 for calloc purposes */
> +    IO_SLOT_PENDING,
> +    /* success/failure is determined by succeeded flag in COMPLETE state
> */
> +    IO_SLOT_COMPLETE
> +} io_slot_status_t;
> +
> +/* must be calloc'able */
> +struct io_slot
> +{
> +    struct obfs_test_context *ctx;
> +    io_slot_status_t status;
> +    OVERLAPPED overlapped;
> +    SOCKET socket;
> +    SOCKADDR_STORAGE addr;
> +    int addr_len, addr_cap;
> +    DWORD bytes, flags;
> +    bool succeeded;
> +    int wsa_error;
> +
> +    /* realloc'd as needed; always private copy, never aliased */
> +    char *buf;
> +    size_t buf_len, buf_cap;
> +};
> +
> +static bool
> +setup_io_slot(struct io_slot *slot, struct obfs_test_context *ctx,
> +              SOCKET socket, HANDLE event)
> +{
> +    slot->ctx = ctx;
> +    slot->status = IO_SLOT_DORMANT;
> +    slot->addr_cap = sizeof(SOCKADDR_STORAGE);
> +    slot->socket = socket;
> +    slot->overlapped.hEvent = event;
> +    return true;
> +}
> +
> +/* Note that this assumes any I/O has already been implicitly canceled
> (via closesocket),
> + * but not waited for yet. */
> +static bool
> +destroy_io_slot(struct io_slot *slot)
> +{
> +    if (slot->status == IO_SLOT_PENDING)
> +    {
> +        DWORD bytes, flags;
> +        BOOL ok = WSAGetOverlappedResult(slot->socket, &slot->overlapped,
> &bytes,
> +                                         TRUE /* wait */, &flags);
> +        if (!ok && WSAGetLastError() == WSA_IO_INCOMPLETE)
> +        {
> +            obfs_test_log(slot->ctx, PLOG_ERR,
> +                          "destroying I/O slot: canceled operation is
> still incomplete after wait?!");
> +            return false;
> +        }
> +    }
> +
> +    slot->status = IO_SLOT_DORMANT;
> +    return true;
> +}
> +
> +/* FIXME: aborts on error. */
> +static void
> +resize_io_buf(struct io_slot *slot, size_t cap)
> +{
> +    if (slot->buf)
> +    {
> +        free(slot->buf);
> +        slot->buf = NULL;
> +    }
> +
> +    char *new_buf = malloc(cap);
> +    if (!new_buf)
> +    {
> +        abort();
> +    }
> +    slot->buf = new_buf;
> +    slot->buf_cap = cap;
> +}
> +
> +struct obfs_test_socket_win32
> +{
> +    struct openvpn_transport_socket handle;
> +    struct obfs_test_args args;
> +    struct obfs_test_context *ctx;
> +    SOCKET socket;
> +
> +    /* Write is ready when idle; read is not-ready when idle. Both
> level-triggered. */
> +    struct openvpn_transport_win32_event_pair completion_events;
> +    struct io_slot slot_read, slot_write;
> +
> +    int last_rwflags;
> +};
> +
> +static void
> +free_socket(struct obfs_test_socket_win32 *sock)
> +{
> +    /* This only ever becomes false in strange situations where we leak
> the entire structure for
> +     * lack of anything else to do. */
> +    bool can_free = true;
> +
> +    if (!sock)
> +    {
> +        return;
> +    }
> +    if (sock->socket != INVALID_SOCKET)
> +    {
> +        closesocket(sock->socket);
> +    }
> +
> +    /* closesocket cancels any pending overlapped I/O, but we still have
> to potentially
> +     * wait for it here before we can free the buffers. This has to
> happen before closing
> +     * the event handles.
> +     *
> +     * If we can't figure out when the canceled overlapped I/O is done,
> for any reason, we defensively
> +     * leak the entire structure; freeing it would be permitting the
> system to corrupt memory later.
> +     * TODO: possibly abort() instead, but make sure we've handled all
> the possible "have to try again"
> +     * cases above first
> +     */
> +    if (!destroy_io_slot(&sock->slot_read))
> +    {
> +        can_free = false;
> +    }
> +    if (!destroy_io_slot(&sock->slot_write))
> +    {
> +        can_free = false;
> +    }
> +    if (!can_free)
> +    {
> +        /* Skip deinitialization of everything else. Doomed. */
> +        obfs_test_log(sock->ctx, PLOG_ERR, "doomed, leaking the entire
> socket structure");
> +        return;
> +    }
> +
> +    if (!is_invalid_handle(sock->completion_events.read))
> +    {
> +        CloseHandle(sock->completion_events.read);
> +    }
> +    if (!is_invalid_handle(sock->completion_events.write))
> +    {
> +        CloseHandle(sock->completion_events.write);
> +    }
> +
> +    free(sock);
> +}
> +
> +static openvpn_transport_socket_t
> +obfs_test_win32_bind(void *plugin_handle, openvpn_transport_args_t args,
> +                     const struct sockaddr *addr,
> openvpn_transport_socklen_t len)
> +{
> +    struct obfs_test_socket_win32 *sock = NULL;
> +    struct sockaddr *addr_rev = NULL;
> +
> +    /* TODO: would be nice to factor out some of these sequences */
> +    addr_rev = calloc(1, len);
> +    if (!addr_rev)
> +    {
> +        goto error;
> +    }
> +    memcpy(addr_rev, addr, len);
> +    obfs_test_munge_addr(addr_rev, len);
> +
> +    sock = calloc(1, sizeof(struct obfs_test_socket_win32));
> +    if (!sock)
> +    {
> +        goto error;
> +    }
> +    sock->handle.vtab = &obfs_test_socket_vtab;
> +    sock->ctx = (struct obfs_test_context *) plugin_handle;
> +    memcpy(&sock->args, args, sizeof(sock->args));
> +
> +    /* Preemptively initialize the members of some Win32 types so error
> exits are okay later on.
> +     * HANDLEs of NULL are considered invalid per above. */
> +    sock->socket = INVALID_SOCKET;
> +
> +    sock->socket = socket(addr_rev->sa_family, SOCK_DGRAM, IPPROTO_UDP);
> +    if (sock->socket == INVALID_SOCKET)
> +    {
> +        goto error;
> +    }
> +
> +    /* See above: write is ready when idle, read is not-ready when idle.
> */
> +    sock->completion_events.read = CreateEvent(NULL, TRUE, FALSE, NULL);
> +    sock->completion_events.write = CreateEvent(NULL, TRUE, TRUE, NULL);
> +    if (is_invalid_handle(sock->completion_events.read) ||
> is_invalid_handle(sock->completion_events.write))
> +    {
> +        goto error;
> +    }
> +    if (!setup_io_slot(&sock->slot_read, sock->ctx,
> +                       sock->socket, sock->completion_events.read))
> +    {
> +        goto error;
> +    }
> +    if (!setup_io_slot(&sock->slot_write, sock->ctx,
> +                       sock->socket, sock->completion_events.write))
> +    {
> +        goto error;
> +    }
> +
> +    if (bind(sock->socket, addr_rev, len))
> +    {
> +        goto error;
> +    }
> +    free(addr_rev);
> +    return &sock->handle;
> +
> +error:
> +    obfs_test_log((struct obfs_test_context *) plugin_handle, PLOG_ERR,
> +                  "bind failure: WSA error = %d", WSAGetLastError());
> +    free_socket(sock);
> +    free(addr_rev);
> +    return NULL;
> +}
> +
> +static void
> +handle_sendrecv_return(struct io_slot *slot, int status)
> +{
> +    if (status == 0)
> +    {
> +        /* Immediately completed. Set the event so it stays consistent. */
> +        slot->status = IO_SLOT_COMPLETE;
> +        slot->succeeded = true;
> +        slot->buf_len = slot->bytes;
> +        SetEvent(slot->overlapped.hEvent);
> +    }
> +    else if (WSAGetLastError() == WSA_IO_PENDING)
> +    {
> +        /* Queued. */
> +        slot->status = IO_SLOT_PENDING;
> +    }
> +    else
> +    {
> +        /* Error. */
> +        slot->status = IO_SLOT_COMPLETE;
> +        slot->succeeded = false;
> +        slot->wsa_error = WSAGetLastError();
> +        slot->buf_len = 0;
> +    }
> +}
> +
> +static void
> +queue_new_read(struct io_slot *slot, size_t cap)
> +{
> +    int status;
> +    WSABUF sbuf;
> +    assert(slot->status == IO_SLOT_DORMANT);
> +
> +    ResetEvent(slot->overlapped.hEvent);
> +    resize_io_buf(slot, cap);
> +    sbuf.buf = slot->buf;
> +    sbuf.len = slot->buf_cap;
> +    slot->addr_len = slot->addr_cap;
> +    slot->flags = 0;
> +    status = WSARecvFrom(slot->socket, &sbuf, 1, &slot->bytes,
> &slot->flags,
> +                         (struct sockaddr *)&slot->addr, &slot->addr_len,
> +                         &slot->overlapped, NULL);
> +    handle_sendrecv_return(slot, status);
> +}
> +
> +/* write slot buffer must already be full. */
> +static void
> +queue_new_write(struct io_slot *slot)
> +{
> +    int status;
> +    WSABUF sbuf;
> +    assert(slot->status == IO_SLOT_COMPLETE || slot->status ==
> IO_SLOT_DORMANT);
> +
> +    ResetEvent(slot->overlapped.hEvent);
> +    sbuf.buf = slot->buf;
> +    sbuf.len = slot->buf_len;
> +    slot->flags = 0;
> +    status = WSASendTo(slot->socket, &sbuf, 1, &slot->bytes, 0 /* flags
> */,
> +                       (struct sockaddr *)&slot->addr, slot->addr_len,
> +                       &slot->overlapped, NULL);
> +    handle_sendrecv_return(slot, status);
> +}
> +
> +static void
> +ensure_pending_read(struct obfs_test_socket_win32 *sock)
> +{
> +    struct io_slot *slot = &sock->slot_read;
> +    switch (slot->status)
> +    {
> +        case IO_SLOT_PENDING:
> +            return;
> +
> +        case IO_SLOT_COMPLETE:
> +            /* Set the event manually here just in case. */
> +            SetEvent(slot->overlapped.hEvent);
> +            return;
> +
> +        case IO_SLOT_DORMANT:
> +            /* TODO: we don't propagate max read size here, so we just
> have to assume the maximum. */
> +            queue_new_read(slot, 65536);
> +            return;
> +
> +        default:
> +            abort();
> +    }
> +}
> +
> +static bool
> +complete_pending_operation(struct io_slot *slot)
> +{
> +    DWORD bytes, flags;
> +    BOOL ok;
> +
> +    switch (slot->status)
> +    {
> +        case IO_SLOT_DORMANT:
> +            /* TODO: shouldn't get here? */
> +            return false;
> +
> +        case IO_SLOT_COMPLETE:
> +            return true;
> +
> +        case IO_SLOT_PENDING:
> +            ok = WSAGetOverlappedResult(slot->socket, &slot->overlapped,
> &bytes,
> +                                        FALSE /* don't wait */, &flags);
> +            if (!ok && WSAGetLastError() == WSA_IO_INCOMPLETE)
> +            {
> +                /* Still waiting. */
> +                return false;
> +            }
> +            else if (ok)
> +            {
> +                /* Completed. slot->addr_len has already been updated. */
> +                slot->buf_len = bytes;
> +                slot->status = IO_SLOT_COMPLETE;
> +                slot->succeeded = true;
> +                return true;
> +            }
> +            else
> +            {
> +                /* Error. */
> +                slot->buf_len = 0;
> +                slot->status = IO_SLOT_COMPLETE;
> +                slot->succeeded = false;
> +                slot->wsa_error = WSAGetLastError();
> +                return true;
> +            }
> +
> +        default:
> +            abort();
> +    }
> +}
> +
> +static bool
> +complete_pending_read(struct obfs_test_socket_win32 *sock)
> +{
> +    bool done = complete_pending_operation(&sock->slot_read);
> +    if (done)
> +    {
> +        ResetEvent(sock->completion_events.read);
> +    }
> +    return done;
> +}
> +
> +static void
> +consumed_pending_read(struct obfs_test_socket_win32 *sock)
> +{
> +    struct io_slot *slot = &sock->slot_read;
> +    assert(slot->status == IO_SLOT_COMPLETE);
> +    slot->status = IO_SLOT_DORMANT;
> +    slot->succeeded = false;
> +    ResetEvent(slot->overlapped.hEvent);
> +}
> +
> +static inline bool
> +complete_pending_write(struct obfs_test_socket_win32 *sock)
> +{
> +    bool done = complete_pending_operation(&sock->slot_write);
> +    if (done)
> +    {
> +        SetEvent(sock->completion_events.write);
> +    }
> +    return done;
> +}
> +
> +static void
> +obfs_test_win32_request_event(openvpn_transport_socket_t handle,
> +                              openvpn_transport_event_set_handle_t
> event_set, unsigned rwflags)
> +{
> +    struct obfs_test_socket_win32 *sock = (struct obfs_test_socket_win32
> *)handle;
> +    obfs_test_log(sock->ctx, PLOG_DEBUG, "request-event: %d", rwflags);
> +    sock->last_rwflags = 0;
> +
> +    if (rwflags & OPENVPN_TRANSPORT_EVENT_READ)
> +    {
> +        ensure_pending_read(sock);
> +    }
> +    if (rwflags)
> +    {
> +        event_set->vtab->set_event(event_set, &sock->completion_events,
> rwflags, handle);
> +    }
> +}
> +
> +static bool
> +obfs_test_win32_update_event(openvpn_transport_socket_t handle, void
> *arg, unsigned rwflags)
> +{
> +    obfs_test_log(((struct obfs_test_socket_win32 *) handle)->ctx,
> PLOG_DEBUG,
> +                  "update-event: %p, %p, %d", handle, arg, rwflags);
> +    if (arg != handle)
> +    {
> +        return false;
> +    }
> +    ((struct obfs_test_socket_win32 *) handle)->last_rwflags |= rwflags;
> +    return true;
> +}
> +
> +static unsigned
> +obfs_test_win32_pump(openvpn_transport_socket_t handle)
> +{
> +    struct obfs_test_socket_win32 *sock = (struct obfs_test_socket_win32
> *)handle;
> +    unsigned result = 0;
> +
> +    if ((sock->last_rwflags & OPENVPN_TRANSPORT_EVENT_READ) &&
> complete_pending_read(sock))
> +    {
> +        result |= OPENVPN_TRANSPORT_EVENT_READ;
> +    }
> +    if ((sock->last_rwflags & OPENVPN_TRANSPORT_EVENT_WRITE)
> +        && (sock->slot_write.status != IO_SLOT_PENDING ||
> complete_pending_write(sock)))
> +    {
> +        result |= OPENVPN_TRANSPORT_EVENT_WRITE;
> +    }
> +
> +    obfs_test_log(sock->ctx, PLOG_DEBUG, "pump -> %d", result);
> +    return result;
> +}
> +
> +static ssize_t
> +obfs_test_win32_recvfrom(openvpn_transport_socket_t handle, void *buf,
> size_t len,
> +                         struct sockaddr *addr,
> openvpn_transport_socklen_t *addrlen)
> +{
> +    struct obfs_test_socket_win32 *sock = (struct obfs_test_socket_win32
> *)handle;
> +    if (!complete_pending_read(sock))
> +    {
> +        WSASetLastError(WSA_IO_INCOMPLETE);
> +        return -1;
> +    }
> +
> +    if (!sock->slot_read.succeeded)
> +    {
> +        int wsa_error = sock->slot_read.wsa_error;
> +        consumed_pending_read(sock);
> +        WSASetLastError(wsa_error);
> +        return -1;
> +    }
> +
> +    /* sock->slot_read now has valid data. */
> +    char *working_buf = sock->slot_read.buf;
> +    ssize_t unmunged_len =
> +        obfs_test_unmunge_buf(&sock->args, working_buf,
> +                              sock->slot_read.buf_len);
> +    if (unmunged_len < 0)
> +    {
> +        /* Act as though this read never happened. Assume one was queued
> before, so it should
> +         * still remain queued. */
> +        consumed_pending_read(sock);
> +        ensure_pending_read(sock);
> +        WSASetLastError(WSA_IO_INCOMPLETE);
> +        return -1;
> +    }
> +
> +    size_t copy_len = unmunged_len;
> +    if (copy_len > len)
> +    {
> +        copy_len = len;
> +    }
> +    memcpy(buf, sock->slot_read.buf, copy_len);
> +
> +    /* TODO: shouldn't truncate, should signal error (but this shouldn't
> happen for any
> +     * supported address families anyway). */
> +    openvpn_transport_socklen_t addr_copy_len = *addrlen;
> +    if (sock->slot_read.addr_len < addr_copy_len)
> +    {
> +        addr_copy_len = sock->slot_read.addr_len;
> +    }
> +    memcpy(addr, &sock->slot_read.addr, addr_copy_len);
> +    *addrlen = addr_copy_len;
> +    if (addr_copy_len > 0)
> +    {
> +        obfs_test_munge_addr(addr, addr_copy_len);
> +    }
> +
> +    /* Reset the I/O slot before returning. */
> +    consumed_pending_read(sock);
> +    return copy_len;
> +}
> +
> +static ssize_t
> +obfs_test_win32_sendto(openvpn_transport_socket_t handle, const void
> *buf, size_t len,
> +                       const struct sockaddr *addr,
> openvpn_transport_socklen_t addrlen)
> +{
> +    struct obfs_test_socket_win32 *sock = (struct obfs_test_socket_win32
> *)handle;
> +    complete_pending_write(sock);
> +
> +    if (sock->slot_write.status == IO_SLOT_PENDING)
> +    {
> +        /* This shouldn't really happen, but. */
> +        WSASetLastError(WSAEWOULDBLOCK);
> +        return -1;
> +    }
> +
> +    if (addrlen > sock->slot_write.addr_cap)
> +    {
> +        /* Shouldn't happen. */
> +        WSASetLastError(WSAEFAULT);
> +        return -1;
> +    }
> +
> +    /* TODO: propagate previous write errors---what does core expect
> here? */
> +    memcpy(&sock->slot_write.addr, addr, addrlen);
> +    sock->slot_write.addr_len = addrlen;
> +    if (addrlen > 0)
> +    {
> +        obfs_test_munge_addr((struct sockaddr *)&sock->slot_write.addr,
> addrlen);
> +    }
> +    resize_io_buf(&sock->slot_write, obfs_test_max_munged_buf_size(len));
> +    sock->slot_write.buf_len =
> +        obfs_test_munge_buf(&sock->args, sock->slot_write.buf, buf, len);
> +    queue_new_write(&sock->slot_write);
> +    switch (sock->slot_write.status)
> +    {
> +        case IO_SLOT_PENDING:
> +            /* The network hasn't given us an error yet, but _we've_
> consumed all the bytes.
> +             * ... sort of. */
> +            return len;
> +
> +        case IO_SLOT_DORMANT:
> +            /* Huh?? But we just queued a write. */
> +            abort();
> +
> +        case IO_SLOT_COMPLETE:
> +            if (sock->slot_write.succeeded)
> +            {
> +                /* TODO: more partial length handling */
> +                return len;
> +            }
> +            else
> +            {
> +                return -1;
> +            }
> +
> +        default:
> +            abort();
> +    }
> +}
> +
> +static void
> +obfs_test_win32_close(openvpn_transport_socket_t handle)
> +{
> +    free_socket((struct obfs_test_socket_win32 *) handle);
> +}
> +
> +void
> +obfs_test_initialize_vtabs_platform(void)
> +{
> +    obfs_test_bind_vtab.bind = obfs_test_win32_bind;
> +    obfs_test_socket_vtab.request_event = obfs_test_win32_request_event;
> +    obfs_test_socket_vtab.update_event = obfs_test_win32_update_event;
> +    obfs_test_socket_vtab.pump = obfs_test_win32_pump;
> +    obfs_test_socket_vtab.recvfrom = obfs_test_win32_recvfrom;
> +    obfs_test_socket_vtab.sendto = obfs_test_win32_sendto;
> +    obfs_test_socket_vtab.close = obfs_test_win32_close;
> +}
> diff --git a/src/plugins/obfs-test/obfs-test.c
> b/src/plugins/obfs-test/obfs-test.c
> new file mode 100644
> index 00000000..27a3d21e
> --- /dev/null
> +++ b/src/plugins/obfs-test/obfs-test.c
> @@ -0,0 +1,94 @@
> +#include <stdlib.h>
> +#include <string.h>
> +#include <stdbool.h>
> +#include "openvpn-plugin.h"
> +#include "openvpn-transport.h"
> +#include "obfs-test.h"
> +
> +struct openvpn_transport_bind_vtab1 obfs_test_bind_vtab = { 0 };
> +struct openvpn_transport_socket_vtab1 obfs_test_socket_vtab = { 0 };
> +
> +struct obfs_test_context
> +{
> +    struct openvpn_plugin_callbacks *global_vtab;
> +};
> +
> +static void
> +free_context(struct obfs_test_context *context)
> +{
> +    if (!context)
> +    {
> +        return;
> +    }
> +    free(context);
> +}
> +
> +OPENVPN_EXPORT int
> +openvpn_plugin_open_v3(int version, struct openvpn_plugin_args_open_in
> const *args,
> +                       struct openvpn_plugin_args_open_return *out)
> +{
> +    struct obfs_test_context *context;
> +
> +    context = (struct obfs_test_context *) calloc(1, sizeof(struct
> obfs_test_context));
> +    if (!context)
> +    {
> +        return OPENVPN_PLUGIN_FUNC_ERROR;
> +    }
> +
> +    context->global_vtab = args->callbacks;
> +    obfs_test_initialize_vtabs_platform();
> +    obfs_test_bind_vtab.parseargs = obfs_test_parseargs;
> +    obfs_test_bind_vtab.argerror = obfs_test_argerror;
> +    obfs_test_bind_vtab.freeargs = obfs_test_freeargs;
> +
> +    out->type_mask = OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_TRANSPORT);
> +    out->handle = (openvpn_plugin_handle_t *) context;
> +    return OPENVPN_PLUGIN_FUNC_SUCCESS;
> +
> +err:
> +    free_context(context);
> +    return OPENVPN_PLUGIN_FUNC_ERROR;
> +}
> +
> +OPENVPN_EXPORT void
> +openvpn_plugin_close_v1(openvpn_plugin_handle_t handle)
> +{
> +    free_context((struct obfs_test_context *) handle);
> +}
> +
> +OPENVPN_EXPORT int
> +openvpn_plugin_func_v3(int version,
> +                       struct openvpn_plugin_args_func_in const
> *arguments,
> +                       struct openvpn_plugin_args_func_return *retptr)
> +{
> +    /* We don't ask for any bits that use this interface. */
> +    return OPENVPN_PLUGIN_FUNC_ERROR;
> +}
> +
> +OPENVPN_EXPORT void *
> +openvpn_plugin_get_vtab_v1(int selector, size_t *size_out)
> +{
> +    switch (selector)
> +    {
> +        case OPENVPN_VTAB_TRANSPORT_BIND_V1:
> +            if (obfs_test_bind_vtab.bind == NULL)
> +            {
> +                return NULL;
> +            }
> +            *size_out = sizeof(struct openvpn_transport_bind_vtab1);
> +            return &obfs_test_bind_vtab;
> +
> +        default:
> +            return NULL;
> +    }
> +}
> +
> +void
> +obfs_test_log(struct obfs_test_context *ctx,
> +              openvpn_plugin_log_flags_t flags, const char *fmt, ...)
> +{
> +    va_list va;
> +    va_start(va, fmt);
> +    ctx->global_vtab->plugin_vlog(flags, OBFS_TEST_PLUGIN_NAME, fmt, va);
> +    va_end(va);
> +}
> diff --git a/src/plugins/obfs-test/obfs-test.exports
> b/src/plugins/obfs-test/obfs-test.exports
> new file mode 100644
> index 00000000..e7baada4
> --- /dev/null
> +++ b/src/plugins/obfs-test/obfs-test.exports
> @@ -0,0 +1,4 @@
> +openvpn_plugin_open_v3
> +openvpn_plugin_close_v1
> +openvpn_plugin_get_vtab_v1
> +openvpn_plugin_func_v3
> diff --git a/src/plugins/obfs-test/obfs-test.h
> b/src/plugins/obfs-test/obfs-test.h
> new file mode 100644
> index 00000000..b9a6f8b4
> --- /dev/null
> +++ b/src/plugins/obfs-test/obfs-test.h
> @@ -0,0 +1,42 @@
> +#ifndef OPENVPN_PLUGIN_OBFS_TEST_H
> +#define OPENVPN_PLUGIN_OBFS_TEST_H 1
> +
> +#include "openvpn-plugin.h"
> +#include "openvpn-transport.h"
> +
> +#define OBFS_TEST_PLUGIN_NAME "obfs-test"
> +
> +struct obfs_test_context;
> +
> +struct obfs_test_args
> +{
> +    const char *error;
> +    int offset;
> +};
> +
> +extern struct openvpn_transport_bind_vtab1 obfs_test_bind_vtab;
> +extern struct openvpn_transport_socket_vtab1 obfs_test_socket_vtab;
> +
> +void obfs_test_initialize_vtabs_platform(void);
> +
> +void obfs_test_munge_addr(struct sockaddr *addr,
> openvpn_transport_socklen_t len);
> +
> +size_t obfs_test_max_munged_buf_size(size_t clear_size);
> +
> +size_t obfs_test_munge_buf(struct obfs_test_args *how,
> +                           char *out, const char *in, size_t len);
> +
> +ssize_t obfs_test_unmunge_buf(struct obfs_test_args *how,
> +                              char *buf, size_t len);
> +
> +openvpn_transport_args_t obfs_test_parseargs(void *plugin_handle,
> +                                             const char *const *argv, int
> argc);
> +
> +const char *obfs_test_argerror(openvpn_transport_args_t args);
> +
> +void obfs_test_freeargs(openvpn_transport_args_t args);
> +
> +void obfs_test_log(struct obfs_test_context *ctx,
> +                   openvpn_plugin_log_flags_t flags, const char *fmt,
> ...);
> +
> +#endif /* !OPENVPN_PLUGIN_OBFS_TEST_H */
> --
> 2.19.2
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--0000000000001ca9600580889d8c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Bumping this as well given the holiday hiatus - it seems l=
ike there was feedback on the patches 2 &amp; 3. Does anyone have any feedb=
ack for this one?<div><br></div><div>Thanks!</div><div>Justin<br clear=3D"a=
ll"><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail=
_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><d=
iv><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div dir=3D=
"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><=
div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=
=3D"ltr"><br><table cellspacing=3D"0" cellpadding=3D"0" style=3D"font-famil=
y:&quot;open sans&quot;,sans-serif"><tbody><tr style=3D"color:rgb(102,102,1=
02);font-family:sans-serif;font-size:small"><td nowrap valign=3D"top" style=
=3D"border:none;padding-right:22px"><img src=3D"https://www.gstatic.com/jig=
saw/Jigsaw_logo.png" height=3D"45" width=3D"45" style=3D"height:45px;width:=
45px"></td><td nowrap style=3D"border:none"><span style=3D"font-weight:bold=
">Justin Henck</span>=C2=A0<br><span>Product Manager</span><span></span>=C2=
=A0<br><div style=3D"display:inline"><span>212-565-9811</span>=C2=A0<br></d=
iv><a href=3D"https://google.com/jigsaw" style=3D"color:rgb(102,102,102)" t=
arget=3D"_blank">google.com/jigsaw</a></td></tr></tbody></table></div><div =
dir=3D"ltr"><div dir=3D"auto"><div><span><font color=3D"#666666"><br></font=
></span></div><div><span><font color=3D"#666666">PGP: EA8E 8C27 2D75 974D B=
357 482B 1039 9F2D 869A 117B</font></span></div></div></div></div></div></d=
iv></div></div></div></div></div></div></div></div></div></div></div></div>=
</div></div></div></div></div></div></div><br></div></div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Dec 30, 2018 at=
 6:31 AM Antonio Quartulli &lt;a@...2181...&gt; wrote:<br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">From: Robin Tarsiger &lt;<a href=3D"=
mailto:rtt@...2484..." target=3D"_blank">rtt@...2484...</a>&gt;<br>
<br>
Add a sample plugin to explain how the new transport API is expected to<br>
be implemented and work. It can be used for testing.<br>
<br>
Signed-off-by: Robin Tarsiger &lt;<a href=3D"mailto:rtt@...2484..." target=
=3D"_blank">rtt@...2484...</a>&gt;<br>
[<a href=3D"mailto:antonio@...515..." target=3D"_blank">antonio@...515...</=
a>: refactored commits, restyled code]<br>
---<br>
=C2=A0<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A09 +<br>
=C2=A0src/plugins/Makefile.am=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A02 +-<br>
=C2=A0src/plugins/obfs-test/Makefile.am=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 29 ++<br>
=C2=A0src/plugins/obfs-test/README.obfs-test=C2=A0 =C2=A0 |=C2=A0 26 +<br>
=C2=A0src/plugins/obfs-test/obfs-test-args.c=C2=A0 =C2=A0 |=C2=A0 60 +++<br>
=C2=A0src/plugins/obfs-test/obfs-test-munging.c | 129 +++++<br>
=C2=A0src/plugins/obfs-test/obfs-test-posix.c=C2=A0 =C2=A0| 207 ++++++++<br>
=C2=A0src/plugins/obfs-test/obfs-test-win32.c=C2=A0 =C2=A0| 579 +++++++++++=
+++++++++++<br>
=C2=A0src/plugins/obfs-test/obfs-test.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 94 ++++<br>
=C2=A0src/plugins/obfs-test/obfs-test.exports=C2=A0 =C2=A0|=C2=A0 =C2=A04 +=
<br>
=C2=A0src/plugins/obfs-test/obfs-test.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 42 ++<br>
=C2=A011 files changed, 1180 insertions(+), 1 deletion(-)<br>
=C2=A0create mode 100644 src/plugins/obfs-test/Makefile.am<br>
=C2=A0create mode 100644 src/plugins/obfs-test/README.obfs-test<br>
=C2=A0create mode 100644 src/plugins/obfs-test/obfs-test-args.c<br>
=C2=A0create mode 100644 src/plugins/obfs-test/obfs-test-munging.c<br>
=C2=A0create mode 100644 src/plugins/obfs-test/obfs-test-posix.c<br>
=C2=A0create mode 100644 src/plugins/obfs-test/obfs-test-win32.c<br>
=C2=A0create mode 100644 src/plugins/obfs-test/obfs-test.c<br>
=C2=A0create mode 100644 src/plugins/obfs-test/obfs-test.exports<br>
=C2=A0create mode 100644 src/plugins/obfs-test/obfs-test.h<br>
<br>
diff --git a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_=
blank">configure.ac</a> b/<a href=3D"http://configure.ac" rel=3D"noreferrer=
" target=3D"_blank">configure.ac</a><br>
index 1e6891b1..b4196812 100644<br>
--- a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
+++ b/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
@@ -200,6 +200,13 @@ AC_ARG_ENABLE(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br>
=C2=A0)<br>
<br>
+AC_ARG_ENABLE(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0[plugin-obfs-test],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0[AS_HELP_STRING([--disable-plugin-obfs-test], [=
disable obfs-test plugin @&lt;:@default=3Dplatform specific@:&gt;@])],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0[enable_plugin_obfs_test=3D&quot;no&quot;]<br>
+)<br>
+<br>
=C2=A0AC_ARG_ENABLE(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [pam-dlopen],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [AS_HELP_STRING([--enable-pam-dlopen], [dlopen =
libpam @&lt;:@default=3Dno@:&gt;@])],<br>
@@ -1344,6 +1351,7 @@ AM_CONDITIONAL([WIN32], [test &quot;${WIN32}&quot; =
=3D &quot;yes&quot;])<br>
=C2=A0AM_CONDITIONAL([GIT_CHECKOUT], [test &quot;${GIT_CHECKOUT}&quot; =3D =
&quot;yes&quot;])<br>
=C2=A0AM_CONDITIONAL([ENABLE_PLUGIN_AUTH_PAM], [test &quot;${enable_plugin_=
auth_pam}&quot; =3D &quot;yes&quot;])<br>
=C2=A0AM_CONDITIONAL([ENABLE_PLUGIN_DOWN_ROOT], [test &quot;${enable_plugin=
_down_root}&quot; =3D &quot;yes&quot;])<br>
+AM_CONDITIONAL([ENABLE_PLUGIN_OBFS_TEST], [test &quot;${enable_plugin_obfs=
_test}&quot; =3D &quot;yes&quot;])<br>
=C2=A0AM_CONDITIONAL([HAVE_LD_WRAP_SUPPORT], [test &quot;${have_ld_wrap_sup=
port}&quot; =3D &quot;yes&quot;])<br>
<br>
=C2=A0sampledir=3D&quot;\$(docdir)/sample&quot;<br>
@@ -1403,6 +1411,7 @@ AC_CONFIG_FILES([<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 src/plugins/Makefile<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 src/plugins/auth-pam/Makefile<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 src/plugins/down-root/Makefile<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0src/plugins/obfs-test/Makefile<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tests/Makefile<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tests/unit_tests/Makefile<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tests/unit_tests/example_test/Makefile<br>
diff --git a/src/plugins/Makefile.am b/src/plugins/Makefile.am<br>
index f3461786..848bac03 100644<br>
--- a/src/plugins/Makefile.am<br>
+++ b/src/plugins/Makefile.am<br>
@@ -12,4 +12,4 @@<br>
=C2=A0MAINTAINERCLEANFILES =3D \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 $(srcdir)/Makefile.in<br>
<br>
-SUBDIRS =3D auth-pam down-root<br>
+SUBDIRS =3D auth-pam down-root obfs-test<br>
diff --git a/src/plugins/obfs-test/Makefile.am b/src/plugins/obfs-test/Make=
file.am<br>
new file mode 100644<br>
index 00000000..4cc8d183<br>
--- /dev/null<br>
+++ b/src/plugins/obfs-test/Makefile.am<br>
@@ -0,0 +1,29 @@<br>
+MAINTAINERCLEANFILES =3D \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(srcdir)/Makefile.in<br>
+<br>
+AM_CFLAGS =3D \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0-I$(top_srcdir)/include \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0$(OPTIONAL_CRYPTO_CFLAGS)<br>
+<br>
+if ENABLE_PLUGIN_OBFS_TEST<br>
+plugin_LTLIBRARIES =3D <a href=3D"http://openvpn-plugin-obfs-test.la" rel=
=3D"noreferrer" target=3D"_blank">openvpn-plugin-obfs-test.la</a><br>
+endif<br>
+<br>
+openvpn_plugin_obfs_test_la_SOURCES =3D \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0obfs-test.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0obfs-test-munging.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0obfs-test-args.c \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0obfs-test.exports<br>
+<br>
+if WIN32<br>
+openvpn_plugin_obfs_test_la_SOURCES +=3D obfs-test-win32.c<br>
+openvpn_plugin_obfs_test_la_LIBADD =3D -lws2_32 -lwininet<br>
+else !WIN32<br>
+openvpn_plugin_obfs_test_la_SOURCES +=3D obfs-test-posix.c<br>
+# No LIBADD necessary; we assume we can access the global symbol space,<br>
+# and core OpenVPN will already link with everything needed for sockets.<b=
r>
+endif<br>
+<br>
+openvpn_plugin_obfs_test_la_LDFLAGS =3D $(AM_LDFLAGS) \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0-export-symbols &quot;$(srcdir)/obfs-test.expor=
ts&quot; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0-module -shared -avoid-version -no-undefined<br>
diff --git a/src/plugins/obfs-test/README.obfs-test b/src/plugins/obfs-test=
/README.obfs-test<br>
new file mode 100644<br>
index 00000000..5492ee02<br>
--- /dev/null<br>
+++ b/src/plugins/obfs-test/README.obfs-test<br>
@@ -0,0 +1,26 @@<br>
+obfs-test<br>
+<br>
+SYNOPSIS<br>
+<br>
+The obfs-test plugin is a proof of concept for supporting protocol<br>
+obfuscation for OpenVPN via a socket intercept plugin.<br>
+<br>
+BUILD<br>
+<br>
+You must specify --enable-plugin-obfs-test at configure time to<br>
+trigger building this plugin. It should function on POSIX-y platforms<br>
+and Windows.<br>
+<br>
+USAGE<br>
+<br>
+To invoke this plugin, load it via an appropriate plugin line in the<br>
+configuration file, and then specify &#39;proto indirect&#39; rather than =
any<br>
+other protocol. Packets will then be passed via UDP, but they will<br>
+also undergo a very basic content transformation, and the bind port<br>
+will be altered (see obfs-test-munging.c for details).<br>
+<br>
+CAVEATS<br>
+<br>
+This has undergone basic functionality testing, but not any kind of<br>
+full-on stress test. Extended socket or I/O handling options are not<br>
+supported at all.<br>
diff --git a/src/plugins/obfs-test/obfs-test-args.c b/src/plugins/obfs-test=
/obfs-test-args.c<br>
new file mode 100644<br>
index 00000000..e6756f8f<br>
--- /dev/null<br>
+++ b/src/plugins/obfs-test/obfs-test-args.c<br>
@@ -0,0 +1,60 @@<br>
+#include &quot;obfs-test.h&quot;<br>
+<br>
+openvpn_transport_args_t<br>
+obfs_test_parseargs(void *plugin_handle,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cons=
t char *const *argv, int argc)<br>
+{<br>
+=C2=A0 =C2=A0 struct obfs_test_args *args =3D calloc(1, sizeof(struct obfs=
_test_args));<br>
+=C2=A0 =C2=A0 if (!args)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (argc &lt; 2)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 args-&gt;offset =3D 0;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else if (argc =3D=3D 2)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 char *end;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 long offset =3D strtol(argv[1], &amp;end, 10);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (*end !=3D &#39;\0&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 args-&gt;error =3D &quot;offset =
must be a decimal number&quot;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (!(0 &lt;=3D offset &amp;&amp; offset =
&lt;=3D 42))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 args-&gt;error =3D &quot;offset =
must be between 0 and 42&quot;;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 args-&gt;offset =3D (int) offset=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 args-&gt;error =3D &quot;too many arguments&qu=
ot;;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return args;<br>
+}<br>
+<br>
+const char *<br>
+obfs_test_argerror(openvpn_transport_args_t args_)<br>
+{<br>
+=C2=A0 =C2=A0 if (!args_)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;cannot allocate&quot;;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return ((struct obfs_test_args *) args_)-&gt;e=
rror;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+void<br>
+obfs_test_freeargs(openvpn_transport_args_t args_)<br>
+{<br>
+=C2=A0 =C2=A0 free(args_);<br>
+=C2=A0 =C2=A0 struct obfs_test_args *args =3D (struct obfs_test_args *) ar=
gs_;<br>
+}<br>
diff --git a/src/plugins/obfs-test/obfs-test-munging.c b/src/plugins/obfs-t=
est/obfs-test-munging.c<br>
new file mode 100644<br>
index 00000000..37d27039<br>
--- /dev/null<br>
+++ b/src/plugins/obfs-test/obfs-test-munging.c<br>
@@ -0,0 +1,129 @@<br>
+#include &lt;string.h&gt;<br>
+#include &lt;errno.h&gt;<br>
+#include &lt;stdbool.h&gt;<br>
+#include &quot;obfs-test.h&quot;<br>
+#ifdef OPENVPN_TRANSPORT_PLATFORM_POSIX<br>
+#include &lt;sys/socket.h&gt;<br>
+#include &lt;netinet/in.h&gt;<br>
+typedef in_port_t obfs_test_in_port_t;<br>
+#else<br>
+#include &lt;winsock2.h&gt;<br>
+#include &lt;ws2tcpip.h&gt;<br>
+typedef u_short obfs_test_in_port_t;<br>
+#endif<br>
+<br>
+static obfs_test_in_port_t<br>
+munge_port(obfs_test_in_port_t port)<br>
+{<br>
+=C2=A0 =C2=A0 return port ^ 15;<br>
+}<br>
+<br>
+/* Reversible. */<br>
+void<br>
+obfs_test_munge_addr(struct sockaddr *addr, openvpn_transport_socklen_t le=
n)<br>
+{<br>
+=C2=A0 =C2=A0 struct sockaddr_in *inet;<br>
+=C2=A0 =C2=A0 struct sockaddr_in6 *inet6;<br>
+<br>
+=C2=A0 =C2=A0 switch (addr-&gt;sa_family)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case AF_INET:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 inet =3D (struct sockaddr_in *) =
addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 inet-&gt;sin_port =3D munge_port=
(inet-&gt;sin_port);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case AF_INET6:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 inet6 =3D (struct sockaddr_in6 *=
) addr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 inet6-&gt;sin6_port =3D munge_po=
rt(inet6-&gt;sin6_port);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+/* Six fixed bytes, six repeated bytes. It&#39;s only a silly transformati=
on. */<br>
+#define MUNGE_OVERHEAD 12<br>
+<br>
+size_t<br>
+obfs_test_max_munged_buf_size(size_t clear_size)<br>
+{<br>
+=C2=A0 =C2=A0 return clear_size + MUNGE_OVERHEAD;<br>
+}<br>
+<br>
+ssize_t<br>
+obfs_test_unmunge_buf(struct obfs_test_args *how,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 char *buf, size_t len)<br>
+{<br>
+=C2=A0 =C2=A0 int i;<br>
+<br>
+=C2=A0 =C2=A0 if (len &lt; 6)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto bad;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; 6; i++)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (buf[i] !=3D i + how-&gt;offset)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto bad;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; 6 &amp;&amp; (6 + 2*i) &lt; len; i++)<b=
r>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (len &lt; (6 + 2*i + 1) || buf[6 + 2*i] !=
=3D buf[6 + 2*i + 1])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto bad;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 buf[i] =3D buf[6 + 2*i];<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (len &gt; 18)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memmove(buf + 6, buf + 18, len - 18);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 len -=3D 12;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 len -=3D 6;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 len /=3D 2;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return len;<br>
+<br>
+bad:<br>
+=C2=A0 =C2=A0 /* TODO: this really isn&#39;t the best way to report this e=
rror */<br>
+=C2=A0 =C2=A0 errno =3D EIO;<br>
+=C2=A0 =C2=A0 return -1;<br>
+}<br>
+<br>
+/* out must have space for len+MUNGE_OVERHEAD bytes. out and in must<br>
+ * not overlap. */<br>
+size_t<br>
+obfs_test_munge_buf(struct obfs_test_args *how,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char=
 *out, const char *in, size_t len)<br>
+{<br>
+=C2=A0 =C2=A0 int i, n;<br>
+=C2=A0 =C2=A0 size_t out_len =3D 6;<br>
+<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; 6; i++)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 out[i] =3D i + how-&gt;offset;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 n =3D len &lt; 6 ? len : 6;<br>
+=C2=A0 =C2=A0 for (i =3D 0; i &lt; n; i++)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 out[6 + 2*i] =3D out[6 + 2*i + 1] =3D in[i];<b=
r>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (len &gt; 6)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 memmove(out + 18, in + 6, len - 6);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 out_len =3D len + 12;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 out_len =3D 6 + 2*len;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return out_len;<br>
+}<br>
diff --git a/src/plugins/obfs-test/obfs-test-posix.c b/src/plugins/obfs-tes=
t/obfs-test-posix.c<br>
new file mode 100644<br>
index 00000000..826381c5<br>
--- /dev/null<br>
+++ b/src/plugins/obfs-test/obfs-test-posix.c<br>
@@ -0,0 +1,207 @@<br>
+#include &quot;obfs-test.h&quot;<br>
+#include &lt;stdbool.h&gt;<br>
+#include &lt;string.h&gt;<br>
+#include &lt;err.h&gt;<br>
+#include &lt;errno.h&gt;<br>
+#include &lt;unistd.h&gt;<br>
+#include &lt;fcntl.h&gt;<br>
+#include &lt;sys/socket.h&gt;<br>
+#include &lt;netinet/in.h&gt;<br>
+<br>
+struct obfs_test_socket_posix<br>
+{<br>
+=C2=A0 =C2=A0 struct openvpn_transport_socket handle;<br>
+=C2=A0 =C2=A0 struct obfs_test_args args;<br>
+=C2=A0 =C2=A0 struct obfs_test_context *ctx;<br>
+=C2=A0 =C2=A0 int fd;<br>
+=C2=A0 =C2=A0 unsigned last_rwflags;<br>
+};<br>
+<br>
+static void<br>
+free_socket(struct obfs_test_socket_posix *sock)<br>
+{<br>
+=C2=A0 =C2=A0 if (!sock)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (sock-&gt;fd !=3D -1)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(sock-&gt;fd);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 free(sock);<br>
+}<br>
+<br>
+static openvpn_transport_socket_t<br>
+obfs_test_posix_bind(void *plugin_handle, openvpn_transport_args_t args,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0const struct sockaddr *addr, socklen_t len)<br>
+{<br>
+=C2=A0 =C2=A0 struct obfs_test_socket_posix *sock =3D NULL;<br>
+=C2=A0 =C2=A0 struct sockaddr *addr_rev =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 addr_rev =3D calloc(1, len);<br>
+=C2=A0 =C2=A0 if (!addr_rev)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 memcpy(addr_rev, addr, len);<br>
+=C2=A0 =C2=A0 obfs_test_munge_addr(addr_rev, len);<br>
+<br>
+=C2=A0 =C2=A0 sock =3D calloc(1, sizeof(struct obfs_test_socket_posix));<b=
r>
+=C2=A0 =C2=A0 if (!sock)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 sock-&gt;handle.vtab =3D &amp;obfs_test_socket_vtab;<br>
+=C2=A0 =C2=A0 sock-&gt;ctx =3D (struct obfs_test_context *) plugin_handle;=
<br>
+=C2=A0 =C2=A0 memcpy(&amp;sock-&gt;args, args, sizeof(sock-&gt;args));<br>
+=C2=A0 =C2=A0 /* Note that sock-&gt;fd isn&#39;t -1 yet. Set it explicitly=
 if there are ever any<br>
+=C2=A0 =C2=A0 =C2=A0* error exits before the socket() call. */<br>
+<br>
+=C2=A0 =C2=A0 sock-&gt;fd =3D socket(addr-&gt;sa_family, SOCK_DGRAM, IPPRO=
TO_UDP);<br>
+=C2=A0 =C2=A0 if (sock-&gt;fd =3D=3D -1)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (fcntl(sock-&gt;fd, F_SETFL, fcntl(sock-&gt;fd, F_GETFL) =
| O_NONBLOCK))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (bind(sock-&gt;fd, addr_rev, len))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 free(addr_rev);<br>
+=C2=A0 =C2=A0 return &amp;sock-&gt;handle;<br>
+<br>
+error:<br>
+=C2=A0 =C2=A0 free_socket(sock);<br>
+=C2=A0 =C2=A0 free(addr_rev);<br>
+=C2=A0 =C2=A0 return NULL;<br>
+}<br>
+<br>
+static void<br>
+obfs_test_posix_request_event(openvpn_transport_socket_t handle,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 openvpn_transport_event_set_handle_t event_=
set, unsigned rwflags)<br>
+{<br>
+=C2=A0 =C2=A0 obfs_test_log(((struct obfs_test_socket_posix *) handle)-&gt=
;ctx,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PLOG_DEBUG,=
 &quot;request-event: %d&quot;, rwflags);<br>
+=C2=A0 =C2=A0 ((struct obfs_test_socket_posix *) handle)-&gt;last_rwflags =
=3D 0;<br>
+=C2=A0 =C2=A0 if (rwflags)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 event_set-&gt;vtab-&gt;set_event(event_set, ((=
struct obfs_test_socket_posix *) handle)-&gt;fd,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rwflags, handle);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static bool<br>
+obfs_test_posix_update_event(openvpn_transport_socket_t handle, void *arg,=
 unsigned rwflags)<br>
+{<br>
+=C2=A0 =C2=A0 obfs_test_log(((struct obfs_test_socket_posix *) handle)-&gt=
;ctx,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PLOG_DEBUG,=
 &quot;update-event: %p, %p, %d&quot;, handle, arg, rwflags);<br>
+=C2=A0 =C2=A0 if (arg !=3D handle)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 ((struct obfs_test_socket_posix *) handle)-&gt;last_rwflags =
|=3D rwflags;<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+static unsigned<br>
+obfs_test_posix_pump(openvpn_transport_socket_t handle)<br>
+{<br>
+=C2=A0 =C2=A0 obfs_test_log(((struct obfs_test_socket_posix *) handle)-&gt=
;ctx,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PLOG_DEBUG,=
 &quot;pump -&gt; %d&quot;, ((struct obfs_test_socket_posix *) handle)-&gt;=
last_rwflags);<br>
+=C2=A0 =C2=A0 return ((struct obfs_test_socket_posix *) handle)-&gt;last_r=
wflags;<br>
+}<br>
+<br>
+static ssize_t<br>
+obfs_test_posix_recvfrom(openvpn_transport_socket_t handle, void *buf, siz=
e_t len,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0struct sockaddr *addr, socklen_t *addrlen)<br>
+{<br>
+=C2=A0 =C2=A0 int fd =3D ((struct obfs_test_socket_posix *) handle)-&gt;fd=
;<br>
+=C2=A0 =C2=A0 ssize_t result;<br>
+<br>
+again:<br>
+=C2=A0 =C2=A0 result =3D recvfrom(fd, buf, len, 0, addr, addrlen);<br>
+=C2=A0 =C2=A0 if (result &lt; 0 &amp;&amp; errno =3D=3D EAGAIN)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ((struct obfs_test_socket_posix *) handle)-&gt=
;last_rwflags &amp;=3D ~OPENVPN_TRANSPORT_EVENT_READ;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (*addrlen &gt; 0)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 obfs_test_munge_addr(addr, *addrlen);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (result &gt; 0)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct obfs_test_args *how =3D &amp;((struct o=
bfs_test_socket_posix *) handle)-&gt;args;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D obfs_test_unmunge_buf(how, buf, res=
ult);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (result &lt; 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Pretend that read never happe=
ned. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto again;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 obfs_test_log(((struct obfs_test_socket_posix *) handle)-&gt=
;ctx,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PLOG_DEBUG,=
 &quot;recvfrom(%d) -&gt; %d&quot;, (int)len, (int)result);<br>
+=C2=A0 =C2=A0 return result;<br>
+}<br>
+<br>
+static ssize_t<br>
+obfs_test_posix_sendto(openvpn_transport_socket_t handle, const void *buf,=
 size_t len,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0const struct sockaddr *addr, socklen_t addrlen)<br>
+{<br>
+=C2=A0 =C2=A0 int fd =3D ((struct obfs_test_socket_posix *) handle)-&gt;fd=
;<br>
+=C2=A0 =C2=A0 struct sockaddr *addr_rev =3D calloc(1, addrlen);<br>
+=C2=A0 =C2=A0 void *buf_munged =3D malloc(obfs_test_max_munged_buf_size(le=
n));<br>
+=C2=A0 =C2=A0 size_t len_munged;<br>
+=C2=A0 =C2=A0 ssize_t result;<br>
+=C2=A0 =C2=A0 if (!addr_rev || !buf_munged)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 memcpy(addr_rev, addr, addrlen);<br>
+=C2=A0 =C2=A0 obfs_test_munge_addr(addr_rev, addrlen);<br>
+=C2=A0 =C2=A0 struct obfs_test_args *how =3D &amp;((struct obfs_test_socke=
t_posix *) handle)-&gt;args;<br>
+=C2=A0 =C2=A0 len_munged =3D obfs_test_munge_buf(how, buf_munged, buf, len=
);<br>
+=C2=A0 =C2=A0 result =3D sendto(fd, buf_munged, len_munged, 0, addr_rev, a=
ddrlen);<br>
+=C2=A0 =C2=A0 if (result &lt; 0 &amp;&amp; errno =3D=3D EAGAIN)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ((struct obfs_test_socket_posix *) handle)-&gt=
;last_rwflags &amp;=3D ~OPENVPN_TRANSPORT_EVENT_WRITE;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 /* TODO: not clear what to do here for partial transfers. */=
<br>
+=C2=A0 =C2=A0 if (result &gt; len)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 result =3D len;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 obfs_test_log(((struct obfs_test_socket_posix *) handle)-&gt=
;ctx,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PLOG_DEBUG,=
 &quot;sendto(%d) -&gt; %d&quot;, (int)len, (int)result);<br>
+=C2=A0 =C2=A0 free(addr_rev);<br>
+=C2=A0 =C2=A0 free(buf_munged);<br>
+=C2=A0 =C2=A0 return result;<br>
+<br>
+error:<br>
+=C2=A0 =C2=A0 free(addr_rev);<br>
+=C2=A0 =C2=A0 free(buf_munged);<br>
+=C2=A0 =C2=A0 return -1;<br>
+}<br>
+<br>
+static void<br>
+obfs_test_posix_close(openvpn_transport_socket_t handle)<br>
+{<br>
+=C2=A0 =C2=A0 free_socket((struct obfs_test_socket_posix *) handle);<br>
+}<br>
+<br>
+void<br>
+obfs_test_initialize_vtabs_platform(void)<br>
+{<br>
+=C2=A0 =C2=A0 obfs_test_bind_vtab.bind =3D obfs_test_posix_bind;<br>
+=C2=A0 =C2=A0 obfs_test_socket_vtab.request_event =3D obfs_test_posix_requ=
est_event;<br>
+=C2=A0 =C2=A0 obfs_test_socket_vtab.update_event =3D obfs_test_posix_updat=
e_event;<br>
+=C2=A0 =C2=A0 obfs_test_socket_vtab.pump =3D obfs_test_posix_pump;<br>
+=C2=A0 =C2=A0 obfs_test_socket_vtab.recvfrom =3D obfs_test_posix_recvfrom;=
<br>
+=C2=A0 =C2=A0 obfs_test_socket_vtab.sendto =3D obfs_test_posix_sendto;<br>
+=C2=A0 =C2=A0 obfs_test_socket_vtab.close =3D obfs_test_posix_close;<br>
+}<br>
diff --git a/src/plugins/obfs-test/obfs-test-win32.c b/src/plugins/obfs-tes=
t/obfs-test-win32.c<br>
new file mode 100644<br>
index 00000000..46c95f55<br>
--- /dev/null<br>
+++ b/src/plugins/obfs-test/obfs-test-win32.c<br>
@@ -0,0 +1,579 @@<br>
+#include &quot;obfs-test.h&quot;<br>
+#include &lt;stdbool.h&gt;<br>
+#include &lt;string.h&gt;<br>
+#include &lt;stdio.h&gt;<br>
+#include &lt;stdarg.h&gt;<br>
+#include &lt;windows.h&gt;<br>
+#include &lt;winsock2.h&gt;<br>
+#include &lt;assert.h&gt;<br>
+<br>
+static inline bool<br>
+is_invalid_handle(HANDLE h)<br>
+{<br>
+=C2=A0 =C2=A0 return h =3D=3D NULL || h =3D=3D INVALID_HANDLE_VALUE;<br>
+}<br>
+<br>
+typedef enum {<br>
+=C2=A0 =C2=A0 IO_SLOT_DORMANT,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=
 must be 0 for calloc purposes */<br>
+=C2=A0 =C2=A0 IO_SLOT_PENDING,<br>
+=C2=A0 =C2=A0 /* success/failure is determined by succeeded flag in COMPLE=
TE state */<br>
+=C2=A0 =C2=A0 IO_SLOT_COMPLETE<br>
+} io_slot_status_t;<br>
+<br>
+/* must be calloc&#39;able */<br>
+struct io_slot<br>
+{<br>
+=C2=A0 =C2=A0 struct obfs_test_context *ctx;<br>
+=C2=A0 =C2=A0 io_slot_status_t status;<br>
+=C2=A0 =C2=A0 OVERLAPPED overlapped;<br>
+=C2=A0 =C2=A0 SOCKET socket;<br>
+=C2=A0 =C2=A0 SOCKADDR_STORAGE addr;<br>
+=C2=A0 =C2=A0 int addr_len, addr_cap;<br>
+=C2=A0 =C2=A0 DWORD bytes, flags;<br>
+=C2=A0 =C2=A0 bool succeeded;<br>
+=C2=A0 =C2=A0 int wsa_error;<br>
+<br>
+=C2=A0 =C2=A0 /* realloc&#39;d as needed; always private copy, never alias=
ed */<br>
+=C2=A0 =C2=A0 char *buf;<br>
+=C2=A0 =C2=A0 size_t buf_len, buf_cap;<br>
+};<br>
+<br>
+static bool<br>
+setup_io_slot(struct io_slot *slot, struct obfs_test_context *ctx,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SOCKET socket, HANDLE eve=
nt)<br>
+{<br>
+=C2=A0 =C2=A0 slot-&gt;ctx =3D ctx;<br>
+=C2=A0 =C2=A0 slot-&gt;status =3D IO_SLOT_DORMANT;<br>
+=C2=A0 =C2=A0 slot-&gt;addr_cap =3D sizeof(SOCKADDR_STORAGE);<br>
+=C2=A0 =C2=A0 slot-&gt;socket =3D socket;<br>
+=C2=A0 =C2=A0 slot-&gt;overlapped.hEvent =3D event;<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/* Note that this assumes any I/O has already been implicitly canceled (vi=
a closesocket),<br>
+ * but not waited for yet. */<br>
+static bool<br>
+destroy_io_slot(struct io_slot *slot)<br>
+{<br>
+=C2=A0 =C2=A0 if (slot-&gt;status =3D=3D IO_SLOT_PENDING)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DWORD bytes, flags;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 BOOL ok =3D WSAGetOverlappedResult(slot-&gt;so=
cket, &amp;slot-&gt;overlapped, &amp;bytes,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TR=
UE /* wait */, &amp;flags);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ok &amp;&amp; WSAGetLastError() =3D=3D WS=
A_IO_INCOMPLETE)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 obfs_test_log(slot-&gt;ctx, PLOG=
_ERR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;destroying I/O slot: canceled operation is still in=
complete after wait?!&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 slot-&gt;status =3D IO_SLOT_DORMANT;<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/* FIXME: aborts on error. */<br>
+static void<br>
+resize_io_buf(struct io_slot *slot, size_t cap)<br>
+{<br>
+=C2=A0 =C2=A0 if (slot-&gt;buf)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 free(slot-&gt;buf);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 slot-&gt;buf =3D NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 char *new_buf =3D malloc(cap);<br>
+=C2=A0 =C2=A0 if (!new_buf)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 abort();<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 slot-&gt;buf =3D new_buf;<br>
+=C2=A0 =C2=A0 slot-&gt;buf_cap =3D cap;<br>
+}<br>
+<br>
+struct obfs_test_socket_win32<br>
+{<br>
+=C2=A0 =C2=A0 struct openvpn_transport_socket handle;<br>
+=C2=A0 =C2=A0 struct obfs_test_args args;<br>
+=C2=A0 =C2=A0 struct obfs_test_context *ctx;<br>
+=C2=A0 =C2=A0 SOCKET socket;<br>
+<br>
+=C2=A0 =C2=A0 /* Write is ready when idle; read is not-ready when idle. Bo=
th level-triggered. */<br>
+=C2=A0 =C2=A0 struct openvpn_transport_win32_event_pair completion_events;=
<br>
+=C2=A0 =C2=A0 struct io_slot slot_read, slot_write;<br>
+<br>
+=C2=A0 =C2=A0 int last_rwflags;<br>
+};<br>
+<br>
+static void<br>
+free_socket(struct obfs_test_socket_win32 *sock)<br>
+{<br>
+=C2=A0 =C2=A0 /* This only ever becomes false in strange situations where =
we leak the entire structure for<br>
+=C2=A0 =C2=A0 =C2=A0* lack of anything else to do. */<br>
+=C2=A0 =C2=A0 bool can_free =3D true;<br>
+<br>
+=C2=A0 =C2=A0 if (!sock)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (sock-&gt;socket !=3D INVALID_SOCKET)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 closesocket(sock-&gt;socket);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* closesocket cancels any pending overlapped I/O, but we st=
ill have to potentially<br>
+=C2=A0 =C2=A0 =C2=A0* wait for it here before we can free the buffers. Thi=
s has to happen before closing<br>
+=C2=A0 =C2=A0 =C2=A0* the event handles.<br>
+=C2=A0 =C2=A0 =C2=A0*<br>
+=C2=A0 =C2=A0 =C2=A0* If we can&#39;t figure out when the canceled overlap=
ped I/O is done, for any reason, we defensively<br>
+=C2=A0 =C2=A0 =C2=A0* leak the entire structure; freeing it would be permi=
tting the system to corrupt memory later.<br>
+=C2=A0 =C2=A0 =C2=A0* TODO: possibly abort() instead, but make sure we&#39=
;ve handled all the possible &quot;have to try again&quot;<br>
+=C2=A0 =C2=A0 =C2=A0* cases above first<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (!destroy_io_slot(&amp;sock-&gt;slot_read))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 can_free =3D false;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (!destroy_io_slot(&amp;sock-&gt;slot_write))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 can_free =3D false;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (!can_free)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Skip deinitialization of everything else. D=
oomed. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 obfs_test_log(sock-&gt;ctx, PLOG_ERR, &quot;do=
omed, leaking the entire socket structure&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (!is_invalid_handle(sock-&gt;completion_events.read))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 CloseHandle(sock-&gt;completion_events.read);<=
br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (!is_invalid_handle(sock-&gt;completion_events.write))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 CloseHandle(sock-&gt;completion_events.write);=
<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 free(sock);<br>
+}<br>
+<br>
+static openvpn_transport_socket_t<br>
+obfs_test_win32_bind(void *plugin_handle, openvpn_transport_args_t args,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0const struct sockaddr *addr, openvpn_transport_socklen_t len)<br>
+{<br>
+=C2=A0 =C2=A0 struct obfs_test_socket_win32 *sock =3D NULL;<br>
+=C2=A0 =C2=A0 struct sockaddr *addr_rev =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 /* TODO: would be nice to factor out some of these sequences=
 */<br>
+=C2=A0 =C2=A0 addr_rev =3D calloc(1, len);<br>
+=C2=A0 =C2=A0 if (!addr_rev)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 memcpy(addr_rev, addr, len);<br>
+=C2=A0 =C2=A0 obfs_test_munge_addr(addr_rev, len);<br>
+<br>
+=C2=A0 =C2=A0 sock =3D calloc(1, sizeof(struct obfs_test_socket_win32));<b=
r>
+=C2=A0 =C2=A0 if (!sock)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 sock-&gt;handle.vtab =3D &amp;obfs_test_socket_vtab;<br>
+=C2=A0 =C2=A0 sock-&gt;ctx =3D (struct obfs_test_context *) plugin_handle;=
<br>
+=C2=A0 =C2=A0 memcpy(&amp;sock-&gt;args, args, sizeof(sock-&gt;args));<br>
+<br>
+=C2=A0 =C2=A0 /* Preemptively initialize the members of some Win32 types s=
o error exits are okay later on.<br>
+=C2=A0 =C2=A0 =C2=A0* HANDLEs of NULL are considered invalid per above. */=
<br>
+=C2=A0 =C2=A0 sock-&gt;socket =3D INVALID_SOCKET;<br>
+<br>
+=C2=A0 =C2=A0 sock-&gt;socket =3D socket(addr_rev-&gt;sa_family, SOCK_DGRA=
M, IPPROTO_UDP);<br>
+=C2=A0 =C2=A0 if (sock-&gt;socket =3D=3D INVALID_SOCKET)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* See above: write is ready when idle, read is not-ready wh=
en idle. */<br>
+=C2=A0 =C2=A0 sock-&gt;completion_events.read =3D CreateEvent(NULL, TRUE, =
FALSE, NULL);<br>
+=C2=A0 =C2=A0 sock-&gt;completion_events.write =3D CreateEvent(NULL, TRUE,=
 TRUE, NULL);<br>
+=C2=A0 =C2=A0 if (is_invalid_handle(sock-&gt;completion_events.read) || is=
_invalid_handle(sock-&gt;completion_events.write))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (!setup_io_slot(&amp;sock-&gt;slot_read, sock-&gt;ctx,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0sock-&gt;socket, sock-&gt;completion_events.read))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (!setup_io_slot(&amp;sock-&gt;slot_write, sock-&gt;ctx,<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0sock-&gt;socket, sock-&gt;completion_events.write))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (bind(sock-&gt;socket, addr_rev, len))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 free(addr_rev);<br>
+=C2=A0 =C2=A0 return &amp;sock-&gt;handle;<br>
+<br>
+error:<br>
+=C2=A0 =C2=A0 obfs_test_log((struct obfs_test_context *) plugin_handle, PL=
OG_ERR,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;bind =
failure: WSA error =3D %d&quot;, WSAGetLastError());<br>
+=C2=A0 =C2=A0 free_socket(sock);<br>
+=C2=A0 =C2=A0 free(addr_rev);<br>
+=C2=A0 =C2=A0 return NULL;<br>
+}<br>
+<br>
+static void<br>
+handle_sendrecv_return(struct io_slot *slot, int status)<br>
+{<br>
+=C2=A0 =C2=A0 if (status =3D=3D 0)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Immediately completed. Set the event so it =
stays consistent. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 slot-&gt;status =3D IO_SLOT_COMPLETE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 slot-&gt;succeeded =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 slot-&gt;buf_len =3D slot-&gt;bytes;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 SetEvent(slot-&gt;overlapped.hEvent);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else if (WSAGetLastError() =3D=3D WSA_IO_PENDING)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Queued. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 slot-&gt;status =3D IO_SLOT_PENDING;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Error. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 slot-&gt;status =3D IO_SLOT_COMPLETE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 slot-&gt;succeeded =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 slot-&gt;wsa_error =3D WSAGetLastError();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 slot-&gt;buf_len =3D 0;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void<br>
+queue_new_read(struct io_slot *slot, size_t cap)<br>
+{<br>
+=C2=A0 =C2=A0 int status;<br>
+=C2=A0 =C2=A0 WSABUF sbuf;<br>
+=C2=A0 =C2=A0 assert(slot-&gt;status =3D=3D IO_SLOT_DORMANT);<br>
+<br>
+=C2=A0 =C2=A0 ResetEvent(slot-&gt;overlapped.hEvent);<br>
+=C2=A0 =C2=A0 resize_io_buf(slot, cap);<br>
+=C2=A0 =C2=A0 sbuf.buf =3D slot-&gt;buf;<br>
+=C2=A0 =C2=A0 sbuf.len =3D slot-&gt;buf_cap;<br>
+=C2=A0 =C2=A0 slot-&gt;addr_len =3D slot-&gt;addr_cap;<br>
+=C2=A0 =C2=A0 slot-&gt;flags =3D 0;<br>
+=C2=A0 =C2=A0 status =3D WSARecvFrom(slot-&gt;socket, &amp;sbuf, 1, &amp;s=
lot-&gt;bytes, &amp;slot-&gt;flags,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(struct sockaddr *)&amp;slot-&gt;addr, &amp;slot-&gt;addr_=
len,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&amp;slot-&gt;overlapped, NULL);<br>
+=C2=A0 =C2=A0 handle_sendrecv_return(slot, status);<br>
+}<br>
+<br>
+/* write slot buffer must already be full. */<br>
+static void<br>
+queue_new_write(struct io_slot *slot)<br>
+{<br>
+=C2=A0 =C2=A0 int status;<br>
+=C2=A0 =C2=A0 WSABUF sbuf;<br>
+=C2=A0 =C2=A0 assert(slot-&gt;status =3D=3D IO_SLOT_COMPLETE || slot-&gt;s=
tatus =3D=3D IO_SLOT_DORMANT);<br>
+<br>
+=C2=A0 =C2=A0 ResetEvent(slot-&gt;overlapped.hEvent);<br>
+=C2=A0 =C2=A0 sbuf.buf =3D slot-&gt;buf;<br>
+=C2=A0 =C2=A0 sbuf.len =3D slot-&gt;buf_len;<br>
+=C2=A0 =C2=A0 slot-&gt;flags =3D 0;<br>
+=C2=A0 =C2=A0 status =3D WSASendTo(slot-&gt;socket, &amp;sbuf, 1, &amp;slo=
t-&gt;bytes, 0 /* flags */,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(struct sockaddr *)&amp;slot-&gt;addr, slot-&gt;addr_len,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&amp;slot-&gt;overlapped, NULL);<br>
+=C2=A0 =C2=A0 handle_sendrecv_return(slot, status);<br>
+}<br>
+<br>
+static void<br>
+ensure_pending_read(struct obfs_test_socket_win32 *sock)<br>
+{<br>
+=C2=A0 =C2=A0 struct io_slot *slot =3D &amp;sock-&gt;slot_read;<br>
+=C2=A0 =C2=A0 switch (slot-&gt;status)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IO_SLOT_PENDING:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IO_SLOT_COMPLETE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Set the event manually here j=
ust in case. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SetEvent(slot-&gt;overlapped.hEv=
ent);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IO_SLOT_DORMANT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TODO: we don&#39;t propagate =
max read size here, so we just have to assume the maximum. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_new_read(slot, 65536);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 abort();<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static bool<br>
+complete_pending_operation(struct io_slot *slot)<br>
+{<br>
+=C2=A0 =C2=A0 DWORD bytes, flags;<br>
+=C2=A0 =C2=A0 BOOL ok;<br>
+<br>
+=C2=A0 =C2=A0 switch (slot-&gt;status)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IO_SLOT_DORMANT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TODO: shouldn&#39;t get here?=
 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IO_SLOT_COMPLETE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IO_SLOT_PENDING:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ok =3D WSAGetOverlappedResult(sl=
ot-&gt;socket, &amp;slot-&gt;overlapped, &amp;bytes,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FALSE /*=
 don&#39;t wait */, &amp;flags);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!ok &amp;&amp; WSAGetLastErr=
or() =3D=3D WSA_IO_INCOMPLETE)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Still waiting. =
*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else if (ok)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Completed. slot=
-&gt;addr_len has already been updated. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slot-&gt;buf_len =
=3D bytes;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slot-&gt;status =
=3D IO_SLOT_COMPLETE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slot-&gt;succeeded=
 =3D true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Error. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slot-&gt;buf_len =
=3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slot-&gt;status =
=3D IO_SLOT_COMPLETE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slot-&gt;succeeded=
 =3D false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 slot-&gt;wsa_error=
 =3D WSAGetLastError();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 abort();<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static bool<br>
+complete_pending_read(struct obfs_test_socket_win32 *sock)<br>
+{<br>
+=C2=A0 =C2=A0 bool done =3D complete_pending_operation(&amp;sock-&gt;slot_=
read);<br>
+=C2=A0 =C2=A0 if (done)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ResetEvent(sock-&gt;completion_events.read);<b=
r>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return done;<br>
+}<br>
+<br>
+static void<br>
+consumed_pending_read(struct obfs_test_socket_win32 *sock)<br>
+{<br>
+=C2=A0 =C2=A0 struct io_slot *slot =3D &amp;sock-&gt;slot_read;<br>
+=C2=A0 =C2=A0 assert(slot-&gt;status =3D=3D IO_SLOT_COMPLETE);<br>
+=C2=A0 =C2=A0 slot-&gt;status =3D IO_SLOT_DORMANT;<br>
+=C2=A0 =C2=A0 slot-&gt;succeeded =3D false;<br>
+=C2=A0 =C2=A0 ResetEvent(slot-&gt;overlapped.hEvent);<br>
+}<br>
+<br>
+static inline bool<br>
+complete_pending_write(struct obfs_test_socket_win32 *sock)<br>
+{<br>
+=C2=A0 =C2=A0 bool done =3D complete_pending_operation(&amp;sock-&gt;slot_=
write);<br>
+=C2=A0 =C2=A0 if (done)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 SetEvent(sock-&gt;completion_events.write);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return done;<br>
+}<br>
+<br>
+static void<br>
+obfs_test_win32_request_event(openvpn_transport_socket_t handle,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 openvpn_transport_event_set_handle_t event_=
set, unsigned rwflags)<br>
+{<br>
+=C2=A0 =C2=A0 struct obfs_test_socket_win32 *sock =3D (struct obfs_test_so=
cket_win32 *)handle;<br>
+=C2=A0 =C2=A0 obfs_test_log(sock-&gt;ctx, PLOG_DEBUG, &quot;request-event:=
 %d&quot;, rwflags);<br>
+=C2=A0 =C2=A0 sock-&gt;last_rwflags =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 if (rwflags &amp; OPENVPN_TRANSPORT_EVENT_READ)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ensure_pending_read(sock);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (rwflags)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 event_set-&gt;vtab-&gt;set_event(event_set, &a=
mp;sock-&gt;completion_events, rwflags, handle);<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static bool<br>
+obfs_test_win32_update_event(openvpn_transport_socket_t handle, void *arg,=
 unsigned rwflags)<br>
+{<br>
+=C2=A0 =C2=A0 obfs_test_log(((struct obfs_test_socket_win32 *) handle)-&gt=
;ctx, PLOG_DEBUG,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;updat=
e-event: %p, %p, %d&quot;, handle, arg, rwflags);<br>
+=C2=A0 =C2=A0 if (arg !=3D handle)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 ((struct obfs_test_socket_win32 *) handle)-&gt;last_rwflags =
|=3D rwflags;<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+static unsigned<br>
+obfs_test_win32_pump(openvpn_transport_socket_t handle)<br>
+{<br>
+=C2=A0 =C2=A0 struct obfs_test_socket_win32 *sock =3D (struct obfs_test_so=
cket_win32 *)handle;<br>
+=C2=A0 =C2=A0 unsigned result =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 if ((sock-&gt;last_rwflags &amp; OPENVPN_TRANSPORT_EVENT_REA=
D) &amp;&amp; complete_pending_read(sock))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 result |=3D OPENVPN_TRANSPORT_EVENT_READ;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if ((sock-&gt;last_rwflags &amp; OPENVPN_TRANSPORT_EVENT_WRI=
TE)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;&amp; (sock-&gt;slot_write.status !=3D IO=
_SLOT_PENDING || complete_pending_write(sock)))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 result |=3D OPENVPN_TRANSPORT_EVENT_WRITE;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 obfs_test_log(sock-&gt;ctx, PLOG_DEBUG, &quot;pump -&gt; %d&=
quot;, result);<br>
+=C2=A0 =C2=A0 return result;<br>
+}<br>
+<br>
+static ssize_t<br>
+obfs_test_win32_recvfrom(openvpn_transport_socket_t handle, void *buf, siz=
e_t len,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0struct sockaddr *addr, openvpn_transport_socklen_t *addrle=
n)<br>
+{<br>
+=C2=A0 =C2=A0 struct obfs_test_socket_win32 *sock =3D (struct obfs_test_so=
cket_win32 *)handle;<br>
+=C2=A0 =C2=A0 if (!complete_pending_read(sock))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 WSASetLastError(WSA_IO_INCOMPLETE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (!sock-&gt;slot_read.succeeded)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int wsa_error =3D sock-&gt;slot_read.wsa_error=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 consumed_pending_read(sock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 WSASetLastError(wsa_error);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* sock-&gt;slot_read now has valid data. */<br>
+=C2=A0 =C2=A0 char *working_buf =3D sock-&gt;slot_read.buf;<br>
+=C2=A0 =C2=A0 ssize_t unmunged_len =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 obfs_test_unmunge_buf(&amp;sock-&gt;args, work=
ing_buf,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sock-&gt;slot_read.buf_len);<br>
+=C2=A0 =C2=A0 if (unmunged_len &lt; 0)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Act as though this read never happened. Ass=
ume one was queued before, so it should<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* still remain queued. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 consumed_pending_read(sock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ensure_pending_read(sock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 WSASetLastError(WSA_IO_INCOMPLETE);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 size_t copy_len =3D unmunged_len;<br>
+=C2=A0 =C2=A0 if (copy_len &gt; len)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 copy_len =3D len;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 memcpy(buf, sock-&gt;slot_read.buf, copy_len);<br>
+<br>
+=C2=A0 =C2=A0 /* TODO: shouldn&#39;t truncate, should signal error (but th=
is shouldn&#39;t happen for any<br>
+=C2=A0 =C2=A0 =C2=A0* supported address families anyway). */<br>
+=C2=A0 =C2=A0 openvpn_transport_socklen_t addr_copy_len =3D *addrlen;<br>
+=C2=A0 =C2=A0 if (sock-&gt;slot_read.addr_len &lt; addr_copy_len)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 addr_copy_len =3D sock-&gt;slot_read.addr_len;=
<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 memcpy(addr, &amp;sock-&gt;slot_read.addr, addr_copy_len);<b=
r>
+=C2=A0 =C2=A0 *addrlen =3D addr_copy_len;<br>
+=C2=A0 =C2=A0 if (addr_copy_len &gt; 0)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 obfs_test_munge_addr(addr, addr_copy_len);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Reset the I/O slot before returning. */<br>
+=C2=A0 =C2=A0 consumed_pending_read(sock);<br>
+=C2=A0 =C2=A0 return copy_len;<br>
+}<br>
+<br>
+static ssize_t<br>
+obfs_test_win32_sendto(openvpn_transport_socket_t handle, const void *buf,=
 size_t len,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0const struct sockaddr *addr, openvpn_transport_socklen_t addrlen)=
<br>
+{<br>
+=C2=A0 =C2=A0 struct obfs_test_socket_win32 *sock =3D (struct obfs_test_so=
cket_win32 *)handle;<br>
+=C2=A0 =C2=A0 complete_pending_write(sock);<br>
+<br>
+=C2=A0 =C2=A0 if (sock-&gt;slot_write.status =3D=3D IO_SLOT_PENDING)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* This shouldn&#39;t really happen, but. */<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 WSASetLastError(WSAEWOULDBLOCK);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (addrlen &gt; sock-&gt;slot_write.addr_cap)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Shouldn&#39;t happen. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 WSASetLastError(WSAEFAULT);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* TODO: propagate previous write errors---what does core ex=
pect here? */<br>
+=C2=A0 =C2=A0 memcpy(&amp;sock-&gt;slot_write.addr, addr, addrlen);<br>
+=C2=A0 =C2=A0 sock-&gt;slot_write.addr_len =3D addrlen;<br>
+=C2=A0 =C2=A0 if (addrlen &gt; 0)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 obfs_test_munge_addr((struct sockaddr *)&amp;s=
ock-&gt;slot_write.addr, addrlen);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 resize_io_buf(&amp;sock-&gt;slot_write, obfs_test_max_munged=
_buf_size(len));<br>
+=C2=A0 =C2=A0 sock-&gt;slot_write.buf_len =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 obfs_test_munge_buf(&amp;sock-&gt;args, sock-&=
gt;slot_write.buf, buf, len);<br>
+=C2=A0 =C2=A0 queue_new_write(&amp;sock-&gt;slot_write);<br>
+=C2=A0 =C2=A0 switch (sock-&gt;slot_write.status)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IO_SLOT_PENDING:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* The network hasn&#39;t given =
us an error yet, but _we&#39;ve_ consumed all the bytes.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* ... sort of. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return len;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IO_SLOT_DORMANT:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Huh?? But we just queued a wr=
ite. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 abort();<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case IO_SLOT_COMPLETE:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sock-&gt;slot_write.succeede=
d)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TODO: more part=
ial length handling */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return len;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 abort();<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+static void<br>
+obfs_test_win32_close(openvpn_transport_socket_t handle)<br>
+{<br>
+=C2=A0 =C2=A0 free_socket((struct obfs_test_socket_win32 *) handle);<br>
+}<br>
+<br>
+void<br>
+obfs_test_initialize_vtabs_platform(void)<br>
+{<br>
+=C2=A0 =C2=A0 obfs_test_bind_vtab.bind =3D obfs_test_win32_bind;<br>
+=C2=A0 =C2=A0 obfs_test_socket_vtab.request_event =3D obfs_test_win32_requ=
est_event;<br>
+=C2=A0 =C2=A0 obfs_test_socket_vtab.update_event =3D obfs_test_win32_updat=
e_event;<br>
+=C2=A0 =C2=A0 obfs_test_socket_vtab.pump =3D obfs_test_win32_pump;<br>
+=C2=A0 =C2=A0 obfs_test_socket_vtab.recvfrom =3D obfs_test_win32_recvfrom;=
<br>
+=C2=A0 =C2=A0 obfs_test_socket_vtab.sendto =3D obfs_test_win32_sendto;<br>
+=C2=A0 =C2=A0 obfs_test_socket_vtab.close =3D obfs_test_win32_close;<br>
+}<br>
diff --git a/src/plugins/obfs-test/obfs-test.c b/src/plugins/obfs-test/obfs=
-test.c<br>
new file mode 100644<br>
index 00000000..27a3d21e<br>
--- /dev/null<br>
+++ b/src/plugins/obfs-test/obfs-test.c<br>
@@ -0,0 +1,94 @@<br>
+#include &lt;stdlib.h&gt;<br>
+#include &lt;string.h&gt;<br>
+#include &lt;stdbool.h&gt;<br>
+#include &quot;openvpn-plugin.h&quot;<br>
+#include &quot;openvpn-transport.h&quot;<br>
+#include &quot;obfs-test.h&quot;<br>
+<br>
+struct openvpn_transport_bind_vtab1 obfs_test_bind_vtab =3D { 0 };<br>
+struct openvpn_transport_socket_vtab1 obfs_test_socket_vtab =3D { 0 };<br>
+<br>
+struct obfs_test_context<br>
+{<br>
+=C2=A0 =C2=A0 struct openvpn_plugin_callbacks *global_vtab;<br>
+};<br>
+<br>
+static void<br>
+free_context(struct obfs_test_context *context)<br>
+{<br>
+=C2=A0 =C2=A0 if (!context)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 free(context);<br>
+}<br>
+<br>
+OPENVPN_EXPORT int<br>
+openvpn_plugin_open_v3(int version, struct openvpn_plugin_args_open_in con=
st *args,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0struct openvpn_plugin_args_open_return *out)<br>
+{<br>
+=C2=A0 =C2=A0 struct obfs_test_context *context;<br>
+<br>
+=C2=A0 =C2=A0 context =3D (struct obfs_test_context *) calloc(1, sizeof(st=
ruct obfs_test_context));<br>
+=C2=A0 =C2=A0 if (!context)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return OPENVPN_PLUGIN_FUNC_ERROR;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 context-&gt;global_vtab =3D args-&gt;callbacks;<br>
+=C2=A0 =C2=A0 obfs_test_initialize_vtabs_platform();<br>
+=C2=A0 =C2=A0 obfs_test_bind_vtab.parseargs =3D obfs_test_parseargs;<br>
+=C2=A0 =C2=A0 obfs_test_bind_vtab.argerror =3D obfs_test_argerror;<br>
+=C2=A0 =C2=A0 obfs_test_bind_vtab.freeargs =3D obfs_test_freeargs;<br>
+<br>
+=C2=A0 =C2=A0 out-&gt;type_mask =3D OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_TRA=
NSPORT);<br>
+=C2=A0 =C2=A0 out-&gt;handle =3D (openvpn_plugin_handle_t *) context;<br>
+=C2=A0 =C2=A0 return OPENVPN_PLUGIN_FUNC_SUCCESS;<br>
+<br>
+err:<br>
+=C2=A0 =C2=A0 free_context(context);<br>
+=C2=A0 =C2=A0 return OPENVPN_PLUGIN_FUNC_ERROR;<br>
+}<br>
+<br>
+OPENVPN_EXPORT void<br>
+openvpn_plugin_close_v1(openvpn_plugin_handle_t handle)<br>
+{<br>
+=C2=A0 =C2=A0 free_context((struct obfs_test_context *) handle);<br>
+}<br>
+<br>
+OPENVPN_EXPORT int<br>
+openvpn_plugin_func_v3(int version,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0struct openvpn_plugin_args_func_in const *arguments,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0struct openvpn_plugin_args_func_return *retptr)<br>
+{<br>
+=C2=A0 =C2=A0 /* We don&#39;t ask for any bits that use this interface. */=
<br>
+=C2=A0 =C2=A0 return OPENVPN_PLUGIN_FUNC_ERROR;<br>
+}<br>
+<br>
+OPENVPN_EXPORT void *<br>
+openvpn_plugin_get_vtab_v1(int selector, size_t *size_out)<br>
+{<br>
+=C2=A0 =C2=A0 switch (selector)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case OPENVPN_VTAB_TRANSPORT_BIND_V1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (obfs_test_bind_vtab.bind =3D=
=3D NULL)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *size_out =3D sizeof(struct open=
vpn_transport_bind_vtab1);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &amp;obfs_test_bind_vtab;=
<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+}<br>
+<br>
+void<br>
+obfs_test_log(struct obfs_test_context *ctx,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 openvpn_plugin_log_flags_=
t flags, const char *fmt, ...)<br>
+{<br>
+=C2=A0 =C2=A0 va_list va;<br>
+=C2=A0 =C2=A0 va_start(va, fmt);<br>
+=C2=A0 =C2=A0 ctx-&gt;global_vtab-&gt;plugin_vlog(flags, OBFS_TEST_PLUGIN_=
NAME, fmt, va);<br>
+=C2=A0 =C2=A0 va_end(va);<br>
+}<br>
diff --git a/src/plugins/obfs-test/obfs-test.exports b/src/plugins/obfs-tes=
t/obfs-test.exports<br>
new file mode 100644<br>
index 00000000..e7baada4<br>
--- /dev/null<br>
+++ b/src/plugins/obfs-test/obfs-test.exports<br>
@@ -0,0 +1,4 @@<br>
+openvpn_plugin_open_v3<br>
+openvpn_plugin_close_v1<br>
+openvpn_plugin_get_vtab_v1<br>
+openvpn_plugin_func_v3<br>
diff --git a/src/plugins/obfs-test/obfs-test.h b/src/plugins/obfs-test/obfs=
-test.h<br>
new file mode 100644<br>
index 00000000..b9a6f8b4<br>
--- /dev/null<br>
+++ b/src/plugins/obfs-test/obfs-test.h<br>
@@ -0,0 +1,42 @@<br>
+#ifndef OPENVPN_PLUGIN_OBFS_TEST_H<br>
+#define OPENVPN_PLUGIN_OBFS_TEST_H 1<br>
+<br>
+#include &quot;openvpn-plugin.h&quot;<br>
+#include &quot;openvpn-transport.h&quot;<br>
+<br>
+#define OBFS_TEST_PLUGIN_NAME &quot;obfs-test&quot;<br>
+<br>
+struct obfs_test_context;<br>
+<br>
+struct obfs_test_args<br>
+{<br>
+=C2=A0 =C2=A0 const char *error;<br>
+=C2=A0 =C2=A0 int offset;<br>
+};<br>
+<br>
+extern struct openvpn_transport_bind_vtab1 obfs_test_bind_vtab;<br>
+extern struct openvpn_transport_socket_vtab1 obfs_test_socket_vtab;<br>
+<br>
+void obfs_test_initialize_vtabs_platform(void);<br>
+<br>
+void obfs_test_munge_addr(struct sockaddr *addr, openvpn_transport_socklen=
_t len);<br>
+<br>
+size_t obfs_test_max_munged_buf_size(size_t clear_size);<br>
+<br>
+size_t obfs_test_munge_buf(struct obfs_test_args *how,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0char *out, const char *in, size_t len);<br>
+<br>
+ssize_t obfs_test_unmunge_buf(struct obfs_test_args *how,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 char *buf, size_t len);<br>
+<br>
+openvpn_transport_args_t obfs_test_parseargs(void *plugin_handle,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0const char *const *argv, int argc);<br>
+<br>
+const char *obfs_test_argerror(openvpn_transport_args_t args);<br>
+<br>
+void obfs_test_freeargs(openvpn_transport_args_t args);<br>
+<br>
+void obfs_test_log(struct obfs_test_context *ctx,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0openv=
pn_plugin_log_flags_t flags, const char *fmt, ...);<br>
+<br>
+#endif /* !OPENVPN_PLUGIN_OBFS_TEST_H */<br>
-- <br>
2.19.2<br>
<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div>

--0000000000001ca9600580889d8c--

