From: Heiko Hund <heiko@...2662...>
Date: Thu, 18 Aug 2022 16:39:12 +0200
Message-ID: <2695184.KalutWefUj@...2664...>
In-Reply-To: <20220520213250.3126372-4-arne@...1227...>
References: <20220520213250.3126372-1-arne@...1227...>
 <20220520213250.3126372-4-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2 3/4] Implement AUTH_FAIL,
 TEMP message support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On Freitag, 20. Mai 2022 23:32:49 CEST Arne Schwabe wrote:
> This allows a server to indicate a temporary problem on the server and
> allows the server to indicate how to proceed (i.e. move to the next server,
> retry the same server, wait a certain time,...)
> 
> This adds options_utils.c/h to be able to unit test the new function.
> 
> Patch v2: Improve documentation, format man page better, comment that
>           protocol-flags is not a user usable option.
> ---
>  doc/man-sections/script-options.rst  |  36 ++++++++++
>  src/openvpn/Makefile.am              |   1 +
>  src/openvpn/init.c                   |   9 ++-
>  src/openvpn/openvpn.vcxproj          |   2 +
>  src/openvpn/openvpn.vcxproj.filters  |   3 +
>  src/openvpn/options.h                |   9 ++-
>  src/openvpn/options_util.c           | 104 +++++++++++++++++++++++++++
>  src/openvpn/options_util.h           |  33 +++++++++
>  src/openvpn/push.c                   |  11 ++-
>  src/openvpn/ssl.c                    |  13 ++--
>  src/openvpn/ssl.h                    |   3 +
>  tests/unit_tests/openvpn/Makefile.am |   1 +
>  tests/unit_tests/openvpn/test_misc.c |  49 +++++++++++++
>  13 files changed, 266 insertions(+), 8 deletions(-)
>  create mode 100644 src/openvpn/options_util.c
>  create mode 100644 src/openvpn/options_util.h
> 
> diff --git a/doc/man-sections/script-options.rst

This is more related to 4/4 and should go there for code archaeology reasons.

> +    /* the server can suggest a backoff time to the client, it
> +     * will still be capped by the max timeout between connections
> +     * (300s by default) */
> +    int server_backoff_time;

This should be (parsed as) an unsigned value. Negative backup requires too 
advanced physics. ;-)

> +const char *
> +parse_auth_failed_temp(struct options *o, const struct buffer *buf)
> +{
> +    struct gc_arena gc = gc_new();
> +    char *m = string_alloc(BSTR(buf), &gc);
> +    /* skip TEMP */
> +    m += strlen("TEMP");
> +    const char *message = BSTR(buf) + 4;

I think if we string_alloc(BSTR(buf) + 4, ...) it's prettier. We have the 
magic number 4 for message anyway, and it's not so magic if we keep the 
comment around.

Generally I wanted to comment on the alloc only for reasons of \0 terminating 
to options, but The code is not prettier if it is changed and performance if 
not the issue here, so no comment (technically).

> \ No newline at end of file

That.

> +++ b/src/openvpn/options_util.h
> \ No newline at end of file

Again

> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index 1c4e637e4..3b3dce642 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -51,7 +52,6 @@ void
>  receive_auth_failed(struct context *c, const struct buffer *buffer)
>  {
>      msg(M_VERB0, "AUTH: Received control message: %s", BSTR(buffer));
> -    c->options.no_advance = true;
> 
>      if (!c->options.pull)
>      {

I think we want to keep this as the default. If I read the code correctly, at 
the moment the default behavior is "advance addr" if none is given, which feel 
wrong to me, given what I have read about the feature.





