MIME-Version: 1.0
In-Reply-To: <1385131108-19717-1-git-send-email-dazo@...384...>
References: <l142b75v@...1062...>
	<1385131108-19717-1-git-send-email-dazo@...384...>
From: Steffan Karger <steffan@...1856...>
Date: Sat, 23 Nov 2013 10:53:05 +0100
Message-ID: <CAA1AbxJZa2gMBXpHiQuXD2J+8eOZCvQp+ftzrC49fH2HDfNACg@...278...>
Content-Type: multipart/alternative; boundary=001a11c3e57c18a67904ebd51aa6
Subject: Re: [Openvpn-devel] [PATCH] Fix file checks when --chroot is being
	used
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <dazo@...384...>
Cc: openvpn-devel@lists.sourceforge.net

--001a11c3e57c18a67904ebd51aa6
Content-Type: text/plain; charset=ISO-8859-1

Hi David,

This solution looks good. I did not test, but I do have one minor comment
after glancing at the code:

 @@ -2662,7 +2700,14 @@ check_cmd_access(const char *command, const char
> *opt)
>       * only requires X_OK to function on Unix - a scenario not unlikely to
>       * be seen on suid binaries.
>       */
> -    return_code = check_file_access(CHKACC_FILE, argv.argv[0], X_OK, opt);
> +    if (chroot)
> +      {
> +        return_code = check_file_access_chroot(chroot, CHKACC_FILE,
> argv.argv[0], X_OK, opt);
> +      }
> +    else
> +      {
> +        return_code = check_file_access(CHKACC_FILE, argv.argv[0], X_OK,
> opt);
> +      }
>

This if seems redundant here, as chroot is checked by
check_file_access_chroot itself. Furthermore, for the other occurences of
check_file_access you stick to just replacing it with
check_file_acess_chroot. I would suggest to do that here too.

-Steffan

--001a11c3e57c18a67904ebd51aa6
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi David,<br><div class=3D"gmail_extra"><br></div><div cla=
ss=3D"gmail_extra">This solution looks good. I did not test, but I do have =
one minor comment after glancing at the code:<br><br><div class=3D"gmail_qu=
ote">


<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
@@ -2662,7 +2700,14 @@ check_cmd_access(const char *command, const char *op=
t)<br>
=A0 =A0 =A0 * only requires X_OK to function on Unix - a scenario not unlik=
ely to<br>
=A0 =A0 =A0 * be seen on suid binaries.<br>
=A0 =A0 =A0 */<br>
- =A0 =A0return_code =3D check_file_access(CHKACC_FILE, argv.argv[0], X_OK,=
 opt);<br>
+ =A0 =A0if (chroot)<br>
+ =A0 =A0 =A0{<br>
+ =A0 =A0 =A0 =A0return_code =3D check_file_access_chroot(chroot, CHKACC_FI=
LE, argv.argv[0], X_OK, opt);<br>
+ =A0 =A0 =A0}<br>
+ =A0 =A0else<br>
+ =A0 =A0 =A0{<br>
+ =A0 =A0 =A0 =A0return_code =3D check_file_access(CHKACC_FILE, argv.argv[0=
], X_OK, opt);<br>
+ =A0 =A0 =A0}<br></blockquote><div><br></div><div>This if seems redundant =
here, as chroot is checked by check_file_access_chroot itself. Furthermore,=
 for the other occurences of check_file_access you stick to just replacing =
it with check_file_acess_chroot. I would suggest to do that here too.</div>


<div><br></div><div>-Steffan</div></div></div></div>

--001a11c3e57c18a67904ebd51aa6--

