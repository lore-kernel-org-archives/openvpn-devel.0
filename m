Message-ID: <48b9c5cc-12ac-10c4-b18b-18cc58afd179@...2080...>
Date: Wed, 9 Feb 2022 23:40:22 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20211209171138.8589-1-frank@...2641...>
 <20211209171138.8589-2-frank@...2641...>
From: David Sommerseth <openvpn@...2080...>
In-Reply-To: <20211209171138.8589-2-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH 2/3] doc: fix misc documentation issues
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
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

On 09/12/2021 18:11, Frank Lichtenheld wrote:
> - Broken/missing formatting
> - Make it obvious which arguments are optional
> - In some cases moved the "Valid syntax" block
>    earlier to make sure the text references argument
>    names after they have been declared.
> 
> Only the files touched have been reviewed, all other
> files likely have similar issues.
> 
> Signed-off-by: Frank Lichtenheld <frank@...2641...>
> ---
>   doc/man-sections/client-options.rst   | 15 +++++------
>   doc/man-sections/generic-options.rst  | 35 +++++++++++++++---------
>   doc/man-sections/link-options.rst     | 38 +++++++++++++++++----------
>   doc/man-sections/protocol-options.rst |  2 +-
>   src/openvpn/options.c                 |  2 +-
>   5 files changed, 56 insertions(+), 36 deletions(-)
> 
> diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
> index c5b7ad96..3c0bce4b 100644
> --- a/doc/man-sections/client-options.rst
> +++ b/doc/man-sections/client-options.rst
> @@ -175,17 +175,16 @@ configuration.
>     enabled.
>   
>   --inactive args
> +  Valid syntaxes::
> +
> +       inactive n
> +       inactive n bytes
> +
>     Causes OpenVPN to exit after ``n`` seconds of inactivity on the TUN/TAP
>     device. The time length of inactivity is measured since the last
>     incoming or outgoing tunnel packet. The default value is 0 seconds,
>     which disables this feature.
>   
> -  Valid syntaxes:
> -  ::
> -
> -       inactive n
> -       inactive n bytes
> -

I'm not sure this change is a clever move.  In particular the HTML 
rendering might in some cases put the option and argument in the same 
line as the "Valid syntax" line - which looks odd.

This is why I initially put the "Valid syntax" block below a short 
introduction to what this option is about.  This option intro should in 
theory be as short and concise as possible and should ideally not exceed 
2-3 lines.  With this approach, the HTML rendering and groff rendering 
is fairly recognisable.

>     If the optional ``bytes`` parameter is included, exit if less than
>     ``bytes`` of combined in/out traffic are produced on the tun/tap device
>     in ``n`` seconds.
> @@ -329,7 +328,7 @@ configuration.
>     If hostname resolve fails for ``--remote``, retry resolve for ``n``
>     seconds before failing.
>   
> -  Set ``n`` to "infinite" to retry indefinitely.
> +  Set ``n`` to :code:`infinite` to retry indefinitely.

Changes like this are good, and that improves the HTML rendering as well 
(and we can make it even better with a better CSS included).

[...snip...]

> @@ -166,6 +171,8 @@ which mode OpenVPN is configured as.
>     renegotiation (and reauthentication) occurs.
>   
>   --disable-occ
> +  Disable "options consistency check" (OCC).
> +

This is good!

[...snip...]

> @@ -106,6 +108,11 @@ the local and the remote host.
>     implements a multi-client server capability.
>   
>   --mssfix max
> +  Valid syntaxes::
> +
> +    mssfix
> +    mssfix max
> +

This section actually has a conflict with latest git master.

[...snip...]

> @@ -291,18 +300,19 @@ the local and the remote host.
>   --replay-window args
>     Modify the replay protection sliding-window size and time window.
>   
> -  Valid syntax:
> -  ::
> +  Valid syntaxes::
>   
> -     replay-window n [t]
> +     replay-window n
> +     replay-window n t

This is reasonable, might be clearer this way.

> -  Use a replay protection sliding-window of size **n** and a time window
> -  of **t** seconds.
> +  Use a replay protection sliding-window of size ``n`` and a time window
> +  of ``t`` seconds.
>   
> -  By default **n** is 64 (the IPSec default) and **t** is 15 seconds.
> +  By default ``n`` is :code:`64` (the IPSec default) and ``t`` is
> +  :code:`15` seconds.
>   
> -  This option is only relevant in UDP mode, i.e. when either **--proto
> -  udp** is specified, or no **--proto** option is specified.
> +  This option is only relevant in UDP mode, i.e. when either ``--proto
> +  udp`` is specified, or no ``--proto`` option is specified.
>   
>     When OpenVPN tunnels IP packets over UDP, there is the possibility that
>     packets might be dropped or delivered out of order. Because OpenVPN,
> diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
> index 1c6b1200..b3edc499 100644
> --- a/doc/man-sections/protocol-options.rst
> +++ b/doc/man-sections/protocol-options.rst
> @@ -125,7 +125,7 @@ configured in a compatible way between both the local and remote side.
>     configuration if supported by the client and otherwise switch to ``comp-lzo no``
>     and add ``--push comp-lzo`` to the client specific configuration.
>   
> -  ***Security Considerations***
> +  **Security Considerations**

This is a more a style/cosmetic change.  The idea with *** was to 
actually have the star-wrapping visible in the rendering.  This was done 
a few places where trying to highlight this even better was the 
intension.  This should not be found many places though, and typically 
related to security challenges.

>   
>     Compression and encryption is a tricky combination. If an attacker knows
>     or is able to control (parts of) the plain-text of packets that contain
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index ac13412a..c1ec7ed0 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -343,7 +343,7 @@ static const char usage_message[] =
>       "                       and received from TCP/UDP (caps) or tun/tap (lc)\n"
>       "                : 6 to 11 -- debug messages of increasing verbosity\n"
>       "--mute n        : Log at most n consecutive messages in the same category.\n"
> -    "--status file n : Write operational status to file every n seconds.\n"
> +    "--status file [n] : Write operational status to file every n seconds.\n"

This is also good!


I've not commented all changes, just the generic ideas of changes here. 
There are lots of good things here, and most of it makes sense.  I'd 
just be very careful moving the "Valid syntax" blocks around.

If we just want security warnings in plain bold or wrapped in '*' is 
more a design/layout detail.  I would suggest that we try to find better 
ways to highlight these security related aspects in a clear and visible 
way though.  It doesn't mean it need to stay as it is today, though. 
The current approach was more or less a "this can work" approach.


-- 
kind regards,

David Sommerseth
OpenVPN Inc


