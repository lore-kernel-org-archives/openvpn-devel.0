MIME-Version: 1.0
In-Reply-To: <57457A80.4030506@...2080...>
References: <1464130427-25002-1-git-send-email-selva.nair@...277...>
	<57457A80.4030506@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 25 May 2016 11:27:38 -0400
Message-ID: <CAKuzo_jawxTrgwQtzOhb7vqHJ3LEvULjPNphTRugYmyWMZenSQ@...278...>
Content-Type: multipart/alternative; boundary=001a114492e87f4d8c0533ac5159
Subject: Re: [Openvpn-devel] [PATCH] Pass echo option to systemd-ask-password
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114492e87f4d8c0533ac5159
Content-Type: text/plain; charset=UTF-8

On Wed, May 25, 2016 at 6:12 AM, David Sommerseth <openvpn@...2142...
topphemmelig.net> wrote:

> On 25/05/16 00:53, Selva Nair wrote:
> > Do not mask input when echo is requested. Useful for username
> > input and sometimes for challenge response.
> >
> > Signed-off-by: Selva Nair <selva.nair@...277...>
>
> ..
>
> Hi Selva,
>
> Thanks a lot!  This patch do make sense, feature wise.  And we already
> have basically that in a patch queue already.


Aha, I did not realize that those patches address the echo issue..


> The problem with this
> approach is that it may break systems with systemd older than version 216.
>

Dud.. I'm more of an irked systemd customer, rather than an aficionado..


>
> Gert also requested that this whole interface should be made less "linux
> specific" [1], so I started on a patchset which makes the
> query-user-input interface far more modular.  But I need to get start
> hacking on a v4 of that patch set as Gert didn't like several things in
> the previous attempt [2].
>
> [1] <http://thread.gmane.org/gmane.network.openvpn.devel/9085/focus=9091>
> [2] <http://thread.gmane.org/gmane.network.openvpn.devel/10021/>
>

Well, if a major rewrite of console input is planned, consider replacing
getpass() as well. It has arbitrary password length limitations on some
platforms. At the same time I'm not sure I understand the need for this
overhaul.


>
> I've just changed employer, and OpenVPN is truly part of what I will be
> working on.  So getting the query-user-input patches through is high up
> on my list.


Good to hear.


> I just need to get settled with my new employer and I'll
> start hacking on it.  But your patch is pretty much identical to what
> I've already proposed [3].
>
> [3] <http://thread.gmane.org/gmane.network.openvpn.devel/10021/focus=10019
> >


Your patch has

+#if SYSTEMD_VERSION > 216
+    if( echo )
+    {
+ argv_printf_cat(&argv, "--echo");
+    }
+#endif

How would such a compile time check be any useful -- the version will have
to be checked at run-time, isn't it?

So, should I withdraw the patch or try to fix it by hacking up a run-time
version check?

Selva

--001a114492e87f4d8c0533ac5159
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, May 25, 2016 at 6:12 AM, David <span><span class=3D"" id=3D":1qn.1"=
 tabindex=3D"-1">Sommerseth</span></span> <span dir=3D"ltr">&lt;<a href=3D"=
mailto:openvpn@...2080..." target=3D"_blank"><span><span class=3D"" id=3D":=
1qn.2" tabindex=3D"-1">openvpn</span></span>@sf.lists.<span><span class=3D"=
" id=3D":1qn.3" tabindex=3D"-1">topphemmelig</span></span>.net</a>&gt;</spa=
n> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-=
style:solid;padding-left:1ex"><span>On 25/05/16 00:53, Selva Nair wrote:<br>
&gt; Do not mask input when echo is requested. Useful for username<br>
&gt; input and sometimes for challenge response.<br>
&gt;<br>
&gt; Signed-off-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." =
target=3D"_blank">selva.nair@...277...</a>&gt;<br><br>..<br>
<br>
</span>Hi Selva,<br>
<br>
Thanks a lot!=C2=A0 This patch do make sense, feature wise.=C2=A0 And we al=
ready<br>
have basically that in a patch queue already.=C2=A0 </blockquote><div><br><=
/div><div>Aha, I did not realize that those patches address the echo issue.=
.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);b=
order-left-style:solid;padding-left:1ex">The problem with this<br>
approach is that it may break systems with systemd older than version 216.<=
br></blockquote><div><br></div><div>Dud.. I&#39;m more of an irked <span><s=
pan class=3D"" id=3D":1qn.4" tabindex=3D"-1">systemd</span></span> customer=
, rather than an aficionado..</div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-l=
eft-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">
<br>
Gert also requested that this whole interface should be made less &quot;lin=
ux<br>
specific&quot; [1], so I started on a patchset which makes the<br>
query-user-input interface far more modular.=C2=A0 But I need to get start<=
br>
hacking on a v4 of that patch set as Gert didn&#39;t like several things in=
<br>
the previous attempt [2].<br>
<br>
[1] &lt;<a href=3D"http://thread.gmane.org/gmane.network.openvpn.devel/9085=
/focus=3D9091" rel=3D"noreferrer" target=3D"_blank">http://thread.gmane.org=
/gmane.network.openvpn.devel/9085/focus=3D9091</a>&gt;<br>
[2] &lt;<a href=3D"http://thread.gmane.org/gmane.network.openvpn.devel/1002=
1/" rel=3D"noreferrer" target=3D"_blank">http://thread.gmane.org/gmane.netw=
ork.openvpn.devel/10021/</a>&gt;<br></blockquote><div><br></div><div>Well, =
if a major rewrite of console input is planned, consider replacing <span><s=
pan class=3D"" id=3D":1qn.5" tabindex=3D"-1">getpass</span></span>() as wel=
l. It has arbitrary password length limitations on some platforms. At the s=
ame time I&#39;m not sure I understand the need for this overhaul.</div><di=
v>=C2=A0=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);borde=
r-left-style:solid;padding-left:1ex">
<br>
I&#39;ve just changed employer, and OpenVPN is truly part of what I will be=
<br>
working on.=C2=A0 So getting the query-user-input patches through is high u=
p<br>
on my list.=C2=A0 </blockquote><div><br></div><div>Good to hear.</div><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-s=
tyle:solid;padding-left:1ex">I just need to get settled with my new employe=
r and I&#39;ll<br>
start hacking on it.=C2=A0 But your patch is pretty much identical to what<=
br>
I&#39;ve already proposed [3].<br>
<br>
[3] &lt;<a href=3D"http://thread.gmane.org/gmane.network.openvpn.devel/1002=
1/focus=3D10019" rel=3D"noreferrer" target=3D"_blank">http://thread.gmane.o=
rg/gmane.network.openvpn.devel/10021/focus=3D10019</a>&gt;</blockquote></di=
v><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Your patc=
h has<br></div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_ext=
ra">+#if <span><span class=3D"" id=3D":1qn.6" tabindex=3D"-1">SYSTEMD</span=
></span>_VERSION &gt; 216</div><div class=3D"gmail_extra">+ =C2=A0 =C2=A0if=
( echo )</div><div class=3D"gmail_extra">+ =C2=A0 =C2=A0{</div><div class=
=3D"gmail_extra">+<span style=3D"white-space:pre-wrap">	</span><span><span =
class=3D"" id=3D":1qn.7" tabindex=3D"-1">argv</span></span>_<span><span cla=
ss=3D"" id=3D":1qn.8" tabindex=3D"-1">printf</span></span>_cat(&amp;<span><=
span class=3D"" id=3D":1qn.9" tabindex=3D"-1">argv</span></span>, &quot;--e=
cho&quot;);</div><div class=3D"gmail_extra">+ =C2=A0 =C2=A0}</div><div clas=
s=3D"gmail_extra">+#<span><span class=3D"" id=3D":1qn.10" tabindex=3D"-1">e=
ndif</span></span></div><br></div><div class=3D"gmail_extra">How would such=
 a compile time check be any useful -- the version will have to be checked =
at run-time, isn&#39;t it?</div><div class=3D"gmail_extra"><br></div><div c=
lass=3D"gmail_extra">So, should I withdraw the patch or try to fix it by ha=
cking up a run-time version check?</div><div class=3D"gmail_extra"><br></di=
v><div class=3D"gmail_extra"><span><span class=3D"" id=3D":1qn.11" tabindex=
=3D"-1">Selva</span></span></div></div>

--001a114492e87f4d8c0533ac5159--

