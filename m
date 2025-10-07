From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 7 Oct 2025 20:12:18 +0000
In-Reply-To: <gerrit.1759239739000.I18e38862df1318740928c6cfa21dc4dcd7d44b89@...2715...>
References: <gerrit.1759239739000.I18e38862df1318740928c6cfa21dc4dcd7d44b89@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a036dd9c04a5e155ebe59739e921bf0a15e7df9d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fqIn/R+vi5U="; charset=UTF-8
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: options: Factor out
 parsing code to separate options_parse.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--fqIn/R+vi5U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
42?usp=3Demail )

Change subject: options: Factor out parsing code to separate options_parse.c
......................................................................

options: Factor out parsing code to separate options_parse.c

For easier testability. And because everything that
reduces the length of that file in a sensible manner
is a good idea.

Change-Id: I18e38862df1318740928c6cfa21dc4dcd7d44b89
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1242
Message-Id: <20251007185110.19267-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59243506/
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
M src/openvpn/Makefile.am
M src/openvpn/common.h
M src/openvpn/options.c
M src/openvpn/options.h
A src/openvpn/options_parse.c
6 files changed, 669 insertions(+), 622 deletions(-)




diff --git a/CMakeLists.txt b/CMakeLists.txt
index 3f6196f..be66357 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -513,6 +513,7 @@
     src/openvpn/options.h
     src/openvpn/options_util.c
     src/openvpn/options_util.h
+    src/openvpn/options_parse.c
     src/openvpn/otime.c
     src/openvpn/otime.h
     src/openvpn/ovpn_dco_win.h
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 1247f11..e44fb2b 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -109,6 +109,7 @@
 	openvpn.c openvpn.h \
 	options.c options.h \
 	options_util.c options_util.h \
+	options_parse.c \
 	otime.c otime.h \
 	packet_id.c packet_id.h \
 	perf.c perf.h \
diff --git a/src/openvpn/common.h b/src/openvpn/common.h
index c0947da..7779614 100644
--- a/src/openvpn/common.h
+++ b/src/openvpn/common.h
@@ -23,6 +23,8 @@
 #ifndef COMMON_H
 #define COMMON_H

+#include <stdint.h>
+
 /*
  * Statistics counters and associated printf format.
  */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f35738d..f2e6dec 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4838,7 +4838,7 @@
 /*
  * Print the help message.
  */
-static void
+void
 usage(void)
 {
     FILE *fp =3D msg_fp(0);
@@ -4967,581 +4967,6 @@
 }
 #endif

-static inline bool
-space(char c)
-{
-    return c =3D=3D '\0' || isspace(c);
-}
-
-int
-parse_line(const char *line, char *p[], const int n, const char *file, con=
st int line_num,
-           msglvl_t msglevel, struct gc_arena *gc)
-{
-    const int STATE_INITIAL =3D 0;
-    const int STATE_READING_QUOTED_PARM =3D 1;
-    const int STATE_READING_UNQUOTED_PARM =3D 2;
-    const int STATE_DONE =3D 3;
-    const int STATE_READING_SQUOTED_PARM =3D 4;
-
-    const char *error_prefix =3D "";
-
-    int ret =3D 0;
-    const char *c =3D line;
-    int state =3D STATE_INITIAL;
-    bool backslash =3D false;
-    char in, out;
-
-    char parm[OPTION_PARM_SIZE];
-    unsigned int parm_len =3D 0;
-
-    msglevel &=3D ~M_OPTERR;
-
-    if (msglevel & M_MSG_VIRT_OUT)
-    {
-        error_prefix =3D "ERROR: ";
-    }
-
-    do
-    {
-        in =3D *c;
-        out =3D 0;
-
-        if (!backslash && in =3D=3D '\\' && state !=3D STATE_READING_SQUOT=
ED_PARM)
-        {
-            backslash =3D true;
-        }
-        else
-        {
-            if (state =3D=3D STATE_INITIAL)
-            {
-                if (!space(in))
-                {
-                    if (in =3D=3D ';' || in =3D=3D '#') /* comment */
-                    {
-                        break;
-                    }
-                    if (!backslash && in =3D=3D '\"')
-                    {
-                        state =3D STATE_READING_QUOTED_PARM;
-                    }
-                    else if (!backslash && in =3D=3D '\'')
-                    {
-                        state =3D STATE_READING_SQUOTED_PARM;
-                    }
-                    else
-                    {
-                        out =3D in;
-                        state =3D STATE_READING_UNQUOTED_PARM;
-                    }
-                }
-            }
-            else if (state =3D=3D STATE_READING_UNQUOTED_PARM)
-            {
-                if (!backslash && space(in))
-                {
-                    state =3D STATE_DONE;
-                }
-                else
-                {
-                    out =3D in;
-                }
-            }
-            else if (state =3D=3D STATE_READING_QUOTED_PARM)
-            {
-                if (!backslash && in =3D=3D '\"')
-                {
-                    state =3D STATE_DONE;
-                }
-                else
-                {
-                    out =3D in;
-                }
-            }
-            else if (state =3D=3D STATE_READING_SQUOTED_PARM)
-            {
-                if (in =3D=3D '\'')
-                {
-                    state =3D STATE_DONE;
-                }
-                else
-                {
-                    out =3D in;
-                }
-            }
-            if (state =3D=3D STATE_DONE)
-            {
-                /* ASSERT (parm_len > 0); */
-                p[ret] =3D gc_malloc(parm_len + 1, true, gc);
-                memcpy(p[ret], parm, parm_len);
-                p[ret][parm_len] =3D '\0';
-                state =3D STATE_INITIAL;
-                parm_len =3D 0;
-                ++ret;
-            }
-
-            if (backslash && out)
-            {
-                if (!(out =3D=3D '\\' || out =3D=3D '\"' || space(out)))
-                {
-#ifdef ENABLE_SMALL
-                    msg(msglevel, "%sOptions warning: Bad backslash ('\\')=
 usage in %s:%d",
-                        error_prefix, file, line_num);
-#else
-                    msg(msglevel,
-                        "%sOptions warning: Bad backslash ('\\') usage in =
%s:%d: remember that backslashes are treated as shell-escapes and if you ne=
ed to pass backslash characters as part of a Windows filename, you should u=
se double backslashes such as \"c:\\\\" PACKAGE
-                        "\\\\static.key\"",
-                        error_prefix, file, line_num);
-#endif
-                    return 0;
-                }
-            }
-            backslash =3D false;
-        }
-
-        /* store parameter character */
-        if (out)
-        {
-            if (parm_len >=3D SIZE(parm))
-            {
-                parm[SIZE(parm) - 1] =3D 0;
-                msg(msglevel, "%sOptions error: Parameter at %s:%d is too =
long (%d chars max): %s",
-                    error_prefix, file, line_num, (int)SIZE(parm), parm);
-                return 0;
-            }
-            parm[parm_len++] =3D out;
-        }
-
-        /* avoid overflow if too many parms in one config file line */
-        if (ret >=3D n)
-        {
-            break;
-        }
-
-    } while (*c++ !=3D '\0');
-
-    if (state =3D=3D STATE_READING_QUOTED_PARM)
-    {
-        msg(msglevel, "%sOptions error: No closing quotation (\") in %s:%d=
", error_prefix, file,
-            line_num);
-        return 0;
-    }
-    if (state =3D=3D STATE_READING_SQUOTED_PARM)
-    {
-        msg(msglevel, "%sOptions error: No closing single quotation (\') i=
n %s:%d", error_prefix,
-            file, line_num);
-        return 0;
-    }
-    if (state !=3D STATE_INITIAL)
-    {
-        msg(msglevel, "%sOptions error: Residual parse state (%d) in %s:%d=
", error_prefix, state,
-            file, line_num);
-        return 0;
-    }
-#if 0
-    {
-        int i;
-        for (i =3D 0; i < ret; ++i)
-        {
-            msg(M_INFO|M_NOPREFIX, "%s:%d ARG[%d] '%s'", file, line_num, i=
, p[i]);
-        }
-    }
-#endif
-    return ret;
-}
-
-static void
-bypass_doubledash(char **p)
-{
-    if (strlen(*p) >=3D 3 && !strncmp(*p, "--", 2))
-    {
-        *p +=3D 2;
-    }
-}
-
-struct in_src
-{
-#define IS_TYPE_FP  1
-#define IS_TYPE_BUF 2
-    int type;
-    union
-    {
-        FILE *fp;
-        struct buffer *multiline;
-    } u;
-};
-
-static bool
-in_src_get(const struct in_src *is, char *line, const int size)
-{
-    if (is->type =3D=3D IS_TYPE_FP)
-    {
-        return BOOL_CAST(fgets(line, size, is->u.fp));
-    }
-    else if (is->type =3D=3D IS_TYPE_BUF)
-    {
-        bool status =3D buf_parse(is->u.multiline, '\n', line, size);
-        if ((int)strlen(line) + 1 < size)
-        {
-            strcat(line, "\n");
-        }
-        return status;
-    }
-    else
-    {
-        ASSERT(0);
-        return false;
-    }
-}
-
-static char *
-read_inline_file(struct in_src *is, const char *close_tag, int *num_lines,=
 struct gc_arena *gc)
-{
-    char line[OPTION_LINE_SIZE];
-    struct buffer buf =3D alloc_buf(8 * OPTION_LINE_SIZE);
-    char *ret;
-    bool endtagfound =3D false;
-
-    while (in_src_get(is, line, sizeof(line)))
-    {
-        (*num_lines)++;
-        char *line_ptr =3D line;
-        /* Remove leading spaces */
-        while (isspace(*line_ptr))
-        {
-            line_ptr++;
-        }
-        if (!strncmp(line_ptr, close_tag, strlen(close_tag)))
-        {
-            endtagfound =3D true;
-            break;
-        }
-        if (!buf_safe(&buf, strlen(line) + 1))
-        {
-            /* Increase buffer size */
-            struct buffer buf2 =3D alloc_buf(buf.capacity * 2);
-            ASSERT(buf_copy(&buf2, &buf));
-            buf_clear(&buf);
-            free_buf(&buf);
-            buf =3D buf2;
-        }
-        buf_printf(&buf, "%s", line);
-    }
-    if (!endtagfound)
-    {
-        msg(M_FATAL, "ERROR: Endtag %s missing", close_tag);
-    }
-    ret =3D string_alloc(BSTR(&buf), gc);
-    buf_clear(&buf);
-    free_buf(&buf);
-    secure_memzero(line, sizeof(line));
-    return ret;
-}
-
-static int
-check_inline_file(struct in_src *is, char *p[], struct gc_arena *gc)
-{
-    int num_inline_lines =3D 0;
-
-    if (p[0] && !p[1])
-    {
-        char *arg =3D p[0];
-        if (arg[0] =3D=3D '<' && arg[strlen(arg) - 1] =3D=3D '>')
-        {
-            struct buffer close_tag;
-
-            arg[strlen(arg) - 1] =3D '\0';
-            p[0] =3D string_alloc(arg + 1, gc);
-            close_tag =3D alloc_buf(strlen(p[0]) + 4);
-            buf_printf(&close_tag, "</%s>", p[0]);
-            p[1] =3D read_inline_file(is, BSTR(&close_tag), &num_inline_li=
nes, gc);
-            p[2] =3D NULL;
-            free_buf(&close_tag);
-        }
-    }
-    return num_inline_lines;
-}
-
-static int
-check_inline_file_via_fp(FILE *fp, char *p[], struct gc_arena *gc)
-{
-    struct in_src is;
-    is.type =3D IS_TYPE_FP;
-    is.u.fp =3D fp;
-    return check_inline_file(&is, p, gc);
-}
-
-static int
-check_inline_file_via_buf(struct buffer *multiline, char *p[], struct gc_a=
rena *gc)
-{
-    struct in_src is;
-    is.type =3D IS_TYPE_BUF;
-    is.u.multiline =3D multiline;
-    return check_inline_file(&is, p, gc);
-}
-
-static void add_option(struct options *options, char *p[], bool is_inline,=
 const char *file,
-                       int line, const int level, const msglvl_t msglevel,
-                       const unsigned int permission_mask, unsigned int *o=
ption_types_found,
-                       struct env_set *es);
-
-static void remove_option(struct context *c, struct options *options, char=
 *p[], bool is_inline,
-                          const char *file, int line, const msglvl_t msgle=
vel,
-                          const unsigned int permission_mask, unsigned int=
 *option_types_found,
-                          struct env_set *es);
-
-static void update_option(struct context *c, struct options *options, char=
 *p[], bool is_inline,
-                          const char *file, int line, const int level, con=
st msglvl_t msglevel,
-                          const unsigned int permission_mask, unsigned int=
 *option_types_found,
-                          struct env_set *es, unsigned int *update_options=
_found);
-
-static void
-read_config_file(struct options *options, const char *file, int level, con=
st char *top_file,
-                 const int top_line, const msglvl_t msglevel,
-                 const unsigned int permission_mask, unsigned int *option_=
types_found,
-                 struct env_set *es)
-{
-    const int max_recursive_levels =3D 10;
-    FILE *fp;
-    int line_num;
-    char line[OPTION_LINE_SIZE + 1];
-    char *p[MAX_PARMS + 1];
-
-    ++level;
-    if (level <=3D max_recursive_levels)
-    {
-        if (streq(file, "stdin"))
-        {
-            fp =3D stdin;
-        }
-        else
-        {
-            fp =3D platform_fopen(file, "r");
-        }
-        if (fp)
-        {
-            line_num =3D 0;
-            while (fgets(line, sizeof(line), fp))
-            {
-                int offset =3D 0;
-                CLEAR(p);
-                ++line_num;
-                if (strlen(line) =3D=3D OPTION_LINE_SIZE)
-                {
-                    msg(msglevel,
-                        "In %s:%d: Maximum option line length (%d) exceede=
d, line starts with %s",
-                        file, line_num, OPTION_LINE_SIZE, line);
-                }
-
-                /* Ignore UTF-8 BOM at start of stream */
-                if (line_num =3D=3D 1 && strncmp(line, "\xEF\xBB\xBF", 3) =
=3D=3D 0)
-                {
-                    offset =3D 3;
-                }
-                if (parse_line(line + offset, p, SIZE(p) - 1, file, line_n=
um, msglevel,
-                               &options->gc))
-                {
-                    bypass_doubledash(&p[0]);
-                    int lines_inline =3D check_inline_file_via_fp(fp, p, &=
options->gc);
-                    add_option(options, p, lines_inline, file, line_num, l=
evel, msglevel,
-                               permission_mask, option_types_found, es);
-                    line_num +=3D lines_inline;
-                }
-            }
-            if (fp !=3D stdin)
-            {
-                fclose(fp);
-            }
-        }
-        else
-        {
-            msg(msglevel, "In %s:%d: Error opening configuration file: %s"=
, top_file, top_line,
-                file);
-        }
-    }
-    else
-    {
-        msg(msglevel,
-            "In %s:%d: Maximum recursive include levels exceeded in includ=
e attempt of file %s -- probably you have a configuration file that tries t=
o include itself.",
-            top_file, top_line, file);
-    }
-    secure_memzero(line, sizeof(line));
-    CLEAR(p);
-}
-
-static void
-read_config_string(const char *prefix, struct options *options, const char=
 *config,
-                   const msglvl_t msglevel, const unsigned int permission_=
mask,
-                   unsigned int *option_types_found, struct env_set *es)
-{
-    char line[OPTION_LINE_SIZE];
-    struct buffer multiline;
-    int line_num =3D 0;
-
-    buf_set_read(&multiline, (uint8_t *)config, strlen(config));
-
-    while (buf_parse(&multiline, '\n', line, sizeof(line)))
-    {
-        char *p[MAX_PARMS + 1];
-        CLEAR(p);
-        ++line_num;
-        if (parse_line(line, p, SIZE(p) - 1, prefix, line_num, msglevel, &=
options->gc))
-        {
-            bypass_doubledash(&p[0]);
-            int lines_inline =3D check_inline_file_via_buf(&multiline, p, =
&options->gc);
-            add_option(options, p, lines_inline, prefix, line_num, 0, msgl=
evel, permission_mask,
-                       option_types_found, es);
-            line_num +=3D lines_inline;
-        }
-        CLEAR(p);
-    }
-    secure_memzero(line, sizeof(line));
-}
-
-void
-parse_argv(struct options *options, const int argc, char *argv[], const ms=
glvl_t msglevel,
-           const unsigned int permission_mask, unsigned int *option_types_=
found, struct env_set *es)
-{
-    /* usage message */
-    if (argc <=3D 1)
-    {
-        usage();
-    }
-
-    /* config filename specified only? */
-    if (argc =3D=3D 2 && strncmp(argv[1], "--", 2))
-    {
-        char *p[MAX_PARMS + 1];
-        CLEAR(p);
-        p[0] =3D "config";
-        p[1] =3D argv[1];
-        add_option(options, p, false, NULL, 0, 0, msglevel, permission_mas=
k, option_types_found,
-                   es);
-    }
-    else
-    {
-        /* parse command line */
-        for (int i =3D 1; i < argc; ++i)
-        {
-            char *p[MAX_PARMS + 1];
-            CLEAR(p);
-            p[0] =3D argv[i];
-            if (strncmp(p[0], "--", 2))
-            {
-                msg(msglevel,
-                    "I'm trying to parse \"%s\" as an --option parameter b=
ut I don't see a leading '--'",
-                    p[0]);
-            }
-            else
-            {
-                p[0] +=3D 2;
-            }
-
-            int j;
-            for (j =3D 1; j < MAX_PARMS; ++j)
-            {
-                if (i + j < argc)
-                {
-                    char *arg =3D argv[i + j];
-                    if (strncmp(arg, "--", 2))
-                    {
-                        p[j] =3D arg;
-                    }
-                    else
-                    {
-                        break;
-                    }
-                }
-            }
-            add_option(options, p, false, NULL, 0, 0, msglevel, permission=
_mask, option_types_found,
-                       es);
-            i +=3D j - 1;
-        }
-    }
-}
-
-bool
-apply_push_options(struct context *c, struct options *options, struct buff=
er *buf,
-                   unsigned int permission_mask, unsigned int *option_type=
s_found,
-                   struct env_set *es, bool is_update)
-{
-    char line[OPTION_PARM_SIZE];
-    int line_num =3D 0;
-    const char *file =3D "[PUSH-OPTIONS]";
-    const msglvl_t msglevel =3D D_PUSH_ERRORS | M_OPTERR;
-    unsigned int update_options_found =3D 0;
-
-    while (buf_parse(buf, ',', line, sizeof(line)))
-    {
-        char *p[MAX_PARMS + 1];
-        CLEAR(p);
-        ++line_num;
-        unsigned int push_update_option_flags =3D 0;
-        int i =3D 0;
-
-        /* skip leading spaces matching the behaviour of parse_line */
-        while (isspace(line[i]))
-        {
-            i++;
-        }
-
-        /* If we are not in a 'PUSH_UPDATE' we just check `apply_pull_filt=
er()`
-         * otherwise we must call `check_push_update_option_flags()` first
-         */
-        if ((is_update && !check_push_update_option_flags(line, &i, &push_=
update_option_flags))
-            || !apply_pull_filter(options, &line[i]))
-        {
-            /* In case we are in a `PUSH_UPDATE` and `check_push_update_op=
tion_flags()`
-             * or `apply_pull_filter()` fail but the option is flagged by =
`PUSH_OPT_OPTIONAL`,
-             * instead of restarting, we just ignore the option and we pro=
cess the next one
-             */
-            if (push_update_option_flags & PUSH_OPT_OPTIONAL)
-            {
-                continue; /* Ignoring this option */
-            }
-            return false; /* Cause push/pull error and stop push processin=
g */
-        }
-
-        if (parse_line(&line[i], p, SIZE(p) - 1, file, line_num, msglevel,=
 &options->gc))
-        {
-            if (!is_update)
-            {
-                add_option(options, p, false, file, line_num, 0, msglevel,=
 permission_mask,
-                           option_types_found, es);
-            }
-            else if (push_update_option_flags & PUSH_OPT_TO_REMOVE)
-            {
-                remove_option(c, options, p, false, file, line_num, msglev=
el, permission_mask,
-                              option_types_found, es);
-            }
-            else
-            {
-                update_option(c, options, p, false, file, line_num, 0, msg=
level, permission_mask,
-                              option_types_found, es, &update_options_foun=
d);
-            }
-        }
-    }
-    return true;
-}
-
-void
-options_server_import(struct options *o, const char *filename, msglvl_t ms=
glevel,
-                      unsigned int permission_mask, unsigned int *option_t=
ypes_found,
-                      struct env_set *es)
-{
-    msg(D_PUSH, "OPTIONS IMPORT: reading client specific options from: %s"=
, filename);
-    read_config_file(o, filename, 0, filename, 0, msglevel, permission_mas=
k, option_types_found,
-                     es);
-}
-
-void
-options_string_import(struct options *options, const char *config, const m=
sglvl_t msglevel,
-                      const unsigned int permission_mask, unsigned int *op=
tion_types_found,
-                      struct env_set *es)
-{
-    read_config_string("[CONFIG-STRING]", options, config, msglevel, permi=
ssion_mask,
-                       option_types_found, es);
-}
-
 #define VERIFY_PERMISSION(mask)                                           =
                    \
     {                                                                     =
                    \
         if (!verify_permission(p[0], file, line, (mask), permission_mask, =
option_types_found, \
@@ -5642,27 +5067,7 @@
         option_ptr->flags =3D 0;                 \
     }

-/**
- * @brief Resets options found in the PUSH_UPDATE message that are precede=
d by the `-` flag.
- *        This function is used in push-updates to reset specified options.
- *        The number of parameters `p` must always be 1. If the permission=
 is verified,
- *        all related options are erased or reset to their default values.
- *        Upon successful permission verification (by VERIFY_PERMISSION()),
- *        `option_types_found` is filled with the flag corresponding to th=
e option.
- *
- * @param c The context structure.
- * @param options A pointer to the options structure.
- * @param p An array of strings containing the options and their parameter=
s.
- * @param is_inline A boolean indicating if the option is inline.
- * @param file The file where the function is called.
- * @param line The line number where the function is called.
- * @param msglevel The message level.
- * @param permission_mask The permission mask used by VERIFY_PERMISSION().
- * @param option_types_found A pointer to the variable where the flags cor=
responding to the options
- * found are stored.
- * @param es The environment set structure.
- */
-static void
+void
 remove_option(struct context *c, struct options *options, char *p[], bool =
is_inline,
               const char *file, int line, const msglvl_t msglevel,
               const unsigned int permission_mask, unsigned int *option_typ=
es_found,
@@ -5982,30 +5387,7 @@
     return true;
 }

-/**
- * @brief Processes an option to update. It first checks whether it has al=
ready
- *        received an option of the same type within the same update messa=
ge.
- *        If the option has already been received, it calls add_option().
- *        Otherwise, it deletes all existing values related to that option=
 before calling
- * add_option().
- *
- * @param c The context structure.
- * @param options A pointer to the options structure.
- * @param p An array of strings containing the options and their parameter=
s.
- * @param is_inline A boolean indicating if the option is inline.
- * @param file The file where the function is called.
- * @param line The line number where the function is called.
- * @param level The level of the option.
- * @param msglevel The message level for logging.
- * @param permission_mask The permission mask used by VERIFY_PERMISSION().
- * @param option_types_found A pointer to the variable where the flags cor=
responding to the options
- * found are stored.
- * @param es The environment set structure.
- * @param update_options_found A pointer to the variable where the flags c=
orresponding to the update
- * options found are stored, used to check if an option of the same type h=
as already been processed
- * by update_option() within the same push-update message.
- */
-static void
+void
 update_option(struct context *c, struct options *options, char *p[], bool =
is_inline,
               const char *file, int line, const int level, const msglvl_t =
msglevel,
               const unsigned int permission_mask, unsigned int *option_typ=
es_found,
@@ -6190,7 +5572,7 @@
     return ret;
 }

-static void
+void
 add_option(struct options *options, char *p[], bool is_inline, const char =
*file, int line,
            const int level, const msglvl_t msglevel, const unsigned int pe=
rmission_mask,
            unsigned int *option_types_found, struct env_set *es)
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index b033068..f038975 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -822,14 +822,83 @@
     struct pull_filter *tail;
 };

+void add_option(struct options *options, char *p[], bool is_inline, const =
char *file,
+                int line, const int level, const msglvl_t msglevel,
+                const unsigned int permission_mask, unsigned int *option_t=
ypes_found,
+                struct env_set *es);
+
+/**
+ * @brief Resets options found in the PUSH_UPDATE message that are precede=
d by the `-` flag.
+ *        This function is used in push-updates to reset specified options.
+ *        The number of parameters `p` must always be 1. If the permission=
 is verified,
+ *        all related options are erased or reset to their default values.
+ *        Upon successful permission verification (by VERIFY_PERMISSION()),
+ *        `option_types_found` is filled with the flag corresponding to th=
e option.
+ *
+ * @param c The context structure.
+ * @param options A pointer to the options structure.
+ * @param p An array of strings containing the options and their parameter=
s.
+ * @param is_inline A boolean indicating if the option is inline.
+ * @param file The file where the function is called.
+ * @param line The line number where the function is called.
+ * @param msglevel The message level.
+ * @param permission_mask The permission mask used by VERIFY_PERMISSION().
+ * @param option_types_found A pointer to the variable where the flags cor=
responding to the options
+ * found are stored.
+ * @param es The environment set structure.
+ */
+void remove_option(struct context *c, struct options *options, char *p[], =
bool is_inline,
+                   const char *file, int line, const msglvl_t msglevel,
+                   const unsigned int permission_mask, unsigned int *optio=
n_types_found,
+                   struct env_set *es);
+
+/**
+ * @brief Processes an option to update. It first checks whether it has al=
ready
+ *        received an option of the same type within the same update messa=
ge.
+ *        If the option has already been received, it calls add_option().
+ *        Otherwise, it deletes all existing values related to that option=
 before calling
+ * add_option().
+ *
+ * @param c The context structure.
+ * @param options A pointer to the options structure.
+ * @param p An array of strings containing the options and their parameter=
s.
+ * @param is_inline A boolean indicating if the option is inline.
+ * @param file The file where the function is called.
+ * @param line The line number where the function is called.
+ * @param level The level of the option.
+ * @param msglevel The message level for logging.
+ * @param permission_mask The permission mask used by VERIFY_PERMISSION().
+ * @param option_types_found A pointer to the variable where the flags cor=
responding to the options
+ * found are stored.
+ * @param es The environment set structure.
+ * @param update_options_found A pointer to the variable where the flags c=
orresponding to the update
+ * options found are stored, used to check if an option of the same type h=
as already been processed
+ * by update_option() within the same push-update message.
+ */
+void update_option(struct context *c, struct options *options, char *p[], =
bool is_inline,
+                   const char *file, int line, const int level, const msgl=
vl_t msglevel,
+                   const unsigned int permission_mask, unsigned int *optio=
n_types_found,
+                   struct env_set *es, unsigned int *update_options_found);
+
 void parse_argv(struct options *options, const int argc, char *argv[], con=
st msglvl_t msglevel,
                 const unsigned int permission_mask, unsigned int *option_t=
ypes_found,
                 struct env_set *es);

+void read_config_file(struct options *options, const char *file, int level=
, const char *top_file,
+                      const int top_line, const msglvl_t msglevel,
+                      const unsigned int permission_mask, unsigned int *op=
tion_types_found,
+                      struct env_set *es);
+
+void read_config_string(const char *prefix, struct options *options, const=
 char *config,
+                        const msglvl_t msglevel, const unsigned int permis=
sion_mask,
+                        unsigned int *option_types_found, struct env_set *=
es);
+
 void notnull(const char *arg, const char *description);

 void usage_small(void);

+void usage(void);
+
 void show_library_versions(const unsigned int flags);

 #ifdef _WIN32
diff --git a/src/openvpn/options_parse.c b/src/openvpn/options_parse.c
new file mode 100644
index 0000000..bb5b404
--- /dev/null
+++ b/src/openvpn/options_parse.c
@@ -0,0 +1,592 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2008-2025 David Sommerseth <dazo@...2108...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include <string.h>
+
+#include "options.h"
+#include "options_util.h"
+#include "push.h"
+
+static void
+bypass_doubledash(char **p)
+{
+    if (strlen(*p) >=3D 3 && !strncmp(*p, "--", 2))
+    {
+        *p +=3D 2;
+    }
+}
+
+static inline bool
+space(char c)
+{
+    return c =3D=3D '\0' || isspace(c);
+}
+
+int
+parse_line(const char *line, char *p[], const int n, const char *file, con=
st int line_num,
+           msglvl_t msglevel, struct gc_arena *gc)
+{
+    const int STATE_INITIAL =3D 0;
+    const int STATE_READING_QUOTED_PARM =3D 1;
+    const int STATE_READING_UNQUOTED_PARM =3D 2;
+    const int STATE_DONE =3D 3;
+    const int STATE_READING_SQUOTED_PARM =3D 4;
+
+    const char *error_prefix =3D "";
+
+    int ret =3D 0;
+    const char *c =3D line;
+    int state =3D STATE_INITIAL;
+    bool backslash =3D false;
+    char in, out;
+
+    char parm[OPTION_PARM_SIZE];
+    unsigned int parm_len =3D 0;
+
+    msglevel &=3D ~M_OPTERR;
+
+    if (msglevel & M_MSG_VIRT_OUT)
+    {
+        error_prefix =3D "ERROR: ";
+    }
+
+    do
+    {
+        in =3D *c;
+        out =3D 0;
+
+        if (!backslash && in =3D=3D '\\' && state !=3D STATE_READING_SQUOT=
ED_PARM)
+        {
+            backslash =3D true;
+        }
+        else
+        {
+            if (state =3D=3D STATE_INITIAL)
+            {
+                if (!space(in))
+                {
+                    if (in =3D=3D ';' || in =3D=3D '#') /* comment */
+                    {
+                        break;
+                    }
+                    if (!backslash && in =3D=3D '\"')
+                    {
+                        state =3D STATE_READING_QUOTED_PARM;
+                    }
+                    else if (!backslash && in =3D=3D '\'')
+                    {
+                        state =3D STATE_READING_SQUOTED_PARM;
+                    }
+                    else
+                    {
+                        out =3D in;
+                        state =3D STATE_READING_UNQUOTED_PARM;
+                    }
+                }
+            }
+            else if (state =3D=3D STATE_READING_UNQUOTED_PARM)
+            {
+                if (!backslash && space(in))
+                {
+                    state =3D STATE_DONE;
+                }
+                else
+                {
+                    out =3D in;
+                }
+            }
+            else if (state =3D=3D STATE_READING_QUOTED_PARM)
+            {
+                if (!backslash && in =3D=3D '\"')
+                {
+                    state =3D STATE_DONE;
+                }
+                else
+                {
+                    out =3D in;
+                }
+            }
+            else if (state =3D=3D STATE_READING_SQUOTED_PARM)
+            {
+                if (in =3D=3D '\'')
+                {
+                    state =3D STATE_DONE;
+                }
+                else
+                {
+                    out =3D in;
+                }
+            }
+            if (state =3D=3D STATE_DONE)
+            {
+                /* ASSERT (parm_len > 0); */
+                p[ret] =3D gc_malloc(parm_len + 1, true, gc);
+                memcpy(p[ret], parm, parm_len);
+                p[ret][parm_len] =3D '\0';
+                state =3D STATE_INITIAL;
+                parm_len =3D 0;
+                ++ret;
+            }
+
+            if (backslash && out)
+            {
+                if (!(out =3D=3D '\\' || out =3D=3D '\"' || space(out)))
+                {
+#ifdef ENABLE_SMALL
+                    msg(msglevel, "%sOptions warning: Bad backslash ('\\')=
 usage in %s:%d",
+                        error_prefix, file, line_num);
+#else
+                    msg(msglevel,
+                        "%sOptions warning: Bad backslash ('\\') usage in =
%s:%d: remember that backslashes are treated as shell-escapes and if you ne=
ed to pass backslash characters as part of a Windows filename, you should u=
se double backslashes such as \"c:\\\\" PACKAGE
+                        "\\\\static.key\"",
+                        error_prefix, file, line_num);
+#endif
+                    return 0;
+                }
+            }
+            backslash =3D false;
+        }
+
+        /* store parameter character */
+        if (out)
+        {
+            if (parm_len >=3D SIZE(parm))
+            {
+                parm[SIZE(parm) - 1] =3D 0;
+                msg(msglevel, "%sOptions error: Parameter at %s:%d is too =
long (%d chars max): %s",
+                    error_prefix, file, line_num, (int)SIZE(parm), parm);
+                return 0;
+            }
+            parm[parm_len++] =3D out;
+        }
+
+        /* avoid overflow if too many parms in one config file line */
+        if (ret >=3D n)
+        {
+            break;
+        }
+
+    } while (*c++ !=3D '\0');
+
+    if (state =3D=3D STATE_READING_QUOTED_PARM)
+    {
+        msg(msglevel, "%sOptions error: No closing quotation (\") in %s:%d=
", error_prefix, file,
+            line_num);
+        return 0;
+    }
+    if (state =3D=3D STATE_READING_SQUOTED_PARM)
+    {
+        msg(msglevel, "%sOptions error: No closing single quotation (\') i=
n %s:%d", error_prefix,
+            file, line_num);
+        return 0;
+    }
+    if (state !=3D STATE_INITIAL)
+    {
+        msg(msglevel, "%sOptions error: Residual parse state (%d) in %s:%d=
", error_prefix, state,
+            file, line_num);
+        return 0;
+    }
+#if 0
+    {
+        int i;
+        for (i =3D 0; i < ret; ++i)
+        {
+            msg(M_INFO|M_NOPREFIX, "%s:%d ARG[%d] '%s'", file, line_num, i=
, p[i]);
+        }
+    }
+#endif
+    return ret;
+}
+
+struct in_src
+{
+#define IS_TYPE_FP  1
+#define IS_TYPE_BUF 2
+    int type;
+    union
+    {
+        FILE *fp;
+        struct buffer *multiline;
+    } u;
+};
+
+static bool
+in_src_get(const struct in_src *is, char *line, const int size)
+{
+    if (is->type =3D=3D IS_TYPE_FP)
+    {
+        return BOOL_CAST(fgets(line, size, is->u.fp));
+    }
+    else if (is->type =3D=3D IS_TYPE_BUF)
+    {
+        bool status =3D buf_parse(is->u.multiline, '\n', line, size);
+        if ((int)strlen(line) + 1 < size)
+        {
+            strcat(line, "\n");
+        }
+        return status;
+    }
+    else
+    {
+        ASSERT(0);
+        return false;
+    }
+}
+
+static char *
+read_inline_file(struct in_src *is, const char *close_tag, int *num_lines,=
 struct gc_arena *gc)
+{
+    char line[OPTION_LINE_SIZE];
+    struct buffer buf =3D alloc_buf(8 * OPTION_LINE_SIZE);
+    char *ret;
+    bool endtagfound =3D false;
+
+    while (in_src_get(is, line, sizeof(line)))
+    {
+        (*num_lines)++;
+        char *line_ptr =3D line;
+        /* Remove leading spaces */
+        while (isspace(*line_ptr))
+        {
+            line_ptr++;
+        }
+        if (!strncmp(line_ptr, close_tag, strlen(close_tag)))
+        {
+            endtagfound =3D true;
+            break;
+        }
+        if (!buf_safe(&buf, strlen(line) + 1))
+        {
+            /* Increase buffer size */
+            struct buffer buf2 =3D alloc_buf(buf.capacity * 2);
+            ASSERT(buf_copy(&buf2, &buf));
+            buf_clear(&buf);
+            free_buf(&buf);
+            buf =3D buf2;
+        }
+        buf_printf(&buf, "%s", line);
+    }
+    if (!endtagfound)
+    {
+        msg(M_FATAL, "ERROR: Endtag %s missing", close_tag);
+    }
+    ret =3D string_alloc(BSTR(&buf), gc);
+    buf_clear(&buf);
+    free_buf(&buf);
+    secure_memzero(line, sizeof(line));
+    return ret;
+}
+
+static int
+check_inline_file(struct in_src *is, char *p[], struct gc_arena *gc)
+{
+    int num_inline_lines =3D 0;
+
+    if (p[0] && !p[1])
+    {
+        char *arg =3D p[0];
+        if (arg[0] =3D=3D '<' && arg[strlen(arg) - 1] =3D=3D '>')
+        {
+            struct buffer close_tag;
+
+            arg[strlen(arg) - 1] =3D '\0';
+            p[0] =3D string_alloc(arg + 1, gc);
+            close_tag =3D alloc_buf(strlen(p[0]) + 4);
+            buf_printf(&close_tag, "</%s>", p[0]);
+            p[1] =3D read_inline_file(is, BSTR(&close_tag), &num_inline_li=
nes, gc);
+            p[2] =3D NULL;
+            free_buf(&close_tag);
+        }
+    }
+    return num_inline_lines;
+}
+
+static int
+check_inline_file_via_fp(FILE *fp, char *p[], struct gc_arena *gc)
+{
+    struct in_src is;
+    is.type =3D IS_TYPE_FP;
+    is.u.fp =3D fp;
+    return check_inline_file(&is, p, gc);
+}
+
+static int
+check_inline_file_via_buf(struct buffer *multiline, char *p[], struct gc_a=
rena *gc)
+{
+    struct in_src is;
+    is.type =3D IS_TYPE_BUF;
+    is.u.multiline =3D multiline;
+    return check_inline_file(&is, p, gc);
+}
+
+void
+read_config_file(struct options *options, const char *file, int level, con=
st char *top_file,
+                 const int top_line, const msglvl_t msglevel,
+                 const unsigned int permission_mask, unsigned int *option_=
types_found,
+                 struct env_set *es)
+{
+    const int max_recursive_levels =3D 10;
+    FILE *fp;
+    int line_num;
+    char line[OPTION_LINE_SIZE + 1];
+    char *p[MAX_PARMS + 1];
+
+    ++level;
+    if (level <=3D max_recursive_levels)
+    {
+        if (streq(file, "stdin"))
+        {
+            fp =3D stdin;
+        }
+        else
+        {
+            fp =3D platform_fopen(file, "r");
+        }
+        if (fp)
+        {
+            line_num =3D 0;
+            while (fgets(line, sizeof(line), fp))
+            {
+                int offset =3D 0;
+                CLEAR(p);
+                ++line_num;
+                if (strlen(line) =3D=3D OPTION_LINE_SIZE)
+                {
+                    msg(msglevel,
+                        "In %s:%d: Maximum option line length (%d) exceede=
d, line starts with %s",
+                        file, line_num, OPTION_LINE_SIZE, line);
+                }
+
+                /* Ignore UTF-8 BOM at start of stream */
+                if (line_num =3D=3D 1 && strncmp(line, "\xEF\xBB\xBF", 3) =
=3D=3D 0)
+                {
+                    offset =3D 3;
+                }
+                if (parse_line(line + offset, p, SIZE(p) - 1, file, line_n=
um, msglevel,
+                               &options->gc))
+                {
+                    bypass_doubledash(&p[0]);
+                    int lines_inline =3D check_inline_file_via_fp(fp, p, &=
options->gc);
+                    add_option(options, p, lines_inline, file, line_num, l=
evel, msglevel,
+                               permission_mask, option_types_found, es);
+                    line_num +=3D lines_inline;
+                }
+            }
+            if (fp !=3D stdin)
+            {
+                fclose(fp);
+            }
+        }
+        else
+        {
+            msg(msglevel, "In %s:%d: Error opening configuration file: %s"=
, top_file, top_line,
+                file);
+        }
+    }
+    else
+    {
+        msg(msglevel,
+            "In %s:%d: Maximum recursive include levels exceeded in includ=
e attempt of file %s -- probably you have a configuration file that tries t=
o include itself.",
+            top_file, top_line, file);
+    }
+    secure_memzero(line, sizeof(line));
+    CLEAR(p);
+}
+
+void
+read_config_string(const char *prefix, struct options *options, const char=
 *config,
+                   const msglvl_t msglevel, const unsigned int permission_=
mask,
+                   unsigned int *option_types_found, struct env_set *es)
+{
+    char line[OPTION_LINE_SIZE];
+    struct buffer multiline;
+    int line_num =3D 0;
+
+    buf_set_read(&multiline, (uint8_t *)config, strlen(config));
+
+    while (buf_parse(&multiline, '\n', line, sizeof(line)))
+    {
+        char *p[MAX_PARMS + 1];
+        CLEAR(p);
+        ++line_num;
+        if (parse_line(line, p, SIZE(p) - 1, prefix, line_num, msglevel, &=
options->gc))
+        {
+            bypass_doubledash(&p[0]);
+            int lines_inline =3D check_inline_file_via_buf(&multiline, p, =
&options->gc);
+            add_option(options, p, lines_inline, prefix, line_num, 0, msgl=
evel, permission_mask,
+                       option_types_found, es);
+            line_num +=3D lines_inline;
+        }
+        CLEAR(p);
+    }
+    secure_memzero(line, sizeof(line));
+}
+
+void
+parse_argv(struct options *options, const int argc, char *argv[], const ms=
glvl_t msglevel,
+           const unsigned int permission_mask, unsigned int *option_types_=
found, struct env_set *es)
+{
+    /* usage message */
+    if (argc <=3D 1)
+    {
+        usage();
+    }
+
+    /* config filename specified only? */
+    if (argc =3D=3D 2 && strncmp(argv[1], "--", 2))
+    {
+        char *p[MAX_PARMS + 1];
+        CLEAR(p);
+        p[0] =3D "config";
+        p[1] =3D argv[1];
+        add_option(options, p, false, NULL, 0, 0, msglevel, permission_mas=
k, option_types_found,
+                   es);
+    }
+    else
+    {
+        /* parse command line */
+        for (int i =3D 1; i < argc; ++i)
+        {
+            char *p[MAX_PARMS + 1];
+            CLEAR(p);
+            p[0] =3D argv[i];
+            if (strncmp(p[0], "--", 2))
+            {
+                msg(msglevel,
+                    "I'm trying to parse \"%s\" as an --option parameter b=
ut I don't see a leading '--'",
+                    p[0]);
+            }
+            else
+            {
+                p[0] +=3D 2;
+            }
+
+            int j;
+            for (j =3D 1; j < MAX_PARMS; ++j)
+            {
+                if (i + j < argc)
+                {
+                    char *arg =3D argv[i + j];
+                    if (strncmp(arg, "--", 2))
+                    {
+                        p[j] =3D arg;
+                    }
+                    else
+                    {
+                        break;
+                    }
+                }
+            }
+            add_option(options, p, false, NULL, 0, 0, msglevel, permission=
_mask, option_types_found,
+                       es);
+            i +=3D j - 1;
+        }
+    }
+}
+
+bool
+apply_push_options(struct context *c, struct options *options, struct buff=
er *buf,
+                   unsigned int permission_mask, unsigned int *option_type=
s_found,
+                   struct env_set *es, bool is_update)
+{
+    char line[OPTION_PARM_SIZE];
+    int line_num =3D 0;
+    const char *file =3D "[PUSH-OPTIONS]";
+    const msglvl_t msglevel =3D D_PUSH_ERRORS | M_OPTERR;
+    unsigned int update_options_found =3D 0;
+
+    while (buf_parse(buf, ',', line, sizeof(line)))
+    {
+        char *p[MAX_PARMS + 1];
+        CLEAR(p);
+        ++line_num;
+        unsigned int push_update_option_flags =3D 0;
+        int i =3D 0;
+
+        /* skip leading spaces matching the behaviour of parse_line */
+        while (isspace(line[i]))
+        {
+            i++;
+        }
+
+        /* If we are not in a 'PUSH_UPDATE' we just check `apply_pull_filt=
er()`
+         * otherwise we must call `check_push_update_option_flags()` first
+         */
+        if ((is_update && !check_push_update_option_flags(line, &i, &push_=
update_option_flags))
+            || !apply_pull_filter(options, &line[i]))
+        {
+            /* In case we are in a `PUSH_UPDATE` and `check_push_update_op=
tion_flags()`
+             * or `apply_pull_filter()` fail but the option is flagged by =
`PUSH_OPT_OPTIONAL`,
+             * instead of restarting, we just ignore the option and we pro=
cess the next one
+             */
+            if (push_update_option_flags & PUSH_OPT_OPTIONAL)
+            {
+                continue; /* Ignoring this option */
+            }
+            return false; /* Cause push/pull error and stop push processin=
g */
+        }
+
+        if (parse_line(&line[i], p, SIZE(p) - 1, file, line_num, msglevel,=
 &options->gc))
+        {
+            if (!is_update)
+            {
+                add_option(options, p, false, file, line_num, 0, msglevel,=
 permission_mask,
+                           option_types_found, es);
+            }
+            else if (push_update_option_flags & PUSH_OPT_TO_REMOVE)
+            {
+                remove_option(c, options, p, false, file, line_num, msglev=
el, permission_mask,
+                              option_types_found, es);
+            }
+            else
+            {
+                update_option(c, options, p, false, file, line_num, 0, msg=
level, permission_mask,
+                              option_types_found, es, &update_options_foun=
d);
+            }
+        }
+    }
+    return true;
+}
+
+void
+options_server_import(struct options *o, const char *filename, msglvl_t ms=
glevel,
+                      unsigned int permission_mask, unsigned int *option_t=
ypes_found,
+                      struct env_set *es)
+{
+    msg(D_PUSH, "OPTIONS IMPORT: reading client specific options from: %s"=
, filename);
+    read_config_file(o, filename, 0, filename, 0, msglevel, permission_mas=
k, option_types_found,
+                     es);
+}
+
+void
+options_string_import(struct options *options, const char *config, const m=
sglvl_t msglevel,
+                      const unsigned int permission_mask, unsigned int *op=
tion_types_found,
+                      struct env_set *es)
+{
+    read_config_string("[CONFIG-STRING]", options, config, msglevel, permi=
ssion_mask,
+                       option_types_found, es);
+}

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1242?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I18e38862df1318740928c6cfa21dc4dcd7d44b89
Gerrit-Change-Number: 1242
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--fqIn/R+vi5U=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1242?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">options: Factor out parsing code to separate opt=
ions_parse.c<br><br>For easier testability. And because everything that<br>=
reduces the length of that file in a sensible manner<br>is a good idea.<br>=
<br>Change-Id: I18e38862df1318740928c6cfa21dc4dcd7d44b89<br>Signed-off-by: =
Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;ge=
rt@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/124=
2<br>Message-Id: &lt;20251007185110.19267-1-gert@...1296...&gt;<br>URL: htt=
ps://sourceforge.net/p/openvpn/mailman/message/59243506/<br>Signed-off-by: =
Gert Doering &lt;gert@...1296...&gt;<br>---<br>M CMakeLists.txt<br>M src/op=
envpn/Makefile.am<br>M src/openvpn/common.h<br>M src/openvpn/options.c<br>M=
 src/openvpn/options.h<br>A src/openvpn/options_parse.c<br>6 files changed,=
 669 insertions(+), 622 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index 3f619=
6f..be66357 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++=
 b/CMakeLists.txt</span><br><span>@@ -513,6 +513,7 @@</span><br><span>     =
src/openvpn/options.h</span><br><span>     src/openvpn/options_util.c</span=
><br><span>     src/openvpn/options_util.h</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    src/openvpn/options_parse.c</span><br><span>    =
 src/openvpn/otime.c</span><br><span>     src/openvpn/otime.h</span><br><sp=
an>     src/openvpn/ovpn_dco_win.h</span><br><span>diff --git a/src/openvpn=
/Makefile.am b/src/openvpn/Makefile.am</span><br><span>index 1247f11..e44fb=
2b 100644</span><br><span>--- a/src/openvpn/Makefile.am</span><br><span>+++=
 b/src/openvpn/Makefile.am</span><br><span>@@ -109,6 +109,7 @@</span><br><s=
pan> 	openvpn.c openvpn.h \</span><br><span> 	options.c options.h \</span><=
br><span> 	options_util.c options_util.h \</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	options_parse.c \</span><br><span> 	otime.c otime.h=
 \</span><br><span> 	packet_id.c packet_id.h \</span><br><span> 	perf.c per=
f.h \</span><br><span>diff --git a/src/openvpn/common.h b/src/openvpn/commo=
n.h</span><br><span>index c0947da..7779614 100644</span><br><span>--- a/src=
/openvpn/common.h</span><br><span>+++ b/src/openvpn/common.h</span><br><spa=
n>@@ -23,6 +23,8 @@</span><br><span> #ifndef COMMON_H</span><br><span> #def=
ine COMMON_H</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &lt;stdint.h&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Statistics counte=
rs and associated printf format.</span><br><span>  */</span><br><span>diff =
--git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>index=
 f35738d..f2e6dec 100644</span><br><span>--- a/src/openvpn/options.c</span>=
<br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -4838,7 +4838,7 @@=
</span><br><span> /*</span><br><span>  * Print the help message.</span><br>=
<span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><spa=
n> usage(void)</span><br><span> {</span><br><span>     FILE *fp =3D msg_fp(=
0);</span><br><span>@@ -4967,581 +4967,6 @@</span><br><span> }</span><br><s=
pan> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-space(char c)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return c =3D=3D &#3=
9;\0&#39; || isspace(c);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-parse_line(const char *line, char *p[], const int n, con=
st char *file, const int line_num,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-           msglvl_t msglevel, struct gc_arena *gc)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    const int STATE_INITIAL =3D 0;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    const int STATE_READING_QUOTED_PARM =
=3D 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int S=
TATE_READING_UNQUOTED_PARM =3D 2;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    const int STATE_DONE =3D 3;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    const int STATE_READING_SQUOTED_PARM =3D 4;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    const char *error_prefix =3D &quot;&quot;;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int ret =3D 0;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    const char *c =3D line;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    int state =3D STATE_INITIAL;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    bool backslash =3D false;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char in, out;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    char parm[OPTION_PARM_SIZE];</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    unsigned int parm_len =3D 0;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    msglevel &amp;=3D ~M_OPTERR;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (msglevel &amp; M_MSG_VIRT_OUT)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        error_prefix =3D &quot;ERROR: &quot;;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        in =3D *c;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        out =3D 0;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        if (!backslash &amp;&amp; in =3D=3D &#3=
9;\\&#39; &amp;&amp; state !=3D STATE_READING_SQUOTED_PARM)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            backslash =3D true;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            if (state =3D=3D STATE_INITIAL)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                if (!space(in))</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                    if (in =3D=3D &#39;;&#39; || in =
=3D=3D &#39;#&#39;) /* comment */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                        break;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                    }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                    if (!backslash &amp;&amp; in =3D=
=3D &#39;\&quot;&#39;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                        state =3D STATE_READING_QUOTED_PARM;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                    }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                    else if (!backs=
lash &amp;&amp; in =3D=3D &#39;\&#39;&#39;)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                        state =3D STATE_READING_SQUOT=
ED_PARM;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
       else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
          {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
              out =3D in;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                        state =3D STATE_READING_UNQUOTED_PARM;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            else if (state =3D=3D STATE_RE=
ADING_UNQUOTED_PARM)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       if (!backslash &amp;&amp; space(in))</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                    state =3D STATE_DONE;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                else</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                    out =3D in;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            else if (state =3D=3D STATE_READING_=
QUOTED_PARM)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                i=
f (!backslash &amp;&amp; in =3D=3D &#39;\&quot;&#39;)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    state =3D STATE_DONE;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                else</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                    out =3D in;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            else if (state =3D=3D STAT=
E_READING_SQUOTED_PARM)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          if (in =3D=3D &#39;\&#39;&#39;)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                    state =3D STATE_DONE;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    out =3D in;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            if (state =3D=3D STATE_DONE)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                /* ASSERT (parm_len &g=
t; 0); */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    p[ret] =3D gc_malloc(parm_len + 1, true, gc);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                memcpy(p[ret], parm, parm_len);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                p[ret=
][parm_len] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                state =3D STATE_INITIAL;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                parm_len =3D 0;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                ++ret;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            if (backslash &amp;&amp; out)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                if (!(out =3D=3D &#39;\\&#39; || ou=
t =3D=3D &#39;\&quot;&#39; || space(out)))</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#ifdef ENABLE_SMALL</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                    msg(msglevel, &quot;%sOptions warning: B=
ad backslash (&#39;\\&#39;) usage in %s:%d&quot;,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                        error_prefix, file, lin=
e_num);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                    msg(msglev=
el,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
      &quot;%sOptions warning: Bad backslash (&#39;\\&#39;) usage in %s:%d:=
 remember that backslashes are treated as shell-escapes and if you need to =
pass backslash characters as part of a Windows filename, you should use dou=
ble backslashes such as \&quot;c:\\\\&quot; PACKAGE</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        &quot;\\\\static.ke=
y\&quot;&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                  error_prefix, file, line_num);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                    return 0;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            backslash =3D false;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* sto=
re parameter character */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (out)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            i=
f (parm_len &gt;=3D SIZE(parm))</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                parm[SIZE(parm) - 1] =3D 0;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                msg(msglevel, &quot;%sOptions error=
: Parameter at %s:%d is too long (%d chars max): %s&quot;,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                    error_prefix, file=
, line_num, (int)SIZE(parm), parm);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                return 0;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            parm[parm_len++] =3D out;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 /* avoid overflow if too many parms in one config file line */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        if (ret &gt;=3D n)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   } while (*c++ !=3D &#39;\0&#39;);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (state =3D=3D STATE_READING_QUOTED_PARM)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        msg(msglevel, &quot;%sOptions error: No closing quotation (\&qu=
ot;) in %s:%d&quot;, error_prefix, file,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            line_num);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        return 0;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (state =3D=3D STATE_READING_SQUOTED_PARM)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        msg(msglevel, &quot;%sOptions error: No closing single q=
uotation (\&#39;) in %s:%d&quot;, error_prefix,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            file, line_num);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        return 0;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (state !=3D STATE_INITIAL)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        msg(msglevel, &quot;%sOptions error: Residual parse state =
(%d) in %s:%d&quot;, error_prefix, state,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            file, line_num);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        return 0;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#if 0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        int i;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; ret=
; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_INFO|M_NO=
PREFIX, &quot;%s:%d ARG[%d] &#39;%s&#39;&quot;, file, line_num, i, p[i]);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    return ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-bypass_doubledash(char **p)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (strlen(*p) &gt;=3D 3 &amp;&amp; !strncmp(*p, &quot;--&=
quot;, 2))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        *p +=3D 2;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct in_sr=
c</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#define IS_TYPE_FP  1</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#define IS_TYPE_BUF 2</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    int type;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    union</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       FILE *fp;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   struct buffer *multiline;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    } u;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-in_src_get(const struct in_src *is, char *line, const in=
t size)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (is-&gt;type =3D=3D IS_TYPE=
_FP)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        return BOOL_CAST(fgets(li=
ne, size, is-&gt;u.fp));</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (=
is-&gt;type =3D=3D IS_TYPE_BUF)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  bool status =3D buf_parse(is-&gt;u.multiline, &#39;\n&#39;, line, size);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if ((int)strle=
n(line) + 1 &lt; size)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 strcat(line, &quot;\n&quot;);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     return status;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        ASSERT(0);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        return false;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-static char *</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-read_inline_file(struct in_src *is, cons=
t char *close_tag, int *num_lines, struct gc_arena *gc)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    char line[OPTION_LINE_SIZE];</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    struct buffer buf =3D alloc_buf(8 * OPTION_LIN=
E_SIZE);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *ret=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool endtagfound=
 =3D false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    while (in_src_get(is, line,=
 sizeof(line)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        (*num_lines)++=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        char *line_p=
tr =3D line;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /=
* Remove leading spaces */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        while (isspace(*line_ptr))</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            line_ptr++;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (!strncmp(line_ptr, close_tag, strlen(close_tag)))</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            endtagfound =3D true;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (!buf_safe(&amp;buf, strlen(line) + 1))</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            /* Increase buffer size *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            struct b=
uffer buf2 =3D alloc_buf(buf.capacity * 2);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            ASSERT(buf_copy(&amp;buf2, &amp;buf));</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            buf_clear(&a=
mp;buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            f=
ree_buf(&amp;buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         buf =3D buf2;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf=
_printf(&amp;buf, &quot;%s&quot;, line);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (!endtagfound)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M=
_FATAL, &quot;ERROR: Endtag %s missing&quot;, close_tag);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    ret =3D string_alloc(BSTR(&amp;buf), gc);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    buf_clear(&amp;buf);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    free_buf(&amp;buf);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    secure_memzero(line, s=
izeof(line));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retu=
rn ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-static int</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-check_inline_file(struct in_src *is, char *p[], struct gc_arena *g=
c)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    int num_inline_lines =3D 0;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (p[0] &amp;&amp; !p[1])</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        char *arg =3D p[0];</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        if (arg[0] =3D=3D &#39;&lt;&#39; &amp;&amp;=
 arg[strlen(arg) - 1] =3D=3D &#39;&gt;&#39;)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            struct buffer close_tag;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            arg[strlen(arg) - 1] =3D &#39;\0&#39;;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            p[0] =3D string_alloc(arg + 1=
, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            clo=
se_tag =3D alloc_buf(strlen(p[0]) + 4);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            buf_printf(&amp;close_tag, &quot;&lt;/%s&gt;&=
quot;, p[0]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    p[1] =3D read_inline_file(is, BSTR(&amp;close_tag), &amp;num_inline_lin=
es, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            p=
[2] =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    free_buf(&amp;close_tag);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return num_inlin=
e_lines;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-static int</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-check_inline_file_via_fp(FILE *fp, char *p[], struct gc_arena *gc=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    struct in_src is;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    is.type =3D IS_TYPE_FP;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    is.u.fp =3D fp;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    return check_inline_file(&amp;is=
, p, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-static int</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-check_inline_file_via_buf(struct buffer *multiline, char *p[], s=
truct gc_arena *gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct in_src is;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    is.type =3D IS_TYP=
E_BUF;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    is.u.multil=
ine =3D multiline;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 return check_inline_file(&amp;is, p, gc);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void add_opti=
on(struct options *options, char *p[], bool is_inline, const char *file,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                       i=
nt line, const int level, const msglvl_t msglevel,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                       const unsigned int perm=
ission_mask, unsigned int *option_types_found,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                       struct env_set *es);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-static void remove_option(struct context *c, stru=
ct options *options, char *p[], bool is_inline,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                          const char *file, int l=
ine, const msglvl_t msglevel,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                          const unsigned int permission_mask, unsig=
ned int *option_types_found,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                          struct env_set *es);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-static void update_option(struct context *c, struct options *opt=
ions, char *p[], bool is_inline,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                          const char *file, int line, const int =
level, const msglvl_t msglevel,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                          const unsigned int permission_mask, uns=
igned int *option_types_found,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                          struct env_set *es, unsigned int *update=
_options_found);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-read_config_file(struct options *opt=
ions, const char *file, int level, const char *top_file,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                 const int top_line, con=
st msglvl_t msglevel,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                 const unsigned int permission_mask, unsigned int *option_t=
ypes_found,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
       struct env_set *es)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int m=
ax_recursive_levels =3D 10;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    FILE *fp;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  int line_num;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ch=
ar line[OPTION_LINE_SIZE + 1];</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    char *p[MAX_PARMS + 1];</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ++=
level;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (level &=
lt;=3D max_recursive_levels)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
f (streq(file, &quot;stdin&quot;))</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            fp =3D stdin;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            fp =3D platform_=
fopen(file, &quot;r&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  if (fp)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            line_num =3D=
 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            while =
(fgets(line, sizeof(line), fp))</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                int offset =3D 0;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                CLEAR(p);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                ++line_num;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                if (strlen(line) =3D=3D OPTION_LINE=
_SIZE)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
 msg(msglevel,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                 &quot;In %s:%d: Maximum option line length (%d) exceeded, =
line starts with %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                        file, line_num, OPTION_LINE_SIZE, line);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                /* Ignore UTF-8 BOM at start of stre=
am */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
if (line_num =3D=3D 1 &amp;&amp; strncmp(line, &quot;\xEF\xBB\xBF&quot;, 3)=
 =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
     offset =3D 3;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         if (parse_line(line + offset, p, SIZE(p) - 1, file, line_num, msgl=
evel,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
               &amp;options-&gt;gc))</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                    bypass_doubledash(&amp;p[0]);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                    int lines_inline=
 =3D check_inline_file_via_fp(fp, p, &amp;options-&gt;gc);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                    add_option(options=
, p, lines_inline, file, line_num, level, msglevel,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                               permission_m=
ask, option_types_found, es);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                    line_num +=3D lines_inline;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            if (fp !=3D stdin)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                fclose(fp);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        else</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   msg(msglevel, &quot;In %s:%d: Error opening configuration file: %s&quot;=
, top_file, top_line,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                file);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        msg(msglevel,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            &quot;In %s:%d: Maximum recursive include le=
vels exceeded in include attempt of file %s -- probably you have a configur=
ation file that tries to include itself.&quot;,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            top_file, top_line, file);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    secure_memzero(line, sizeof(line));</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    CLEAR(p);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stat=
ic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_config_st=
ring(const char *prefix, struct options *options, const char *config,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                   const ms=
glvl_t msglevel, const unsigned int permission_mask,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                   unsigned int *option_typ=
es_found, struct env_set *es)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char lin=
e[OPTION_LINE_SIZE];</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   struct buffer multiline;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    int line_num =3D 0;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_set_r=
ead(&amp;multiline, (uint8_t *)config, strlen(config));</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    while (buf_parse(&amp;multiline, &#39;\n&#39;, line, sizeo=
f(line)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        char *p[MAX_PARMS + =
1];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        CLEAR(p);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ++line_num;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (parse_line(l=
ine, p, SIZE(p) - 1, prefix, line_num, msglevel, &amp;options-&gt;gc))</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            bypass_doubledash(&amp;p[0=
]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            int li=
nes_inline =3D check_inline_file_via_buf(&amp;multiline, p, &amp;options-&g=
t;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            add=
_option(options, p, lines_inline, prefix, line_num, 0, msglevel, permission=
_mask,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
        option_types_found, es);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            line_num +=3D lines_inline;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        CLEAR(p);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 secure_memzero(line, sizeof(line));</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-parse_argv(struct options *options, const i=
nt argc, char *argv[], const msglvl_t msglevel,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-           const unsigned int permission_mask, un=
signed int *option_types_found, struct env_set *es)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    /* usage message */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (argc &lt;=3D 1)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        usage();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    /* config filename specified only? */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (argc =3D=3D 2 =
&amp;&amp; strncmp(argv[1], &quot;--&quot;, 2))</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        char *p[MAX_PARMS + 1];</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        CLEAR(p);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        p[0] =3D &quot;config&quot;;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        p[1] =3D argv[1];</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        add_option(options, p, false, N=
ULL, 0, 0, msglevel, permission_mask, option_types_found,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                   es);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 /* parse command line */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        for (int i =3D 1; i &lt; argc; ++i)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            char *p[MAX_PARMS + 1];</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            CLEAR(p);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            p[0] =3D argv[i];</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            if (strncmp(p[0], &quot;--&=
quot;, 2))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg=
(msglevel,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         &quot;I&#39;m trying to parse \&quot;%s\&quot; as an --option para=
meter but I don&#39;t see a leading &#39;--&#39;&quot;,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    p[0]);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            else</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                p[0] +=3D 2;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         int j;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      for (j =3D 1; j &lt; MAX_PARMS; ++j)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                if (i + j &lt; argc)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                    char *arg =3D argv[i + j];</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                    if (st=
rncmp(arg, &quot;--&quot;, 2))</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                        p[j] =3D arg;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                    else</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                        break;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                    }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            add_option(options, p, false, NULL, 0,=
 0, msglevel, permission_mask, option_types_found,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                       es);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            i +=3D j - 1;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-apply_push_options(struct context *c, struct op=
tions *options, struct buffer *buf,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                   unsigned int permission_mask, unsigned int=
 *option_types_found,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                   struct env_set *es, bool is_update)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    char line[OPTION_PARM_SIZE];</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    int line_num =3D 0;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    const char *file =3D &quot;[PUSH-OPTIONS]&quo=
t;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const msglvl_t=
 msglevel =3D D_PUSH_ERRORS | M_OPTERR;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    unsigned int update_options_found =3D 0;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    while (buf_parse(buf, &#39;,&#39;, line, sizeof(lin=
e)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        char *p[MAX_PARMS + 1];</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        CLEAR(p);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        ++line_num;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        unsigned int push_upd=
ate_option_flags =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        int i =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* skip lead=
ing spaces matching the behaviour of parse_line */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        while (isspace(line[i]))</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            i++;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /*=
 If we are not in a &#39;PUSH_UPDATE&#39; we just check `apply_pull_filter(=
)`</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * otherwis=
e we must call `check_push_update_option_flags()` first</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-         */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        if ((is_update &amp;&amp; !check_push_updat=
e_option_flags(line, &amp;i, &amp;push_update_option_flags))</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            || !apply_pull_filter(op=
tions, &amp;line[i]))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
/* In case we are in a `PUSH_UPDATE` and `check_push_update_option_flags()`=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             * or `ap=
ply_pull_filter()` fail but the option is flagged by `PUSH_OPT_OPTIONAL`,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-             * instead =
of restarting, we just ignore the option and we process the next one</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-             */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            if (push_update_option=
_flags &amp; PUSH_OPT_OPTIONAL)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                continue; /* Ignoring this option */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            return false; /* Cause push/pull error=
 and stop push processing */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (parse_line(&am=
p;line[i], p, SIZE(p) - 1, file, line_num, msglevel, &amp;options-&gt;gc))<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            if (!is_update)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                add_option(options, =
p, false, file, line_num, 0, msglevel, permission_mask,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                           option_types_f=
ound, es);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            else if=
 (push_update_option_flags &amp; PUSH_OPT_TO_REMOVE)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                remove_option(c, options, p, false,=
 file, line_num, msglevel, permission_mask,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                              option_types_found, es)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            else</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                update_option(c, options,=
 p, false, file, line_num, 0, msglevel, permission_mask,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                              option_typ=
es_found, es, &amp;update_options_found);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return true;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-opti=
ons_server_import(struct options *o, const char *filename, msglvl_t msgleve=
l,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
   unsigned int permission_mask, unsigned int *option_types_found,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                      struct e=
nv_set *es)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_PUSH, &quot;OPTIONS =
IMPORT: reading client specific options from: %s&quot;, filename);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    read_config_file(o, filena=
me, 0, filename, 0, msglevel, permission_mask, option_types_found,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                     es);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-options_s=
tring_import(struct options *options, const char *config, const msglvl_t ms=
glevel,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
        const unsigned int permission_mask, unsigned int *option_types_foun=
d,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
   struct env_set *es)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    read_config_str=
ing(&quot;[CONFIG-STRING]&quot;, options, config, msglevel, permission_mask=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
   option_types_found, es);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an> #define VERIFY_PERMISSION(mask)                                        =
                       \</span><br><span>     {                            =
                                                             \</span><br><s=
pan>         if (!verify_permission(p[0], file, line, (mask), permission_ma=
sk, option_types_found, \</span><br><span>@@ -5642,27 +5067,7 @@</span><br>=
<span>         option_ptr-&gt;flags =3D 0;                 \</span><br><spa=
n>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @brief Res=
ets options found in the PUSH_UPDATE message that are preceded by the `-` f=
lag.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *        This fu=
nction is used in push-updates to reset specified options.</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- *        The number of parameters `p`=
 must always be 1. If the permission is verified,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- *        all related options are erased or res=
et to their default values.</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- *        Upon successful permission verification (by VERIFY_PERMISSI=
ON()),</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *        `opti=
on_types_found` is filled with the flag corresponding to the option.</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * @param c The context structure.</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * @param options A pointer to the=
 options structure.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 @param p An array of strings containing the options and their parameters.<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param is_inline A =
boolean indicating if the option is inline.</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * @param file The file where the function is called.=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param line The li=
ne number where the function is called.</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * @param msglevel The message level.</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * @param permission_mask The permission =
mask used by VERIFY_PERMISSION().</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * @param option_types_found A pointer to the variable where th=
e flags corresponding to the options</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * found are stored.</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * @param es The environment set structure.</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void</span><br><span> remove_option(struct context *c, struct opt=
ions *options, char *p[], bool is_inline,</span><br><span>               co=
nst char *file, int line, const msglvl_t msglevel,</span><br><span>        =
       const unsigned int permission_mask, unsigned int *option_types_found=
,</span><br><span>@@ -5982,30 +5387,7 @@</span><br><span>     return true;<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
@brief Processes an option to update. It first checks whether it has alread=
y</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *        received a=
n option of the same type within the same update message.</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- *        If the option has already bee=
n received, it calls add_option().</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- *        Otherwise, it deletes all existing values related to=
 that option before calling</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * add_option().</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param c The co=
ntext structure.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @p=
aram options A pointer to the options structure.</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * @param p An array of strings containing the o=
ptions and their parameters.</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * @param is_inline A boolean indicating if the option is inline.</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param file The file =
where the function is called.</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * @param line The line number where the function is called.</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * @param level The level of=
 the option.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param=
 msglevel The message level for logging.</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * @param permission_mask The permission mask used by VE=
RIFY_PERMISSION().</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
@param option_types_found A pointer to the variable where the flags corresp=
onding to the options</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * found are stored.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* @param es The environment set structure.</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * @param update_options_found A pointer to the variab=
le where the flags corresponding to the update</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * options found are stored, used to check if an o=
ption of the same type has already been processed</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * by update_option() within the same push-upda=
te message.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span> update_option(=
struct context *c, struct options *options, char *p[], bool is_inline,</spa=
n><br><span>               const char *file, int line, const int level, con=
st msglvl_t msglevel,</span><br><span>               const unsigned int per=
mission_mask, unsigned int *option_types_found,</span><br><span>@@ -6190,7 =
+5572,7 @@</span><br><span>     return ret;</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span> ad=
d_option(struct options *options, char *p[], bool is_inline, const char *fi=
le, int line,</span><br><span>            const int level, const msglvl_t m=
sglevel, const unsigned int permission_mask,</span><br><span>            un=
signed int *option_types_found, struct env_set *es)</span><br><span>diff --=
git a/src/openvpn/options.h b/src/openvpn/options.h</span><br><span>index b=
033068..f038975 100644</span><br><span>--- a/src/openvpn/options.h</span><b=
r><span>+++ b/src/openvpn/options.h</span><br><span>@@ -822,14 +822,83 @@</=
span><br><span>     struct pull_filter *tail;</span><br><span> };</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+void add_op=
tion(struct options *options, char *p[], bool is_inline, const char *file,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                int =
line, const int level, const msglvl_t msglevel,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                const unsigned int permission_m=
ask, unsigned int *option_types_found,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                struct env_set *es);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @brief Resets options found in the PUSH_UPDATE message that are precede=
d by the `-` flag.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*        This function is used in push-updates to reset specified options.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        The number=
 of parameters `p` must always be 1. If the permission is verified,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *        all related optio=
ns are erased or reset to their default values.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *        Upon successful permission verificati=
on (by VERIFY_PERMISSION()),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *        `option_types_found` is filled with the flag correspondi=
ng to the option.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param c The con=
text structure.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param options A pointer to the options structure.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param p An array of strings containing th=
e options and their parameters.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param is_inline A boolean indicating if the option is inlin=
e.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param file Th=
e file where the function is called.</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param line The line number where the function is calle=
d.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param msgleve=
l The message level.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param permission_mask The permission mask used by VERIFY_PERMISSION().=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param option_ty=
pes_found A pointer to the variable where the flags corresponding to the op=
tions</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * found are s=
tored.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param es =
The environment set structure.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void =
remove_option(struct context *c, struct options *options, char *p[], bool i=
s_inline,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
         const char *file, int line, const msglvl_t msglevel,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                   const unsigned=
 int permission_mask, unsigned int *option_types_found,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                   struct env_set *es);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @brief Processes an option to update. It first chec=
ks whether it has already</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *        received an option of the same type within the same update =
message.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        I=
f the option has already been received, it calls add_option().</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *        Otherwise, it deletes =
all existing values related to that option before calling</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * add_option().</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param c The context structure.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param options A pointer to the option=
s structure.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am p An array of strings containing the options and their parameters.</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param is_inline A boo=
lean indicating if the option is inline.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param file The file where the function is called.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param line The l=
ine number where the function is called.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param level The level of the option.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param msglevel The message le=
vel for logging.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param permission_mask The permission mask used by VERIFY_PERMISSION().</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param option_types_=
found A pointer to the variable where the flags corresponding to the option=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * found are store=
d.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param es The =
environment set structure.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param update_options_found A pointer to the variable where the f=
lags corresponding to the update</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * options found are stored, used to check if an option of the=
 same type has already been processed</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * by update_option() within the same push-update message=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void update_option(struct context =
*c, struct options *options, char *p[], bool is_inline,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                   const char *file, in=
t line, const int level, const msglvl_t msglevel,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                   const unsigned int permiss=
ion_mask, unsigned int *option_types_found,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                   struct env_set *es, unsigned int=
 *update_options_found);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> void parse_argv(struct options *options, const int a=
rgc, char *argv[], const msglvl_t msglevel,</span><br><span>               =
  const unsigned int permission_mask, unsigned int *option_types_found,</sp=
an><br><span>                 struct env_set *es);</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+void read_config_file(stru=
ct options *options, const char *file, int level, const char *top_file,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                      c=
onst int top_line, const msglvl_t msglevel,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                      const unsigned int permission=
_mask, unsigned int *option_types_found,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                      struct env_set *es);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+void read_config_string(const char *prefix, struct=
 options *options, const char *config,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                        const msglvl_t msglevel, const u=
nsigned int permission_mask,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                        unsigned int *option_types_found, struct e=
nv_set *es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span> void notnull(const char *arg, const char *description);</span><b=
r><span> </span><br><span> void usage_small(void);</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+void usage(void);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void show_=
library_versions(const unsigned int flags);</span><br><span> </span><br><sp=
an> #ifdef _WIN32</span><br><span>diff --git a/src/openvpn/options_parse.c =
b/src/openvpn/options_parse.c</span><br><span>new file mode 100644</span><b=
r><span>index 0000000..bb5b404</span><br><span>--- /dev/null</span><br><spa=
n>+++ b/src/openvpn/options_parse.c</span><br><span>@@ -0,0 +1,592 @@</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely=
 tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             over a single UDP port, with support for SSL/TLS-based</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             session au=
thentication and key exchange,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *             packet encryption, packet authentication, and</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet c=
ompression.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-20=
25 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  Copyright (C) 2008-2025 David Sommerseth &lt;dazo@...1186...=
.2108...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free=
 software; you can redistribute it and/or modify</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Publ=
ic License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  as published by the Free Software Foundation.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  This program is distributed in the hope that it will be u=
seful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHO=
UT ANY WARRANTY; without even the implied warranty of</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PART=
ICULAR PURPOSE.  See the</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  GNU General Public License for more details.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  You should have received a copy of the GNU General Pub=
lic License along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;config.h&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &lt;string.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;op=
tions.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;options_util.h&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;push.h&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bypass_do=
ubledash(char **p)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (strlen(*p) =
&gt;=3D 3 &amp;&amp; !strncmp(*p, &quot;--&quot;, 2))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        *p +=3D 2;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static inline bool</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+space(char c)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return c =3D=3D &#39;\0&#39; || isspace(c);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+parse_l=
ine(const char *line, char *p[], const int n, const char *file, const int l=
ine_num,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
msglvl_t msglevel, struct gc_arena *gc)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const int STATE_INITIAL =3D 0;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const int STATE_READING_QUOTED_PARM =3D 1;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const int STATE_READING_UNQ=
UOTED_PARM =3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const int STATE_DONE =3D 3;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const int STATE_READING_SQUOTED_PARM =3D 4;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const char *error_prefix =3D &quot;&quot;;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    int ret =3D 0;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const char *c =3D line;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int state =3D STATE_INITIAL;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    bool backslash =3D false=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char in, out;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    char parm[OPTION_PARM_SIZE];</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int parm_len =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    msglevel &amp;=3D ~M_OPTERR;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (msglevel &amp; M_MSG_VIRT_OUT)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        error_prefix =3D &quot;ER=
ROR: &quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    do</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        in =3D *c;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        out =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!=
backslash &amp;&amp; in =3D=3D &#39;\\&#39; &amp;&amp; state !=3D STATE_REA=
DING_SQUOTED_PARM)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 backslash =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        e=
lse</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            if (state =3D=
=3D STATE_INITIAL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         if (!space(in))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    if (in =3D=3D &#39;;&#39; || in =3D=3D &#39;#&#39;) =
/* comment */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                    break;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    if (!backslash &amp;&amp; in =3D=3D &#39;\&quo=
t;&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
               state =3D STATE_READING_QUOTED_PARM;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    else if (!backslash=
 &amp;&amp; in =3D=3D &#39;\&#39;&#39;)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                        state =3D STATE_READING_SQUOT=
ED_PARM;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
           else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                      out =3D in;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                        state =3D STATE_READING_UNQUOTED_PARM=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            else if (sta=
te =3D=3D STATE_READING_UNQUOTED_PARM)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                if (!backslash &amp;&amp; space(in))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                    state =3D S=
TATE_DONE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        out =3D in;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    else if (state =3D=3D STATE_READING_QUOTED_PARM)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                if (!backslash &amp;&amp; in =
=3D=3D &#39;\&quot;&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    state =3D STATE_DONE;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                else</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    out =3D in;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            else if (state =3D=3D STATE_READING=
_SQUOTED_PARM)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     if (in =3D=3D &#39;\&#39;&#39;)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                    state =3D STATE_DONE;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                else</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    out =3D in;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            if (state =3D=3D STATE_DO=
NE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                /* ASS=
ERT (parm_len &gt; 0); */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                p[ret] =3D gc_malloc(parm_len + 1, true, gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                memcpy(p[re=
t], parm, parm_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                p[ret][parm_len] =3D &#39;\0&#39;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                state =3D STATE_INITIAL;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                parm=
_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        ++ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            if (backslash &amp=
;&amp; out)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  if (!(out =3D=3D &#39;\\&#39; || out =3D=3D &#39;\&quot;&#39; || space(ou=
t)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_SMA=
LL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   msg(msglevel, &quot;%sOptions warning: Bad backslash (&#39;\\&#39;) usag=
e in %s:%d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                      error_prefix, file, line_num);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                    msg(msglevel,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        &quot;%sOptions w=
arning: Bad backslash (&#39;\\&#39;) usage in %s:%d: remember that backslas=
hes are treated as shell-escapes and if you need to pass backslash characte=
rs as part of a Windows filename, you should use double backslashes such as=
 \&quot;c:\\\\&quot; PACKAGE</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                        &quot;\\\\static.key\&quot;&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                        err=
or_prefix, file, line_num);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
               return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         backslash =3D false;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* store pa=
rameter character */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (out)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
if (parm_len &gt;=3D SIZE(parm))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                parm[SIZE(parm) - 1] =3D 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                msg(msglevel, &quot;%sOption=
s error: Parameter at %s:%d is too long (%d chars max): %s&quot;,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                    error_pre=
fix, file, line_num, (int)SIZE(parm), parm);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                return 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            parm[parm_len++] =3D out;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        /* avoid overflow if too many parms in one config fi=
le line */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (ret &gt;=3D n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    } while (*c++ !=3D &#39;\0&#39;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (state =3D=3D STATE_READING_QUOTED=
_PARM)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel, &quot=
;%sOptions error: No closing quotation (\&quot;) in %s:%d&quot;, error_pref=
ix, file,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  line_num);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (state =3D=3D ST=
ATE_READING_SQUOTED_PARM)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
msg(msglevel, &quot;%sOptions error: No closing single quotation (\&#39;) i=
n %s:%d&quot;, error_prefix,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            file, line_num);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        return 0;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (state !=3D STATE_INITIAL)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        msg(msglevel, &quot;%sOptions error: Residual parse state (%d) in=
 %s:%d&quot;, error_prefix, state,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            file, line_num);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#if 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int i;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (i =3D 0; i &=
lt; ret; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(=
M_INFO|M_NOPREFIX, &quot;%s:%d ARG[%d] &#39;%s&#39;&quot;, file, line_num, =
i, p[i]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct in_src=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#define IS_TYPE_FP  1</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define IS_TYPE_BUF 2</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    int type;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    union</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        FILE *fp;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        struct buffer *multiline;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    } u;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+in_src_get(const struct in_src =
*is, char *line, const int size)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (is-&gt;type =3D=3D IS_TYPE_FP)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        return BOOL_CAST(fgets(line, size, is-&gt;u.fp));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    else if (is-&gt;type =3D=3D IS_TYPE_BUF)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        bool status =3D buf_parse(is-&gt=
;u.multiline, &#39;\n&#39;, line, size);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if ((int)strlen(line) + 1 &lt; size)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            strcat(line, &quot;\n&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return status;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        ASSERT(0);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static char *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+read_inline_file(struct in_src *is, const ch=
ar *close_tag, int *num_lines, struct gc_arena *gc)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    char line[OPTION_LINE_SIZE];</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf(8 * OPTION=
_LINE_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cha=
r *ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool end=
tagfound =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (in_src_g=
et(is, line, sizeof(line)))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  (*num_lines)++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      char *line_ptr =3D line;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        /* Remove leading spaces */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        while (isspace(*line_ptr))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            line_ptr++;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (!strncmp(line_ptr, close_tag, strle=
n(close_tag)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            end=
tagfound =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
!buf_safe(&amp;buf, strlen(line) + 1))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            /* Increase buffer size */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            struct buffer buf2 =3D alloc_buf(bu=
f.capacity * 2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         ASSERT(buf_copy(&amp;buf2, &amp;buf));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            buf_clear(&amp;buf);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            free_buf(&amp;buf);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf =3D bu=
f2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;bu=
f, &quot;%s&quot;, line);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
!endtagfound)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL,=
 &quot;ERROR: Endtag %s missing&quot;, close_tag);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    ret =3D string_alloc(BSTR(&amp;buf), gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    buf_clear(&amp;buf);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;buf);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    secure_memzero(line=
, sizeof(line));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+check_inline_file(struct in_src *is, char *p[], struc=
t gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int num_inline_lin=
es =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (p[0] &amp;&amp; !p[1]=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        char *arg =3D p[0];</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (arg[0] =3D=
=3D &#39;&lt;&#39; &amp;&amp; arg[strlen(arg) - 1] =3D=3D &#39;&gt;&#39;)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            struct buffer close=
_tag;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            arg[strlen(arg) - 1] =
=3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          p[0] =3D string_alloc(arg + 1, gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            close_tag =3D alloc_buf(strlen(p[0]) =
+ 4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            bu=
f_printf(&amp;close_tag, &quot;&lt;/%s&gt;&quot;, p[0]);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            p[1] =3D read_inline_file(=
is, BSTR(&amp;close_tag), &amp;num_inline_lines, gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            p[2] =3D NULL;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            free_buf(&amp;close_ta=
g);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return num_inline_lines;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ch=
eck_inline_file_via_fp(FILE *fp, char *p[], struct gc_arena *gc)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct in_src is;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    is.type =3D IS_TYPE_FP;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    is.u.fp =3D fp;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return check_inline_file(&amp;is, =
p, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+check_inline_file_via_buf(struct buffer *multiline, char *=
p[], struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct i=
n_src is;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    is.typ=
e =3D IS_TYPE_BUF;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   is.u.multiline =3D multiline;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    return check_inline_file(&amp;is, p, gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read_config_f=
ile(struct options *options, const char *file, int level, const char *top_f=
ile,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
  const int top_line, const msglvl_t msglevel,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                 const unsigned int permission_m=
ask, unsigned int *option_types_found,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                 struct env_set *es)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const int max_recursive_levels =3D 10;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    FILE *fp;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    int line_num;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    char line[OPTION_LINE_SIZE + 1];</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *p[MAX_PARMS + =
1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    ++level;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (level &lt;=3D max_recursive_level=
s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (streq(file, &quot;s=
tdin&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            fp =
=3D stdin;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            fp =3D platform_fopen(fi=
le, &quot;r&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (fp)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            line_num =3D=
 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            whil=
e (fgets(line, sizeof(line), fp))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                int offset =3D 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                CLEAR(p);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                ++line_num;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                if (strlen(line) =3D=3D=
 OPTION_LINE_SIZE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                 msg(msglevel,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                        &quot;In %s:%d: Maximum option line leng=
th (%d) exceeded, line starts with %s&quot;,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                        file, line_num, OPTION_LIN=
E_SIZE, line);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                /* Ignore =
UTF-8 BOM at start of stream */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                if (line_num =3D=3D 1 &amp;&amp; strncmp(line, =
&quot;\xEF\xBB\xBF&quot;, 3) =3D=3D 0)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                    offset =3D 3;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                if (parse_line(line + offset, =
p, SIZE(p) - 1, file, line_num, msglevel,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                               &amp;options-&gt;gc))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    by=
pass_doubledash(&amp;p[0]);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                    int lines_inline =3D check_inline_file_via_fp(f=
p, p, &amp;options-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                    add_option(options, p, lines_inline, file, line=
_num, level, msglevel,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                               permission_mask, option_types_found, es);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 line_num +=3D lines_inline;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            if (fp !=3D stdin)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                fclose(fp);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(msg=
level, &quot;In %s:%d: Error opening configuration file: %s&quot;, top_file=
, top_line,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        file);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        msg(msglevel,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            &quot;In %s:%d: Maximum recursive includ=
e levels exceeded in include attempt of file %s -- probably you have a conf=
iguration file that tries to include itself.&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            top_file, top_line, file);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    secure_memzero(line, sizeof(line=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(p);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+read_config_string(const char *prefix, struct options *options, const char=
 *config,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
         const msglvl_t msglevel, const unsigned int permission_mask,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                   unsign=
ed int *option_types_found, struct env_set *es)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    char line[OPTION_LINE_SIZE];</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct buffer multiline;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int line_num =3D 0;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    buf_set_read(&amp;multiline, (uint8_t *)config, strl=
en(config));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    while (buf_parse(&amp;=
multiline, &#39;\n&#39;, line, sizeof(line)))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        char *p[MAX_PARMS + 1];</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        CLEAR(p);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        ++line_num;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (parse_line(line, p, SIZE(p) - 1, prefix, =
line_num, msglevel, &amp;options-&gt;gc))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            bypass_doubledash(&amp;p[0]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            int lines_inline =3D check_in=
line_file_via_buf(&amp;multiline, p, &amp;options-&gt;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            add_option(options, p, l=
ines_inline, prefix, line_num, 0, msglevel, permission_mask,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                       option_type=
s_found, es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      line_num +=3D lines_inline;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        CLEAR(p);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    secure_m=
emzero(line, sizeof(line));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+parse_argv(struct options *options, const in=
t argc, char *argv[], const msglvl_t msglevel,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+           const unsigned int permission_mask, u=
nsigned int *option_types_found, struct env_set *es)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* usage message */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (argc &lt;=3D 1)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        usage();</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* config filename spe=
cified only? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (argc =3D=3D 2 &amp;&amp; strncmp(argv[1], &quot;--&quot;, 2))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        char *p[MAX_PARMS + 1];</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        CLEAR(p);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        p[0] =3D &quot;config&q=
uot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        p[1] =
=3D argv[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 add_option(options, p, false, NULL, 0, 0, msglevel, permission_mask, optio=
n_types_found,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
              es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        /* parse command line */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 1; i=
 &lt; argc; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            c=
har *p[MAX_PARMS + 1];</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            CLEAR(p);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            p[0] =3D argv[i];</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            if (strncmp(p[0], &quot;--&quot;, 2))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                msg(msglevel,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                    &quot;=
I&#39;m trying to parse \&quot;%s\&quot; as an --option parameter but I don=
&#39;t see a leading &#39;--&#39;&quot;,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    p[0]);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            else</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                p[0] +=3D 2;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         int j;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        for (j =3D 1; j &lt; MAX_PARMS; ++j)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                if (i + j &lt; argc)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    char *arg =3D argv[i =
+ j];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
      if (strncmp(arg, &quot;--&quot;, 2))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                        p[j] =3D arg;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    else</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
 break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            add_op=
tion(options, p, false, NULL, 0, 0, msglevel, permission_mask, option_types=
_found,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
           es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        i +=3D j - 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+apply_push_options(struct context *c, struct options *options, struct buff=
er *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
        unsigned int permission_mask, unsigned int *option_types_found,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                   stru=
ct env_set *es, bool is_update)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ch=
ar line[OPTION_PARM_SIZE];</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int line_num =3D 0;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const char *file =3D &quot;[PUSH-OPTIONS]&quot;;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const msglvl_t msglevel =3D=
 D_PUSH_ERRORS | M_OPTERR;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    unsigned int update_options_found =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    while (buf_parse(buf, &#39;,&#39;, line, sizeof(line)))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        char *p[MAX_PARMS + 1];</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        CLEAR(p);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        ++line_num;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        unsigned int pus=
h_update_option_flags =3D 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        int i =3D 0;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /=
* skip leading spaces matching the behaviour of parse_line */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        while (isspace(line[i]))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            i++;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        /* If we are not in a &#39;PUSH_UPDATE&#39; we just =
check `apply_pull_filter()`</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+         * otherwise we must call `check_push_update_option_flags()=
` first</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if ((is_upda=
te &amp;&amp; !check_push_update_option_flags(line, &amp;i, &amp;push_updat=
e_option_flags))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         || !apply_pull_filter(options, &amp;line[i]))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            /* In case we are in a `PUSH_UPDATE` a=
nd `check_push_update_option_flags()`</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+             * or `apply_pull_filter()` fail but the opti=
on is flagged by `PUSH_OPT_OPTIONAL`,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+             * instead of restarting, we just ignore the =
option and we process the next one</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+             */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            if (push_update_option_flags &amp; PUSH_OPT_OPTIONAL=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                continue=
; /* Ignoring this option */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            return false; /* Cause push/pull error and stop push process=
ing */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (parse_line(&amp;line[i], p, S=
IZE(p) - 1, file, line_num, msglevel, &amp;options-&gt;gc))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            if (!is_update)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                add_option(options, p, fa=
lse, file, line_num, 0, msglevel, permission_mask,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                           option_types_foun=
d, es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            else i=
f (push_update_option_flags &amp; PUSH_OPT_TO_REMOVE)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                remove_option(c, options, p, fa=
lse, file, line_num, msglevel, permission_mask,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                              option_types_foun=
d, es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            else</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                update_opti=
on(c, options, p, false, file, line_num, 0, msglevel, permission_mask,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
      option_types_found, es, &amp;update_options_found);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+options_server_import(struct options *o, cons=
t char *filename, msglvl_t msglevel,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                      unsigned int permission_mask, unsign=
ed int *option_types_found,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                      struct env_set *es)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    msg(D_PUSH, &quot;OPTIONS IMPORT: reading client specific o=
ptions from: %s&quot;, filename);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    read_config_file(o, filename, 0, filename, 0, msglevel, p=
ermission_mask, option_types_found,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                     es);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+options_string_import(struct o=
ptions *options, const char *config, const msglvl_t msglevel,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                      const unsig=
ned int permission_mask, unsigned int *option_types_found,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                      struct env_set=
 *es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    read_config_string(&quot;[CO=
NFIG-STRING]&quot;, options, config, msglevel, permission_mask,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                       option_t=
ypes_found, es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1242?usp=3Demail">change 1242</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://=
schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1242?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I18e38862df1318740928c6cfa21=
dc4dcd7d44b89 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1242 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--fqIn/R+vi5U=--

