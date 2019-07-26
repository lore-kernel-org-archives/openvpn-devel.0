MIME-Version: 1.0
References: <aa4f4026-a684-f96d-c8cb-d4f8a3468c4c@...277...>
 <CAGyAFMVBdD6tkNSnkZXqMUd5i-zA_d-q1W-OEpPvHtA8gPkSVA@...278...>
 <20190725182058.GA1097@...1296...>
In-Reply-To: <20190725182058.GA1097@...1296...>
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 26 Jul 2019 12:07:42 +0300
Message-ID: <CAGyAFMWuZCrsrvF7JW9ZL9uL7O=xDRv4+OYX53c-BRRsEKvvCA@...278...>
Content-Type: multipart/alternative; boundary="0000000000007f0f90058e91e0ac"
Subject: Re: [Openvpn-devel] Wrong FILETYPE in .rc files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Gisle Vanem <gisle.vanem@...277...>, OpenVPN-dev <openvpn-devel@lists.sourceforge.net>

--0000000000007f0f90058e91e0ac
Content-Type: text/plain; charset="UTF-8"

Hi,


> This might be something with your mailer at openvpn... Antonio complained
> about a well-formed patch yesterday, now you complain while I can apply
> the patch just fine...
>

I am sorry, I downloaded patch as mbox from patchwork (
https://patchwork.openvpn.net/patch/773/mbox/)
and tried "git am" on Windows and WSL. Other patches are applied just fine.
Looks like we might need to look into patchwork.

This would be a separate patch, I'd say - the patch here is actually
> changing numbers, while your suggestion would be more of a cleanup
> thing, not actually changing the result.
>

Well so far we were consistent by using numbers, albeit wrong ones.
After this patch we will have a mix of numbers and strings. But I agree,
that can be fixed later.

$ git am /tmp/mail.eml
> warning: Patch sent with format=flowed; space at the end of lines might be
> lost.
> Applying: Wrong FILETYPE in .rc files
>
> So - since I can apply the patch just fine, is the change itself ACKed?
>

Yep, if you can apply it I am fine with that.

Acked-By: Lev Stipakov <lstipakov@...277...>

-- 
-Lev

--0000000000007f0f90058e91e0ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div class=3D"gmail_quote"><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
This might be something with your mailer at openvpn... Antonio complained<b=
r>
about a well-formed patch yesterday, now you complain while I can apply<br>
the patch just fine...<br></blockquote><div><br></div><div>I am sorry, I do=
wnloaded patch as mbox from patchwork (<a href=3D"https://patchwork.openvpn=
.net/patch/773/mbox/">https://patchwork.openvpn.net/patch/773/mbox/</a>)</d=
iv><div>and tried &quot;git am&quot; on Windows and WSL. Other patches are =
applied just fine.</div><div>Looks like we might need to look into patchwor=
k.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Th=
is would be a separate patch, I&#39;d say - the patch here is actually<br>
changing numbers, while your suggestion would be more of a cleanup<br>
thing, not actually changing the result.<br></blockquote><div><br></div><di=
v>Well so far we were consistent by using numbers, albeit wrong ones.</div>=
<div>After this patch we will have a mix of numbers and strings. But I agre=
e,</div><div>that can be fixed later.</div><div><br></div><div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">$ git am /tmp/mail.eml<br>warning: Pa=
tch sent with format=3Dflowed; space at the end of lines might be lost.<br>=
Applying: Wrong FILETYPE in .rc files<br><br>So - since I can apply the pat=
ch just fine, is the change itself ACKed?<br></blockquote><div><br></div><d=
iv>Yep, if you can apply it I am fine=C2=A0with that.</div></div><div><br><=
/div><div>Acked-By: Lev Stipakov &lt;<a href=3D"mailto:lstipakov@...277..."=
>lstipakov@...277...</a>&gt;<br></div></div><div><br></div>-- <br><div dir=
=3D"ltr" class=3D"gmail_signature">-Lev</div></div>

--0000000000007f0f90058e91e0ac--

