MIME-Version: 1.0
In-Reply-To: <CAKuzo_hQ4MDGuAoSnabFxL9UnTnPznSMOBLUDRnoomGThoaU+w@...278...>
References: <1449446507-16654-1-git-send-email-selva.nair@...277...>
	<20151207071641.GR24952@...1296...>
	<CAKuzo_iriPYgazMiq=FKwvYbvVE39t9X8zheKP4PqOVwbtjQ7Q@...278...>
	<20151207154740.GD24952@...1296...>
	<CAKuzo_hQ4MDGuAoSnabFxL9UnTnPznSMOBLUDRnoomGThoaU+w@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 7 Dec 2015 12:31:57 -0500
Message-ID: <CAKuzo_jH=TfcwY7Y9Lsi7t6JZmNxiWq0FZyC+1JU57gSD2qz4w@...278...>
Content-Type: multipart/alternative; boundary=047d7ba97a880f75820526523dbb
Subject: Re: [Openvpn-devel] [PATCH master] Add an autoconf macro to check
 WINAPI functions
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

--047d7ba97a880f75820526523dbb
Content-Type: text/plain; charset=UTF-8

Hi,


>> > > Which environments did you test this on?  It needs to work on mingw as
>> > I use debian jessie, but it should work elsewhere.
>> >
>> > > shipped with ubuntu 12.04 (no inet_pton), mingw as shipped with 14.04
>> > > (inet_pton, *and* the definition its using conflicts with our compat/
>> > > libraries, so a false negative will fail later) and cygwin.
>>
>> Well, the reason why I pointed out these two is that they are different
>> regarding header file brokenness - I'm not sure I remember the details,
>> but stuff that broke for me on 12.04 worked for samuli on 14.04.
>>
>
> I don't think AC_FUNC_CHECK can detect intet_pton in any version of
> windows API. It just tries to link
>

Regarding the mingw-specific issue: I forgot to add that those two appear
to be the only WINAPI functions tested using AC_CHECK_FUNC in configure.ac.
These wont be detected though present in vista+. So, the build tries to use
the replacement functions even on vista, which should have been ok except
for the declaration mismatch with some mingw headers for vista+ --- such a
mismatch is not expected, so is very likely specific to some versions of
mingw, I don't know.

The failure to detect a function, but then find a mismatch while building
is a good example of the limitations of AC_CHECK_FUNC -- one being, headers
not included (cannot be included) during the test.

Selva

--047d7ba97a880f75820526523dbb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><div class=3D"gmail_quote"><br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span cl=
ass=3D""><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex"><span><br>
&gt; &gt; Which environments did you test this on?=C2=A0 It needs to work o=
n mingw as<br>
&gt; I use debian jessie, but it should work elsewhere.<br>
&gt;<br>
&gt; &gt; shipped with ubuntu 12.04 (no inet_pton), mingw as shipped with 1=
4.04<br>
&gt; &gt; (inet_pton, *and* the definition its using conflicts with our com=
pat/<br>
&gt; &gt; libraries, so a false negative will fail later) and cygwin.<br>
<br>
</span>Well, the reason why I pointed out these two is that they are differ=
ent<br>
regarding header file brokenness - I&#39;m not sure I remember the details,=
<br>
but stuff that broke for me on 12.04 worked for samuli on 14.04.<br></block=
quote><div><br></div></span><div>I don&#39;t think AC_FUNC_CHECK can detect=
 intet_pton in any version of windows API. It just tries to link</div></blo=
ckquote></div><br>Regarding the mingw-specific issue: I forgot to add that =
those two appear to be the only WINAPI functions tested using AC_CHECK_FUNC=
 in <a href=3D"http://configure.ac">configure.ac</a>. These wont be detecte=
d though present in vista+. So, the build tries to use the replacement func=
tions even on vista, which should have been ok except for the declaration m=
ismatch with some mingw headers for vista+ --- such a mismatch is not expec=
ted, so is very likely specific to some versions of mingw, I don&#39;t know=
.=C2=A0</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra=
">The failure to detect a function, but then find a mismatch while building=
 is a good example of the limitations of AC_CHECK_FUNC -- one being, header=
s not included (cannot be included) during the test.=C2=A0</div><div class=
=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Selva</div></div>

--047d7ba97a880f75820526523dbb--

