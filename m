MIME-Version: 1.0
In-Reply-To: <c95121f3-3f11-1369-a74f-dd09cb49e255@...2080...>
References: <1484035447-11838-1-git-send-email-chipitsine@...277...>
	<c95121f3-3f11-1369-a74f-dd09cb49e255@...2080...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 27 Jan 2017 18:56:14 +0500
Message-ID: <CAFHpkQE6w_EwAY8_osyubZs3eE4v80adVhFVP1ePy5O5NXr7sg@...278...>
Content-Type: multipart/alternative; boundary=001a11469c5440dd40054713d486
Subject: Re: [Openvpn-devel] [PATCH] Resolving several travis-ci issues:
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11469c5440dd40054713d486
Content-Type: text/plain; charset=UTF-8

2017-01-26 0:21 GMT+05:00 David Sommerseth <
openvpn@...2080...>:

> On 10/01/17 09:04, Ilya Shipitsin wrote:
> > * moving LD_LIBRARY_PATH as far as possible (otherwise "wget" picks it,
> which is not desirable)
> > * split LD_LIBRARY_PATH into LD_LIBRARY_PATH/DYLD_LIBRARY_PATH
> depending on operating system
> > * removed MBEDTLS_VERSION, OPENSSL_VERSION (the last depended on
> nonexistent OPENSSL_VERION variable)
> > * removed "apt: true" from caching, it never worked actually
>
> Sorry about this lingering ... To the changes itself, I don't have any
> real possibility to evaluate these changes.  From the subject and commit
> message, I do not understand *why* this is needed.  You just describe
> what I can see in the patch itself.
>
> Having an improved commit message actually describing *why* these
> changes are needed - that helps motivating us to apply it.  We don't
> like to apply things "just because it fixes things".  What is this "it"
> and why is /this/ the right way to do it?
>
> Basically a patch with commit message consists of three parts: Problem
> description, Why and How.  The patch diff is the How.  These two others
> belong to the commit message and often also worthy a comment line or two
> in modified files as well - especially if it isn't clear why.
>
> I would strongly recommend you to read this blog post [1] on writing
> commit messages.  It is a really good written post on this topic.
>
> [1] <http://chris.beams.io/posts/git-commit/>
>


thank you for the link.
I added more detailed commit description based on that article.

may I ask you something in turn ?
I cannot read other people thoughts, if there's something wrong with my
patch, there's no other known way, but your reply.

since, you are keeping silence, I've no idea whether is it wrong or not. It
would be really nice if you will tell "that and that is wrong". I'm sure,
there are sites about git, where it is written.


>
> > this patch should be applied after https://www.mail-archive.com/
> openvpn-devel@lists.sourceforge.net/msg13843.html
>
> That approach got rejected and we went for this [2] approach instead,
> will that change anything in regards to the changes in this patch?
>
> [2]
> <https://www.mail-archive.com/openvpn-devel@...1199...
> sourceforge.net/msg13911.html>
>
>
> --
> kind regards,
>
> David Sommerseth
> OpenVPN Technologies, Inc
>
>
>

--001a11469c5440dd40054713d486
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-01-26 0:21 GMT+05:00 David Sommerseth <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2080...</a>&gt=
;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 10/01/17 09=
:04, Ilya Shipitsin wrote:<br>
&gt; * moving LD_LIBRARY_PATH as far as possible (otherwise &quot;wget&quot=
; picks it, which is not desirable)<br>
&gt; * split LD_LIBRARY_PATH into LD_LIBRARY_PATH/DYLD_LIBRARY_<wbr>PATH de=
pending on operating system<br>
&gt; * removed MBEDTLS_VERSION, OPENSSL_VERSION (the last depended on nonex=
istent OPENSSL_VERION variable)<br>
&gt; * removed &quot;apt: true&quot; from caching, it never worked actually=
<br>
<br>
</span>Sorry about this lingering ... To the changes itself, I don&#39;t ha=
ve any<br>
real possibility to evaluate these changes.=C2=A0 From the subject and comm=
it<br>
message, I do not understand *why* this is needed.=C2=A0 You just describe<=
br>
what I can see in the patch itself.<br>
<br>
Having an improved commit message actually describing *why* these<br>
changes are needed - that helps motivating us to apply it.=C2=A0 We don&#39=
;t<br>
like to apply things &quot;just because it fixes things&quot;.=C2=A0 What i=
s this &quot;it&quot;<br>
and why is /this/ the right way to do it?<br>
<br>
Basically a patch with commit message consists of three parts: Problem<br>
description, Why and How.=C2=A0 The patch diff is the How.=C2=A0 These two =
others<br>
belong to the commit message and often also worthy a comment line or two<br>
in modified files as well - especially if it isn&#39;t clear why.<br>
<br>
I would strongly recommend you to read this blog post [1] on writing<br>
commit messages.=C2=A0 It is a really good written post on this topic.<br>
<br>
[1] &lt;<a href=3D"http://chris.beams.io/posts/git-commit/" rel=3D"noreferr=
er" target=3D"_blank">http://chris.beams.io/posts/<wbr>git-commit/</a>&gt;<=
br></blockquote><div><br><br></div><div>thank you for the link.<br></div><d=
iv>I added more detailed commit description based on that article.<br><br><=
/div><div>may I ask you something in turn ?<br></div><div>I cannot read oth=
er people thoughts, if there&#39;s something wrong with my patch, there&#39=
;s no other known way, but your reply.<br><br></div><div>since, you are kee=
ping silence, I&#39;ve no idea whether is it wrong or not. It would be real=
ly nice if you will tell &quot;that and that is wrong&quot;. I&#39;m sure, =
there are sites about git, where it is written.<br></div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">
<span class=3D""><br>
&gt; this patch should be applied after <a href=3D"https://www.mail-archive=
.com/openvpn-devel@lists.sourceforge.net/msg13843.html" rel=3D"noreferrer" =
target=3D"_blank">https://www.mail-archive.com/<wbr>openvpn-devel@...2239...=
.<wbr>sourceforge.net/msg13843.html</a><br>
<br>
</span>That approach got rejected and we went for this [2] approach instead=
,<br>
will that change anything in regards to the changes in this patch?<br>
<br>
[2]<br>
&lt;<a href=3D"https://www.mail-archive.com/openvpn-devel@...282...=
.net/msg13911.html" rel=3D"noreferrer" target=3D"_blank">https://www.mail-a=
rchive.com/<wbr>openvpn-devel@...1199...<wbr>sourceforge.net/msg13911.html<=
/a>&gt;<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
--<br>
kind regards,<br>
<br>
David Sommerseth<br>
OpenVPN Technologies, Inc<br>
<br>
<br>
</font></span></blockquote></div><br></div></div>

--001a11469c5440dd40054713d486--

