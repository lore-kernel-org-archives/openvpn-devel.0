MIME-Version: 1.0
References: <20230128215901.2207208-1-selva.nair@...277...>
 <Y9jx+xrcrids9fgk@...2685...>
In-Reply-To: <Y9jx+xrcrids9fgk@...2685...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 25 May 2023 14:41:10 -0400
Message-ID: <CAKuzo_i898TWdDNEV+MeaBWQneCqsemp7CmkzOwsnFXwzU9KPQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000cc00c105fc88f7f5"
Subject: Re: [Openvpn-devel] [PATCH 1/2] Improve signal handling using POSIX
 sigaction
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

--000000000000cc00c105fc88f7f5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Gert,

Now that 2.6 appears to have reached a fairly stable state, may I request
you to look into this patch for 2.7 -- this one has an ACK (thanks to
Frank), 2/2 may need a closer look but that one is small.

I dread the prospect of this developing serious merge conflicts and having
to drill down into the details to resolve them. Right now it looks like no
one has yet touched related chunks.

Thanks,

Selva



On Tue, Jan 31, 2023 at 5:48=E2=80=AFAM Frank Lichtenheld <frank@...2641...>
wrote:

> On Sat, Jan 28, 2023 at 04:59:00PM -0500, selva.nair@...277... wrote:
> > From: Selva Nair <selva.nair@...277...>
> >
> > Currently we use the old signal API which follows system-V or
> > BSD semantics depending on the platform and/or feature-set macros.
> > Further, signal has many weaknesses which makes proper masking
> > (deferring) of signals during update not possible.
> >
> > Improve this:
> >
> > - Use sigaction to properly mask signals when modifying.
> >
>
> Acked-By: Frank Lichtenheld <frank@...2641...>
>
> Stared at code intensively. AFAICT this should not change the
> general behavior except to be more generally safe.
>
> Only compile+t_client tested.
>
> Regards,
> --
>   Frank Lichtenheld
>

--000000000000cc00c105fc88f7f5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Gert,<div><br></div><div>Now that 2.6 =
appears to have reached a fairly=C2=A0stable state, may I request you to lo=
ok into this patch for 2.7 -- this one has an ACK (thanks to Frank), 2/2 ma=
y need a closer look but that one is small.</div><div><br></div><div>I drea=
d the prospect of this developing serious merge conflicts and having to dri=
ll down into the details to=C2=A0resolve them. Right now it looks like no o=
ne has yet touched related chunks.</div><div><br></div><div>Thanks,</div><d=
iv><br></div><div>Selva</div><div><br></div><div><br></div></div><br><div c=
lass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jan 31, =
2023 at 5:48=E2=80=AFAM Frank Lichtenheld &lt;<a href=3D"mailto:frank@...2375...=
41..." target=3D"_blank">frank@...2641...</a>&gt; wrote:<br></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">On Sat, Jan 28, 2023 at 04:59:00PM=
 -0500, <a href=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nai=
r@...277...</a> wrote:<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D=
"_blank">selva.nair@...277...</a>&gt;<br>
&gt; <br>
&gt; Currently we use the old signal API which follows system-V or<br>
&gt; BSD semantics depending on the platform and/or feature-set macros.<br>
&gt; Further, signal has many weaknesses which makes proper masking<br>
&gt; (deferring) of signals during update not possible.<br>
&gt; <br>
&gt; Improve this:<br>
&gt; <br>
&gt; - Use sigaction to properly mask signals when modifying.<br>
&gt; <br>
<br>
Acked-By: Frank Lichtenheld &lt;<a href=3D"mailto:frank@...2641..." target=
=3D"_blank">frank@...2641...</a>&gt;<br>
<br>
Stared at code intensively. AFAICT this should not change the<br>
general behavior except to be more generally safe.<br>
<br>
Only compile+t_client tested.<br>
<br>
Regards,<br>
-- <br>
=C2=A0 Frank Lichtenheld<br>
</blockquote></div></div>

--000000000000cc00c105fc88f7f5--

