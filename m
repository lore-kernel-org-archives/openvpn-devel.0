Message-ID: <4F6C7148.3000705@...515...>
Date: Fri, 23 Mar 2012 14:49:12 +0200
From: =?UTF-8?B?U2FtdWxpIFNlcHDDpG5lbg==?= <samuli@...515...>
MIME-Version: 1.0
References: <4F632647.30603@...515...>
	<20120316114747.GV6615@...1330...>
	<CAOazyz2K4s3V3Yq6W8f9Q2us+vk9ArLT1UX3gKCS4Zxr245o+g@...278...>
	<4F633670.1000807@...1114...>
	<CAOazyz0nMAdD5H2MbBR=+ssOPPHgFsdgxr2g-SwWb4BHzDMdcw@...278...>
	<4F633B0C.8080502@...515...>	<20120316152145.GF1359@...1296...>
	<4F66EE39.5050405@...515...>	<4F66F5ED.30006@...1114...>
	<4F66FE98.4030707@...1114...>	<20120319094235.GM1359@...1296...>
	<4F6700E1.60201@...1114...>
	<CAOazyz1aPWoiWWg=T7Ykw0YUL0S_wdAE-T6Gg=djpc=iwF9YXg@...278...>
	<4F6B10DC.1080306@...1114...>
	<CAOazyz1d2xRaX6QCqOE3kqNCdSEu+Uj4sf2NVxf-Lxxb4x_nEw@...278...>
	<4F6B2FBF.8050202@...1114...>
	<CAOazyz36gy_Ji6uKxPUzRSYeWxWL5WnZ6j-3vPWfMpT=_6xwrQ@...278...>
In-Reply-To: <CAOazyz36gy_Ji6uKxPUzRSYeWxWL5WnZ6j-3vPWfMpT=_6xwrQ@...278...>
Content-Type: multipart/alternative;
	boundary="------------070408080703090100050403"
Subject: Re: [Openvpn-devel] New generic buildsystem: lzo enabled or
 disabled by default?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------070408080703090100050403
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Alon,

Are you saying that there's no way you can generate a series of fixes
(=3Dpatches) that apply on top of your previous patches? Or, if the fixes
are fairly trivial, you could provide a diff of the old and new trees
and explain what changes are included. Then the new tree could be pulled
as-is.

- --=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

> No.
> Please don't take the patches from the mailing list.
> As I explicitly requested in the past *SEVERAL* times.
>
> I've done minor fixups in my repository.
> As you see my work is in good quality and without comments, issues I
> fixed needs to be fixed in tree as well.
>
> As I requested this approach several times and got no rejection I
> assumed this is acceptable.
>
> This is a *COMPLETE* show stopper.
>
> If you insist in doing that this way I will resend the patch series to
the list.
>
> Alon.
>
>
> On Thu, Mar 22, 2012 at 3:57 PM, David Sommerseth
> <openvpn.list@...1114...> wrote:
> On 22/03/12 12:47, Alon Bar-Lev wrote:
> >>> On Thu, Mar 22, 2012 at 1:45 PM, David Sommerseth
> >>> <openvpn.list@...1114...> wrote:
> >>>> -----BEGIN PGP SIGNED MESSAGE----- Hash: SHA1
> >>>>
> >>>> On 19/03/12 16:16, Alon Bar-Lev wrote:
> >>>>> The only component that is in question is lzo. I still think this
> >>>>> is packager responsibility, not sure why this is an exception. But
> >>>>> if it will make people happy, I will enable lzo by default. All
> >>>>> the other components are optional by they nature, and again it is
> >>>>> up to packager to decide what good for his configuration.
> >>>>
> >>>> Hi Alon,
> >>>>
> >>>> Okay, based on the discussion on this thread, it makes sense to then
> >>>> flip LZO to be enabled by default.
> >>>>
> >>>> No need to hurry with any patches, as I can add such a patch on top
> >>>> of everything when the merging is completed. The patch will be
> >>>> submitted to the mailing list when it's ready to be implemented.
> >>>>
> >>>
> >>> OK, great. I will modify the branch with this (rebase) so it won't
> >>> create additional noise. So you be able to do a clean pull with
> >>> complete feature set.
>
> No, I will take this change as an additional patch - as I stated in my
> previous response. I don't want to base such changes on patches which
> are already reviewed and ACKed. That invalidates the work queue I'm on
> already. I'm taking patches from the mailing list, that works very well
> in my workflow - and it gives a good chance of providing the Acked-by
> statements in the git log.
>
>
> kind regards,
>
> David Sommerseth
>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9scUIACgkQwp2X7RmNIqOJXgCeIg5I9bFheKZAsOlVu+X2tt+d
YZQAnA2OE75kTWbrszdeni1jnc5ESIlg
=3Dkb/l
-----END PGP SIGNATURE-----


--------------070408080703090100050403
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"Content-Type=
">
  </head>
  <body bgcolor=3D"#FFFFFF" text=3D"#000000">
    <br>
    -----BEGIN PGP SIGNED MESSAGE-----<br>
    Hash: SHA1<br>
    <br>
    Hi Alon,<br>
    <br>
    Are you saying that there's no way you can generate a series of
    fixes (=3Dpatches) that apply on top of your previous patches? Or, if
    the fixes are fairly trivial, you could provide a diff of the old
    and new trees and explain what changes are included. Then the new
    tree could be pulled as-is.<br>
    <br>
    - -- <br>
    Samuli Sepp=C3=A4nen<br>
    Community Manager<br>
    OpenVPN Technologies, Inc<br>
    <br>
    irc freenode net: mattock<br>
    <br>
    <span style=3D"white-space: pre;">&gt; No.<br>
      &gt; Please don't take the patches from the mailing list.<br>
      &gt; As I explicitly requested in the past *SEVERAL* times.<br>
      &gt;<br>
      &gt; I've done minor fixups in my repository.<br>
      &gt; As you see my work is in good quality and without comments,
      issues I<br>
      &gt; fixed needs to be fixed in tree as well.<br>
      &gt;<br>
      &gt; As I requested this approach several times and got no
      rejection I<br>
      &gt; assumed this is acceptable.<br>
      &gt;<br>
      &gt; This is a *COMPLETE* show stopper.<br>
      &gt;<br>
      &gt; If you insist in doing that this way I will resend the patch
      series to the list.<br>
      &gt;<br>
      &gt; Alon.<br>
      &gt;<br>
      &gt;<br>
      &gt; On Thu, Mar 22, 2012 at 3:57 PM, David Sommerseth<br>
      &gt; <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:openvpn.list@...220...=
..1114...">&lt;openvpn.list@...1114...&gt;</a> wrote:<br>
      &gt; On 22/03/12 12:47, Alon Bar-Lev wrote:<br>
      &gt; &gt;&gt;&gt; On Thu, Mar 22, 2012 at 1:45 PM, David
      Sommerseth<br>
      &gt; &gt;&gt;&gt; <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:o=
penvpn.list@...1114...">&lt;openvpn.list@...1114...&gt;</a> wrote:<br>
      &gt; &gt;&gt;&gt;&gt; -----BEGIN PGP SIGNED MESSAGE----- Hash:
      SHA1<br>
      &gt; &gt;&gt;&gt;&gt;<br>
      &gt; &gt;&gt;&gt;&gt; On 19/03/12 16:16, Alon Bar-Lev wrote:<br>
      &gt; &gt;&gt;&gt;&gt;&gt; The only component that is in question
      is lzo. I still think this<br>
      &gt; &gt;&gt;&gt;&gt;&gt; is packager responsibility, not sure why
      this is an exception. But<br>
      &gt; &gt;&gt;&gt;&gt;&gt; if it will make people happy, I will
      enable lzo by default. All<br>
      &gt; &gt;&gt;&gt;&gt;&gt; the other components are optional by
      they nature, and again it is<br>
      &gt; &gt;&gt;&gt;&gt;&gt; up to packager to decide what good for
      his configuration.<br>
      &gt; &gt;&gt;&gt;&gt;<br>
      &gt; &gt;&gt;&gt;&gt; Hi Alon,<br>
      &gt; &gt;&gt;&gt;&gt;<br>
      &gt; &gt;&gt;&gt;&gt; Okay, based on the discussion on this
      thread, it makes sense to then<br>
      &gt; &gt;&gt;&gt;&gt; flip LZO to be enabled by default.<br>
      &gt; &gt;&gt;&gt;&gt;<br>
      &gt; &gt;&gt;&gt;&gt; No need to hurry with any patches, as I can
      add such a patch on top<br>
      &gt; &gt;&gt;&gt;&gt; of everything when the merging is completed.
      The patch will be<br>
      &gt; &gt;&gt;&gt;&gt; submitted to the mailing list when it's
      ready to be implemented.<br>
      &gt; &gt;&gt;&gt;&gt;<br>
      &gt; &gt;&gt;&gt;<br>
      &gt; &gt;&gt;&gt; OK, great. I will modify the branch with this
      (rebase) so it won't<br>
      &gt; &gt;&gt;&gt; create additional noise. So you be able to do a
      clean pull with<br>
      &gt; &gt;&gt;&gt; complete feature set.<br>
      &gt;<br>
      &gt; No, I will take this change as an additional patch - as I
      stated in my<br>
      &gt; previous response. I don't want to base such changes on
      patches which<br>
      &gt; are already reviewed and ACKed. That invalidates the work
      queue I'm on<br>
      &gt; already. I'm taking patches from the mailing list, that works
      very well<br>
      &gt; in my workflow - and it gives a good chance of providing the
      Acked-by<br>
      &gt; statements in the git log.<br>
      &gt;<br>
      &gt;<br>
      &gt; kind regards,<br>
      &gt;<br>
      &gt; David Sommerseth<br>
      &gt;</span><br>
    <br>
    -----BEGIN PGP SIGNATURE-----<br>
    Version: GnuPG v1.4.11 (GNU/Linux)<br>
    Comment: Using GnuPG with Mozilla - <a class=3D"moz-txt-link-freetext" =
href=3D"http://enigmail.mozdev.org/">http://enigmail.mozdev.org/</a><br>
    <br>
    iEYEARECAAYFAk9scUIACgkQwp2X7RmNIqOJXgCeIg5I9bFheKZAsOlVu+X2tt+d<br>
    YZQAnA2OE75kTWbrszdeni1jnc5ESIlg<br>
    =3Dkb/l<br>
    -----END PGP SIGNATURE-----<br>
    <br>
  </body>
</html>

--------------070408080703090100050403--

