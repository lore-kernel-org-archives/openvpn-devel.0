From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 7 Oct 2025 20:12:15 +0000
In-Reply-To: <gerrit.1759239739000.I18e38862df1318740928c6cfa21dc4dcd7d44b89@...2715...>
References: <gerrit.1759239739000.I18e38862df1318740928c6cfa21dc4dcd7d44b89@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a036dd9c04a5e155ebe59739e921bf0a15e7df9d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AKvBr/gqBjc="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--AKvBr/gqBjc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1242?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/42/1242/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I18e38862df1318740928c6cfa21dc4dcd7d44b89
Gerrit-Change-Number: 1242
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--AKvBr/gqBjc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1242?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">options: Factor out parsing code to=
 separate options_parse.c<br><br>For easier testability. And because everyt=
hing that<br>reduces the length of that file in a sensible manner<br>is a g=
ood idea.<br><br>Change-Id: I18e38862df1318740928c6cfa21dc4dcd7d44b89<br>Si=
gned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert D=
oering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/=
openvpn/+/1242<br>Message-Id: &lt;20251007185110.19267-1-gert@...1296...&gt=
;<br>URL: https://sourceforge.net/p/openvpn/mailman/message/59243506/<br>Si=
gned-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M CMakeLists.tx=
t<br>M src/openvpn/Makefile.am<br>M src/openvpn/common.h<br>M src/openvpn/o=
ptions.c<br>M src/openvpn/options.h<br>A src/openvpn/options_parse.c<br>6 f=
iles changed, 669 insertions(+), 622 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/42/1242/2<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index =
3f6196f..be66357 100644</span><br><span>--- a/CMakeLists.txt</span><br><spa=
n>+++ b/CMakeLists.txt</span><br><span>@@ -513,6 +513,7 @@</span><br><span>=
     src/openvpn/options.h</span><br><span>     src/openvpn/options_util.c<=
/span><br><span>     src/openvpn/options_util.h</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    src/openvpn/options_parse.c</span><br><span=
>     src/openvpn/otime.c</span><br><span>     src/openvpn/otime.h</span><b=
r><span>     src/openvpn/ovpn_dco_win.h</span><br><span>diff --git a/src/op=
envpn/Makefile.am b/src/openvpn/Makefile.am</span><br><span>index 1247f11..=
e44fb2b 100644</span><br><span>--- a/src/openvpn/Makefile.am</span><br><spa=
n>+++ b/src/openvpn/Makefile.am</span><br><span>@@ -109,6 +109,7 @@</span><=
br><span> 	openvpn.c openvpn.h \</span><br><span> 	options.c options.h \</s=
pan><br><span> 	options_util.c options_util.h \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+	options_parse.c \</span><br><span> 	otime.c ot=
ime.h \</span><br><span> 	packet_id.c packet_id.h \</span><br><span> 	perf.=
c perf.h \</span><br><span>diff --git a/src/openvpn/common.h b/src/openvpn/=
common.h</span><br><span>index c0947da..7779614 100644</span><br><span>--- =
a/src/openvpn/common.h</span><br><span>+++ b/src/openvpn/common.h</span><br=
><span>@@ -23,6 +23,8 @@</span><br><span> #ifndef COMMON_H</span><br><span>=
 #define COMMON_H</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &lt;stdint.h&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * Statistics c=
ounters and associated printf format.</span><br><span>  */</span><br><span>=
diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>=
index f35738d..f2e6dec 100644</span><br><span>--- a/src/openvpn/options.c</=
span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -4838,7 +4838=
,7 @@</span><br><span> /*</span><br><span>  * Print the help message.</span=
><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static=
 void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br=
><span> usage(void)</span><br><span> {</span><br><span>     FILE *fp =3D ms=
g_fp(0);</span><br><span>@@ -4967,581 +4967,6 @@</span><br><span> }</span><=
br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-static inline bool</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-space(char c)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return c =3D=
=3D &#39;\0&#39; || isspace(c);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-parse_line(const char *line, char *p[], const int=
 n, const char *file, const int line_num,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-           msglvl_t msglevel, struct gc_arena *gc)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    const int STATE_INITIAL =3D 0;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    const int STATE_READING_QUOTE=
D_PARM =3D 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cons=
t int STATE_READING_UNQUOTED_PARM =3D 2;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    const int STATE_DONE =3D 3;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    const int STATE_READING_SQUOTED_PARM =3D 4=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    const char *error_prefix =3D &quot;&q=
uot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D 0;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    const char *c =3D line;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    int state =3D STATE_INITIAL;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool backslash =3D =
false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char in, ou=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    char parm[OPTION_PARM_SIZE];</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int parm_len =3D=
 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    msglevel &amp;=3D ~M_OPTERR;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (msglevel &amp; M_MSG_VIRT_OUT)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        error_prefix =3D &quot;ERROR: &quot;;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    do</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        in =3D *c=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        out =3D 0;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (!backslash &amp;&amp; in =3D=3D=
 &#39;\\&#39; &amp;&amp; state !=3D STATE_READING_SQUOTED_PARM)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            backslash =3D true;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            if (state =3D=3D STATE_INITIAL)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                if (!space(in))</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    if (in =3D=3D &#39;;&#3=
9; || in =3D=3D &#39;#&#39;) /* comment */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                        break;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    if (!backslash &amp;&am=
p; in =3D=3D &#39;\&quot;&#39;)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                        state =3D STATE_READING_QUOTED_PARM;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                    else i=
f (!backslash &amp;&amp; in =3D=3D &#39;\&#39;&#39;)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        state =3D STATE_REA=
DING_SQUOTED_PARM;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                 else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                        out =3D in;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                        state =3D STATE_READING_UNQUOTED_PARM=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            else if (state =3D=
=3D STATE_READING_UNQUOTED_PARM)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                if (!backslash &amp;&amp; space(in))</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    state =3D STATE_DONE;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                else</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                    out =3D in;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            else if (state =3D=3D =
STATE_READING_QUOTED_PARM)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             if (!backslash &amp;&amp; in =3D=3D &#39;\&quot;&#39;)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    state =3D STA=
TE_DONE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                e=
lse</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    ou=
t =3D in;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            else if (sta=
te =3D=3D STATE_READING_SQUOTED_PARM)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                if (in =3D=3D &#39;\&#39;&#39;)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    state =3D STATE_DONE;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                else</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                    out =3D in;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            if (state =3D=3D STATE=
_DONE)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                /* ASSE=
RT (parm_len &gt; 0); */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                p[ret] =3D gc_malloc(parm_len + 1, true, gc);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                memcpy(p[ret], p=
arm, parm_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          p[ret][parm_len] =3D &#39;\0&#39;;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                state =3D STATE_INITIAL;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                parm_len =3D 0;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                ++ret;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            if (backslash &amp;&amp; out)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                if (!(out =3D=3D &#39;\=
\&#39; || out =3D=3D &#39;\&quot;&#39; || space(out)))</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_SMALL</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                    msg(msglevel, &quot;%sOption=
s warning: Bad backslash (&#39;\\&#39;) usage in %s:%d&quot;,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                        error_prefi=
x, file, line_num);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
lse</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
  msg(msglevel,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                  &quot;%sOptions warning: Bad backslash (&#39;\\&#39;) usa=
ge in %s:%d: remember that backslashes are treated as shell-escapes and if =
you need to pass backslash characters as part of a Windows filename, you sh=
ould use double backslashes such as \&quot;c:\\\\&quot; PACKAGE</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                        &quot;\\\=
\static.key\&quot;&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                        error_prefix, file, line_num);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                    return 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            backslash =3D false;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       /* store parameter character */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (out)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            if (parm_len &gt;=3D SIZE(parm))</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                parm[SIZE(parm) - 1] =3D 0;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                msg(msglevel, &quot;%s=
Options error: Parameter at %s:%d is too long (%d chars max): %s&quot;,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                    error=
_prefix, file, line_num, (int)SIZE(parm), parm);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                return 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            parm[parm_len++] =3D out;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        /* avoid overflow if too many parms in one config file line =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (ret &gt=
;=3D n)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            break;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    } while (*c++ !=3D &#39;\0&#39;);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (state =3D=3D STATE_READING_QUOTED_PARM)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        msg(msglevel, &quot;%sOptions error: No closing q=
uotation (\&quot;) in %s:%d&quot;, error_prefix, file,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            line_num);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        return 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (state =3D=3D STATE_READING_SQUOTED_PARM)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        msg(msglevel, &quot;%sOptions error: No =
closing single quotation (\&#39;) in %s:%d&quot;, error_prefix,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            file, line_num);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        return 0;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (state !=3D STATE_INITIAL)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        msg(msglevel, &quot;%sOptions error: Resid=
ual parse state (%d) in %s:%d&quot;, error_prefix, state,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            file, line_num);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        return 0;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#if 0</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
nt i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        for (i =
=3D 0; i &lt; ret; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  msg(M_INFO|M_NOPREFIX, &quot;%s:%d ARG[%d] &#39;%s&#39;&quot;, file, line=
_num, i, p[i]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    return ret;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-bypass_doubledash(char **p)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (strlen(*p) &gt;=3D 3 &amp;&amp; !st=
rncmp(*p, &quot;--&quot;, 2))</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
*p +=3D 2;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-struct in_src</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IS_TYPE_FP  1=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IS_TYPE_BUF 2=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int type;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    union</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        FILE *fp;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        struct buffer *multiline;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    } u;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-in_src_get(const struct in_src *is, c=
har *line, const int size)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (is-&gt;=
type =3D=3D IS_TYPE_FP)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return=
 BOOL_CAST(fgets(line, size, is-&gt;u.fp));</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    else if (is-&gt;type =3D=3D IS_TYPE_BUF)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        bool status =3D buf_parse(is-&gt;u.multiline, &#39;\n&=
#39;, line, size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     if ((int)strlen(line) + 1 &lt; size)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            strcat(line, &quot;\n&quot;);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return status;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(0);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        return false;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static char *=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_inline_file(stru=
ct in_src *is, const char *close_tag, int *num_lines, struct gc_arena *gc)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    char line[OPTION_LINE_SIZE];</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer buf =3D alloc=
_buf(8 * OPTION_LINE_SIZE);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    char *ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   bool endtagfound =3D false;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    while (i=
n_src_get(is, line, sizeof(line)))</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     (*num_lines)++;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       char *line_ptr =3D line;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        /* Remove leading spaces */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        while (isspace(*line_ptr))</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            line_ptr++;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        if (!strncmp(line_ptr, close_tag, strlen(close_tag))=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            endtagfound =3D true=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            break;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        if (!buf_safe(&amp;buf, str=
len(line) + 1))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* Inc=
rease buffer size */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           struct buffer buf2 =3D alloc_buf(buf.capacity * 2);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            ASSERT(buf_copy(&amp;b=
uf2, &amp;buf));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       buf_clear(&amp;buf);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            free_buf(&amp;buf);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            buf =3D buf2;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        buf_printf(&amp;buf, &quot;%s&quot;, line);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (!endtagfound)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        msg(M_FATAL, &quot;ERROR: Endtag %s missing&quot;, close_tag)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    ret =3D string_alloc(BSTR(&amp;b=
uf), gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_clea=
r(&amp;buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    free_=
buf(&amp;buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sec=
ure_memzero(line, sizeof(line));</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    return ret;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-static int</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-check_inline_file(struct in_src *is, char *p[],=
 struct gc_arena *gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int num_inline_l=
ines =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (p[0] &amp;&amp; !p[1])<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        char *arg =3D p[0];</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        if (arg[0] =3D=3D &#39;&=
lt;&#39; &amp;&amp; arg[strlen(arg) - 1] =3D=3D &#39;&gt;&#39;)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            struct buffer close_tag;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            arg[strlen(arg) - 1] =3D &#39;\0&#39;=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            p[0] =3D=
 string_alloc(arg + 1, gc);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            close_tag =3D alloc_buf(strlen(p[0]) + 4);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            buf_printf(&amp;close_ta=
g, &quot;&lt;/%s&gt;&quot;, p[0]);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            p[1] =3D read_inline_file(is, BSTR(&amp;close_tag)=
, &amp;num_inline_lines, gc);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            p[2] =3D NULL;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            free_buf(&amp;close_tag);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    return num_inline_lines;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-static int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-check_inline_file_via_fp(FILE *fp, char *p[=
], struct gc_arena *gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct in_src =
is;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    is.type =3D IS=
_TYPE_FP;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    is.u.fp =
=3D fp;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return che=
ck_inline_file(&amp;is, p, gc);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-static int</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-check_inline_file_via_buf(struct buffer *m=
ultiline, char *p[], struct gc_arena *gc)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    struct in_src is;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    is.type =3D IS_TYPE_BUF;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    is.u.multiline =3D multiline;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    return check_inline_file(&amp;is, p, gc);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-static void add_option(struct options *options, char *p[], bool is_inline=
, const char *file,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                     int line, const int level, const msglvl_t msglevel,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                       c=
onst unsigned int permission_mask, unsigned int *option_types_found,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                       struc=
t env_set *es);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-static void remove_option(s=
truct context *c, struct options *options, char *p[], bool is_inline,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                          c=
onst char *file, int line, const msglvl_t msglevel,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                          const unsigned in=
t permission_mask, unsigned int *option_types_found,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                          struct env_set *e=
s);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-static void update_option(struct contex=
t *c, struct options *options, char *p[], bool is_inline,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                          const char *f=
ile, int line, const int level, const msglvl_t msglevel,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                          const unsigned=
 int permission_mask, unsigned int *option_types_found,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                          struct env_set =
*es, unsigned int *update_options_found);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-s=
tatic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_config=
_file(struct options *options, const char *file, int level, const char *top=
_file,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
  const int top_line, const msglvl_t msglevel,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                 const unsigned int permission_mas=
k, unsigned int *option_types_found,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                 struct env_set *es)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    const int max_recursive_levels =3D 10;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    FILE *fp;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    int line_num;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    char line[OPTION_LINE_SIZE + 1];</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    char *p[MAX_PARMS + 1];</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    ++level;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (level &lt;=3D max_recursive_levels)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (streq(file, &quot;stdin&quot;))</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            fp =3D stdin;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        else</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           fp =3D platform_fopen(file, &quot;r&quot;);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (fp)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            line_num =3D 0;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            while (fgets(line, sizeof(line), fp))</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                int offset =3D 0;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                CLEAR(p);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                ++line_num;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (strl=
en(line) =3D=3D OPTION_LINE_SIZE)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                    msg(msglevel,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                        &quot;In %s:%d: Maximum option =
line length (%d) exceeded, line starts with %s&quot;,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        file, line_num, OPT=
ION_LINE_SIZE, line);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                /* Ignore=
 UTF-8 BOM at start of stream */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                if (line_num =3D=3D 1 &amp;&amp; strncmp(line, &=
quot;\xEF\xBB\xBF&quot;, 3) =3D=3D 0)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                    offset =3D 3;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                if (parse_line(line + offset, p, SIZE(p=
) - 1, file, line_num, msglevel,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                               &amp;options-&gt;gc))</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                    bypass_doubledash=
(&amp;p[0]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
           int lines_inline =3D check_inline_file_via_fp(fp, p, &amp;option=
s-&gt;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         add_option(options, p, lines_inline, file, line_num, level, msglev=
el,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
             permission_mask, option_types_found, es);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                    line_num +=3D lines_in=
line;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            if (fp !=3D stdi=
n)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                fclose(fp);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            msg(msglevel, &quot;In %s:%d: Error opening config=
uration file: %s&quot;, top_file, top_line,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                file);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    e=
lse</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        msg(msglevel,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            &quot;In %s:%d: Maximu=
m recursive include levels exceeded in include attempt of file %s -- probab=
ly you have a configuration file that tries to include itself.&quot;,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            top_file, top_l=
ine, file);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    secure_memzero(line, s=
izeof(line));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    CLEA=
R(p);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-read_config_string(const char *prefix, struct options *options, con=
st char *config,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
              const msglvl_t msglevel, const unsigned int permission_mask,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   uns=
igned int *option_types_found, struct env_set *es)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    char line[OPTION_LINE_SIZE];</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    struct buffer multiline;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    int line_num =3D 0;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    buf_set_read(&amp;multiline, (uint8_t *)config, strlen(config))=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    while (buf_parse(&amp;multiline, &#39=
;\n&#39;, line, sizeof(line)))</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 char *p[MAX_PARMS + 1];</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        CLEAR(p);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       ++line_num;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     if (parse_line(line, p, SIZE(p) - 1, prefix, line_num, msglevel, &amp;=
options-&gt;gc))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            bypas=
s_doubledash(&amp;p[0]);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            int lines_inline =3D check_inline_file_via_buf(&amp;multilin=
e, p, &amp;options-&gt;gc);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            add_option(options, p, lines_inline, prefix, line_num, 0,=
 msglevel, permission_mask,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                       option_types_found, es);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            line_num +=3D lines_inline;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        CLEAR(p);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    secure_memzero(line, sizeof(line));</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-parse_argv(struct opti=
ons *options, const int argc, char *argv[], const msglvl_t msglevel,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-           const unsigned in=
t permission_mask, unsigned int *option_types_found, struct env_set *es)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* usage message */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (argc &lt;=3D 1)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        usage();</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* config filename=
 specified only? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (argc =3D=3D 2 &amp;&amp; strncmp(argv[1], &quot;--&quot;, 2))</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        char *p[MAX_PARMS + 1];</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        CLEAR(p);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        p[0] =3D &quot;config&quot;;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        p[1] =3D argv[=
1];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        add_option=
(options, p, false, NULL, 0, 0, msglevel, permission_mask, option_types_fou=
nd,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
 es);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        /* parse command line */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        for (int i =3D 1; i &lt; argc; ++i)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            char *p[MAX_PARMS + 1];</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            CLEAR(p);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            p[0] =3D arg=
v[i];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (=
strncmp(p[0], &quot;--&quot;, 2))</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                msg(msglevel,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                    &quot;I&#39;m trying to parse \&quot;%s\&qu=
ot; as an --option parameter but I don&#39;t see a leading &#39;--&#39;&quo=
t;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
  p[0]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            else</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                p[0] +=3D 2;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            int j;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            for (j =3D 1; j &lt; MAX_PARMS; ++j)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                if (i + j &lt; argc)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                    char *arg=
 =3D argv[i + j];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                if (strncmp(arg, &quot;--&quot;, 2))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        p[j] =3D arg;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                    }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                    else</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            add_option(opti=
ons, p, false, NULL, 0, 0, msglevel, permission_mask, option_types_found,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
es);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            i +=
=3D j - 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-apply_push_options(str=
uct context *c, struct options *options, struct buffer *buf,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                   unsigned int perm=
ission_mask, unsigned int *option_types_found,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                   struct env_set *es, bool is_upd=
ate)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    char line[OPTION_PARM_SIZE];</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    int line_num =3D 0;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *file =3D=
 &quot;[PUSH-OPTIONS]&quot;;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    const msglvl_t msglevel =3D D_PUSH_ERRORS | M_OPTERR;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int update_options_=
found =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    while (buf_parse(buf, &#39=
;,&#39;, line, sizeof(line)))</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
char *p[MAX_PARMS + 1];</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        CLEAR(p);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      ++line_num;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    unsigned int push_update_option_flags =3D 0;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        int i =3D 0;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        /* skip leading spaces matching the behaviour of parse_line */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        while (isspac=
e(line[i]))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            i++;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        /* If we are not in a &#39;PUSH_UPDATE&#39; we just =
check `apply_pull_filter()`</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-         * otherwise we must call `check_push_update_option_flags()` =
first</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        if ((is_update &am=
p;&amp; !check_push_update_option_flags(line, &amp;i, &amp;push_update_opti=
on_flags))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 || !apply_pull_filter(options, &amp;line[i]))</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            /* In case we are in a `PUSH_UPDATE` and `check_pu=
sh_update_option_flags()`</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-             * or `apply_pull_filter()` fail but the option is flagged =
by `PUSH_OPT_OPTIONAL`,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-             * instead of restarting, we just ignore the option and we pr=
ocess the next one</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
          */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   if (push_update_option_flags &amp; PUSH_OPT_OPTIONAL)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                continue; /* Ignoring this optio=
n */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            return false;=
 /* Cause push/pull error and stop push processing */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (parse_line(&amp;line[i], p, SIZE(p) - 1, file, line_num, msgleve=
l, &amp;options-&gt;gc))</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   if (!is_update)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     add_option(options, p, false, file, line_num, 0, msglevel, permission_=
mask,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
           option_types_found, es);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            else if (push_update_option_flags &amp; PUSH_OPT_TO_REMOV=
E)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                remove_opti=
on(c, options, p, false, file, line_num, msglevel, permission_mask,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                             =
 option_types_found, es);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                u=
pdate_option(c, options, p, false, file, line_num, 0, msglevel, permission_=
mask,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
              option_types_found, es, &amp;update_options_found);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    return true;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-options_server_import(struct options *o, const char *fi=
lename, msglvl_t msglevel,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                      unsigned int permission_mask, unsigned int *opti=
on_types_found,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                struct env_set *es)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ms=
g(D_PUSH, &quot;OPTIONS IMPORT: reading client specific options from: %s&qu=
ot;, filename);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    re=
ad_config_file(o, filename, 0, filename, 0, msglevel, permission_mask, opti=
on_types_found,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
               es);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-options_string_import(struct options *options, const char *c=
onfig, const msglvl_t msglevel,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                      const unsigned int permission_mask, unsigne=
d int *option_types_found,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                      struct env_set *es)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    read_config_string(&quot;[CONFIG-STRING]&quot;, options, config, m=
sglevel, permission_mask,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                       option_types_found, es);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span> #define VERIFY_PERMISSION(mask)              =
                                                 \</span><br><span>     {  =
                                                                           =
            \</span><br><span>         if (!verify_permission(p[0], file, l=
ine, (mask), permission_mask, option_types_found, \</span><br><span>@@ -564=
2,27 +5067,7 @@</span><br><span>         option_ptr-&gt;flags =3D 0;       =
          \</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * @brief Resets options found in the PUSH_UPDATE message tha=
t are preceded by the `-` flag.</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- *        This function is used in push-updates to reset specifie=
d options.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *        T=
he number of parameters `p` must always be 1. If the permission is verified=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *        all relate=
d options are erased or reset to their default values.</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- *        Upon successful permission verif=
ication (by VERIFY_PERMISSION()),</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- *        `option_types_found` is filled with the flag correspo=
nding to the option.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param c The cont=
ext structure.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @par=
am options A pointer to the options structure.</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * @param p An array of strings containing the opt=
ions and their parameters.</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * @param is_inline A boolean indicating if the option is inline.</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param file The file wh=
ere the function is called.</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * @param line The line number where the function is called.</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * @param msglevel The message=
 level.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param perm=
ission_mask The permission mask used by VERIFY_PERMISSION().</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * @param option_types_found A point=
er to the variable where the flags corresponding to the options</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * found are stored.</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * @param es The environment set s=
tructure.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+void</span><br><span> remove_option(st=
ruct context *c, struct options *options, char *p[], bool is_inline,</span>=
<br><span>               const char *file, int line, const msglvl_t msgleve=
l,</span><br><span>               const unsigned int permission_mask, unsig=
ned int *option_types_found,</span><br><span>@@ -5982,30 +5387,7 @@</span><=
br><span>     return true;</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * @brief Processes an option to update. It first c=
hecks whether it has already</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- *        received an option of the same type within the same update=
 message.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *        If=
 the option has already been received, it calls add_option().</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- *        Otherwise, it deletes all=
 existing values related to that option before calling</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * add_option().</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * @param c The context structure.</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * @param options A pointer to the options structure.=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param p An array =
of strings containing the options and their parameters.</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * @param is_inline A boolean indicating =
if the option is inline.</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * @param file The file where the function is called.</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * @param line The line number where the=
 function is called.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* @param level The level of the option.</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * @param msglevel The message level for logging.</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * @param permission_mask The=
 permission mask used by VERIFY_PERMISSION().</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * @param option_types_found A pointer to the varia=
ble where the flags corresponding to the options</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * found are stored.</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * @param es The environment set structure.</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param update_options_fo=
und A pointer to the variable where the flags corresponding to the update</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- * options found are st=
ored, used to check if an option of the same type has already been processe=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * by update_option(=
) within the same push-update message.</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-s=
tatic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</spa=
n><br><span> update_option(struct context *c, struct options *options, char=
 *p[], bool is_inline,</span><br><span>               const char *file, int=
 line, const int level, const msglvl_t msglevel,</span><br><span>          =
     const unsigned int permission_mask, unsigned int *option_types_found,<=
/span><br><span>@@ -6190,7 +5572,7 @@</span><br><span>     return ret;</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-static void</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void</span><br><span> add_option(struct options *options, char *p[], boo=
l is_inline, const char *file, int line,</span><br><span>            const =
int level, const msglvl_t msglevel, const unsigned int permission_mask,</sp=
an><br><span>            unsigned int *option_types_found, struct env_set *=
es)</span><br><span>diff --git a/src/openvpn/options.h b/src/openvpn/option=
s.h</span><br><span>index b033068..f038975 100644</span><br><span>--- a/src=
/openvpn/options.h</span><br><span>+++ b/src/openvpn/options.h</span><br><s=
pan>@@ -822,14 +822,83 @@</span><br><span>     struct pull_filter *tail;</s=
pan><br><span> };</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+void add_option(struct options *options, char *p[], bool is=
_inline, const char *file,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                int line, const int level, const msglvl_t msglevel,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                cons=
t unsigned int permission_mask, unsigned int *option_types_found,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                struct env_se=
t *es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @brief Resets options found in the PUSH_UPDA=
TE message that are preceded by the `-` flag.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *        This function is used in push-updates t=
o reset specified options.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *        The number of parameters `p` must always be 1. If the perm=
ission is verified,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *        all related options are erased or reset to their default values.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        Upon succe=
ssful permission verification (by VERIFY_PERMISSION()),</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *        `option_types_found` is fille=
d with the flag corresponding to the option.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param c The context structure.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param options A pointer to the options structure=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param p An arr=
ay of strings containing the options and their parameters.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param is_inline A boolean indica=
ting if the option is inline.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param file The file where the function is called.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param line The line number =
where the function is called.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param msglevel The message level.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param permission_mask The permission mask u=
sed by VERIFY_PERMISSION().</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param option_types_found A pointer to the variable where the fl=
ags corresponding to the options</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * found are stored.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param es The environment set structure.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void remove_option(struct context *c, struct options =
*options, char *p[], bool is_inline,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                   const char *file, int line, const msglv=
l_t msglevel,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
             const unsigned int permission_mask, unsigned int *option_types=
_found,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
       struct env_set *es);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @brief Processes an opti=
on to update. It first checks whether it has already</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *        received an option of the same =
type within the same update message.</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *        If the option has already been received, it call=
s add_option().</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
      Otherwise, it deletes all existing values related to that option befo=
re calling</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * add_op=
tion().</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param c The context struc=
ture.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param opti=
ons A pointer to the options structure.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param p An array of strings containing the options =
and their parameters.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param is_inline A boolean indicating if the option is inline.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param file The file whe=
re the function is called.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param line The line number where the function is called.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param level The level o=
f the option.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram msglevel The message level for logging.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param permission_mask The permission mask used =
by VERIFY_PERMISSION().</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param option_types_found A pointer to the variable where the flags =
corresponding to the options</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * found are stored.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param es The environment set structure.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param update_options_found A pointer =
to the variable where the flags corresponding to the update</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * options found are stored, used t=
o check if an option of the same type has already been processed</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * by update_option() within t=
he same push-update message.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void up=
date_option(struct context *c, struct options *options, char *p[], bool is_=
inline,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
       const char *file, int line, const int level, const msglvl_t msglevel=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
 const unsigned int permission_mask, unsigned int *option_types_found,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                   struc=
t env_set *es, unsigned int *update_options_found);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void parse_argv(struct =
options *options, const int argc, char *argv[], const msglvl_t msglevel,</s=
pan><br><span>                 const unsigned int permission_mask, unsigned=
 int *option_types_found,</span><br><span>                 struct env_set *=
es);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void read_config_file(struct options *options, const char *file, int lev=
el, const char *top_file,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                      const int top_line, const msglvl_t msglevel,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
const unsigned int permission_mask, unsigned int *option_types_found,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                      str=
uct env_set *es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+void read_config_stri=
ng(const char *prefix, struct options *options, const char *config,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                        con=
st msglvl_t msglevel, const unsigned int permission_mask,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                        unsigned int =
*option_types_found, struct env_set *es);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> void notnull(const char *arg, const=
 char *description);</span><br><span> </span><br><span> void usage_small(vo=
id);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void usage(void);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> void show_library_versions(const unsigned int flags);</s=
pan><br><span> </span><br><span> #ifdef _WIN32</span><br><span>diff --git a=
/src/openvpn/options_parse.c b/src/openvpn/options_parse.c</span><br><span>=
new file mode 100644</span><br><span>index 0000000..bb5b404</span><br><span=
>--- /dev/null</span><br><span>+++ b/src/openvpn/options_parse.c</span><br>=
<span>@@ -0,0 +1,592 @@</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -=
- An application to securely tunnel IP networks</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *             over a single UDP port, with sup=
port for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *             session authentication and key exchange,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, pa=
cket authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *             packet compression.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  Copyright (C) 2002-2025 OpenVPN Inc &lt;sales@...515...&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2008-2025 =
David Sommerseth &lt;dazo@...2108...&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  This program is free software; you can redistribute it and/or modif=
y</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the t=
erms of the GNU General Public License version 2</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundati=
on.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed i=
n the hope that it will be useful,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warra=
nty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTA=
BILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for more d=
etails.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have received =
a copy of the GNU General Public License along</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://w=
ww.gnu.org/licenses/&gt;.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config.h&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &lt;string.h&gt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &quot;options.h&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;options_util.h&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#include &quot;push.h&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+bypass_doubledash(char **p)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (strlen(*p) &gt;=3D 3 &amp;&amp; !strncmp(*p, &quot;--&quo=
t;, 2))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        *p +=3D 2;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic inline bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+spac=
e(char c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return c =3D=3D &#39;\0&=
#39; || isspace(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+parse_line(const char *line, char *p[], const int n, =
const char *file, const int line_num,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+           msglvl_t msglevel, struct gc_arena *gc)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const int STATE_INITIAL =3D 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const int STATE_READING_Q=
UOTED_PARM =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const int STATE_READING_UNQUOTED_PARM =3D 2;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const int STATE_DONE =3D 3;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const int STATE_READING_SQUOTED_=
PARM =3D 4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *error_prefi=
x =3D &quot;&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *c =
=3D line;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int st=
ate =3D STATE_INITIAL;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    bool backslash =3D false;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    char in, out;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char=
 parm[OPTION_PARM_SIZE];</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    unsigned int parm_len =3D 0;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   msglevel &amp;=3D ~M_OPTERR;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(msglevel &amp; M_MSG_VIRT_OUT)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      error_prefix =3D &quot;ERROR: &quot;;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    do</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        in =3D *c;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        out =3D 0;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (!backslash &amp;&amp; in =3D=3D &#39;\\&#39; =
&amp;&amp; state !=3D STATE_READING_SQUOTED_PARM)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            backslash =3D true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            if (state =3D=3D STATE_INITIAL)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                if (!space(in))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                    if (in =3D=3D &#39;;=
&#39; || in =3D=3D &#39;#&#39;) /* comment */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                        break;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    if (!backslash=
 &amp;&amp; in =3D=3D &#39;\&quot;&#39;)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                        state =3D STATE_READING_QUOT=
ED_PARM;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
           else if (!backslash &amp;&amp; in =3D=3D &#39;\&#39;&#39;)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
 state =3D STATE_READING_SQUOTED_PARM;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    else</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                        out =3D in;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        state =
=3D STATE_READING_UNQUOTED_PARM;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            else if (state =3D=3D STATE_READING_UNQUOTED_PARM)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                if (!backslash =
&amp;&amp; space(in))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    state =3D STATE_DONE;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                else</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    out =3D in;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            else if (state =3D=3D STATE_READING_QUOT=
ED_PARM)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                i=
f (!backslash &amp;&amp; in =3D=3D &#39;\&quot;&#39;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    state =3D STATE_DONE;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                else<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    ou=
t =3D in;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            else i=
f (state =3D=3D STATE_READING_SQUOTED_PARM)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                if (in =3D=3D &#39;\&#39;&#39;)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                    state =3D S=
TATE_DONE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        out =3D in;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    if (state =3D=3D STATE_DONE)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                /* ASSERT (parm_len &gt; 0); */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                p[ret] =3D gc_malloc(par=
m_len + 1, true, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                memcpy(p[ret], parm, parm_len);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                p[ret][parm_len] =3D &#39;\0&=
#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  state =3D STATE_INITIAL;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                parm_len =3D 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                ++ret;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         if (backslash &amp;&amp; out)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                if (!(out =3D=3D &#39;\\&#39; || out =3D=3D &#=
39;\&quot;&#39; || space(out)))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#ifdef ENABLE_SMALL</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    msg(msglevel, &quot;%sOptions warning: Bad ba=
ckslash (&#39;\\&#39;) usage in %s:%d&quot;,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                        error_prefix, file, line_n=
um);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                    msg(msgle=
vel,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
         &quot;%sOptions warning: Bad backslash (&#39;\\&#39;) usage in %s:=
%d: remember that backslashes are treated as shell-escapes and if you need =
to pass backslash characters as part of a Windows filename, you should use =
double backslashes such as \&quot;c:\\\\&quot; PACKAGE</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                        &quot;\\\\static=
.key\&quot;&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                       error_prefix, file, line_num);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    return 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            backslash =3D false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        /* store parameter character */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (out)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            if (parm_len &gt;=3D SIZE(parm))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                parm[SIZE(parm) - 1] =3D =
0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                m=
sg(msglevel, &quot;%sOptions error: Parameter at %s:%d is too long (%d char=
s max): %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  error_prefix, file, line_num, (int)SIZE(parm), parm);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                return =
0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            parm[parm_l=
en++] =3D out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        /* avoid overflow if too m=
any parms in one config file line */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (ret &gt;=3D n)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            break;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    } while (*c+=
+ !=3D &#39;\0&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (state =3D=
=3D STATE_READING_QUOTED_PARM)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     msg(msglevel, &quot;%sOptions error: No closing quotation (\&quot;) in=
 %s:%d&quot;, error_prefix, file,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            line_num);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return 0;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (state =3D=3D STATE_READING_SQUOTED_PARM)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        msg(msglevel, &quot;%sOptions error: No closing sin=
gle quotation (\&#39;) in %s:%d&quot;, error_prefix,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            file, line_num);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (state !=3D STATE_INITIAL)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        msg(msglevel, &quot;%sOptions error: Res=
idual parse state (%d) in %s:%d&quot;, error_prefix, state,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            file, line_num);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if 0</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        int i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        for (i =3D 0; i &lt; ret; ++i)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            msg(M_INFO|M_NOPREFIX, &quot;%s:%d ARG[%d] &#39;%s&#3=
9;&quot;, file, line_num, i, p[i]);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+struct in_src</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define I=
S_TYPE_FP  1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 IS_TYPE_BUF 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
nt type;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    union</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        FILE *fp;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        struct buffer *multiline;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    } u;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in_=
src_get(const struct in_src *is, char *line, const int size)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (is-&gt;type =3D=3D IS_TYPE_FP)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return BOOL_CAST(fgets(line, size, is-&=
gt;u.fp));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (is-&gt;typ=
e =3D=3D IS_TYPE_BUF)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        bool=
 status =3D buf_parse(is-&gt;u.multiline, &#39;\n&#39;, line, size);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if ((int)strlen(li=
ne) + 1 &lt; size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 strcat(line, &quot;\n&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return status;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(0);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static cha=
r *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read_inline_file=
(struct in_src *is, const char *close_tag, int *num_lines, struct gc_arena =
*gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    char line[OPTION_LINE_SIZE];<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer bu=
f =3D alloc_buf(8 * OPTION_LINE_SIZE);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    char *ret;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    bool endtagfound =3D false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    while (in_src_get(is, line, sizeof(line)))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        (*num_lines)++;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        char *line_ptr =3D line;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        /* Remove leading spaces */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        while (isspace=
(*line_ptr))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            line_=
ptr++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!strncmp(li=
ne_ptr, close_tag, strlen(close_tag)))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            endtagfound =3D true;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            break;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (!buf_safe(&amp;buf, strlen(line) + 1))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* Increase buffer size */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            struct buf=
fer buf2 =3D alloc_buf(buf.capacity * 2);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            ASSERT(buf_copy(&amp;buf2, &amp;buf));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_clear(=
&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   free_buf(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            buf =3D buf2;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       buf_printf(&amp;buf, &quot;%s&quot;, line);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (!endtagfound)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        msg(M_FATAL, &quot;ERROR: Endtag %s missing&quot;, close_tag);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    ret =3D string_alloc(BSTR(&am=
p;buf), gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf=
_clear(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  free_buf(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    secure_memzero(line, sizeof(line));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+check_inline_file(struct in_=
src *is, char *p[], struct gc_arena *gc)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    int num_inline_lines =3D 0;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (p[0] &amp;&amp; !p[1])</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 char *arg =3D p[0];</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (arg[0] =3D=3D &#39;&lt;&#39; &amp;&amp; arg[strlen(arg) - 1] =
=3D=3D &#39;&gt;&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     struct buffer close_tag;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   arg[strlen(arg) - 1] =3D &#39;\0&#39;;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            p[0] =3D string_alloc(arg + 1, gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            close_tag =3D=
 alloc_buf(strlen(p[0]) + 4);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            buf_printf(&amp;close_tag, &quot;&lt;/%s&gt;&quot;, p=
[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            p[=
1] =3D read_inline_file(is, BSTR(&amp;close_tag), &amp;num_inline_lines, gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            p[2] =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  free_buf(&amp;close_tag);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return num_i=
nline_lines;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+check_inline_file_via_fp(FILE *fp, char *p[], struct =
gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct in_src is;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    is.type =3D IS_TYP=
E_FP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    is.u.fp =
=3D fp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return c=
heck_inline_file(&amp;is, p, gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+check_inline_file_via_buf(struct=
 buffer *multiline, char *p[], struct gc_arena *gc)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct in_src is;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    is.type =3D IS_TYPE_BUF;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    is.u.multiline =3D multiline;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return check_inline_file(&amp;=
is, p, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+read_config_file(struct options *options, const char *file, =
int level, const char *top_file,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                 const int top_line, const msglvl_t msglevel,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 con=
st unsigned int permission_mask, unsigned int *option_types_found,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                 struct env_=
set *es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const int max_recursive_l=
evels =3D 10;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    FI=
LE *fp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int line=
_num;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char line[=
OPTION_LINE_SIZE + 1];</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    char *p[MAX_PARMS + 1];</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ++le=
vel;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (level &=
lt;=3D max_recursive_levels)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (streq(file, &quot;stdin&quot;))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            fp =3D stdin;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
fp =3D platform_fopen(file, &quot;r&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (fp)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            line_num =3D 0;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            while (fgets(line, sizeof(line), fp))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                int offset =3D 0;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                CLEAR(p);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                ++lin=
e_num;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   if (strlen(line) =3D=3D OPTION_LINE_SIZE)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    msg(msglevel,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                        &quot;In %s:%d=
: Maximum option line length (%d) exceeded, line starts with %s&quot;,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
file, line_num, OPTION_LINE_SIZE, line);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                /* Ignore UTF-8 BOM at start of stream */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                if (line_num =3D=3D 1=
 &amp;&amp; strncmp(line, &quot;\xEF\xBB\xBF&quot;, 3) =3D=3D 0)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    offset =3D 3=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                if (=
parse_line(line + offset, p, SIZE(p) - 1, file, line_num, msglevel,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
    &amp;options-&gt;gc))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    bypass_doubledash(&amp;p[0]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    int lines_inline =3D =
check_inline_file_via_fp(fp, p, &amp;options-&gt;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    add_option(options, p=
, lines_inline, file, line_num, level, msglevel,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                               permission_mask=
, option_types_found, es);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    line_num +=3D lines_inline;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            if (fp !=3D stdin)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                fclose(fp);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            msg(msglevel, &quot;In %s:%d: Error opening configurat=
ion file: %s&quot;, top_file, top_line,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                file);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;In %s:=
%d: Maximum recursive include levels exceeded in include attempt of file %s=
 -- probably you have a configuration file that tries to include itself.&qu=
ot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            top=
_file, top_line, file);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    secure=
_memzero(line, sizeof(line));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    CLEAR(p);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+read_config_string(const char *prefix, struct op=
tions *options, const char *config,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                   const msglvl_t msglevel, const unsigned =
int permission_mask,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                   unsigned int *option_types_found, struct env_set *es)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    char line[OPTION_LINE_SIZE];</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer multilin=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int line_num =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;multiline,=
 (uint8_t *)config, strlen(config));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  while (buf_parse(&amp;multiline, &#39;\n&#39;, line, sizeof(line)))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        char *p[MAX_PARMS + 1];</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        CLEAR(p);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        ++line_num;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (parse_line(line, =
p, SIZE(p) - 1, prefix, line_num, msglevel, &amp;options-&gt;gc))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            bypass_doubledash(&amp;p[0]=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            int l=
ines_inline =3D check_inline_file_via_buf(&amp;multiline, p, &amp;options-&=
gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
add_option(options, p, lines_inline, prefix, line_num, 0, msglevel, permiss=
ion_mask,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
             option_types_found, es);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            line_num +=3D lines_inline;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        CLEAR(p);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    secure_memzero(line, sizeof(line));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+parse_argv(struct =
options *options, const int argc, char *argv[], const msglvl_t msglevel,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+           const unsig=
ned int permission_mask, unsigned int *option_types_found, struct env_set *=
es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* usage message */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (argc &lt;=3D 1)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        usage();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* config filename specified only? */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (argc =3D=3D 2 &amp;&amp; strncmp(argv[1], &q=
uot;--&quot;, 2))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        char *p[=
MAX_PARMS + 1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    CLEAR(p);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  p[0] =3D &quot;config&quot;;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        p[1] =3D argv[1];</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        add_option(options, p, false, NULL, 0, 0, msglevel=
, permission_mask, option_types_found,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                   es);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* parse=
 command line */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     for (int i =3D 1; i &lt; argc; ++i)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            char *p[MAX_PARMS + 1];</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            CLEAR(p);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            p[0] =3D argv[i];</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            if (strncmp(p[0], &quot;=
--&quot;, 2))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    msg(msglevel,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  &quot;I&#39;m trying to parse \&quot;%s\&quot; as an --op=
tion parameter but I don&#39;t see a leading &#39;--&#39;&quot;,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    p[0]);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                p[0] +=3D 2;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            int j;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            for (j =3D 1; j &lt; MAX_PARMS; ++j)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                if (i + j &lt; a=
rgc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   char *arg =3D argv[i + j];</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    if (strncmp(arg, &quot;--&quot;, 2))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                        p[=
j] =3D arg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                        break;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            add_option(options, p, false, NULL, 0, 0, msglevel, permi=
ssion_mask, option_types_found,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                       es);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            i +=3D j - 1;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+apply_push_options(struct context *c, struct optio=
ns *options, struct buffer *buf,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                   unsigned int permission_mask, unsigned int =
*option_types_found,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                   struct env_set *es, bool is_update)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    char line[OPTION_PARM_SIZE];</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    int line_num =3D 0;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const char *file =3D &quot;[PUSH-OPT=
IONS]&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st msglvl_t msglevel =3D D_PUSH_ERRORS | M_OPTERR;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    unsigned int update_options_found =3D 0;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    while (buf_parse(buf, &#39;,&#39;,=
 line, sizeof(line)))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        char=
 *p[MAX_PARMS + 1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        CLEAR(p);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      ++line_num;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      unsigned int push_update_option_flags =3D 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        int i =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        /* skip leading spaces matching the behaviour of par=
se_line */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        w=
hile (isspace(line[i]))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      i++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        /* If we are not in a &#39;PUS=
H_UPDATE&#39; we just check `apply_pull_filter()`</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+         * otherwise we must call `check_push=
_update_option_flags()` first</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+         */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if ((is_update &amp;&amp; !check_push_update_option_flags(line, &=
amp;i, &amp;push_update_option_flags))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            || !apply_pull_filter(options, &amp;line[i])=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            /* In case we ar=
e in a `PUSH_UPDATE` and `check_push_update_option_flags()`</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+             * or `apply_pull_filte=
r()` fail but the option is flagged by `PUSH_OPT_OPTIONAL`,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+             * instead of restartin=
g, we just ignore the option and we process the next one</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+             */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (push_update_option_flags =
&amp; PUSH_OPT_OPTIONAL)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               continue; /* Ignoring this option */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            return false; /* Cause push/pull er=
ror and stop push processing */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (parse=
_line(&amp;line[i], p, SIZE(p) - 1, file, line_num, msglevel, &amp;options-=
&gt;gc))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!is_u=
pdate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                add=
_option(options, p, false, file, line_num, 0, msglevel, permission_mask,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
     option_types_found, es);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            else if (push_update_option_flags &amp; PUSH_OPT_TO_REMOVE)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                remove_op=
tion(c, options, p, false, file, line_num, msglevel, permission_mask,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
     option_types_found, es);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            else</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           update_option(c, options, p, false, file, line_num, 0, msglevel,=
 permission_mask,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                            option_types_found, es, &amp;update_options_fou=
nd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+options_server_import(str=
uct options *o, const char *filename, msglvl_t msglevel,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                      unsigned int per=
mission_mask, unsigned int *option_types_found,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                      struct env_set *es)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msg(D_PUSH, &quot;OPTIONS IMPORT: rea=
ding client specific options from: %s&quot;, filename);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    read_config_file(o, filename, 0, fi=
lename, 0, msglevel, permission_mask, option_types_found,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                     es);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+options_=
string_import(struct options *options, const char *config, const msglvl_t m=
sglevel,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
           const unsigned int permission_mask, unsigned int *option_types_f=
ound,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
        struct env_set *es)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    read_c=
onfig_string(&quot;[CONFIG-STRING]&quot;, options, config, msglevel, permis=
sion_mask,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
              option_types_found, es);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/1242?usp=3Demail">change 1242=
</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tp://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemsco=
pe itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1242?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--AKvBr/gqBjc=--

