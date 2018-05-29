MIME-Version: 1.0
In-Reply-To: <20180529190850.GK79551@...1296...>
References: <1527587707-21417-1-git-send-email-lev@...515...>
 <1527594447-10710-1-git-send-email-lev@...515...>
 <20180529190850.GK79551@...1296...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 29 May 2018 22:50:51 +0300
Message-ID: <CAGyAFMWC7axUL0VO29kK4cB3DxLgjSYLnZiVTui8ZV02vo48Rg@...278...>
Content-Type: multipart/alternative; boundary="00000000000032669a056d5d8d80"
Subject: Re: [Openvpn-devel] [PATCH v2] Improve "recursive routing" warning
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--00000000000032669a056d5d8d80
Content-Type: text/plain; charset="UTF-8"

Hi,


> I'm not sure I'm convinced.  This is quite a lot of extra code for
> an "add a few extra fields to a warning" enhancement - especially
> given that those that are already confused by the warning today
> will be more confused by "more numbers"...
>

I assume that people are confused by the fact of seeing warning,
less by provided numbers.

The patch adds a few more lines of code, but those are needed to provide
more information to fix/workaroud the issue. With

proto saddr:sport -> daddr:dport

it should be easy to figure out what app generates problematic traffic. Also
warning now tells user what to do - I think it is much more useful
comparison
to "someting is wrong" - style message what we have now. There are quite
many posts on internet asking "hey I have this warning, what is that, how
to fix"
and I think this patch helps address some of those.

>          /* make sure we got whole IP header */
> > -        if (BLEN(buf) < ((int) sizeof(struct openvpn_iphdr) +
> ip_hdr_offset))
> > +        if (BLEN(buf) < ((int)sizeof(struct openvpn_iphdr) +
> ip_hdr_offset))
>
> In addition, these changes look funny.  The existing code style was
> produced
> by the scripted big code cleanup for 2.4, so there should never be a
> reason to change the style in a patch for "master".


The "whitespace after cast" thing is inconsistent at the moment, have a
look at proto.c:

51         if (BLEN(buf) < (int) sizeof(struct openvpn_iphdr))

60         if (BLEN(buf) < (int)(sizeof(struct openvpn_ethhdr)

both of those lines were touched in "The Greate Reformatting - first phase"
commit.

Let's discuss this at the next meeting.

-- 
-Lev

--00000000000032669a056d5d8d80
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div class=3D"gmail_extra"><div class=3D"gmail_quote"><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">I&#39;m n=
ot sure I&#39;m convinced.=C2=A0 This is quite a lot of extra code for<br>
an &quot;add a few extra fields to a warning&quot; enhancement - especially=
<br>
given that those that are already confused by the warning today <br>
will be more confused by &quot;more numbers&quot;...<br></blockquote><div><=
br></div><div>I assume that people are confused by the fact of seeing warni=
ng,</div><div>less by provided numbers.</div><div><br></div><div>The patch =
adds a few more lines of code, but those are needed to provide=C2=A0</div><=
div>more information to fix/workaroud the issue. With</div><div><br></div><=
div>proto saddr:sport -&gt; daddr:dport</div><div><br></div><div>it should =
be easy to figure out what app generates problematic traffic. Also</div><di=
v>warning now tells user what to do - I think it is much more useful compar=
ison=C2=A0</div><div>to &quot;someting is wrong&quot; - style message what =
we have now. There are quite</div><div>many posts on internet asking &quot;=
hey I have this warning, what is that, how to fix&quot;</div><div>and I thi=
nk this patch helps address some of those.</div><div><br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex"><span class=3D"gmail-">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* make sure we got whole IP header =
*/<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (BLEN(buf) &lt; ((int) sizeof(struct o=
penvpn_iphdr) + ip_hdr_offset))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (BLEN(buf) &lt; ((int)sizeof(struct op=
envpn_iphdr) + ip_hdr_offset))<br>
<br>
</span>In addition, these changes look funny.=C2=A0 The existing code style=
 was produced<br>
by the scripted big code cleanup for 2.4, so there should never be a<br>
reason to change the style in a patch for &quot;master&quot;.</blockquote><=
div><br></div><div>The &quot;whitespace after cast&quot; thing is inconsist=
ent at the moment, have a look at proto.c:</div><div><br></div><div>51=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (BLEN(buf) &lt; (int) sizeof(struct openv=
pn_iphdr))</div><div><br></div><div>60=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if =
(BLEN(buf) &lt; (int)(sizeof(struct openvpn_ethhdr)=C2=A0</div></div><div c=
lass=3D"gmail_extra"><br></div>both of those lines were touched in &quot;Th=
e Greate Reformatting - first phase&quot; commit.</div><div class=3D"gmail_=
extra"><br></div><div class=3D"gmail_extra">Let&#39;s discuss this at the n=
ext meeting.<br clear=3D"all"><div><br></div>-- <br><div class=3D"gmail_sig=
nature">-Lev</div>
</div></div>

--00000000000032669a056d5d8d80--

