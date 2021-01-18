MIME-Version: 1.0
References: <20210118121529.16579-1-gert@...1296...>
 <20210118162850.24214-1-gert@...1296...>
In-Reply-To: <20210118162850.24214-1-gert@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 18 Jan 2021 14:30:03 -0500
Message-ID: <CAKuzo_idykBPWX5w3jtJM1A7KgMw+tibLiUP+rPK5vwM_awBSA@...278...>
Subject: Re: [Openvpn-devel] [PATCH v3] Document common uses of 'echo'
 directive, re-enable logging for 'echo'.
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
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi.

Looks good to me.

The white- "space police" may object to the formatting in the logging
code (see below). Could be fixed at commit time.

On Mon, Jan 18, 2021 at 11:31 AM Gert Doering <gert@...1296...> wrote:
>
> The 'echo' command can be used to signal information to an OpenVPN
> GUI driving the openvpn core via management interface.  Which commands
> exists and their syntax has so far been mostly undocumented.
>
> Condense the long and good discussion between Selva Nair and
> Jonathan K. Bullard into doc/gui-notes.txt (initial draft from
> Jonathan, comments from Selva and Arne), with a pointer added
> to doc/management-notes.txt.
>
> See:
>
> https://sourceforge.net/p/openvpn/mailman/openvpn-users/thread/CAEsd45T%2Bd6FUJ9Po0KHwtHjfuL9Q2D-poG8yFtY45Qyh%2BtHjkg%40mail.gmail.com/#msg36136236
>
> and
>
> https://sourceforge.net/p/openvpn/mailman/openvpn-devel/thread/CAKuzo_jPThhvXTJAtzhqVUVOLPW1VGu6h2jQhVsHicY8P2WRqA%40mail.gmail.com/#msg36141193
>
> for the details.
>
> Re-enable logging of 'echo' statements, but only for the particular
> class of messages starting with 'echo msg...'.
>
> v2:
>   incorporate feedback from Selva Nair, correct >ECHO examples
>
> v3:
>   add "msg*" support status for Windows GUI (11.22.0) and Android (Planned)
>
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  doc/Makefile.am          |   2 +-
>  doc/gui-notes.txt        | 370 +++++++++++++++++++++++++++++++++++++++
>  doc/management-notes.txt |  10 ++
>  src/openvpn/options.c    |  15 +-
>  4 files changed, 389 insertions(+), 8 deletions(-)
>  create mode 100644 doc/gui-notes.txt
>
> diff --git a/doc/Makefile.am b/doc/Makefile.am
> index df2f54a3..e411f5f9 100644
> --- a/doc/Makefile.am
> +++ b/doc/Makefile.am
> @@ -15,7 +15,7 @@ MAINTAINERCLEANFILES = \
>  SUBDIRS = doxygen
>
>  dist_doc_DATA = \
> -       management-notes.txt
> +       management-notes.txt gui-notes.txt
>
>  dist_noinst_DATA = \
>         README.plugins interactive-service-notes.rst \
> diff --git a/doc/gui-notes.txt b/doc/gui-notes.txt
> new file mode 100644
> index 00000000..08270f07
> --- /dev/null
> +++ b/doc/gui-notes.txt
> @@ -0,0 +1,370 @@
> +Management Interface "echo" protocol
> +
>

snipped...

+COMMAND -- setenv
+-----------------
+
+Syntax: setenv name value
+
+Sets an environment variable that will be available to the scripts run
+by the GUI.
+
+This will set environment variable "OPENVPN_name" to value "value" for
+the scripts run by the GUI. "name" is changed to "OPENVPN_name" to
+prevent overwriting sensitive variables such as PATH. Variables are
+set in the order received, with later values replacing earlier ones
+for the same "name".
+
+Names may include only alphanumeric characters and underscores. A
+"setenv" command with an invalid name will be ignored.
+
+    Android: ??????
+
+    Tunnelblick: Planned.
+
+    Windows OpenVPN GUI: supported since release v2.4.7 (GUI version v11.12.0)
+The variables set by "setenv" are merged with those for the process
+environment.  In case of duplicate names the one in the setenv list is
+chosen.
+

The extra blank line at the end of file is unnecessary (whitespace
error according to git).

> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index ff3954d5..36009f4f 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -5306,13 +5306,14 @@ add_option(struct options *options,
>          }
>          if (good)
>          {
> -#if 0
> -            /* removed for now since ECHO can potentially include
> -             * security-sensitive strings */
> -            msg(M_INFO, "%s:%s",
> -                pull_mode ? "ECHO-PULL" : "ECHO",
> -                BSTR(&string));
> -#endif
> +            /* only message-related ECHO are logged, since other ECHOs
> +             * can potentially include security-sensitive strings */
> +            if (strncmp(p[1],"msg",3) == 0)

Missing space between function arguments.

> +            {
> +                msg(M_INFO, "%s:%s",
> +                    pull_mode ? "ECHO-PULL" : "ECHO",
> +                    BSTR(&string));
> +            }
>  #ifdef ENABLE_MANAGEMENT
>              if (management)
>              {
> --
> 2.26.2

I have only compile tested as the code change looks sane and simple.

Acked by: selva.nair@...277...

Thanks,

Selva

