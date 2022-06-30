Message-ID: <97c385c8-c708-05bb-b989-5fbba4ab721f@...2080...>
Date: Thu, 30 Jun 2022 23:06:39 +0200
MIME-Version: 1.0
Content-Language: en-GB
References: <20220520213250.3126372-1-arne@...1227...>
 <20220520213250.3126372-4-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
In-Reply-To: <20220520213250.3126372-4-arne@...1227...>
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

On 20/05/2022 23:32, Arne Schwabe wrote:
> This allows a server to indicate a temporary problem on the server and
> allows the server to indicate how to proceed (i.e. move to the next server,
> retry the same server, wait a certain time,...)
> 
> This adds options_utils.c/h to be able to unit test the new function.
> 
> Patch v2: Improve documentation, format man page better, comment that
>            protocol-flags is not a user usable option.
> ---
>   doc/man-sections/script-options.rst  |  36 ++++++++++
>   src/openvpn/Makefile.am              |   1 +
>   src/openvpn/init.c                   |   9 ++-
>   src/openvpn/openvpn.vcxproj          |   2 +
>   src/openvpn/openvpn.vcxproj.filters  |   3 +20220520213250.3126372-4-arne@...1227...
>   src/openvpn/options.h                |   9 ++-
>   src/openvpn/options_util.c           | 104 +++++++++++++++++++++++++++
>   src/openvpn/options_util.h           |  33 +++++++++
>   src/openvpn/push.c                   |  11 ++-
>   src/openvpn/ssl.c                    |  13 ++--
>   src/openvpn/ssl.h                    |   3 +
>   tests/unit_tests/openvpn/Makefile.am |   1 +
>   tests/unit_tests/openvpn/test_misc.c |  49 +++++++++++++
>   13 files changed, 266 insertions(+), 8 deletions(-)
>   create mode 100644 src/openvpn/options_util.c
>   create mode 100644 src/openvpn/options_util.h
> 

[...snip...]

> diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
> index 577294804..a619aac38 100644
> --- a/src/openvpn/Makefile.am
> +++ b/src/openvpn/Makefile.am
> @@ -95,6 +95,7 @@ openvpn_SOURCES = \
>   	pkcs11_mbedtls.c \
>   	openvpn.c openvpn.h \
>   	options.c options.h \
> +    options_util.c options_util.h \

Indent mismatch.  Makefile.am uses tabs ... because traditional Make 
needed it.  Since the rest of our Makefile.am files uses tabs, we 
continue with that for now.

[...snip...]

> diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
> new file mode 100644
> index 000000000..d8a7e2343
> --- /dev/null
> +++ b/src/openvpn/options_util.c
> @@ -0,0 +1,104 @@
> +/*
> + *  OpenVPN -- An application to securely tunnel IP networks
> + *             over a single TCP/UDP port, with support for SSL/TLS-based
> + *             session authentication and key exchange,
> + *             packet encryption, packet authentication, and
> + *             packet compression.
> + *
> + *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
> + *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>
                                ^^^^^^^^^^^^^^
Does any of the code in this file come from Fox at all?  If not, you 
could probably consider removing that last line.

[...snip...]

> +const char *
> +parse_auth_failed_temp(struct options *o, const struct buffer *buf)
> +{

The code here looks nice and clean; unit tests runs fine as well.

> diff --git a/src/openvpn/options_util.h b/src/openvpn/options_util.h
> new file mode 100644
> index 000000000..9785bb239
> --- /dev/null
> +++ b/src/openvpn/options_util.h
> @@ -0,0 +1,33 @@
> +/*
> + *  OpenVPN -- An application to securely tunnel IP networks
> + *             over a single TCP/UDP port, with support for SSL/TLS-based
> + *             session authentication and key exchange,
> + *             packet encryption, packet authentication, and
> + *             packet compression.
> + *
> + *  Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>
> + *  Copyright (C) 2010-2021 Fox Crypto B.V. <openvpn@...2507...>

Same copyright note as for the options_util.c.

[...snip...]

> --- a/src/openvpn/ssl.h
> +++ b/src/openvpn/ssl.h
> @@ -93,6 +93,9 @@
>    * result. */
>   #define IV_PROTO_NCP_P2P         (1<<5)
>   
> +/** Support for AUTH_FAIL,TEMP messages */
> +#define IV_PROTO_AUTH_FAIL_TEMP  (1<<6)
> +

This conflicts with IV_PROTO_DNS_OPTION which has already been merged to 
git master.

[...snip...]

I've not yet tested this code in a functional test; it compiles fine 
without warnings and unit tests runs fine.  Since some minor changes are 
need, I just wanted to get this feedback sent before I run some more 
testing.

One thing I spotted, and I'm not sure if it's my Thunderbird fooling me 
or what it is ... there were spurious indenting "errors" here and there. 
  But the patch I pulled down directly from Patchwork had no such issues 
at all.  I'll check that more carefully on my end.  One issue I know is 
real I've commented here already.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


