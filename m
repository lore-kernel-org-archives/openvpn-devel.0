MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Thu, 17 Dec 2015 16:22:37 -0500
Message-ID: <CAKuzo_gVUcS+j0jfoUjSYknd+G_wOqGttxTV60tuB=3RLakg4A@...278...>
Content-Type: multipart/alternative; boundary=047d7b8738a46441ff05271ea0ec
Subject: [Openvpn-devel] Issues with challenge-response when user/pass is
	read from a file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--047d7b8738a46441ff05271ea0ec
Content-Type: text/plain; charset=UTF-8

Hi,

While reviewing the series of patches from Wayne Davison, I've come to
realize that, until the recent changes in get_user_pass_cr, the use of
challenge-response was incompatible with reading auth-user-pass from a
file. As this goes back to early 2.3-alpha, it may be by design, but not
documented as such?

Anyway, as a side effect of the "username-only" commit (6e9373c846..), now
static-challenge gets prompted from console when only username is read from
a file. Dynamic challenge remains incompatible (i.e., broken if auth_file
is defined).  It looks useful and worthwhile to make this more consistent
by reading the response to the challenge from console in all cases (except
when query from management is enabled, of course).

This can be done by a few lines of changes to the code, but I would like to
hear what others think about the following options:

(a) leave as is and document that challenge-response is incompatible with
user and pass from file

OR

(b) prompt for the response from console in both dynamic and static cases

OR

(c) something else

Prompting from management works fine as long as auth-user-pass file is not
set.

If there is no strong preference, I'll submit a patch for (b) acknowledging
Wayne Davison who brought this up.

Thanks,

Selva

--047d7b8738a46441ff05271ea0ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div><div>Hi,<br><br>While review=
ing the series of patches from Wayne <span>Davison</span>, I&#39;ve come to=
 realize that, until the recent changes in get_user_pass_<span>cr</span>, t=
he use of challenge-response was incompatible with reading <span>auth</span=
>-user-pass from a file. As this goes back to early 2.3-alpha, it may be by=
 design, but not documented as such?<br></div><br>Anyway, as a side effect =
of the &quot;<span>username</span>-only&quot; commit (6e9373c846..), now st=
atic-challenge gets prompted from console when only <span>username</span> i=
s read from a file. Dynamic challenge remains incompatible (i.e., broken if=
 auth_file is defined).=C2=A0 It looks useful and worthwhile to make this m=
ore consistent by reading the response to the challenge from console in all=
 cases (except when query from management is enabled, of course).<br><br></=
div>This can be done by a few lines of changes to the code, but I would lik=
e to hear what others think about the following options:<br><br></div>(a) l=
eave as is and document that challenge-response is incompatible with user a=
nd pass from file<br></div><br>OR<br><br>(b) prompt for the response from <=
span>console</span> in both dynamic and static cases<br></div><br>OR<br><br=
>(c) something else<br><br></div><div>Prompting from management works fine =
as long as auth-user-pass file is not set.<br><br></div><div>If there is no=
 strong preference, I&#39;ll submit a patch for (b) acknowledging Wayne <sp=
an>Davison</span> who brought this up.<br><br></div>Thanks,<br><br></div><s=
pan>Selva</span><br></div>

--047d7b8738a46441ff05271ea0ec--

