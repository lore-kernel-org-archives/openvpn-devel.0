MIME-Version: 1.0
References: <CAOh3LPOey9b8wdPv7NeHqZopWgw3f0c-cXsZ+ozWZ7nzyn7s2Q.ref@...278...>
 <CAOh3LPOey9b8wdPv7NeHqZopWgw3f0c-cXsZ+ozWZ7nzyn7s2Q@...278...>
 <ec8fb727-3db8-4ca5-b4ce-b94adbce53e9@...1227...>
In-Reply-To: <ec8fb727-3db8-4ca5-b4ce-b94adbce53e9@...1227...>
From: Jon Chiappetta <root@...2904...>
Date: Mon, 3 Nov 2025 12:10:53 -0500
Message-ID: <CAOh3LPNJSs-FwQQ40jC5FPcqm5-24zrG4L4LQn2U8M4ZjBmQ9A@...278...>
Content-Type: multipart/alternative; boundary="000000000000e9c8cf0642b3cc49"
Subject: Re: [Openvpn-devel] One more program crash that I happened to
 observe and catch in GDB - potential free/malloc bug?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--000000000000e9c8cf0642b3cc49
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arne,

That method you listed is not the one that I had captured in my GDB
backtrace. The potentially problematic method is the key_state_free() and
there are indeed free_buff() calls in that one which could be operating on
a NULL pointer if its zero'd out still which could be bad! If you could
take a look at this method instead:

https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/ssl.c#L916

There is a tls_session_init() method which calls key_state_init() on only
the KS_PRIMARY key and not the KS_LAME_DUCK key as you can see below!

https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/ssl.c#L1032

This is not good to do because in the tls_session_free() method, it is
calling key_state_free() on ALL keys regardless without checking any of
them before!!

https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/ssl.c#L1066

There shouldn't be index mismatches for init's and free's in general for
good quality coding practices and I believe this is the code path that my
debugging session hit when doing my testing which I considered a bug and
have worked around in my own branches.

Are you able to confirm the details that I have mentioned above?

Thanks for your time,
Jon C





On Mon, Nov 3, 2025 at 5:12=E2=80=AFAM Arne Schwabe <arne@...1227...> wrote:

> Am 02.11.25 um 20:52 schrieb Jon Chiappetta via Openvpn-devel:
> > Hi Gert and devs,
> >
> > During my experimentation with this dual mode, I've had to go through a
> > lot of the code in the ssl.c library file. While I was tracing and
> > testing my modifications, I think I found another potential crash path
> > but I'm also not sure if it was my modifications or if this is indeed a
> > bug potentially.
> >
> > This was the GDB backtrace I was able to capture during my own modified
> > testing:
> >
> >
> >
> > Thread 8 "openvpn" received signal SIGSEGV, Segmentation fault.
> > [Switching to Thread 0x7fffdffff6c0 (LWP 638500)]
> > 0x00007ffff74add55 in __GI___libc_free (mem=3D0x2) at
> ./malloc/malloc.c:3375
> > warning: 3375   ./malloc/malloc.c: No such file or directory
> > (gdb) Quit
> > (gdb) bt
> > #0  0x00007ffff74add55 in __GI___libc_free (mem=3D0x2) at ./malloc/
> > malloc.c:3375
> > #1  0x0000555555564be1 in free_buf (buf=3Dbuf@...1851...=3D0x7fffd40068=
b0) at
> > buffer.c:186
> > #2  0x00005555555e1d04 in key_state_free (ks=3Dks@...1851...=3D0x7fffd4=
0065d0,
> clear=3Dclear@...1851...=3Dfalse) at ssl.c:928
>
>
> void
> key_state_ssl_free(struct key_state_ssl *ks_ssl)
> {
>      if (ks_ssl->ssl)
>      {
> #ifdef BIO_DEBUG
>          bio_debug_oc("close ssl_bio", ks_ssl->ssl_bio);
>          bio_debug_oc("close ct_in", ks_ssl->ct_in);
>          bio_debug_oc("close ct_out", ks_ssl->ct_out);
> #endif
>          BIO_free_all(ks_ssl->ssl_bio);
>          SSL_free(ks_ssl->ssl);
>      }
> }
>
> This method does not have a free_buf that is in your backtrace. So it
> looks more like it is only in your modified version.
>
> In general you have to a bit careful. Often the code assumes that the
> struct are initlised with zero, which also makes pointers and so on
> NULL. And the original method here is also in this pattern and checking
> if (ks_ssl->ssl) before doing anything. The pattern that free is used on
> something that is not initialised (but only is all zero) is a quite a
> common pattern in OpenVPN.
>
> Arne
>

--000000000000e9c8cf0642b3cc49
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Arne,<div><br></div><div>That method you listed is not =
the one that I had captured in my GDB backtrace. The potentially problemati=
c method is the key_state_free() and there are indeed free_buff() calls in =
that one which could be operating on a NULL pointer if its zero&#39;d out s=
till which could be bad! If you could take a look at this method instead:</=
div><div><br></div><div><a href=3D"https://github.com/OpenVPN/openvpn/blob/=
master/src/openvpn/ssl.c#L916">https://github.com/OpenVPN/openvpn/blob/mast=
er/src/openvpn/ssl.c#L916</a><br></div><div><br></div><div>There is a=C2=A0=
tls_session_init() method which calls key_state_init() on only the=C2=A0KS_=
PRIMARY key and not the=C2=A0KS_LAME_DUCK key as you can see below!</div><d=
iv><br></div><div><a href=3D"https://github.com/OpenVPN/openvpn/blob/master=
/src/openvpn/ssl.c#L1032">https://github.com/OpenVPN/openvpn/blob/master/sr=
c/openvpn/ssl.c#L1032</a><br></div><div><br></div><div>This is not good to =
do because in the=C2=A0tls_session_free() method, it is calling=C2=A0key_st=
ate_free() on ALL keys regardless without checking any of them before!!</di=
v><div><br></div><div><a href=3D"https://github.com/OpenVPN/openvpn/blob/ma=
ster/src/openvpn/ssl.c#L1066">https://github.com/OpenVPN/openvpn/blob/maste=
r/src/openvpn/ssl.c#L1066</a><br></div><div><br></div><div>There shouldn&#3=
9;t be index mismatches for init&#39;s and free&#39;s in general for good q=
uality coding practices and I believe this is the code path that my debuggi=
ng session hit when doing my testing which I considered a bug and have work=
ed around in my own branches.=C2=A0</div><div><br></div><div>Are you able t=
o confirm the details that I have mentioned above?</div><div><br></div><div=
>Thanks for your time,</div><div>Jon C</div><div><br></div><div><br></div><=
div><br></div><div><br></div></div><br><div class=3D"gmail_quote gmail_quot=
e_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 3, 2025 at 5=
:12=E2=80=AFAM Arne Schwabe &lt;<a href=3D"mailto:arne@...1227...">arne@...493...=
1227...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;bord=
er-left-color:rgb(204,204,204);padding-left:1ex">Am 02.11.25 um 20:52 schri=
eb Jon Chiappetta via Openvpn-devel:<br>
&gt; Hi Gert and devs,<br>
&gt; <br>
&gt; During my experimentation with this dual mode, I&#39;ve had to go thro=
ugh a <br>
&gt; lot of the code in the ssl.c library file. While I was tracing and <br>
&gt; testing my modifications, I think I found another potential crash path=
 <br>
&gt; but I&#39;m also not sure if it was my modifications or if this is ind=
eed a <br>
&gt; bug potentially.<br>
&gt; <br>
&gt; This was the GDB backtrace I was able to capture during my own modifie=
d <br>
&gt; testing:<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; Thread 8 &quot;openvpn&quot; received signal SIGSEGV, Segmentation fau=
lt.<br>
&gt; [Switching to Thread 0x7fffdffff6c0 (LWP 638500)]<br>
&gt; 0x00007ffff74add55 in __GI___libc_free (mem=3D0x2) at ./malloc/malloc.=
c:3375<br>
&gt; warning: 3375 =C2=A0 ./malloc/malloc.c: No such file or directory<br>
&gt; (gdb) Quit<br>
&gt; (gdb) bt<br>
&gt; #0 =C2=A00x00007ffff74add55 in __GI___libc_free (mem=3D0x2) at ./mallo=
c/ <br>
&gt; malloc.c:3375<br>
&gt; #1 =C2=A00x0000555555564be1 in free_buf (buf=3Dbuf@...1851...=3D0x7fff=
d40068b0) at <br>
&gt; buffer.c:186<br>
&gt; #2=C2=A0 0x00005555555e1d04 in key_state_free (ks=3Dks@...1851...=3D0x=
7fffd40065d0, clear=3Dclear@...1851...=3Dfalse) at ssl.c:928<br>
<br>
<br>
void<br>
key_state_ssl_free(struct key_state_ssl *ks_ssl)<br>
{<br>
=C2=A0 =C2=A0 =C2=A0if (ks_ssl-&gt;ssl)<br>
=C2=A0 =C2=A0 =C2=A0{<br>
#ifdef BIO_DEBUG<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bio_debug_oc(&quot;close ssl_bio&quot;, k=
s_ssl-&gt;ssl_bio);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bio_debug_oc(&quot;close ct_in&quot;, ks_=
ssl-&gt;ct_in);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bio_debug_oc(&quot;close ct_out&quot;, ks=
_ssl-&gt;ct_out);<br>
#endif<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIO_free_all(ks_ssl-&gt;ssl_bio);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SSL_free(ks_ssl-&gt;ssl);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
}<br>
<br>
This method does not have a free_buf that is in your backtrace. So it <br>
looks more like it is only in your modified version.<br>
<br>
In general you have to a bit careful. Often the code assumes that the <br>
struct are initlised with zero, which also makes pointers and so on <br>
NULL. And the original method here is also in this pattern and checking <br>
if (ks_ssl-&gt;ssl) before doing anything. The pattern that free is used on=
 <br>
something that is not initialised (but only is all zero) is a quite a <br>
common pattern in OpenVPN.<br>
<br>
Arne<br>
</blockquote></div>

--000000000000e9c8cf0642b3cc49--

