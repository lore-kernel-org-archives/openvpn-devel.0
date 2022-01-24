MIME-Version: 1.0
References: <20220120212243.306-1-lstipakov@...277...>
 <CAKuzo_gK2s3uvnu7RPRTJK6YcDOuP+GhUTsv8b2x_9yJ+-cJ_g@...278...>
 <CAGyAFMWzNnQioFPgCcVRM2BfUXnZ_Qv6OaWtCgiwBnpFFASBbA@...278...>
In-Reply-To: <CAGyAFMWzNnQioFPgCcVRM2BfUXnZ_Qv6OaWtCgiwBnpFFASBbA@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 24 Jan 2022 16:33:46 -0500
Message-ID: <CAKuzo_iKJSs1Sf9uM_ALdaBsvcnCRNKo_E5WTB+33YP5vLhsrQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000003db3cc05d65aba3a"
Subject: Re: [Openvpn-devel] [PATCH] msvc: switch to openssl3
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--0000000000003db3cc05d65aba3a
Content-Type: text/plain; charset="UTF-8"

Hi

On Mon, Jan 24, 2022 at 1:56 PM Lev Stipakov <lstipakov@...277...> wrote:

> Hi,
>
> > A whole patch in the commit message is not very helpful and makes it
> hard to read. Why not include this patch + the original, and apply the
> patch during build?
> >
> > Or just add a pointer to the original file in the changed file so that
> it could be diff-ed against if need be,
>
> Yeah, I was not sure what is the best way to indicate difference
> between this one and original one, so I added it to commit message.
> Not sure what do you mean by "apply the patch during build" - you can
> have patches for port sources but I don't think you can patch the port
> script.


> Like you proposed I could add a comment to the patched file which
> points to original one.
>

As mentioned in my response to the GUI PR, I just can't bring myself to
like this idea of matching vcpkg ports in OpenVPN core and GUI and the need
to keep them in sync, keep them updated etc. Feels like a  wrong approach
though I do not know enough to suggest  a better way.


>
> > These changes look sane though I think this should be a separate commit.
>
> I could do that, but then commit without those changes will break the
> build.
>

Your fix to the xkey patch set is actually a generic one, not just a
work-around for msvc. It could be applied first before fixing the msvc
build.

Selva

--0000000000003db3cc05d65aba3a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Jan 24, 2022 at 1:56 PM Lev Stipakov &lt;<a=
 href=3D"mailto:lstipakov@...277..." target=3D"_blank">lstipakov@...277...<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">H=
i,<br>
<br>
&gt; A whole patch in the commit message is not very helpful and makes it h=
ard to read. Why not include this patch + the original, and apply the patch=
 during build?<br>
&gt;<br>
&gt; Or just add a pointer to the original file in the changed file so that=
 it could be diff-ed against if need be,<br>
<br>
Yeah, I was not sure what is the best way to indicate difference<br>
between this one and original one, so I added it to commit message.<br>
Not sure what do you mean by &quot;apply the patch during build&quot; - you=
 can<br>
have patches for port sources but I don&#39;t think you can patch the port<=
br>
script.</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Like you proposed I could add a comment to the patched file which<br>
points to original one.<br></blockquote><div><br></div><div>As mentioned in=
 my response to the GUI PR, I just can&#39;t=C2=A0bring myself to like this=
 idea of matching vcpkg ports in OpenVPN core and GUI and the need to keep =
them in sync, keep them updated etc. Feels like a=C2=A0 wrong approach thou=
gh I do not know enough to suggest=C2=A0 a better way.</div><div>=C2=A0=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; These changes look sane though I think this should be a separate commi=
t.<br>
<br>
I could do that, but then commit without those changes will break the build=
.<br></blockquote><div><br></div><div>Your fix to the xkey patch set is act=
ually a generic one, not just a work-around for msvc. It could be applied f=
irst before fixing the msvc build.</div><div><br></div><div>Selva</div></di=
v></div>

--0000000000003db3cc05d65aba3a--

