MIME-Version: 1.0
References: <gerrit.1690549401000.I9f9d0f0d5ab03f8cdfd7ba7200f2d56613cc586d@...2715...>
 <d549c9b5e5d66624ef82f99206898ff8e43a5fb5-HTML@...2715...>
In-Reply-To: <d549c9b5e5d66624ef82f99206898ff8e43a5fb5-HTML@...2715...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 28 Jul 2023 16:54:08 +0300
Message-ID: <CAGyAFMXMAsFHJjdy1e6Y2tRF6-MSuGe9vDptuwLkxN58t0+PDg@...278...>
Subject: Re: [Openvpn-devel] [XS] Change in openvpn[master]: options: Do not
 hide variables from parent scope
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: frank@...2641..., openvpn-devel@lists.sourceforge.net

Looks good, makes sense. Test-compiled locally.

Acked-by: Lev Stipakov <lstipakov@...277...>

pe 28. hein=C3=A4k. 2023 klo 16.10 flichtenheld (Code Review)
(gerrit@...515...) kirjoitti:
>
> flichtenheld has uploaded this change for review.
>
> View Change
>
> options: Do not hide variables from parent scope
>
> msglevel hides the function parameter of the same name,
> which could lead to confusion. Use a unique name.
>
> Change-Id: I9f9d0f0d5ab03f8cdfd7ba7200f2d56613cc586d
> Signed-off-by: Frank Lichtenheld <frank@...2641...>
> ---
> M src/openvpn/options.c
> 1 file changed, 4 insertions(+), 4 deletions(-)
>
> git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/20/320/1
>
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 90d85be..d168163 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -9476,24 +9476,24 @@
>      else
>      {
>          int i;
> -        int msglevel =3D msglevel_fc;
> +        int msglevel_unknown =3D msglevel_fc;
>          /* Check if an option is in --ignore-unknown-option and
>           * set warning level to non fatal */
>          for (i =3D 0; options->ignore_unknown_option && options->ignore_=
unknown_option[i]; i++)
>          {
>              if (streq(p[0], options->ignore_unknown_option[i]))
>              {
> -                msglevel =3D M_WARN;
> +                msglevel_unknown =3D M_WARN;
>                  break;
>              }
>          }
>          if (file)
>          {
> -            msg(msglevel, "Unrecognized option or missing or extra param=
eter(s) in %s:%d: %s (%s)", file, line, p[0], PACKAGE_VERSION);
> +            msg(msglevel_unknown, "Unrecognized option or missing or ext=
ra parameter(s) in %s:%d: %s (%s)", file, line, p[0], PACKAGE_VERSION);
>          }
>          else
>          {
> -            msg(msglevel, "Unrecognized option or missing or extra param=
eter(s): --%s (%s)", p[0], PACKAGE_VERSION);
> +            msg(msglevel_unknown, "Unrecognized option or missing or ext=
ra parameter(s): --%s (%s)", p[0], PACKAGE_VERSION);
>          }
>      }
>  err:
>
> To view, visit change 320. To unsubscribe, or for help writing mail filte=
rs, visit settings.
>
> Gerrit-Project: openvpn
> Gerrit-Branch: master
> Gerrit-Change-Id: I9f9d0f0d5ab03f8cdfd7ba7200f2d56613cc586d
> Gerrit-Change-Number: 320
> Gerrit-PatchSet: 1
> Gerrit-Owner: flichtenheld <frank@...2641...>
> Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
> Gerrit-MessageType: newchange
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel



--=20
-Lev

