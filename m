MIME-Version: 1.0
References: <CAKh=nwGz-NSEcSY9KhQ12gC1GNXP6XOBTEO3FdP8gyJN5VTggg@...278...>
	<de60bac0-2491-44af-2a65-00654b14f55b@...2080...>
In-Reply-To: <de60bac0-2491-44af-2a65-00654b14f55b@...2080...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 17 Feb 2017 18:17:43 +0000
Message-ID: <CAFHpkQFG5vKg95y6_7dUWA-cjtD0+HoV_BqEztxu0TjRJ42ezA@...278...>
Content-Type: multipart/alternative; boundary=001a1148e3aab8bf4c0548bdee09
Subject: Re: [Openvpn-devel] build against openssl 1.1.0
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Emmanuel Deloget <logout@...260...>, openvpn-devel@lists.sourceforge.net

--001a1148e3aab8bf4c0548bdee09
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=9F=D1=82, 17 =D1=84=D0=B5=D0=B2=D1=80. 2017 =D0=B3. =D0=B2 22:21, David=
 Sommerseth <
openvpn@...2080...>:

> On 17/02/17 17:35, Emmanuel Deloget wrote:
> >
> > Now, I have a question which is related to this. The way I'm doing
> > things, I will make sure that the new code is compatible with both
> > OpenSSL 1.0.x and OpenSSL 1.1. There is a good chance that it will be
> > compatible with version 0.9.8 as well, yet I can't stop wondering if
> > this is a good thing. OpenSSL 0.9.8 has been EoL'ed 12 month ago and I
> > believe it's OK to let it die. OpenVPN cannot rely on a dead SSL
> > library -- unless it wants to make sure that future vulnerabilities in
> > this old, deprecated version will affect it (and I'm not sure it's a
> > good thing). Same goes for OpenSSL 1.0.1 which has been declared out
> > of support in January 2017.
>
> TL;DR: You can drop support for OpenSSL v1.0.1d and older, but we must
> support v1.0.1e until at least June 30, 2024.




I added openssl-1.0.1e to test matrix (do not pay attention to commit
title, it happened accidently from iPad), so ...

https://travis-ci.org/OpenVPN/openvpn/jobs/202709493





>
>
> And now to why ....
>
> One thing is what the upstream OpenSSL supports or not.  But there are
> commercial Linux vendors which maintains versions after upstream drops
> the support.  The most obvious Linux vendor here is Red Hat.
>
> We have had a policy that the oldest Linux distribution we support is
> what Red Hat officially supports [1].  We do not consider the "extended
> support" scenarios, as that is services customers needs to pay extra for
> (and is quite costly, AFAIR).  Currently, RHEL 5 (Red Hat Enterprise
> Linux 5) is the oldest supported distribution, so that is what we
> support.  But that support expires March 31, 2017.  So as of April 1st,
> 2017 RHEL 6 is the oldest distribution we support.
>
> With that said.  Since we released OpenVPN v2.4 fairly recently (late
> December), we have not considered or planned for a long-term RHEL 5
> support for that distribution, as that is going EOL very soon.
>
> [1]
> <https://access.redhat.com/support/policy/updates/errata/#Life_Cycle_Dates
> >
>
>
> > I understand that I'm the new guy in town, but can you allow me to
> > make the formal request to ditch OpenSSL 0.9.8, 1.0.0 and 1.0.1 and
> > require at least version 1.0.2?
>
> So to the RHEL releases and the OpenSSL versions.  RHEL 5 ships with
> openssl-0.9.8e.  Both RHEL 6 and RHEL 7 ships with openssl-1.0.1e.
>
> The way Red Hat releases works is that versions are close to never
> rebased, at least not core libraries such as OpenSSL.  But Red Hat
> employs a lot of users to ensure all packages they distribute is secure
> and maintained.  That means that security and important bug fixes will
> be backported from newer OpenSSL releases to the openssl-1.0.1e
> baseline.  And this happens for the whole life cycle of each major releas=
e.
>
> Sometimes even features are backported as well.  But I have gotten
> fairly clear signals that TLSv1.3 from openssl-1.1 will not be
> backported, as the code has changed too much since the 1.0.1 baseline.
> But I would be surprised if a future RHEL 8 does not ship with
> openssl-1.1.x
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
> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--001a1148e3aab8bf4c0548bdee09
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br><div class=3D"gmail_quote"><div>=D0=9F=D1=82, 17 =D1=84=D0=B5=D0=
=B2=D1=80. 2017 =D0=B3. =D0=B2 22:21, David Sommerseth &lt;<a href=3D"mailt=
o:openvpn@...2080...">openvpn@...2080...</a>&gt;:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">On 17/02/17 17:35, Emmanuel Deloget wrote:<br class=3D"gmail=
_msg">
&gt;<br class=3D"gmail_msg">
&gt; Now, I have a question which is related to this. The way I&#39;m doing=
<br class=3D"gmail_msg">
&gt; things, I will make sure that the new code is compatible with both<br =
class=3D"gmail_msg">
&gt; OpenSSL 1.0.x and OpenSSL 1.1. There is a good chance that it will be<=
br class=3D"gmail_msg">
&gt; compatible with version 0.9.8 as well, yet I can&#39;t stop wondering =
if<br class=3D"gmail_msg">
&gt; this is a good thing. OpenSSL 0.9.8 has been EoL&#39;ed 12 month ago a=
nd I<br class=3D"gmail_msg">
&gt; believe it&#39;s OK to let it die. OpenVPN cannot rely on a dead SSL<b=
r class=3D"gmail_msg">
&gt; library -- unless it wants to make sure that future vulnerabilities in=
<br class=3D"gmail_msg">
&gt; this old, deprecated version will affect it (and I&#39;m not sure it&#=
39;s a<br class=3D"gmail_msg">
&gt; good thing). Same goes for OpenSSL 1.0.1 which has been declared out<b=
r class=3D"gmail_msg">
&gt; of support in January 2017.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
TL;DR: You can drop support for OpenSSL v1.0.1d and older, but we must<br c=
lass=3D"gmail_msg">
support v1.0.1e until at least June 30, 2024.</blockquote><div><br></div><d=
iv><br></div><div><br></div><div>I added openssl-1.0.1e to test matrix (do =
not pay attention to commit title, it happened accidently from iPad), so ..=
.</div><div><br></div><div><a href=3D"https://travis-ci.org/OpenVPN/openvpn=
/jobs/202709493">https://travis-ci.org/OpenVPN/openvpn/jobs/202709493</a><b=
r></div><div><br></div><div><br></div><div><br></div><div><br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex"><br class=3D"gmail_msg">
<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
And now to why ....<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
One thing is what the upstream OpenSSL supports or not.=C2=A0 But there are=
<br class=3D"gmail_msg">
commercial Linux vendors which maintains versions after upstream drops<br c=
lass=3D"gmail_msg">
the support.=C2=A0 The most obvious Linux vendor here is Red Hat.<br class=
=3D"gmail_msg">
<br class=3D"gmail_msg">
We have had a policy that the oldest Linux distribution we support is<br cl=
ass=3D"gmail_msg">
what Red Hat officially supports [1].=C2=A0 We do not consider the &quot;ex=
tended<br class=3D"gmail_msg">
support&quot; scenarios, as that is services customers needs to pay extra f=
or<br class=3D"gmail_msg">
(and is quite costly, AFAIR).=C2=A0 Currently, RHEL 5 (Red Hat Enterprise<b=
r class=3D"gmail_msg">
Linux 5) is the oldest supported distribution, so that is what we<br class=
=3D"gmail_msg">
support.=C2=A0 But that support expires March 31, 2017.=C2=A0 So as of Apri=
l 1st,<br class=3D"gmail_msg">
2017 RHEL 6 is the oldest distribution we support.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
With that said.=C2=A0 Since we released OpenVPN v2.4 fairly recently (late<=
br class=3D"gmail_msg">
December), we have not considered or planned for a long-term RHEL 5<br clas=
s=3D"gmail_msg">
support for that distribution, as that is going EOL very soon.<br class=3D"=
gmail_msg">
<br class=3D"gmail_msg">
[1]<br class=3D"gmail_msg">
&lt;<a href=3D"https://access.redhat.com/support/policy/updates/errata/#Lif=
e_Cycle_Dates" rel=3D"noreferrer" class=3D"gmail_msg" target=3D"_blank">htt=
ps://access.redhat.com/support/policy/updates/errata/#Life_Cycle_Dates</a>&=
gt;<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
&gt; I understand that I&#39;m the new guy in town, but can you allow me to=
<br class=3D"gmail_msg">
&gt; make the formal request to ditch OpenSSL 0.9.8, 1.0.0 and 1.0.1 and<br=
 class=3D"gmail_msg">
&gt; require at least version 1.0.2?<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
So to the RHEL releases and the OpenSSL versions.=C2=A0 RHEL 5 ships with<b=
r class=3D"gmail_msg">
openssl-0.9.8e.=C2=A0 Both RHEL 6 and RHEL 7 ships with openssl-1.0.1e.<br =
class=3D"gmail_msg">
<br class=3D"gmail_msg">
The way Red Hat releases works is that versions are close to never<br class=
=3D"gmail_msg">
rebased, at least not core libraries such as OpenSSL.=C2=A0 But Red Hat<br =
class=3D"gmail_msg">
employs a lot of users to ensure all packages they distribute is secure<br =
class=3D"gmail_msg">
and maintained.=C2=A0 That means that security and important bug fixes will=
<br class=3D"gmail_msg">
be backported from newer OpenSSL releases to the openssl-1.0.1e<br class=3D=
"gmail_msg">
baseline.=C2=A0 And this happens for the whole life cycle of each major rel=
ease.<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
Sometimes even features are backported as well.=C2=A0 But I have gotten<br =
class=3D"gmail_msg">
fairly clear signals that TLSv1.3 from openssl-1.1 will not be<br class=3D"=
gmail_msg">
backported, as the code has changed too much since the 1.0.1 baseline.<br c=
lass=3D"gmail_msg">
But I would be surprised if a future RHEL 8 does not ship with openssl-1.1.=
x<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
--<br class=3D"gmail_msg">
kind regards,<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
David Sommerseth<br class=3D"gmail_msg">
OpenVPN Technologies, Inc<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
<br class=3D"gmail_msg">
---------------------------------------------------------------------------=
---<br class=3D"gmail_msg">
Check out the vibrant tech community on one of the world&#39;s most<br clas=
s=3D"gmail_msg">
engaging tech sites, SlashDot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" class=3D"gmail_msg" target=3D"_blank">http://sdm.link/slash=
dot</a>_______________________________________________<br class=3D"gmail_ms=
g">
Openvpn-devel mailing list<br class=3D"gmail_msg">
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" class=3D"gmail_msg" =
target=3D"_blank">Openvpn-devel@lists.sourceforge.net</a><br class=3D"gmail=
_msg">
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" class=3D"gmail_msg" target=3D"_blank">https://lists.sourcef=
orge.net/lists/listinfo/openvpn-devel</a><br class=3D"gmail_msg">
</blockquote></div></div>

--001a1148e3aab8bf4c0548bdee09--

