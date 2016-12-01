MIME-Version: 1.0
In-Reply-To: <201612010821.uB18LTdC072864@...2054...>
References: <1480542696-7123-1-git-send-email-selva.nair@...277...>
	<201612010821.uB18LTdC072864@...2054...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 1 Dec 2016 17:25:49 -0500
Message-ID: <CAKuzo_ix65GDUitzwTdFhCPm5Gyd6NjtHG0+78Rnu_fPmPUvuA@...278...>
Content-Type: multipart/alternative; boundary=001a11376232ef3a5e0542a04eb1
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Do not restart dns client
 service as a part of --register-dns processing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11376232ef3a5e0542a04eb1
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu, Dec 1, 2016 at 3:21 AM, Gert Doering <gert@...1296...> wrote:

> ACK, thanks.
>
> Code looks good, and test compiles.  Have not test-run yet but do not
> expect any surprises there.
>
> I have added a Changes.rst entry (someone *might* notice and wonder if
> this was intentional :) ) and updated doc/openvpn.8 and the help text
> in options.c which both used to list all the commands run...
>
> Your patch has been applied to the master branch.
>

Do we want this in 2.3.14 as well ? If so I'll send a patch with service
part removed (note to self: remember to include docs and Changes.rst edits)

Selva

--001a11376232ef3a5e0542a04eb1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Thu, Dec 1, 2016 at 3:21 AM, Gert Do=
ering <span dir=3D"ltr">&lt;<a href=3D"mailto:gert@...1296..." target=3D"_b=
lank">gert@...1296...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">ACK, thanks.<br>
<br>
Code looks good, and test compiles.=C2=A0 Have not test-run yet but do not<=
br>
expect any surprises there.<br>
<br>
I have added a Changes.rst entry (someone *might* notice and wonder if<br>
this was intentional :) ) and updated doc/openvpn.8 and the help text<br>
in options.c which both used to list all the commands run...<br>
<br>
Your patch has been applied to the master branch.<br></blockquote><div><br>=
</div><div>Do we want this in 2.3.14 as well ? If so I&#39;ll send a patch =
with service</div><div>part removed (note to self: remember to include docs=
 and Changes.rst edits)</div></div><br></div><div class=3D"gmail_extra">Sel=
va</div></div>

--001a11376232ef3a5e0542a04eb1--

