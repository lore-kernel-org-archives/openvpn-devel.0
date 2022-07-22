MIME-Version: 1.0
References: <CAGyAFMWSHhzpTzEe+TJXD6jasv+w+vGCYygH6uXjEm1k4L0qxQ@...278...>
 <20220503002840.295-1-lstipakov@...277...> <YtrND9EAUEoe4Lvv@...1296...>
In-Reply-To: <YtrND9EAUEoe4Lvv@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 22 Jul 2022 16:34:40 -0400
Message-ID: <CAKuzo_gcZH=+igQ4dYpT4Gn1TRUJc6yYqOCA8H=EDCE0BRu4UA@...278...>
Content-Type: multipart/alternative; boundary="00000000000061eeb605e46ac4ca"
Subject: Re: [Openvpn-devel] [PATCH v2] Fix M_ERRNO behavior on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Lev Stipakov <lstipakov@...277...>, Lev Stipakov <lev@...515...>, openvpn-devel@lists.sourceforge.net

--00000000000061eeb605e46ac4ca
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 22, 2022 at 12:17 PM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Tue, May 03, 2022 at 03:28:40AM +0300, Lev Stipakov wrote:
> > From: Lev Stipakov <lev@...515...>
> >
> > We use M_ERRNO flag in logging to display error code
> > and error message. This has been broken on Windows,
> > where we use error code from GetLastError() and
> > error description from strerror(). strerror() expects
> > C runtime error code, which is quite different from
> > last error code from WinAPI call. As a result, we got
> > incorrect error description.
>
> This patch breaks extended socket error reporting.
>
> In the git tree, we have those two right next to each other
>
> commit 54800aa975418fe3570f3206a5f9b277dc59bd47
> Author: Lev Stipakov <lev@...515...>
> Date:   Tue May 3 03:28:40 2022 +0300
>
>     Fix M_ERRNO behavior on Windows
>
>  -> broken
>
> commit 043c67f36342969cd171d24c70ee6b62ebc95fee
> Author: Gert Doering <gert@...1296...>
> Date:   Tue Feb 22 15:35:14 2022 +0100
>
>     Implement --mtu-disc for IPv6 UDP sockets.
>
>  -> works
>
>
> Testing is easy: point openvpn on a Linux system(!) to an unreachable
> destination (--verb 5 used here, but 3 should be sufficient)).
>
> With 043c67f, this gives
>
> 2022-07-22 18:07:59 us=599924 UDPv6 link remote:
> [AF_INET6]2001:608:2:a::253:1196
> W2022-07-22 18:07:59 us=628976 read UDPv6 [ECONNREFUSED]: Connection
> refused (fd=3,code=111)
> W2022-07-22 18:08:02 us=168862 read UDPv6 [ECONNREFUSED]: Connection
> refused (fd=3,code=111)
> W2022-07-22 18:08:07 us=228896 read UDPv6 [ECONNREFUSED]: Connection
> refused (fd=3,code=111)
>
> with 54800aa9754, this becomes
>
> 2022-07-22 18:14:16 us=271797 UDPv6 link remote:
> [AF_INET6]2001:608:2:a::253:1196
> WWWWW^C2022-07-22 18:14:46 us=706438 event_wait : Interrupted system call
> (fd=-1,code=4)
>
> ("nothing nothing nothing ctrl-c")
>

This one is tricky -- though the patch appeared to be a no-op for
non-Windows, in error.c:x_check_status(), it did move down  the line
my_errno = openvpn_errno() and thus potentially lose the original error. At
that time it looked like a good move (pun intended), though. So much for
C99 style..

Especially, before outputting the message we call
format_extended_socket_error() which calls recvmsg() which can
easily return EAGAIN in errno. To top it, EAGAIN is completely ignored by
ignore_sys_error(), so we get nothing printed. I think moving those line
back up to the start of the  function should fix this

Selva


>
> I can see that the patch at least touches code close to it...
>
> +#endif /* EXTENDED_SOCKET_ERROR_CAPABILITY */
>
> ... so it would be nice if someone could have a look what this patch
> is trampling on that it shouldn't...
>
> gert
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never
> doubted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh
> Mistress
>
> Gert Doering - Munich, Germany
> gert@...1296...
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--00000000000061eeb605e46ac4ca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jul 22, 2022 at 12:17 PM Gert=
 Doering &lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Tue, May 03, 2022 at 03:28:40AM +0300, Lev Stipakov wrote:<br>
&gt; From: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"_bla=
nk">lev@...515...</a>&gt;<br>
&gt; <br>
&gt; We use M_ERRNO flag in logging to display error code<br>
&gt; and error message. This has been broken on Windows,<br>
&gt; where we use error code from GetLastError() and<br>
&gt; error description from strerror(). strerror() expects<br>
&gt; C runtime error code, which is quite different from<br>
&gt; last error code from WinAPI call. As a result, we got<br>
&gt; incorrect error description.<br>
<br>
This patch breaks extended socket error reporting.<br>
<br>
In the git tree, we have those two right next to each other<br>
<br>
commit 54800aa975418fe3570f3206a5f9b277dc59bd47<br>
Author: Lev Stipakov &lt;<a href=3D"mailto:lev@...515..." target=3D"_blank"=
>lev@...515...</a>&gt;<br>
Date:=C2=A0 =C2=A0Tue May 3 03:28:40 2022 +0300<br>
<br>
=C2=A0 =C2=A0 Fix M_ERRNO behavior on Windows<br>
<br>
=C2=A0-&gt; broken<br>
<br>
commit 043c67f36342969cd171d24c70ee6b62ebc95fee<br>
Author: Gert Doering &lt;<a href=3D"mailto:gert@...1296..." target=3D"_blan=
k">gert@...1296...</a>&gt;<br>
Date:=C2=A0 =C2=A0Tue Feb 22 15:35:14 2022 +0100<br>
<br>
=C2=A0 =C2=A0 Implement --mtu-disc for IPv6 UDP sockets.<br>
<br>
=C2=A0-&gt; works<br>
<br>
<br>
Testing is easy: point openvpn on a Linux system(!) to an unreachable<br>
destination (--verb 5 used here, but 3 should be sufficient)).<br>
<br>
With 043c67f, this gives<br>
<br>
2022-07-22 18:07:59 us=3D599924 UDPv6 link remote: [AF_INET6]2001:608:2:a::=
253:1196<br>
W2022-07-22 18:07:59 us=3D628976 read UDPv6 [ECONNREFUSED]: Connection refu=
sed (fd=3D3,code=3D111)<br>
W2022-07-22 18:08:02 us=3D168862 read UDPv6 [ECONNREFUSED]: Connection refu=
sed (fd=3D3,code=3D111)<br>
W2022-07-22 18:08:07 us=3D228896 read UDPv6 [ECONNREFUSED]: Connection refu=
sed (fd=3D3,code=3D111)<br>
<br>
with 54800aa9754, this becomes<br>
<br>
2022-07-22 18:14:16 us=3D271797 UDPv6 link remote: [AF_INET6]2001:608:2:a::=
253:1196<br>
WWWWW^C2022-07-22 18:14:46 us=3D706438 event_wait : Interrupted system call=
 (fd=3D-1,code=3D4)<br>
<br>
(&quot;nothing nothing nothing ctrl-c&quot;)<br></blockquote><div><br></div=
><div>This one is tricky -- though the patch appeared to be a no-op for non=
-Windows, in error.c:x_check_status(), it did move down=C2=A0 the line my_e=
rrno =3D openvpn_errno() and thus potentially lose the original error. At t=
hat time it looked like a good move (pun intended), though. So much for C99=
 style..</div><div><br></div><div>Especially, before outputting the message=
 we call format_extended_socket_error() which calls recvmsg() which can eas=
ily=C2=A0return EAGAIN in errno. To top it, EAGAIN is completely ignored by=
 ignore_sys_error(), so we get nothing printed. I think moving those line b=
ack up to the start of the=C2=A0 function should fix this</div><div><br></d=
iv><div>Selva</div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
<br>
I can see that the patch at least touches code close to it...<br>
<br>
+#endif /* EXTENDED_SOCKET_ERROR_CAPABILITY */<br>
<br>
... so it would be nice if someone could have a look what this patch<br>
is trampling on that it shouldn&#39;t...<br>
<br>
gert<br>
-- <br>
&quot;If was one thing all people took for granted, was conviction that if =
you <br>
=C2=A0feed honest figures into a computer, honest figures come out. Never d=
oubted <br>
=C2=A0it myself till I met a computer with a sense of humor.&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Robert A. Heinlein, The Moon is a Harsh Mist=
ress<br>
<br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296..." target=3D"_blank">gert@...1296...</a><br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div></div>

--00000000000061eeb605e46ac4ca--

