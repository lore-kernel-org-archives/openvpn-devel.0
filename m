MIME-Version: 1.0
In-Reply-To: <20170505184622.24520-1-davids@...515...>
References: <20170505184622.24520-1-davids@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 9 May 2017 10:58:45 -0400
Message-ID: <CAKuzo_gET_fP-KpGq+QgSE8QCXNKAxwzEAZTSPsfu7Crws8d-g@...278...>
Content-Type: multipart/alternative; boundary=001a1146fe62e128f8054f189886
Subject: Re: [Openvpn-devel] [PATCH] plugin: Export secure_memzero() to
	plug-ins
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1146fe62e128f8054f189886
Content-Type: text/plain; charset=UTF-8

Hi,

On Fri, May 5, 2017 at 2:46 PM, David Sommerseth <davids@...515...> wrote:

> The provides plug-ins with a safe and secure way to santize sensitive
> information such as passwords, by re-using the secure_memzero()
> implementation in OpenVPN.
>
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>  include/openvpn-plugin.h.in | 25 ++++++++++++++++++++++---
>  src/openvpn/plugin.c        |  3 ++-
>  2 files changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
> index 0b303520..ec83f3a6 100644
> --- a/include/openvpn-plugin.h.in
> +++ b/include/openvpn-plugin.h.in
> @@ -199,7 +199,8 @@ struct openvpn_plugin_string_list
>
>  /* openvpn_plugin_{open,func}_v3() related structs */
>
> -/* Defines version of the v3 plugin argument structs
> +/**
> + * Defines version of the v3 plugin argument structs
>   *
>   * Whenever one or more of these structs are modified, this constant
>   * must be updated.  A changelog should be appended in this comment
> @@ -218,8 +219,10 @@ struct openvpn_plugin_string_list
>   *    3      Added ovpn_version, ovpn_version_major, ovpn_version_minor
>   *           and ovpn_version_patch to provide the runtime version of
>   *           OpenVPN to plug-ins.
> + *
> + *    4      Exported secure_memzero() as plugin_secure_memzero()
>   */
> -#define OPENVPN_PLUGINv3_STRUCTVER 3
> +#define OPENVPN_PLUGINv3_STRUCTVER 4
>
>  /**
>   * Definitions needed for the plug-in callback functions.
> @@ -255,10 +258,19 @@ typedef void (*plugin_vlog_t)(openvpn_plugin_log_flags_t
> flags,
>                                const char *plugin_name,
>                                const char *format,
>                                va_list arglist) _ovpn_chk_fmt (3, 0);
> -
>  #undef _ovpn_chk_fmt
>
>  /**
> + *  Export of secure_memzero() to be used inside plug-ins
> + *
> + *  @param data   Pointer to data to zeroise
> + *  @param len    Length of data, in bytes
> + *
> + */
> +typedef void (*plugin_secure_memzero_t)(void *data, size_t len);
> +
> +
> +/**
>   * Used by the openvpn_plugin_open_v3() function to pass callback
>   * function pointers to the plug-in.
>   *
> @@ -267,11 +279,18 @@ typedef void (*plugin_vlog_t)(openvpn_plugin_log_flags_t
> flags,
>   *               Messages will only be displayed if the plugin_name
> parameter
>   *               is set. PLOG_DEBUG messages will only be displayed with
> plug-in
>   *               debug log verbosity (at the time of writing that's verb
> >= 7).
> + *
> + * plugin_secure_memzero
> + *             : Use this function to securely wipe sensitive information
> from
> + *               memory.  This function is declared in a way that the
> compiler
> + *               will not remove these function calls during the compiler
> + *               optimization phase.
>   */
>  struct openvpn_plugin_callbacks
>  {
>      plugin_log_t plugin_log;
>      plugin_vlog_t plugin_vlog;
> +    plugin_secure_memzero_t plugin_secure_memzero;
>  };
>
>  /**
> diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
> index 05cbae3e..a652d528 100644
> --- a/src/openvpn/plugin.c
> +++ b/src/openvpn/plugin.c
> @@ -410,7 +410,8 @@ plugin_log(openvpn_plugin_log_flags_t flags, const
> char *name, const char *forma
>
>  static struct openvpn_plugin_callbacks callbacks = {
>      plugin_log,
> -    plugin_vlog
> +    plugin_vlog,
> +    secure_memzero   /* plugin_secure_memzero */
>  };


This avoids code duplication in the plugin and works as expected.

ACK.

Selva

--001a1146fe62e128f8054f189886
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div><div class=3D"gmail_extra"><br><div class=3D"g=
mail_quote">On Fri, May 5, 2017 at 2:46 PM, David Sommerseth <span dir=3D"l=
tr">&lt;<a href=3D"mailto:davids@...515..." target=3D"_blank">davids@...2146...=
...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">The provides pl=
ug-ins with a safe and secure way to santize sensitive<br>
information such as passwords, by re-using the secure_memzero()<br>
implementation in OpenVPN.<br>
<br>
Signed-off-by: David Sommerseth &lt;<a href=3D"mailto:davids@...515...">dav=
ids@...515...</a>&gt;<br>
---<br>
=C2=A0include/<a href=3D"http://openvpn-plugin.h.in" rel=3D"noreferrer" tar=
get=3D"_blank">openvpn-plugin.h.in</a> | 25 ++++++++++++++++++++++---<br>
=C2=A0src/openvpn/plugin.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 3 ++-<br>
=C2=A02 files changed, 24 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/include/<a href=3D"http://openvpn-plugin.h.in" rel=3D"noreferr=
er" target=3D"_blank">openvpn-plugin.h.in</a> b/include/<a href=3D"http://o=
penvpn-plugin.h.in" rel=3D"noreferrer" target=3D"_blank">openvpn-plugin.h.i=
n</a><br>
index 0b303520..ec83f3a6 100644<br>
--- a/include/<a href=3D"http://openvpn-plugin.h.in" rel=3D"noreferrer" tar=
get=3D"_blank">openvpn-plugin.h.in</a><br>
+++ b/include/<a href=3D"http://openvpn-plugin.h.in" rel=3D"noreferrer" tar=
get=3D"_blank">openvpn-plugin.h.in</a><br>
@@ -199,7 +199,8 @@ struct openvpn_plugin_string_list<br>
<br>
=C2=A0/* openvpn_plugin_{open,func}_v3(<wbr>) related structs */<br>
<br>
-/* Defines version of the v3 plugin argument structs<br>
+/**<br>
+ * Defines version of the v3 plugin argument structs<br>
=C2=A0 *<br>
=C2=A0 * Whenever one or more of these structs are modified, this constant<=
br>
=C2=A0 * must be updated.=C2=A0 A changelog should be appended in this comm=
ent<br>
@@ -218,8 +219,10 @@ struct openvpn_plugin_string_list<br>
=C2=A0 *=C2=A0 =C2=A0 3=C2=A0 =C2=A0 =C2=A0 Added ovpn_version, ovpn_versio=
n_major, ovpn_version_minor<br>
=C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0and ovpn_version_patch to =
provide the runtime version of<br>
=C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0OpenVPN to plug-ins.<br>
+ *<br>
+ *=C2=A0 =C2=A0 4=C2=A0 =C2=A0 =C2=A0 Exported secure_memzero() as plugin_=
secure_memzero()<br>
=C2=A0 */<br>
-#define OPENVPN_PLUGINv3_STRUCTVER 3<br>
+#define OPENVPN_PLUGINv3_STRUCTVER 4<br>
<br>
=C2=A0/**<br>
=C2=A0 * Definitions needed for the plug-in callback functions.<br>
@@ -255,10 +258,19 @@ typedef void (*plugin_vlog_t)(openvpn_<wbr>plugin_log=
_flags_t flags,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *plugin_name,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *format,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0va_list arglist) _ovpn_chk_fmt (3, 0)=
;<br>
-<br>
=C2=A0#undef _ovpn_chk_fmt<br>
<br>
=C2=A0/**<br>
+ *=C2=A0 Export of secure_memzero() to be used inside plug-ins<br>
+ *<br>
+ *=C2=A0 @param data=C2=A0 =C2=A0Pointer to data to zeroise<br>
+ *=C2=A0 @param len=C2=A0 =C2=A0 Length of data, in bytes<br>
+ *<br>
+ */<br>
+typedef void (*plugin_secure_memzero_t)(<wbr>void *data, size_t len);<br>
+<br>
+<br>
+/**<br>
=C2=A0 * Used by the openvpn_plugin_open_v3() function to pass callback<br>
=C2=A0 * function pointers to the plug-in.<br>
=C2=A0 *<br>
@@ -267,11 +279,18 @@ typedef void (*plugin_vlog_t)(openvpn_<wbr>plugin_log=
_flags_t flags,<br>
=C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Messages wil=
l only be displayed if the plugin_name parameter<br>
=C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0is set. PLOG=
_DEBUG messages will only be displayed with plug-in<br>
=C2=A0 *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0debug log ve=
rbosity (at the time of writing that&#39;s verb &gt;=3D 7).<br>
+ *<br>
+ * plugin_secure_memzero<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: Use this function to s=
ecurely wipe sensitive information from<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memory.=C2=A0 Thi=
s function is declared in a way that the compiler<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0will not remove t=
hese function calls during the compiler<br>
+ *=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0optimization phas=
e.<br>
=C2=A0 */<br>
=C2=A0struct openvpn_plugin_callbacks<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0plugin_log_t plugin_log;<br>
=C2=A0 =C2=A0 =C2=A0plugin_vlog_t plugin_vlog;<br>
+=C2=A0 =C2=A0 plugin_secure_memzero_t plugin_secure_memzero;<br>
=C2=A0};<br>
<br>
=C2=A0/**<br>
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c<br>
index 05cbae3e..a652d528 100644<br>
--- a/src/openvpn/plugin.c<br>
+++ b/src/openvpn/plugin.c<br>
@@ -410,7 +410,8 @@ plugin_log(openvpn_plugin_log_<wbr>flags_t flags, const=
 char *name, const char *forma<br>
<br>
=C2=A0static struct openvpn_plugin_callbacks callbacks =3D {<br>
=C2=A0 =C2=A0 =C2=A0plugin_log,<br>
-=C2=A0 =C2=A0 plugin_vlog<br>
+=C2=A0 =C2=A0 plugin_vlog,<br>
+=C2=A0 =C2=A0 secure_memzero=C2=A0 =C2=A0/* plugin_secure_memzero */<br>
=C2=A0};<span class=3D"HOEnZb"><font color=3D"#888888"></font></span></bloc=
kquote><div><br></div><div>This avoids code duplication in the plugin and w=
orks as expected.<br><br></div><div>ACK.<br><br></div><div>Selva<br></div><=
/div></div></div></div>

--001a1146fe62e128f8054f189886--

