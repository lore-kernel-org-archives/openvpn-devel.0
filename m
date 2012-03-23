Date: Fri, 23 Mar 2012 15:18:15 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120323141815.GC1359@...1296...>
References: <CAEsd45TVCJKRrag9FRKnXhTVhOWO=pjMq3wXkz_bd43_mwhWAA@...278...>
	<4F576C3B.9090308@...1114...>
	<CAEsd45TaK6gpOivakP85Lb2ndb9LE8s59NmJ1_=z3Ggzj4EDDA@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CFO0SFgG+t1lcV5s"
Content-Disposition: inline
In-Reply-To: <CAEsd45TaK6gpOivakP85Lb2ndb9LE8s59NmJ1_=z3Ggzj4EDDA@...278...>
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
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--CFO0SFgG+t1lcV5s
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

sorry for not coming back to this.  We *do* appreciate (very much!) that=20
you are interested and working on getting 2.3-alpha into tunnelblick - but
life got in the way, as usual.

On Thu, Mar 08, 2012 at 04:57:11PM -0500, Jonathan K. Bullard wrote:
> Below is a patch to fix this problem.
>=20
> It causes the affected options (--up, --down, etc.) to call a new
> function for verification: check_cmd_access(). It is called with the
> same calling sequence as check_file_access() so as to simplify things,
> and it uses check_file_access() to check the file once the path for it
> has been isolated. I wrote a new function so that (a) I wouldn't
> disturb the existing function, and (b) it could be extended -- for
> example, to check for any problems with any arguments that follow the
> path to the functions (mismatched quotes, for example).

I think the generall approach is reasonable.

Quoting of arguments in general is an *interesting* problem, given the
possible sources of --up arguments - config file, shell (with the shell
having its own ideas which bits to keep and which to remove), windows
cli (no idea).  But this is sort of outside the scope of this initial
patch, just something to keep in mind.


> It's my first proposed patch for OpenVPN, so please examine it _very_
> carefully. I've tested it only OS X (and it works fine), but I don't
> have a full debugging environment, so it was tested as a "black box"
> using msg() calls to verify its behavior. I tried to conform to the
> style I saw elsewhere in the source, but may have missed or
> misunderstood something.
>=20
> There are a couple of anomalies in the existing code that I have not deal=
t with:
>=20
> 1. --iproute also takes a "cmd" argument but the options.c code does
> not call check_file_access() for it. (So I have not included it in
> this patch),

Well spotted.  For completeness, this would need such a check as well - or
the option could be thrown out (personally I'm tempted to throw it out,
as all other external system utilities are called with compiled-in paths,
but that's a different discussion again)

> 2. Although the man page [1] says most of the "cmd" arguments can be a
> "shell command", that doesn't seem correct. On OS X, for example,
> backslashes are discarded (not used to escape the next character) and
> double-quotes can only be used at the start and end of an individual
> argument in "cmd". The bash shell implements both of these (rendering
>      abc"def"ghi.\ txt
> as
>      abcdefghi.txt
> for example.=20

The shell will "eat" quotes, if not double-quoted, like:

 openvpn --up 'my_command "with arguments in quotes"'

will pass everything but the single quotes to openvpn as a single argv[]
argument, including the double quotes.  OTOH I would need to check what
the config file parser does regarding single and double quotes...

> This patch is very restrictive: it allows a "cmd" to be a
> path (optionally enclosed in double-quotes), optionally followed by a
> space, which may be followed by anything.

Conceptionally, I'd say this is good enough for Alpha2.  Then let's see
what else will break.

> I would particularly like input on these lines in the new routine (but
> of course all input is welcome):
>=20
>     ASSERT((path_size <=3D OPTION_PARM_SIZE) || (path_size > 0));
>     msg (M_NOPREFIX|M_OPTERR, "%s fails with '%s': param_size BAD:
> stop_char =3D '%c'; start_ix =3D %d; "
>          "command =3D " ptr_format "; stop_ptr =3D " ptr_format ";
> path_size =3D %d; OPTION_PARAM_SIZE =3D %d",
>          opt, command, stop_char, start_ix,
>          (ptr_type) command, (ptr_type) stop_ptr, path_size, (int)
> OPTION_PARM_SIZE);
>     return true;
>=20
> These lines test to make sure that OPTION_PARM_SIZE is reasonable. I
> don't know your conventions, so I included both an assert and an error
> message to be output before a failure return ("true" is a failure
> indicator).

Well, both are used throughout the code...

ASSERT, if there is no way to recover, and this really shouldn't happen=20
in the first place.  But this should be an "&&" there, because with an
"||", this will *always* be true...

msg(), if the program can go on, or this is inside option parsing (M_FATAL),
but we want a "friendly" exit instead of a hard abort.  msg() output is
normally meant to be understandable by a user of the code, not only
targetted to the programmer.


Now, the msg() above looks very much like "targetted to the programmer"
to me - printing pointer addresses is not something a user expects to
see, and it wouldn't help them fix the problem.  So if this is a "this
should never happen!" bit of the code, ASSERT() is good enough - and if
it's "the user has input a funny string" it should be spelled differently :=
-)


After all the preliminaries (am I making sense?), now looking at the actual
patch :-)


> --- openvpn/options.c	(revision 1964)
> +++ openvpn/options.c	(working copy)
> @@ -2656,6 +2656,72 @@
>  }
>=20
>  /*
> + * Check the command that comes after certain script options (e.g., --up=
).
> + *
> + * The command should consist of a path, which may be enclosed in
> double-quotes, and may be

Just as a side note: your mail client has mangled the patch, and word-
wrapped some of the longer lines.  This is not a problem for reviewing,
but for inclusion you might want to send it as an attachment and not
inline in the mail.  ("Smart" programs can be *so* unhelpful...)

> + * optionally followed by a space which may be followed by arbitrary arg=
uments.
> + *
> + * Once the path has been extracted from the command (if that is
> necessary), check_file_access()
> + * is used to do the  sanity checking on it. The type, mode, and opt
> arguments to this routine
> + * are the same as the corresponding check_file_access() arguments to
> facilitate this.
> + */
> +static bool
> +check_cmd_access(const int type, const char *command, const int mode,
> const char *opt)
> +{
> +  /* If no command configured, no errors to look for */
> +  if (! command)
> +    return false;
> +
> +  /* Test for a quote as the first char of command
> +     and for presence of a space in command */
> +
> +  int   start_ix  =3D 0;      /* Where the path starts within command
>                (0 or 1) */
> +  char  stop_char =3D '\000'; /* Character that terminates the path
> within command (' ' or '"') */
> +  char *stop_ptr  =3D NULL;   /* Pointer past end of path       (NULL
> or points inside command) */
> +
> +  if (command[0] =3D=3D '"')
> +  {
> +    start_ix  =3D 1;
> +    stop_char =3D '"';
> +    stop_ptr  =3D strchr(command+1, '"');
> +    if (stop_ptr =3D=3D NULL)
> +    {
> +      msg (M_NOPREFIX|M_OPTERR, "%s fails with '%s': Unbalanced quote",
> +           opt, command);
> +      return true;
> +    }
> +  } else

I usually try to avoid this... but please follow the same indentation
style the rest of the code uses (we all seem to agree that it's ugly, but
the only thing that is *more* ugly is "different styles in the same code
base").  So this would be:

  if (command[0] =3D=3D '"')
    {
      start_ix  =3D 1;
      stop_char =3D '"';
      stop_ptr  =3D strchr(command+1, '"');
      if (stop_ptr =3D=3D NULL)
	{
	  msg (M_NOPREFIX|M_OPTERR, "%s fails with '%s': Unbalanced quote",
	       opt, command);
	  return true;
	}
    }=20
  else
    {
...

(namely, indent size is 4, with the curly brackets on a single line,=20
indented only by 2 spaces)

> +  {
> +    start_ix  =3D 0;
> +    stop_char =3D ' ';
> +    stop_ptr  =3D strchr(command, ' ');
> +  }
> +
> +  /* If command doesn't start with a quote and doesn't include any
> spaces, just test it directly */
> +
> +  if ((start_ix =3D=3D 0) && (stop_ptr =3D=3D NULL))
> +    return check_file_access(type, command, mode, opt);
> +
> +  /* Extract the path from command into a new string and test that */
> +
> +  int path_size =3D stop_ptr - command - start_ix + 1;          /*
> (Includes terminating NUL) */
> +
> +  if ((path_size > OPTION_PARM_SIZE) || (path_size < 1)) {
> +    ASSERT((path_size <=3D OPTION_PARM_SIZE) || (path_size > 0));

See above, this assert doesn't really make sense the way it is written,
because the argument is aways true (if path_size is negative, it will
be <=3D OPTION_PARM_SIZE, and if it's > OPTION_PARM_SIZE, it is also >0).

> +    msg (M_NOPREFIX|M_OPTERR, "%s fails with '%s': param_size BAD:
> stop_char =3D '%c'; start_ix =3D %d; "
> +         "command =3D " ptr_format "; stop_ptr =3D " ptr_format ";
> path_size =3D %d; OPTION_PARAM_SIZE =3D %d",
> +         opt, command, stop_char, start_ix,
> +         (ptr_type) command, (ptr_type) stop_ptr, path_size, (int)
> OPTION_PARM_SIZE);
> +    return true;
> +  }
> +
> +  char path[OPTION_PARM_SIZE];

Having variables declared at after the first code block fails on
a few C compilers, namely MSVC.  Which we might drop or not, but this
has caused us some headaches in the past, so we should avoid adding
new code.  So the "char path[]" declaration needs to go up to the
beginning of the function.

> +  memcpy(path, command+start_ix, (path_size-1)*sizeof(char));
> +  path[path_size-1] =3D '\000';

This works, but makes me wonder.  Up there, you increase path_size by +1,
to make sure to include the trailing null byte.  Then, when using it,
you always subtract one again...  I find this somewhat confusing.

sizeof(char) is 1 by definition of "sizeof", so this can be left off
(http://en.wikipedia.org/wiki/Sizeof).

> +  return check_file_access(type, path, mode, opt);
> +}
> +
> +/*
>   * Sanity check of all file/dir options.  Checks that file/dir
>   * is accessible by OpenVPN
>   */
> @@ -2738,19 +2804,20 @@
>                               R_OK|X_OK, "--client-disconnect script");
>    errs |=3D check_file_access (CHKACC_FILE,
> options->auth_user_pass_verify_script,
>                               R_OK|X_OK, "--auth-user-pass-verify script"=
);
> -  errs |=3D check_file_access (CHKACC_FILE, options->tls_verify,
> +  /* ** Script hooks that accept shell commands ** */
> +  errs |=3D check_cmd_access (CHKACC_FILE, options->tls_verify,
>                               R_OK|X_OK, "--tls-verify script");
> -  errs |=3D check_file_access (CHKACC_FILE, options->up_script,
> +  errs |=3D check_cmd_access (CHKACC_FILE, options->up_script,
>                               R_OK|X_OK, "--up script");
> -  errs |=3D check_file_access (CHKACC_FILE, options->down_script,
> +  errs |=3D check_cmd_access (CHKACC_FILE, options->down_script,
>                               R_OK|X_OK, "--down script");
> -  errs |=3D check_file_access (CHKACC_FILE, options->ipchange,
> +  errs |=3D check_cmd_access (CHKACC_FILE, options->ipchange,
>                               R_OK|X_OK, "--ipchange script");
> -  errs |=3D check_file_access (CHKACC_FILE, options->route_script,
> +  errs |=3D check_cmd_access (CHKACC_FILE, options->route_script,
>                               R_OK|X_OK, "--route-up script");
> -  errs |=3D check_file_access (CHKACC_FILE, options->route_predown_scrip=
t,
> +  errs |=3D check_cmd_access (CHKACC_FILE, options->route_predown_script,
>                               R_OK|X_OK, "--route-pre-down script");
> -  errs |=3D check_file_access (CHKACC_FILE, options->learn_address_scrip=
t,
> +  errs |=3D check_cmd_access (CHKACC_FILE, options->learn_address_script,
>                               R_OK|X_OK, "--learn-address script");
>  #endif /* P2MP_SERVER */


Code-wise, I think this is a good start, but the style and a few minor=20
nits need to be adjusted :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--CFO0SFgG+t1lcV5s
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT2yGJqkuBuNlUUl1AQIzIwQAj+KA1kEbD5AdyslL2S7uv5p5ow9pK8Rk
DCBQlIwZLAZP7btVMhE3nJ/0Lhm1QETNLvZmLLQbARqWZxYiIAUciH6MxAbcCLO8
Vx2XjCVuCTNj1AoVzRnGo4mAoRjdIVxk+OpQxRafDK9/bbFmhcLy4jMjCP3QmjBX
fnGfYdkm+Kw=
=FE8W
-----END PGP SIGNATURE-----

--CFO0SFgG+t1lcV5s--

