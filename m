MIME-Version: 1.0
In-Reply-To: <4F576C3B.9090308@...1114...>
References: <CAEsd45TVCJKRrag9FRKnXhTVhOWO=pjMq3wXkz_bd43_mwhWAA@...278...>
	<4F576C3B.9090308@...1114...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Thu, 8 Mar 2012 16:57:11 -0500
Message-ID: <CAEsd45TaK6gpOivakP85Lb2ndb9LE8s59NmJ1_=z3Ggzj4EDDA@...278...>
Subject: Re: [Openvpn-devel] 2.3alpha1 fails on OS X when the --up argument
 contains more than an execution path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Wed, Mar 7, 2012 at 9:10 AM, David Sommerseth
<openvpn.list@...1114...> wrote:
[skipped]
> > OpenVPN 2.3alpha1 fails when the argument to "--up" contains more
> > than an execution path. The problem also occurs for the "--down"
> > option and the new "--route-pre-down" option (and presumably any other
> > options that take more than just an execution path).
[skipped]

> Ouch! =A0I see that check_file_access() needs to strip out any arguments.
> It will now basically 'access("/private/tmp/test/up.sh -x")' ... which is
> a file which doesn't exist ... but if it tested for
> 'access("/private/tmp/test/up.sh")' it should find the file.
>
> However, it isn't as easy to just skip through the string and "terminate
> it" on the first space (0x20) value, as it might have been escaped.
> Which can make quite typical paths like this fail:
>
> =A0 "C:\Program Files\OpenVPN\bin\up-script.bat"


Below is a patch to fix this problem.

It causes the affected options (--up, --down, etc.) to call a new
function for verification: check_cmd_access(). It is called with the
same calling sequence as check_file_access() so as to simplify things,
and it uses check_file_access() to check the file once the path for it
has been isolated. I wrote a new function so that (a) I wouldn't
disturb the existing function, and (b) it could be extended -- for
example, to check for any problems with any arguments that follow the
path to the functions (mismatched quotes, for example).

It's my first proposed patch for OpenVPN, so please examine it _very_
carefully. I've tested it only OS X (and it works fine), but I don't
have a full debugging environment, so it was tested as a "black box"
using msg() calls to verify its behavior. I tried to conform to the
style I saw elsewhere in the source, but may have missed or
misunderstood something.

There are a couple of anomalies in the existing code that I have not dealt =
with:

1. --iproute also takes a "cmd" argument but the options.c code does
not call check_file_access() for it. (So I have not included it in
this patch),

2. Although the man page [1] says most of the "cmd" arguments can be a
"shell command", that doesn't seem correct. On OS X, for example,
backslashes are discarded (not used to escape the next character) and
double-quotes can only be used at the start and end of an individual
argument in "cmd". The bash shell implements both of these (rendering
     abc"def"ghi.\ txt
as
     abcdefghi.txt
for example. This patch is very restrictive: it allows a "cmd" to be a
path (optionally enclosed in double-quotes), optionally followed by a
space, which may be followed by anything.

I would particularly like input on these lines in the new routine (but
of course all input is welcome):

    ASSERT((path_size <=3D OPTION_PARM_SIZE) || (path_size > 0));
    msg (M_NOPREFIX|M_OPTERR, "%s fails with '%s': param_size BAD:
stop_char =3D '%c'; start_ix =3D %d; "
         "command =3D " ptr_format "; stop_ptr =3D " ptr_format ";
path_size =3D %d; OPTION_PARAM_SIZE =3D %d",
         opt, command, stop_char, start_ix,
         (ptr_type) command, (ptr_type) stop_ptr, path_size, (int)
OPTION_PARM_SIZE);
    return true;

These lines test to make sure that OPTION_PARM_SIZE is reasonable. I
don't know your conventions, so I included both an assert and an error
message to be output before a failure return ("true" is a failure
indicator).

Let me know of any changes you'd like me to make.

- Jon Bullard

[1] http://openvpn.net/index.php/manuals/523-openvpn-23.html

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D

--- openvpn/options.c	(revision 1964)
+++ openvpn/options.c	(working copy)
@@ -2656,6 +2656,72 @@
 }

 /*
+ * Check the command that comes after certain script options (e.g., --up).
+ *
+ * The command should consist of a path, which may be enclosed in
double-quotes, and may be
+ * optionally followed by a space which may be followed by arbitrary argum=
ents.
+ *
+ * Once the path has been extracted from the command (if that is
necessary), check_file_access()
+ * is used to do the  sanity checking on it. The type, mode, and opt
arguments to this routine
+ * are the same as the corresponding check_file_access() arguments to
facilitate this.
+ */
+static bool
+check_cmd_access(const int type, const char *command, const int mode,
const char *opt)
+{
+  /* If no command configured, no errors to look for */
+  if (! command)
+    return false;
+
+  /* Test for a quote as the first char of command
+     and for presence of a space in command */
+
+  int   start_ix  =3D 0;      /* Where the path starts within command
               (0 or 1) */
+  char  stop_char =3D '\000'; /* Character that terminates the path
within command (' ' or '"') */
+  char *stop_ptr  =3D NULL;   /* Pointer past end of path       (NULL
or points inside command) */
+
+  if (command[0] =3D=3D '"')
+  {
+    start_ix  =3D 1;
+    stop_char =3D '"';
+    stop_ptr  =3D strchr(command+1, '"');
+    if (stop_ptr =3D=3D NULL)
+    {
+      msg (M_NOPREFIX|M_OPTERR, "%s fails with '%s': Unbalanced quote",
+           opt, command);
+      return true;
+    }
+  } else
+  {
+    start_ix  =3D 0;
+    stop_char =3D ' ';
+    stop_ptr  =3D strchr(command, ' ');
+  }
+
+  /* If command doesn't start with a quote and doesn't include any
spaces, just test it directly */
+
+  if ((start_ix =3D=3D 0) && (stop_ptr =3D=3D NULL))
+    return check_file_access(type, command, mode, opt);
+
+  /* Extract the path from command into a new string and test that */
+
+  int path_size =3D stop_ptr - command - start_ix + 1;          /*
(Includes terminating NUL) */
+
+  if ((path_size > OPTION_PARM_SIZE) || (path_size < 1)) {
+    ASSERT((path_size <=3D OPTION_PARM_SIZE) || (path_size > 0));
+    msg (M_NOPREFIX|M_OPTERR, "%s fails with '%s': param_size BAD:
stop_char =3D '%c'; start_ix =3D %d; "
+         "command =3D " ptr_format "; stop_ptr =3D " ptr_format ";
path_size =3D %d; OPTION_PARAM_SIZE =3D %d",
+         opt, command, stop_char, start_ix,
+         (ptr_type) command, (ptr_type) stop_ptr, path_size, (int)
OPTION_PARM_SIZE);
+    return true;
+  }
+
+  char path[OPTION_PARM_SIZE];
+  memcpy(path, command+start_ix, (path_size-1)*sizeof(char));
+  path[path_size-1] =3D '\000';
+  return check_file_access(type, path, mode, opt);
+}
+
+/*
  * Sanity check of all file/dir options.  Checks that file/dir
  * is accessible by OpenVPN
  */
@@ -2738,19 +2804,20 @@
                              R_OK|X_OK, "--client-disconnect script");
   errs |=3D check_file_access (CHKACC_FILE,
options->auth_user_pass_verify_script,
                              R_OK|X_OK, "--auth-user-pass-verify script");
-  errs |=3D check_file_access (CHKACC_FILE, options->tls_verify,
+  /* ** Script hooks that accept shell commands ** */
+  errs |=3D check_cmd_access (CHKACC_FILE, options->tls_verify,
                              R_OK|X_OK, "--tls-verify script");
-  errs |=3D check_file_access (CHKACC_FILE, options->up_script,
+  errs |=3D check_cmd_access (CHKACC_FILE, options->up_script,
                              R_OK|X_OK, "--up script");
-  errs |=3D check_file_access (CHKACC_FILE, options->down_script,
+  errs |=3D check_cmd_access (CHKACC_FILE, options->down_script,
                              R_OK|X_OK, "--down script");
-  errs |=3D check_file_access (CHKACC_FILE, options->ipchange,
+  errs |=3D check_cmd_access (CHKACC_FILE, options->ipchange,
                              R_OK|X_OK, "--ipchange script");
-  errs |=3D check_file_access (CHKACC_FILE, options->route_script,
+  errs |=3D check_cmd_access (CHKACC_FILE, options->route_script,
                              R_OK|X_OK, "--route-up script");
-  errs |=3D check_file_access (CHKACC_FILE, options->route_predown_script,
+  errs |=3D check_cmd_access (CHKACC_FILE, options->route_predown_script,
                              R_OK|X_OK, "--route-pre-down script");
-  errs |=3D check_file_access (CHKACC_FILE, options->learn_address_script,
+  errs |=3D check_cmd_access (CHKACC_FILE, options->learn_address_script,
                              R_OK|X_OK, "--learn-address script");
 #endif /* P2MP_SERVER */

