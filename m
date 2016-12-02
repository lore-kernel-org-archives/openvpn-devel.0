MIME-Version: 1.0
In-Reply-To: <20161202112809.GA78624@...1296...>
References: <1480542696-7123-1-git-send-email-selva.nair@...277...>
	<201612010821.uB18LTdC072864@...2054...>
	<CAKuzo_ix65GDUitzwTdFhCPm5Gyd6NjtHG0+78Rnu_fPmPUvuA@...278...>
	<20161202112809.GA78624@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 2 Dec 2016 08:19:25 -0500
Message-ID: <CAKuzo_hSVhZE5Wn11KS655jBG8_ZAQTJve-fH6ATWbWM5BvTcA@...278...>
Content-Type: multipart/alternative; boundary=94eb2c0438e0b74d680542acca3d
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

--94eb2c0438e0b74d680542acca3d
Content-Type: text/plain; charset=UTF-8

On Fri, Dec 2, 2016 at 6:28 AM, Gert Doering <gert@...1296...> wrote:

> On Thu, Dec 01, 2016 at 05:25:49PM -0500, Selva Nair wrote:
> > Do we want this in 2.3.14 as well ? If so I'll send a patch with service
> > part removed (note to self: remember to include docs and Changes.rst
> edits)
>
> My gut feeling is "leave 2.3 as it is, this could actually be *necessary*
> on XP".
>
> We're so close to 2.4 release that telling windows users that run into
> this issue to "just upgrade to 2.4, it will no longer restart dnscache
> *and* brings lots of more goodness anyway!" can be done with good faith.


Agreed. Also, on further thought, 2.3 needs to run openvpn as admin, so
replacing --register-dns with a script is a viable option for those who do
not want dns service restart.

Selva

--94eb2c0438e0b74d680542acca3d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Dec 2, 2016 at 6:28 AM, Gert Doering <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On Thu, Dec 01,=
 2016 at 05:25:49PM -0500, Selva Nair wrote:<br>
&gt; Do we want this in 2.3.14 as well ? If so I&#39;ll send a patch with s=
ervice<br>
&gt; part removed (note to self: remember to include docs and Changes.rst e=
dits)<br>
<br>
</span>My gut feeling is &quot;leave 2.3 as it is, this could actually be *=
necessary*<br>
on XP&quot;.<br>
<br>
We&#39;re so close to 2.4 release that telling windows users that run into<=
br>
this issue to &quot;just upgrade to 2.4, it will no longer restart dnscache=
<br>
*and* brings lots of more goodness anyway!&quot; can be done with good fait=
h.</blockquote></div><br>Agreed. Also, on further thought, 2.3 needs to run=
 openvpn as admin, so replacing --register-dns with a script is a viable op=
tion for those who do not want dns service restart.<br><br></div><div class=
=3D"gmail_extra">Selva<br></div><div class=3D"gmail_extra"><br></div></div>

--94eb2c0438e0b74d680542acca3d--

