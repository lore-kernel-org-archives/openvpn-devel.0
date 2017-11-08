MIME-Version: 1.0
In-Reply-To: <20171108161813.GT958@...1296...>
References: <CAKuzo_j+TbC19HRNH1YxWro74950Ftpxj-oDOi7kgAO8bc6ckQ@...278...>
 <20171108161813.GT958@...1296...>
From: Selva <selva.nair@...277...>
Date: Wed, 8 Nov 2017 11:46:44 -0500
Message-ID: <CAKuzo_hEuXEHBdSnSZ-17Dt-HOgv+3P_cHhaz8YWd7YU_B2FcA@...278...>
Content-Type: multipart/alternative; boundary="001a1147603cff75ab055d7b6f87"
Subject: Re: [Openvpn-devel] patchwork
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1147603cff75ab055d7b6f87
Content-Type: text/plain; charset="UTF-8"

Hi,

On Wed, Nov 8, 2017 at 11:18 AM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Wed, Nov 08, 2017 at 11:07:16AM -0500, Selva wrote:
> > Confused as to how patchwork works:
>
> Welcome to the club :-)
>

I already feel better :)


>
> I had some ideas how it should work (like, picking up my "applied" mails
> and auto-closing patches) but right now it's refusing to do so - I think
> we need more tweaking there.
>
> For the time being, I clean up applied and superceded patches manually -
> the list is not long, and it's way more convenient than maintaining the
> old "open patches" list in the wiki.
>

I like it too -- way better than keeping track in an inbox folder.


>
> [..]
> > What status header should ACK-ed patches get? I suppose Accepted is for
> > merged ones. Anything other than "New" or "Under review" appears to take
> > the patch out of the "Action Required" list, although Acked patches still
> > need attention to get merged.
>
> ACKed patches *should* see an "1" show up in the "A/R/T" column (so you'd
> need to send a mail with "acked-by: selva <...>" instead of a plain "ACK",
> but it's currently not doing that either.
>

Aha, missed that. No way to flip those A/R/T flags by hand, is it.. Will
remember
to add Acked-by: Name <email> next time.

Thanks,

Selva

--001a1147603cff75ab055d7b6f87
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Wed, Nov 8, 2017 at 11:18 AM, Gert D=
oering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=3D"_=
blank">gert@...1296...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">Hi,<br>
<span><br>
On Wed, Nov 08, 2017 at 11:07:16AM -0500, Selva wrote:<br>
&gt; Confused as to how patchwork works:<br>
<br>
</span>Welcome to the club :-)<br></blockquote><div><br></div><div>I alread=
y feel better :)</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
I had some ideas how it should work (like, picking up my &quot;applied&quot=
; mails<br>
and auto-closing patches) but right now it&#39;s refusing to do so - I thin=
k<br>
we need more tweaking there.<br>
<br>
For the time being, I clean up applied and superceded patches manually -<br>
the list is not long, and it&#39;s way more convenient than maintaining the=
<br>
old &quot;open patches&quot; list in the wiki.<br></blockquote><div><br></d=
iv><div>I like it too -- way better than keeping track in an inbox folder.<=
/div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
[..]<br>
<span>&gt; What status header should ACK-ed patches get? I suppose Accepted=
 is for<br>
&gt; merged ones. Anything other than &quot;New&quot; or &quot;Under review=
&quot; appears to take<br>
&gt; the patch out of the &quot;Action Required&quot; list, although Acked =
patches still<br>
&gt; need attention to get merged.<br>
<br>
</span>ACKed patches *should* see an &quot;1&quot; show up in the &quot;A/R=
/T&quot; column (so you&#39;d<br>
need to send a mail with &quot;acked-by: selva &lt;...&gt;&quot; instead of=
 a plain &quot;ACK&quot;,<br>
but it&#39;s currently not doing that either.<br></blockquote><div><br></di=
v><div>Aha, missed that. No way to flip those A/R/T flags by hand, is it.. =
Will remember</div><div>to add Acked-by: Name &lt;email&gt; next time.</div=
><div><br></div><div>Thanks,</div><div><br></div><div>Selva</div></div></di=
v></div>

--001a1147603cff75ab055d7b6f87--

