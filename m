MIME-Version: 1.0
In-Reply-To: <1528020718-12721-3-git-send-email-steffan@...1856...>
References: <1528020718-12721-1-git-send-email-steffan@...1856...>
 <1528020718-12721-3-git-send-email-steffan@...1856...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 3 Jun 2018 11:51:43 -0400
Message-ID: <CAKuzo_gTP27vWqV7Uyh0ig+5Sy_Kcs8mnuc-TWZnPODY7R1pUQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] Print a --verb 1 warning when a
 connection uses compression
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Sun, Jun 3, 2018 at 6:11 AM, Steffan Karger <steffan@...1856...> wrote:
> Can be suppressed by adding a "nowarn" flag to the compress options, for
> those that are really sure that compression is fine for their use case.
>
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
> This patch is also meant to discuss how far we want to go in warning
> users about using compression.  I think this approach is reasonable,
> but I'm not sure everyone agrees.
>
>  doc/openvpn.8      | 11 +++++++++--
>  src/openvpn/comp.c | 14 ++++++++++++++
>  src/openvpn/comp.h |  1 +
>  3 files changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 9e988b3..21a3c42 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -2500,12 +2500,13 @@ consecutive messages in the same category.  This is useful to
>  limit repetitive logging of similar message types.
>  .\"*********************************************************
>  .TP
> -.B \-\-compress [algorithm]
> +.B \-\-compress [algorithm] ["nowarn"]
>  Enable a compression algorithm.
>
>  The
>  .B algorithm
> -parameter may be empty, "stub", "stub-v2", "lzo", "lz4", or "lz4-v2".
> +parameter may be empty, "any", "stub", "stub-v2", "lzo", "lz4", or "lz4-v2".
> +If left empty, OpenVPN defaults to "any".
>
>  LZO and LZ4 are different compression algorithms, with LZ4 generally offering
>  the best performance with least CPU usage.  For backwards compatibility with
> @@ -2532,6 +2533,12 @@ e.g. the CRIME and BREACH attacks on TLS which also leverage compression to
>  break encryption.  If you are not entirely sure that the above does not apply
>  to your traffic, you are advised to *not* enable compression.
>
> +If you have carefully considered the above, and are sure that using compression
> +is safe for your use case, you can add
> +.B "nowarn"
> +as the second parameter to suppress warnings about the risk of enabling
> +compression.
> +
>  .\"*********************************************************
>  .TP
>  .B \-\-comp\-lzo [mode]
> diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
> index a945913..a34e64a 100644
> --- a/src/openvpn/comp.c
> +++ b/src/openvpn/comp.c
> @@ -40,6 +40,20 @@
>  struct compress_context *
>  comp_init(const struct compress_options *opt)
>  {
> +    switch (opt->alg)
> +    {
> +        case COMP_ALG_UNDEF:
> +        case COMP_ALG_STUB:
> +        case COMP_ALGV2_UNCOMPRESSED:
> +            break;
> +        default:
> +            if (!(opt->flags & COMP_F_NOWARN))
> +            {
> +                msg(M_INFO, "WARNING: Compression enabled, might be insure. "

May I suggest to change that to M_INFO|M_WARN so that it gets the
warning tag "W" that could be parsed by UI's. OpenVPN Windows GUI we
like to highlight (in colour) warnings and errors and this will slip
through as a info message.

Ideally we should redefine M_WARN as M_WARN + verb1 or make a
M_WARN_GENERIC that prints only in verb 1 and use it everywhere, but
that is a different topic.

Selva

