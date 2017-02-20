MIME-Version: 1.0
In-Reply-To: <20170220121852.GW93896@...1296...>
References: <1483905658-25267-1-git-send-email-selva.nair@...277...>
	<1484428589-7882-1-git-send-email-selva.nair@...277...>
	<20170220121852.GW93896@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 20 Feb 2017 11:13:49 -0500
Message-ID: <CAKuzo_jFiNfL4mVBmYhVAi4GyWB3PVG=WgWiZCdZ_A8UH7ri=g@...278...>
Content-Type: multipart/alternative; boundary=94eb2c05eb34be78130548f88d67
Subject: Re: [Openvpn-devel] [PATCH v2] Fix user's group membership check in
 interactive service to work with domains
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

--94eb2c05eb34be78130548f88d67
Content-Type: text/plain; charset=UTF-8

On Mon, Feb 20, 2017 at 7:18 AM, Gert Doering <gert@...1296...> wrote:

> On Sat, Jan 14, 2017 at 04:16:29PM -0500, selva.nair@...277... wrote:
> > From: Selva Nair <selva.nair@...277...>
> >
> > Currently the username unqualified by the domain is used to validate
> > a user which fails for domain users. Instead authorize the user
> >
> > (i) if the built-in admin group or ovpn_admin group is in the process
> token
> > (ii) else if the user's SID is in the built-in admin or ovpn_admin groups
> >
> > The second check is needed to recognize dynamic updates to group
> membership
> > on the local machine that will not be reflected in the token.
> >
> > These checks do not require connection to a domain controller and will
> > work even when user is logged in with cached credentials.
> >
> > Resolves Trac: #810
> >
> > v2: include the token check as described above
>
> Took me way too long...  the code change looks reasonable ("does what it
> says on the tin, and safely so").
>
> One questions occured to me, though...
>
> MS documentation for GetTokenInformation() suggests that group membership
> tests should be done with "CheckTokenMembership()", which sounds more
> convenient than "extract them all and walk the list" - so maybe this
> is done to avoid domain controller contact?


Thanks for the review :)

CheckTokenMembership() returns true only if the SID is present and enabled.
That means when UAC is active it will not detect that the user is a member
of administrators group as the SID will not be enabled. In other words, our
usage of group membership is somewhat special -- we only care user is a
member of admin or ovpn_admin groups, not that the corresponding rights be
enabled in the token.

Selva

--94eb2c05eb34be78130548f88d67
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Feb 20, 2017 at 7:18 AM, Gert Doering <span dir=3D"ltr">&lt;<a href=
=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On Sat, Jan 14,=
 2017 at 04:16:29PM -0500, <a href=3D"mailto:selva.nair@...277...">selva.na=
ir@...277...</a> wrote:<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277...">selva.nai=
r@...277...</a>&gt;<br>
&gt;<br>
&gt; Currently the username unqualified by the domain is used to validate<b=
r>
&gt; a user which fails for domain users. Instead authorize the user<br>
&gt;<br>
&gt; (i) if the built-in admin group or ovpn_admin group is in the process =
token<br>
&gt; (ii) else if the user&#39;s SID is in the built-in admin or ovpn_admin=
 groups<br>
&gt;<br>
&gt; The second check is needed to recognize dynamic updates to group membe=
rship<br>
&gt; on the local machine that will not be reflected in the token.<br>
&gt;<br>
&gt; These checks do not require connection to a domain controller and will=
<br>
&gt; work even when user is logged in with cached credentials.<br>
&gt;<br>
&gt; Resolves Trac: #810<br>
&gt;<br>
&gt; v2: include the token check as described above<br>
<br>
</span>Took me way too long...=C2=A0 the code change looks reasonable (&quo=
t;does what it<br>
says on the tin, and safely so&quot;).<br>
<br>
One questions occured to me, though...<br>
<br>
MS documentation for GetTokenInformation() suggests that group membership<b=
r>
tests should be done with &quot;CheckTokenMembership()&quot;, which sounds =
more<br>
convenient than &quot;extract them all and walk the list&quot; - so maybe t=
his<br>
is done to avoid domain controller contact?</blockquote></div><br>Thanks fo=
r the review :)<br><br>CheckTokenMembership() returns true only if the SID =
is present and enabled. That means when UAC is active it will not detect th=
at the user is a member of administrators group as the SID will not be enab=
led. In other words, our usage of group membership is somewhat special -- w=
e only care user is a member of admin or ovpn_admin groups, not that the co=
rresponding rights be enabled in the token.<br><br></div><div class=3D"gmai=
l_extra">Selva<br></div></div>

--94eb2c05eb34be78130548f88d67--

