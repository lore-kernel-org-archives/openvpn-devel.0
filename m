MIME-Version: 1.0
In-Reply-To: <c11afdfb-d3ac-b805-016b-c8cdcf61efb3@...2080...>
References: <1484036287-12801-1-git-send-email-chipitsine@...277...>
	<c11afdfb-d3ac-b805-016b-c8cdcf61efb3@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 10 Jan 2017 14:50:38 -0500
Message-ID: <CAKuzo_hGrj5zhLpwqnwo7qf8hhyPBe1qswQa54RHs+EUFii8NA@...278...>
Content-Type: multipart/alternative; boundary=94eb2c1259469c04b00545c2cded
Subject: Re: [Openvpn-devel] [PATCH] resolving trivial issue found by clang
 static analyzer variable "ret" is assigned a value that is redefined later
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c1259469c04b00545c2cded
Content-Type: text/plain; charset=UTF-8

On Tue, Jan 10, 2017 at 2:12 PM, David Sommerseth <openvpn@...2142...
topphemmelig.net> wrote:

> The attached patch is cleaning up this a bit, avoiding some of the
> scoping and the not really useful 'bool ret' variable.
>


In the patch  you correctly break out of the while() on when man-even-loop
prematurely returns due to signal but do not return false on signal. This
could potentially cause the current remote to be accepted if the UI sends a
signal instead of ACCEPT in answer to  the >REMOTE query.

Here is my suggestion which involves only a very small change:


>     volatile struct connection_entry *ce = &c->options.ce;
> -    int ret = true;
> +
>

leave that as in original


>
>      update_time();
>      if (management)
>      {
> @@ -266,17 +266,14 @@ ce_management_query_remote(struct context *c)
>              management_event_loop_n_seconds(management, 1);
>              if (IS_SIG(c))
>              {
> -                ret = false;
>

leave this as in original


>                  break;
>              }
>          }
>      }
> -    {
> -        const int flags = ((ce->flags>>CE_MAN_QUERY_REMOTE_SHIFT) &
> CE_MAN_QUERY_REMOTE_MASK);
> -        ret = (flags != CE_MAN_QUERY_REMOTE_SKIP);
> -    }
>

Make the above conditional on ret = true -- i.e., if ret has turned false
due to signal do not change it.



>      gc_free(&gc);
> -    return ret;
>

Leave as in original


> +
> +    const int flags = ((ce->flags>>CE_MAN_QUERY_REMOTE_SHIFT) &
> CE_MAN_QUERY_REMOTE_MASK);
> +    return (flags != CE_MAN_QUERY_REMOTE_SKIP);;
>

delete these


>  }

 #endif /* ENABLE_MANAGEMENT */

Selva

--94eb2c1259469c04b00545c2cded
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Jan 10, 2017 at 2:12 PM, David Sommerseth <span dir=3D"ltr">&lt;<a =
href=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2142...<wbr=
>topphemmelig.net</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color=
:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><div id=3D"m_54=
80765987281022629gmail-:1gi" class=3D"m_5480765987281022629gmail-a3s m_5480=
765987281022629gmail-aXjCH m_5480765987281022629gmail-m15989cdc3515b380">Th=
e attached patch is cleaning up this a bit, avoiding some of the<br>
scoping and the not really useful &#39;bool ret&#39; variable.=C2=A0</div><=
/blockquote></div><div><br></div><div>=C2=A0</div><div>In the patch =C2=A0y=
ou correctly break out of the while() on when man-even-loop prematurely ret=
urns due to signal but do not return false on signal. This could potentiall=
y cause the current remote to be accepted if the UI sends a signal instead =
of ACCEPT in answer to =C2=A0the &gt;REMOTE query.</div><div><br></div><div=
>Here is my suggestion which involves only a very small change:</div><div><=
br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-styl=
e:solid;padding-left:1ex"><br>=C2=A0 =C2=A0 volatile struct connection_entr=
y *ce =3D &amp;c-&gt;options.ce;<br>- =C2=A0 =C2=A0int ret =3D true;<br>+<b=
r></blockquote><div><br></div><div>leave that as in original</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-styl=
e:solid;padding-left:1ex"><br>=C2=A0 =C2=A0 =C2=A0update_time();<br>=C2=A0 =
=C2=A0 =C2=A0if (management)<br>=C2=A0 =C2=A0 =C2=A0{<br>@@ -266,17 +266,14=
 @@ ce_management_query_remote(<wbr>struct context *c)<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0management_event_loop_n_<wbr>seconds(managem=
ent, 1);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_SIG(c))<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>- =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D false;<br></blockquote><div><=
br></div><div>leave this as in original=C2=A0</div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-wi=
dth:1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-=
left:1ex">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bre=
ak;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0}<br>- =C2=A0 =C2=A0{<br>- =C2=
=A0 =C2=A0 =C2=A0 =C2=A0const int flags =3D ((ce-&gt;flags&gt;&gt;CE_MAN_QU=
ERY_<wbr>REMOTE_SHIFT) &amp; CE_MAN_QUERY_REMOTE_MASK);<br>- =C2=A0 =C2=A0 =
=C2=A0 =C2=A0ret =3D (flags !=3D CE_MAN_QUERY_REMOTE_SKIP);<br>- =C2=A0 =C2=
=A0}<br></blockquote><div><br></div><div>Make the above conditional on ret =
=3D true -- i.e., if ret has turned false due to signal do not change it.</=
div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(20=
4,204,204);border-left-style:solid;padding-left:1ex">=C2=A0 =C2=A0 =C2=A0gc=
_free(&amp;gc);<br>- =C2=A0 =C2=A0return ret;<br></blockquote><div><br></di=
v><div>Leave as in original=C2=A0</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">=
+<br>+ =C2=A0 =C2=A0const int flags =3D ((ce-&gt;flags&gt;&gt;CE_MAN_QUERY_=
<wbr>REMOTE_SHIFT) &amp; CE_MAN_QUERY_REMOTE_MASK);<br>+ =C2=A0 =C2=A0retur=
n (flags !=3D CE_MAN_QUERY_REMOTE_SKIP);;<br></blockquote><div><br></div><d=
iv>delete these</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(=
204,204,204);border-left-style:solid;padding-left:1ex">=C2=A0}</blockquote>=
</div><div class=3D"gmail_extra"><div class=3D"gmail_extra">=C2=A0#endif /*=
 ENABLE_MANAGEMENT */</div></div><div class=3D"gmail_extra"><div class=3D"g=
mail_extra"><br></div><div class=3D"gmail_extra">Selva</div></div></div>

--94eb2c1259469c04b00545c2cded--

