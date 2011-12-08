MIME-Version: 1.0
In-Reply-To: <4EE0910F.8010108@...1114...>
References: <1323301588-29815-1-git-send-email-davids@...1347...>
	<CAOazyz3B=PWg7jySe41p8KTZmWk87H0NM51EvkW1qKC1XPtSXA@...278...>
	<4EE0910F.8010108@...1114...>
Date: Thu, 8 Dec 2011 12:35:55 +0200
Message-ID: <CAOazyz0DHUMDODSd22o48v+55Ai3+ATtVwYeu=0qXteWYrCA-g@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Move away from openvpn_basename() over
 to platform provided basename()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

On Thu, Dec 8, 2011 at 12:27 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
> Hi Alon,
>
> I'm not sure I understand the critique too well now. =C2=A0As this is the
> approach I tried to do. =C2=A0However, I put the basename() and dirname()
> implementations in compat.h, calling the combined openvpn_dirbasename()
> function.
>
> The reason for the combined version is basically to keep as much generic
> code as possible. =C2=A0And the old openvpn_basename() has been tested and
> tried for many years, so that code base can be considered solid. =C2=A0As=
 you
> know, the difference between dirname() and basename() is basically if you
> return the string from the beginning to the split point, or from the
> split point and to the end of the string.
>
> But I can move the static inline functions from the compat.h file over to
> the compat.c file, and declare openvpn_dirbasename() static instead. =C2=
=A0If
> that is a better solution.
>

Yes, this what I meant... :)

Best not to put code in headers, unless absolutely required... when?
if you prove by profiler
that you can optimize anything... Most likely you won't call basename
in 1000000000 loop.

However, you should be very careful from relying of the "solid"
openvpn_dirbasename
as it won't be used at most systems... as most have basename/dirname...

This is the code from glibc, which most probably be linked into your
code, the only difference
in windows it to check both '/' and '\'.... I like to use '/' also in
windows. But if you don't like it
we can do AC_DEFINE([PATH_SEPARATOR], ...) in configure.ac, if not
already there,
then use PATH_SEPARATOR constant in code.
---
char *
basename (filename)
     const char *filename;
{
  char *p =3D strrchr (filename, '/');
  return p ? p + 1 : (char *) filename;
}

char *
dirname (char *path)
{
  static const char dot[] =3D ".";
  char *last_slash;

  /* Find last '/'.  */
  last_slash =3D path !=3D NULL ? strrchr (path, '/') : NULL;

  if (last_slash !=3D NULL && last_slash !=3D path && last_slash[1] =3D=3D =
'\0')
    {
      /* Determine whether all remaining characters are slashes.  */
      char *runp;

      for (runp =3D last_slash; runp !=3D path; --runp)
        if (runp[-1] !=3D '/')
          break;

      /* The '/' is the last character, we have to look further.  */
      if (runp !=3D path)
        last_slash =3D __memrchr (path, '/', runp - path);
    }

  if (last_slash !=3D NULL)
    {
      /* Determine whether all remaining characters are slashes.  */
      char *runp;

      for (runp =3D last_slash; runp !=3D path; --runp)
        if (runp[-1] !=3D '/')
          break;

      /* Terminate the path.  */
      if (runp =3D=3D path)
        {
          /* The last slash is the first character in the string.  We have =
to
             return "/".  As a special case we have to return "//" if there
             are exactly two slashes at the beginning of the string.  See
             XBD 4.10 Path Name Resolution for more information.  */
          if (last_slash =3D=3D path + 1)
            ++last_slash;
          else
            last_slash =3D path + 1;
        }
      else
        last_slash =3D runp;

      last_slash[0] =3D '\0';
    }
  else
    /* This assignment is ill-designed but the XPG specs require to
       return a string containing "." in any case no directory part is
       found and so a static and constant string is required.  */
    path =3D (char *) dot;

  return path;
}
---

Alon.

