MIME-Version: 1.0
From: Selva Nair <selva.nair@...277...>
Date: Sat, 7 Jan 2017 15:08:28 -0500
Message-ID: <CAKuzo_hHYCmuLXYudgp-WcXXP3mPk97HRZn9JCxj9FgcMRDChQ@...278...>
Content-Type: multipart/alternative; boundary=001a1149b9a8dbc5e5054586b32f
Subject: [Openvpn-devel] User validation by interactive service
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1149b9a8dbc5e5054586b32f
Content-Type: text/plain; charset=UTF-8

Hi,

As discussed in Trac #810, the service currently does not qualify the
username with domain while checking group membership. This breaks configs
in user's profile for domain users so I want to fix it in 2.4.1

An easy fix is to do what the GUI does -- use DOMAIN\username instead of
just username. This works by asking Windows for a list of groups a
user@...2051... belongs to and requires access to the domain controller to
resolve the user which is not ideal [1]

So I suggest to use the user's SID (which is available to the GUI through
in the process token,  and to the service through the impersonation token)
and compare it with SIDs of all members of the built-in admin group
and ovpn_admin_group
[2]

Limitations: (i) indirect membership (e.g., user is member of group A which
is a member of the admin group) will not be checked. It is possible to
recurse, but we have to restrict to checking local groups and not domain
groups to avoid connection to a DC.
(ii) Domain administrators are members of the built-in admin group though
indirect membership in "Domain Admins", but we wont detect.

I think these are reasonable limitations required to ensure that the
validation can be done using local resources only (i.e without needing to
consult the AD).

But would like to hear any suggestions for or against the above.

Thanks.

Selva

[1] In some setups domain controller may be reachable only through the VPN
and the user may be logging in with cached credentials. Even otherwise
requiring network access to validate user's access to the iservice is best
avoided
.
[2] Proposed patch is here here
<https://github.com/selvanair/openvpn/commit/7b4342a7b7f1dabd27ad94b2c665fcbe0680cf37>
(pending more tests).

--001a1149b9a8dbc5e5054586b32f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div><div><div><div><div><div>Hi,=
<br><br></div>As discussed in <span class=3D"" style=3D"" id=3D":3da.1" tab=
index=3D"-1">Trac</span> #810, the service currently does not qualify the <=
span class=3D"" style=3D"" id=3D":3da.2" tabindex=3D"-1">username</span> wi=
th domain while checking group membership. This breaks <span class=3D"" sty=
le=3D"" id=3D":3da.3" tabindex=3D"-1">configs</span> in user&#39;s profile =
for domain users so I want to fix it in 2.4.1<br><br></div>An easy fix is t=
o do what the GUI does -- use DOMAIN\username instead of just <span class=
=3D"" style=3D"" id=3D":3da.4" tabindex=3D"-1">username</span>. This works =
by asking Windows for a list of groups a user@...2051... belongs to and req=
uires access to the domain controller to resolve the user which is not idea=
l [1]<br><br></div>So I suggest to use the user&#39;s SID (which is availab=
le to the GUI through in the process token,=C2=A0 and to the service throug=
h the impersonation token) and compare it with <span class=3D"" style=3D"" =
id=3D":3da.5" tabindex=3D"-1">SIDs</span> of all members of the built-in ad=
min group and <span class=3D"" style=3D"" id=3D":3da.6" tabindex=3D"-1">ovp=
n</span>_admin_group [2]<br><br></div>Limitations: (i) indirect membership =
(e.g., user is member of group A which is a member of the admin group) will=
 not be checked. It is possible to <span class=3D"" style=3D"" id=3D":3da.7=
" tabindex=3D"-1">recurse</span>, but we have to restrict to checking local=
 groups and not domain groups to avoid connection to a DC.<br></div>(ii) Do=
main administrators are members of the built-in admin group though indirect=
 membership in &quot;Domain Admins&quot;, but we wont detect<span class=3D"=
" style=3D"" id=3D":3da.8" tabindex=3D"-1"></span>.<br><br></div>I think th=
ese are reasonable limitations required to ensure that the validation can b=
e done using local resources only (i.e without needing to consult the AD). =
<br><br></div>But would like to hear any suggestions for or against the abo=
ve.<br><br></div>Thanks.<br><br></div><span class=3D"" style=3D"" id=3D":3d=
a.9" tabindex=3D"-1">Selva</span><br></div><br>[1] In some setups domain co=
ntroller may be reachable only through the <span class=3D"" style=3D"" id=
=3D":3da.10" tabindex=3D"-1">VPN</span> and the user may be logging in with=
 cached credentials. Even otherwise requiring network access to validate us=
er&#39;s access to the <span class=3D"" style=3D"" id=3D":3da.11" tabindex=
=3D"-1">iservice</span> is best avoided<br>.<br></div>[2] Proposed patch is=
 here <a href=3D"https://github.com/selvanair/openvpn/commit/7b4342a7b7f1da=
bd27ad94b2c665fcbe0680cf37">here</a> (pending more tests).<br></div>

--001a1149b9a8dbc5e5054586b32f--

