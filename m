MIME-Version: 1.0
In-Reply-To: <50F9055C.8000908@...515...>
References: <CABT9mj_oAJ6sRy0_TKrWBVdN5OeTBVwC+-GmAkHbUPmpi=j5HQ@...278...>
	<20130116101123.GU22465@...1296...>
	<CABT9mj_MjH3Bo9tq0ahpnnA8rWh+a3UOaTH9DPgATq+ZJ_6YDQ@...278...>
	<50F80441.6060407@...515...>
	<994BD26D-4B6E-427E-AD47-BEA12119EDEC@...277...>
	<50F9055C.8000908@...515...>
Date: Fri, 18 Jan 2013 15:05:35 +0200
Message-ID: <CABT9mj_ruNxGR_XUSfepu3NUgfBJjXY_rWHLvBi58ovZpTGkNg@...278...>
From: Athanasios Douitsis <aduitsis@...277...>
Content-Type: multipart/alternative; boundary=047d7b6774d05e68ee04d38fc4e1
Subject: Re: [Openvpn-devel] compiling with visual studio
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--047d7b6774d05e68ee04d38fc4e1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 18, 2013 at 10:18 AM, Samuli Sepp=E4nen <samuli@...515...>wrote:

>
>
> > Hi,
> >
> > First of thanks for taking the time to write a very comprehensive
> response, much appreciated.
> >
> > Although I have already succeeded with the msvc build, the idea of
> having a dedicated vm doing building and packaging seems very agreeable.
> I'll be sure to get back to you if there are any questions.
> >
> > Best regards and thanks,
> > Athanasios
> >
>
> Hi Athanasios,
>
> Good to hear you got msvc builds to work! Now, you mentioned that the
> documentation about msvc building was obsolete. Could you update the
> documentation on the Wiki or let us know which steps you needed to take
> to get the build working?
>


It was somewhat of a mess, actually. Some download URLs are invalid, so
appropriate replacements must be found. With pkcs11-helper, I had to copy
an older zip from an older build of mine. Trying to get the current zip
file from alon's or opensc repo on github yields the error:

NMAKE : fatal error U1073: don't know how to make 'versioninfo.res'

Correct me if I'm wrong, but to produce the versioninfo.res file one would
need the versioninfo.rc file. But unfortunately the versioninfo.rc file is
not here:

https://github.com/alonbl/pkcs11-helper/tree/pkcs11-helper-1.09/lib

There is the versioninfo.rc.in file in the same place, but the build
requirements are Perl and VS10, so automake is not going to be available
right?

After that it should be smooth sailing from there, apart form the fact that
the source for openvpn 2.3 contains 2 places where c99-ish C is used. But
you already know that.


Kind regards,
Athanasios




>
> --
> Samuli Sepp=E4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
>


--=20
Athanasios Douitsis

--047d7b6774d05e68ee04d38fc4e1
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Fri, Jan 18, 2013 at 10:18 AM, Samuli=
 Sepp=E4nen <span dir=3D"ltr">&lt;<a href=3D"mailto:samuli@...515..." targe=
t=3D"_blank">samuli@...515...</a>&gt;</span> wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">
<div class=3D"im"><br>
<br>
&gt; Hi,<br>
&gt;<br>
&gt; First of thanks for taking the time to write a very comprehensive resp=
onse, much appreciated.<br>
&gt;<br>
&gt; Although I have already succeeded with the msvc build, the idea of hav=
ing a dedicated vm doing building and packaging seems very agreeable. I&#39=
;ll be sure to get back to you if there are any questions.<br>
&gt;<br>
&gt; Best regards and thanks,<br>
&gt; Athanasios<br>
&gt;<br>
<br>
</div>Hi Athanasios,<br>
<br>
Good to hear you got msvc builds to work! Now, you mentioned that the<br>
documentation about msvc building was obsolete. Could you update the<br>
documentation on the Wiki or let us know which steps you needed to take<br>
to get the build working?<br></blockquote><div><br><br>It was somewhat of a=
 mess, actually. Some download URLs are invalid, so appropriate replacement=
s must be found. With pkcs11-helper, I had to copy an older zip from an old=
er build of mine. Trying to get the current zip file from alon&#39;s or ope=
nsc repo on github yields the error:<br>
<br>NMAKE : fatal error U1073: don&#39;t know how to make &#39;versioninfo.=
res&#39;<br><br>Correct me if I&#39;m wrong, but to produce the versioninfo=
.res file one would need the versioninfo.rc file. But unfortunately the ver=
sioninfo.rc file is not here:<br>
<br><a href=3D"https://github.com/alonbl/pkcs11-helper/tree/pkcs11-helper-1=
.09/lib">https://github.com/alonbl/pkcs11-helper/tree/pkcs11-helper-1.09/li=
b</a><br><br>There is the <a href=3D"http://versioninfo.rc.in">versioninfo.=
rc.in</a> file in the same place, but the build requirements are Perl and V=
S10, so automake is not going to be available right? <br>
<br>After that it should be smooth sailing from there, apart form the fact =
that the source for openvpn 2.3 contains 2 places where c99-ish C is used. =
But you already know that.<br><br><br>Kind regards,<br>Athanasios<br><br>
<br>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5"><br>
--<br>
Samuli Sepp=E4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>Athanasios =
Douitsis<br><br><br>

--047d7b6774d05e68ee04d38fc4e1--

