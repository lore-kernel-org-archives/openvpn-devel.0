MIME-Version: 1.0
In-Reply-To: <f25623ee-09e1-6b5c-e573-bff0f8fe4ae9@...515...>
References: <915ececd-c052-01b7-6051-74b3bc87b5fb@...515...>
	<f25623ee-09e1-6b5c-e573-bff0f8fe4ae9@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 8 Nov 2016 14:22:20 +0500
Message-ID: <CAFHpkQFWfW7du2SKrCALHF=aPxY_VnWuk99U-pm+5BZ1Htw8HA@...278...>
Content-Type: multipart/alternative; boundary=001a1144375e6918e00540c6ad8d
Subject: Re: [Openvpn-devel] Summary of today's (Monday,
 7th Nov 2016) community meeting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1144375e6918e00540c6ad8d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2016-11-08 1:39 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:

> Hi,
>
> Here's the summary of today's IRC meeting.
>
> ---
>
> COMMUNITY MEETING
>
> Place: #openvpn-meeting on irc.freenode.net
> Date: Monday 7th November 2016
> Time: 20:00 CET (19:00 UTC)
>
> Planned meeting topics for this meeting were here:
>
> <https://community.openvpn.net/openvpn/wiki/Topics-2016-11-07>
>
> The next meeting has not been scheduled yet.
>
> Your local meeting time is easy to check from services such as
>
> <http://www.timeanddate.com/worldclock>
>
> SUMMARY
>
> agi, cron2, dazo, lev, mattock and syzzer participated in this meeting.
>
> ---
>
> Discussed patchwork:
>
> <http://jk.ozlabs.org/projects/patchwork/>
>
> It was agreed that even the minimal level ("show status of patches on the
> list") would be useful, especially with community LDAP integration. At a
> later point we can implement a more elaborate process such as this:
>
> Patch comes in to openvpn-devel
> Patchwork picks it up
> Test "git apply"
>   - Failure -> auto-reject
>   - Success -> queue
> Preliminary human review ("feature-ACK")
>   - Makes sense -> trigger build test
>     - Failure -> auto-reject
>     - Success -> code review
>   - Does not make sense -> reject
>
> This approach would be DoS/misuse-resistant: starting builds automatically
> from random patches sent to list would be dangerous on many levels.
>
> Mattock will start by setting up patchwork with the minimal feature set,
> as discussed above.
>
> ---
>
> Discussed basic Windows testing, which could be fully automated by
> integrating these two tools together:
>
> <https://github.com/mattock/openvpn-windows-buildtest>
> <https://github.com/mattock/openvpn-windows-test>
>
> The glue would probably more Powershell scripting, along with a Chocolatey
> repository for OpenVPN:
>
> <https://chocolatey.org/>
>
> Wpkg was also mentioned as an option for Chocolatey, but it is less well
> suited for a public-facing repository, as some of its features depend on
> SMB shares.
>
> ---
>
> Discussed OpenVPN 2.4 release schedule. It was agreed to set the deadline
> for 2.4_beta1 to November 16th. That will give us some time to finish the
> final set of really important patches. Any major features that remain will
> be postponed for 2.5. The release date for 2.5_alpha1 could be set to ~6
> months after 2.4.0, so this postponement of features would not be the end
> of the work.
>
> ---
>
> Discussed the only known openvpnserv2 issue:
>
> <https://github.com/xkjyeah/openvpnserv2/issues/10>
>
> Agreed that, if possible, the fix should go in to 2.4.0, but if necessary,
> to a later point release. The fix is important, as it is possible, in
> certain cases, for connectivity to break, if openvpnserv2 restarts a
> connection.
>
> ---
>
> Discussed our systemd unit files, which would be good to have in all
> distros; right now all distros have rolled up their own.  Our unit files
> handle clients and servers separately, which has the benefit that it allo=
ws
> seamless migrations, as well as fixes some issues with certain Cloud
> providers:
>
> <https://community.openvpn.net/openvpn/ticket/462>
> <https://bugs.launchpad.net/ubuntu/+source/openvpn/+bug/1580356>
>
> Agi, the Debian package maintainer, will test our systemd unit files and
> report back.
>
> ---
>
> Discussed latest results from Coverity Scan. Our defect average is way
> below industry average. The new "defects" in our current code (as reported
> by Coverity) are not really defects, but more related to coding style.
>
> ---
>
> Discussed OpenVPN 2.3.14 release. The biggest thing missing is
> "block-outside-dns v2". The



block-outside-dns is not supported on WinXP, right ?



> remaining things are fairly minor in comparison. Decided to release 2.3.14
> after 2.4_beta1 is out to keep our focus clear.
>
> --
>
> Full chatlog has been attached to this email.
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
>
>
> ------------------------------------------------------------
> ------------------
> Developer Access Program for Intel Xeon Phi Processors
> Access to Intel Xeon Phi processor-based developer platforms.
> With one year of Intel Parallel Studio XE.
> Training and support from Colfax.
> Order your platform today. http://sdm.link/xeonphi
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>

--001a1144375e6918e00540c6ad8d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2016-11-08 1:39 GMT+05:00 Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:samuli@...515..." target=3D"_blank">samuli@...515...</a>&gt=
;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
Here&#39;s the summary of today&#39;s IRC meeting.<br>
<br>
---<br>
<br>
COMMUNITY MEETING<br>
<br>
Place: #openvpn-meeting on <a href=3D"http://irc.freenode.net" rel=3D"noref=
errer" target=3D"_blank">irc.freenode.net</a><br>
Date: Monday 7th November 2016<br>
Time: 20:00 CET (19:00 UTC)<br>
<br>
Planned meeting topics for this meeting were here:<br>
<br>
&lt;<a href=3D"https://community.openvpn.net/openvpn/wiki/Topics-2016-11-07=
" rel=3D"noreferrer" target=3D"_blank">https://community.openvpn.net<wbr>/o=
penvpn/wiki/Topics-2016-11-<wbr>07</a>&gt;<br>
<br>
The next meeting has not been scheduled yet.<br>
<br>
Your local meeting time is easy to check from services such as<br>
<br>
&lt;<a href=3D"http://www.timeanddate.com/worldclock" rel=3D"noreferrer" ta=
rget=3D"_blank">http://www.timeanddate.com/wo<wbr>rldclock</a>&gt;<br>
<br>
SUMMARY<br>
<br>
agi, cron2, dazo, lev, mattock and syzzer participated in this meeting.<br>
<br>
---<br>
<br>
Discussed patchwork:<br>
<br>
&lt;<a href=3D"http://jk.ozlabs.org/projects/patchwork/" rel=3D"noreferrer"=
 target=3D"_blank">http://jk.ozlabs.org/projects<wbr>/patchwork/</a>&gt;<br>
<br>
It was agreed that even the minimal level (&quot;show status of patches on =
the list&quot;) would be useful, especially with community LDAP integration=
. At a later point we can implement a more elaborate process such as this:<=
br>
<br>
Patch comes in to openvpn-devel<br>
Patchwork picks it up<br>
Test &quot;git apply&quot;<br>
=C2=A0 - Failure -&gt; auto-reject<br>
=C2=A0 - Success -&gt; queue<br>
Preliminary human review (&quot;feature-ACK&quot;)<br>
=C2=A0 - Makes sense -&gt; trigger build test<br>
=C2=A0 =C2=A0 - Failure -&gt; auto-reject<br>
=C2=A0 =C2=A0 - Success -&gt; code review<br>
=C2=A0 - Does not make sense -&gt; reject<br>
<br>
This approach would be DoS/misuse-resistant: starting builds automatically =
from random patches sent to list would be dangerous on many levels.<br>
<br>
Mattock will start by setting up patchwork with the minimal feature set, as=
 discussed above.<br>
<br>
---<br>
<br>
Discussed basic Windows testing, which could be fully automated by integrat=
ing these two tools together:<br>
<br>
&lt;<a href=3D"https://github.com/mattock/openvpn-windows-buildtest" rel=3D=
"noreferrer" target=3D"_blank">https://github.com/mattock/op<wbr>envpn-wind=
ows-buildtest</a>&gt;<br>
&lt;<a href=3D"https://github.com/mattock/openvpn-windows-test" rel=3D"nore=
ferrer" target=3D"_blank">https://github.com/mattock/op<wbr>envpn-windows-t=
est</a>&gt;<br>
<br>
The glue would probably more Powershell scripting, along with a Chocolatey =
repository for OpenVPN:<br>
<br>
&lt;<a href=3D"https://chocolatey.org/" rel=3D"noreferrer" target=3D"_blank=
">https://chocolatey.org/</a>&gt;<br>
<br>
Wpkg was also mentioned as an option for Chocolatey, but it is less well su=
ited for a public-facing repository, as some of its features depend on SMB =
shares.<br>
<br>
---<br>
<br>
Discussed OpenVPN 2.4 release schedule. It was agreed to set the deadline f=
or 2.4_beta1 to November 16th. That will give us some time to finish the fi=
nal set of really important patches. Any major features that remain will be=
 postponed for 2.5. The release date for 2.5_alpha1 could be set to ~6 mont=
hs after 2.4.0, so this postponement of features would not be the end of th=
e work.<br>
<br>
---<br>
<br>
Discussed the only known openvpnserv2 issue:<br>
<br>
&lt;<a href=3D"https://github.com/xkjyeah/openvpnserv2/issues/10" rel=3D"no=
referrer" target=3D"_blank">https://github.com/xkjyeah/op<wbr>envpnserv2/is=
sues/10</a>&gt;<br>
<br>
Agreed that, if possible, the fix should go in to 2.4.0, but if necessary, =
to a later point release. The fix is important, as it is possible, in certa=
in cases, for connectivity to break, if openvpnserv2 restarts a connection.=
<br>
<br>
---<br>
<br>
Discussed our systemd unit files, which would be good to have in all distro=
s; right now all distros have rolled up their own.=C2=A0 Our unit files han=
dle clients and servers separately, which has the benefit that it allows se=
amless migrations, as well as fixes some issues with certain Cloud provider=
s:<br>
<br>
&lt;<a href=3D"https://community.openvpn.net/openvpn/ticket/462" rel=3D"nor=
eferrer" target=3D"_blank">https://community.openvpn.net<wbr>/openvpn/ticke=
t/462</a>&gt;<br>
&lt;<a href=3D"https://bugs.launchpad.net/ubuntu/+source/openvpn/+bug/15803=
56" rel=3D"noreferrer" target=3D"_blank">https://bugs.launchpad.net/ub<wbr>=
untu/+source/openvpn/+bug/1580<wbr>356</a>&gt;<br>
<br>
Agi, the Debian package maintainer, will test our systemd unit files and re=
port back.<br>
<br>
---<br>
<br>
Discussed latest results from Coverity Scan. Our defect average is way belo=
w industry average. The new &quot;defects&quot; in our current code (as rep=
orted by Coverity) are not really defects, but more related to coding style=
.<br>
<br>
---<br>
<br>
Discussed OpenVPN 2.3.14 release. The biggest thing missing is &quot;block-=
outside-dns v2&quot;. The </blockquote><div><br><br></div><div>block-outsid=
e-dns is not supported on WinXP, right ?<br></div><div><br>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">remaining things are fairly minor in comparison.=
 Decided to release 2.3.14 after 2.4_beta1 is out to keep our focus clear.<=
span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
-- <br>
<br>
Full chatlog has been attached to this email.<br>
<br>
-- <br>
Samuli Sepp=C3=A4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
<br>
<br>
</font></span><br>------------------------------<wbr>----------------------=
--------<wbr>------------------<br>
Developer Access Program for Intel Xeon Phi Processors<br>
Access to Intel Xeon Phi processor-based developer platforms.<br>
With one year of Intel Parallel Studio XE.<br>
Training and support from Colfax.<br>
Order your platform today. <a href=3D"http://sdm.link/xeonphi" rel=3D"noref=
errer" target=3D"_blank">http://sdm.link/xeonphi</a><br>___________________=
___________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
<br></blockquote></div><br></div></div>

--001a1144375e6918e00540c6ad8d--

