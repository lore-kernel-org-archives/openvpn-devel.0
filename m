MIME-Version: 1.0
In-Reply-To: <aca7419e-3150-9608-db23-8b203335a80b@...1856...>
References: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
	<f55ae849-32a0-5f7e-829f-1158bc3d68fc@...2080...>
	<aca7419e-3150-9608-db23-8b203335a80b@...1856...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 13 Dec 2016 18:55:37 -0500
Message-ID: <CAKuzo_jvvArhyw1cM2f2PvB8fozotNkigpT1yxvF_tJ8pKeR2Q@...278...>
Content-Type: multipart/alternative; boundary=94eb2c12542234a437054392f680
Subject: Re: [Openvpn-devel] Coding style clean-up ... phase 1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c12542234a437054392f680
Content-Type: text/plain; charset=UTF-8

On Tue, Dec 13, 2016 at 5:08 PM, Steffan Karger <steffan@...1856...> wrote:

> > This is based on the last master branch, with two additional commits.
> >  The first commit adds the reformatting script which does the complete
> > reformatting in a consistent way across the complete source tree.  The
> > second commit is massive, with the complete reformatting.
> >
> > Have fun and report back.
>
> Excellent.
>
> I just verified that 9f4993fbd4e6cd36c9c3f4661c78881b7e6121bc is indeed
> the result of running the formatting script commit in
> a084eb6cc294c7326395e01b6a5c14abb7ed4ee5 on that commit.



 sp_bool missing  <-- present in CodeStyle page

Surprisingly this has an effect only a couple of places (unlike sp_arith ;)
eg: syshead.h line 430

&&defined(IP_PKTINFO)) || defined(IP_RECVDSTADDR)) && defined(HAVE_MSGHDR) \
&& defined(HAVE_CMSGHDR) && defined(HAVE_IOVEC) && defined(CMSG_FIRSTHDR) \
&& defined(CMSG_NXTHDR) && defined(HAVE_RECVMSG) && defined(HAVE_SENDMSG)

Otherwise looks as promised.

Selva

--94eb2c12542234a437054392f680
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Dec 13, 2016 at 5:08 PM, Steffan Karger <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);borde=
r-left-style:solid;padding-left:1ex"><span>&gt; This is based on the last m=
aster branch, with two additional commits.<br>
&gt;=C2=A0 The first commit adds the reformatting script which does the com=
plete<br>
&gt; reformatting in a consistent way across the complete source tree.=C2=
=A0 The<br>
&gt; second commit is massive, with the complete reformatting.<br>
&gt;<br>
&gt; Have fun and report back.<br>
<br>
</span>Excellent.<br>
<br>
I just verified that 9f4993fbd4e6cd36c9c3f4661c7888<wbr>1b7e6121bc is indee=
d<br>
the result of running the formatting script commit in<br>
a084eb6cc294c7326395e01b6a5c14<wbr>abb7ed4ee5 on that commit.</blockquote><=
/div></div><div class=3D"gmail_extra"><div><br></div><div><br></div><div>=
=C2=A0sp_bool missing =C2=A0&lt;-- present in CodeStyle page=C2=A0<br></div=
></div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Surp=
risingly this has an effect only a couple of places (unlike sp_arith ;) eg:=
 syshead.h line 430</div><div class=3D"gmail_extra"><br></div><div class=3D=
"gmail_extra"><div class=3D"gmail_extra">&amp;&amp;defined(IP_PKTINFO)) || =
defined(IP_RECVDSTADDR)) &amp;&amp; defined(HAVE_MSGHDR) \</div><div class=
=3D"gmail_extra">&amp;&amp; defined(HAVE_CMSGHDR) &amp;&amp; defined(HAVE_I=
OVEC) &amp;&amp; defined(CMSG_FIRSTHDR) \</div><div class=3D"gmail_extra">&=
amp;&amp; defined(CMSG_NXTHDR) &amp;&amp; defined(HAVE_RECVMSG) &amp;&amp; =
defined(HAVE_SENDMSG)</div></div><div class=3D"gmail_extra"><br></div><div =
class=3D"gmail_extra">Otherwise looks as promised.</div><div class=3D"gmail=
_extra"><br></div><div class=3D"gmail_extra">Selva</div></div>

--94eb2c12542234a437054392f680--

