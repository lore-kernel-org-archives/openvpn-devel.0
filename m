MIME-Version: 1.0
In-Reply-To: <CAFHpkQFNi0w665vv2tqvbx+L5-_ap003S6kZViwLLecDu0ATmw@...278...>
References: <CAKh=nwGz-NSEcSY9KhQ12gC1GNXP6XOBTEO3FdP8gyJN5VTggg@...278...>
	<de60bac0-2491-44af-2a65-00654b14f55b@...2080...>
	<CAFHpkQFG5vKg95y6_7dUWA-cjtD0+HoV_BqEztxu0TjRJ42ezA@...278...>
	<CAFHpkQEqTK+v6T2WM7Kk6Eax3VmqJcP7r=goykuVPoef+oWatQ@...278...>
	<f3597b76-1fde-1ce0-67e8-577f7bc169bc@...2080...>
	<CAFHpkQFNi0w665vv2tqvbx+L5-_ap003S6kZViwLLecDu0ATmw@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 24 Feb 2017 12:11:01 +0500
Message-ID: <CAFHpkQE-12qBv_64zKDXCgz4eCcpdcXEH8M1u_-joWwncskGyA@...278...>
Content-Type: multipart/alternative; boundary=001a1141d210a6bfa40549416e18
Subject: Re: [Openvpn-devel] build against openssl 1.1.0
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1141d210a6bfa40549416e18
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-02-19 9:48 GMT+05:00 =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=
=D1=86=D0=B8=D0=BD <chipitsine@...277...>:

>
>
> 2017-02-19 4:16 GMT+05:00 David Sommerseth <openvpn@...2142...
> topphemmelig.net>:
>
>> On 18/02/17 08:34, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
>> >     I added openssl-1.0.1e to test matrix (do not pay attention to
>> >     commit title, it happened accidently from iPad), so ...
>> >
>> >     https://travis-ci.org/OpenVPN/openvpn/jobs/202709493
>> >
>> > t_cltsrv.sh + openssl-1.0.1f  =3D OK
>> > t_cltsrv.sh + openssl-1.0.1e =3D FAIL
>>
>> Okay, lets get a few important details straight first.  When I spoke
>> about openssl-1.0.1e, it was in an RHEL context (including CentOS and
>> Scientific Linux).  In reality, that is not the same version as OpenSSL
>> upstream 1.0.1e.  Red Hat employs people to backport bugfixes and
>> security fixes from newer OpenSSL 1.0.x releases to 1.0.1e. So the
>> OpenSSL _baseline_ is 1.0.1e [1].  But it must not be compared directly
>> against v1.0.1e from openssl.org.  The baseline defines a /stable ABI/
>> (Application Binary Interface) which applications linking against the
>> library can rely on.  This is what makes RHEL and the clones so stable
>> over 7-10++ years.  And this is the challenge backporters in Red Hat
>> struggle with; not breaking applications which works.
>>
>> So unless I have misunderstood your travis commit ... you set the
>> version to 1.0.1e regardless of Linux distribution.  This itself does
>> not provide any real value for us.  As there are a lot of bugfixes and
>> security implemented in the OpenSSL package RHEL ships ... you can get
>> an idea by looking at the changelog of the openssl RPM package:
>> <https://git.centos.org/blob/rpms!!openssl/1c5d99a56e70d3f66
>> 8fd69f148538c635dd990d6/SPECS!openssl.spec#L642>
>>
>> RHEL6 was released in May 2010 while RHEL7 in June 2014.  What you see
>> above is the changelog for RHEL7.  If my count is correct, that is
>> currently 127 patches *on top of* the upstream OpenSSL v1.0.1e.  I
>> wouldn't expect this patch list to be much longer on RHEL 6 though.
>>
>> So unless your travis script is clever enough to only test OpenSSL
>> v1.0.1e on RHEL, CentOS or ScientificLinux *or* build OpenSSL using the
>> CentOS source RPM ... then I am not surprised things may fail.  Red Hat
>> may very well have fixed some bugs which we're hitting.
>>
>
>
> well, RedHat not only ship their very own openssl, but also their own
> openvpn package
>
> https://dl.fedoraproject.org/pub/epel/7/SRPMS/o/
>
> I see, there's %check section, but it is commented. Not sure how thay test
> it. We should get in touch with redhat people if we want openvpn properly
> tested and packaged
>
> I'll have a look at 'make check' under centos later
>

make check

is ok under CentOS 7 (it is shipped with openssl-1.0.1e)


>
>
>>
>>
>> --
>> kind regards,
>>
>> David Sommerseth
>> OpenVPN Technologies, Inc
>>
>>
>>
>>
>> [1] The reason is that all the _baseline_ packages in major RHEL
>>     releases are certified against a lot of hardware (IBM, HP, Dell,
>>     EMC, NetApp, etc, etc) and third party software (SAP, Oracle, etc,
>>     etc).  So rebasing is out of question, as that requires new, time
>>     consuming and expensive re-certifications.  Which is why you
>>     extremely seldom see version updates on packages.  Those few times
>>     that happens, it is usually considered to not break any important
>>     certifications.  Like, a SAP server installation probably don't
>>     have any dependencies against the GNOME 3 packages.
>>
>>
>>
>>
>>
>>
>

--001a1141d210a6bfa40549416e18
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-02-19 9:48 GMT+05:00 =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=
=D0=B8=D1=86=D0=B8=D0=BD <span dir=3D"ltr">&lt;<a href=3D"mailto:chipitsine=
@...277..." target=3D"_blank">chipitsine@...277...</a>&gt;</span>:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex"><div dir=3D"ltr"><br><div class=3D"gmail_extra"><=
br><div class=3D"gmail_quote"><div><div class=3D"h5">2017-02-19 4:16 GMT+05=
:00 David Sommerseth <span dir=3D"ltr">&lt;<a href=3D"mailto:openvpn@...2250...=
0..." target=3D"_blank">openvpn@...2142...<wbr>topphemmelig.net</a>&gt;</sp=
an>:<br><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote"><span class=3D"m_=
-2243699995421784048gmail-">On 18/02/17 08:34, =D0=98=D0=BB=D1=8C=D1=8F =D0=
=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0I added openssl-1.0.1e to test matrix (do not pay a=
ttention to<br>
&gt;=C2=A0 =C2=A0 =C2=A0commit title, it happened accidently from iPad), so=
 ...<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0<a rel=3D"noreferrer" href=3D"https://travis-ci.org=
/OpenVPN/openvpn/jobs/202709493" target=3D"_blank">https://travis-ci.org/<w=
br>OpenVPN/openvpn/jobs/202709493</a><br>
&gt;<br>
&gt; t_cltsrv.sh + openssl-1.0.1f=C2=A0 =3D OK<br>
&gt; t_cltsrv.sh + openssl-1.0.1e =3D FAIL<br>
<br>
</span>Okay, lets get a few important details straight first.=C2=A0 When I =
spoke<br>
about openssl-1.0.1e, it was in an RHEL context (including CentOS and<br>
Scientific Linux).=C2=A0 In reality, that is not the same version as OpenSS=
L<br>
upstream 1.0.1e.=C2=A0 Red Hat employs people to backport bugfixes and<br>
security fixes from newer OpenSSL 1.0.x releases to 1.0.1e. So the<br>
OpenSSL _baseline_ is 1.0.1e [1].=C2=A0 But it must not be compared directl=
y<br>
against v1.0.1e from <a rel=3D"noreferrer" href=3D"http://openssl.org" targ=
et=3D"_blank">openssl.org</a>.=C2=A0 The baseline defines a /stable ABI/<br>
(Application Binary Interface) which applications linking against the<br>
library can rely on.=C2=A0 This is what makes RHEL and the clones so stable=
<br>
over 7-10++ years.=C2=A0 And this is the challenge backporters in Red Hat<b=
r>
struggle with; not breaking applications which works.<br>
<br>
So unless I have misunderstood your travis commit ... you set the<br>
version to 1.0.1e regardless of Linux distribution.=C2=A0 This itself does<=
br>
not provide any real value for us.=C2=A0 As there are a lot of bugfixes and=
<br>
security implemented in the OpenSSL package RHEL ships ... you can get<br>
an idea by looking at the changelog of the openssl RPM package:<br>
&lt;<a rel=3D"noreferrer" href=3D"https://git.centos.org/blob/rpms%21%21ope=
nssl/1c5d99a56e70d3f668fd69f148538c635dd990d6/SPECS%21openssl.spec#L642" ta=
rget=3D"_blank">https://git.centos.org/blob/r<wbr>pms!!openssl/1c5d99a56e70=
d3f66<wbr>8fd69f148538c635dd990d6/SPECS!<wbr>openssl.spec#L642</a>&gt;<br>
<br>
RHEL6 was released in May 2010 while RHEL7 in June 2014.=C2=A0 What you see=
<br>
above is the changelog for RHEL7.=C2=A0 If my count is correct, that is<br>
currently 127 patches *on top of* the upstream OpenSSL v1.0.1e.=C2=A0 I<br>
wouldn&#39;t expect this patch list to be much longer on RHEL 6 though.<br>
<br>
So unless your travis script is clever enough to only test OpenSSL<br>
v1.0.1e on RHEL, CentOS or ScientificLinux *or* build OpenSSL using the<br>
CentOS source RPM ... then I am not surprised things may fail.=C2=A0 Red Ha=
t<br>
may very well have fixed some bugs which we&#39;re hitting.<br></blockquote=
><div><br><br></div></div></div><div>well, RedHat not only ship their very =
own openssl, but also their own openvpn package<br><br><a href=3D"https://d=
l.fedoraproject.org/pub/epel/7/SRPMS/o/" target=3D"_blank">https://dl.fedor=
aproject.org/<wbr>pub/epel/7/SRPMS/o/</a><br><br></div><div>I see, there&#3=
9;s %check section, but it is commented. Not sure how thay test it. We shou=
ld get in touch with redhat people if we want openvpn properly tested and p=
ackaged<br><br></div><div>I&#39;ll have a look at &#39;make check&#39; unde=
r centos later<br></div></div></div></div></blockquote><div><br></div><div>=
make check<br><br></div><div>is ok under CentOS 7 (it is shipped with opens=
sl-1.0.1e)<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div di=
r=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div></div>=
<span class=3D""><div>=C2=A0</div><blockquote style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex" class=3D"gmai=
l_quote">
<span class=3D"m_-2243699995421784048gmail-"><br>
<br>
--<br>
kind regards,<br>
<br>
David Sommerseth<br>
OpenVPN Technologies, Inc<br>
<br>
<br>
<br>
<br>
</span>[1] The reason is that all the _baseline_ packages in major RHEL<br>
=C2=A0 =C2=A0 releases are certified against a lot of hardware (IBM, HP, De=
ll,<br>
=C2=A0 =C2=A0 EMC, NetApp, etc, etc) and third party software (SAP, Oracle,=
 etc,<br>
=C2=A0 =C2=A0 etc).=C2=A0 So rebasing is out of question, as that requires =
new, time<br>
=C2=A0 =C2=A0 consuming and expensive re-certifications.=C2=A0 Which is why=
 you<br>
=C2=A0 =C2=A0 extremely seldom see version updates on packages.=C2=A0 Those=
 few times<br>
=C2=A0 =C2=A0 that happens, it is usually considered to not break any impor=
tant<br>
=C2=A0 =C2=A0 certifications.=C2=A0 Like, a SAP server installation probabl=
y don&#39;t<br>
=C2=A0 =C2=A0 have any dependencies against the GNOME 3 packages.<br>
<br>
<br>
<br>
<br>
<br>
</blockquote></span></div><br></div></div>
</blockquote></div><br></div></div>

--001a1141d210a6bfa40549416e18--

