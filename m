MIME-Version: 1.0
References: <1573760407-20662-1-git-send-email-selva.nair@...277...>
 <108f5ba4-240b-5496-f37b-51ff2a6fb2fe@...2080...>
 <CAKuzo_he9FoT-iC-FZAW7qQH2vepY+XmOfsiL6uSH=7hW8ZvVQ@...278...>
 <78052b9a-0a3a-040d-c419-f48e9ef95a6e@...2080...>
In-Reply-To: <78052b9a-0a3a-040d-c419-f48e9ef95a6e@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 19 Nov 2019 11:50:40 -0500
Message-ID: <CAKuzo_hcQLNbtQehY5eZeagOfZ7N1NAuXrEA9+w0d15UTcym3g@...278...>
Content-Type: multipart/alternative; boundary="0000000000004efb030597b5dea6"
Subject: Re: [Openvpn-devel] [PATCH] Fix ACL_CHECK_ADD_COMPILE_FLAGS to work
 with clang
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000004efb030597b5dea6
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, Nov 19, 2019 at 9:09 AM David Sommerseth <
openvpn@...2080...> wrote:

> On 14/11/2019 22:58, Selva Nair wrote:
> > Hi David
> >
> > Thanks for the comments
> >
> >     My idea was just to add -Werror right in the line above, and not
> extend the
> >     ACL_CHECK_ADD_COMPILE_FLAGS macro with another argument.
> >
> >
> > I'm fine with that approach as well. Let me know if you want a v2.
>
> Sorry for the delay responding.  I've done some pondering, and I have come
> to
> the same conclusion as Arne, so this is a reasonable approach to add
> -Werror.
>
> That said, is there any specific reasons why adding the [-Werror] to
> essentially all ACL_CHECK_ADD_COMPILE_FLAGS() calls?  Our ./configure
> script
> is the only one implementing and supporting and using this macro, and it is
> defined in configure.ac.
>
> If there are no foreseeable reason for that now, I think it's just fine to
> change the AC_COMPILE_IFELSE() call to use CFLAGS="$1 -Werror $old_cflags".
> Just add a comment in that area why we add the -Werror explicitly.  This
> makes
> the whole change smaller and clearer.  If we need the flexibility later
> on, we
> can adjust this when that time arrives.
>

Agreed. v2 follows.

Selva

--0000000000004efb030597b5dea6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Tue, Nov 19, 2019 at 9:09 AM David Sommers=
eth &lt;<a href=3D"mailto:openvpn@...2080...">openvpn@...2080...</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 14/11/20=
19 22:58, Selva Nair wrote:<br>
&gt; Hi David<br>
&gt; <br>
&gt; Thanks for the comments<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0My idea was just to add -Werror right in the line a=
bove, and not extend the<br>
&gt;=C2=A0 =C2=A0 =C2=A0ACL_CHECK_ADD_COMPILE_FLAGS macro with another argu=
ment.<br>
&gt; <br>
&gt; <br>
&gt; I&#39;m fine with that approach as well. Let me know if you want a v2.=
<br>
<br>
Sorry for the delay responding.=C2=A0 I&#39;ve done some pondering, and I h=
ave come to<br>
the same conclusion as Arne, so this is a reasonable approach to add -Werro=
r.<br>
<br>
That said, is there any specific reasons why adding the [-Werror] to<br>
essentially all ACL_CHECK_ADD_COMPILE_FLAGS() calls?=C2=A0 Our ./configure =
script<br>
is the only one implementing and supporting and using this macro, and it is=
<br>
defined in <a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_bl=
ank">configure.ac</a>.<br>
<br>
If there are no foreseeable reason for that now, I think it&#39;s just fine=
 to<br>
change the AC_COMPILE_IFELSE() call to use CFLAGS=3D&quot;$1 -Werror $old_c=
flags&quot;.<br>
Just add a comment in that area why we add the -Werror explicitly.=C2=A0 Th=
is makes<br>
the whole change smaller and clearer.=C2=A0 If we need the flexibility late=
r on, we<br>
can adjust this when that time arrives.<br></blockquote><div><br></div><div=
>Agreed. v2 follows.</div><div><br></div><div>Selva</div></div></div>

--0000000000004efb030597b5dea6--

