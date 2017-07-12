MIME-Version: 1.0
In-Reply-To: <CAKuzo_gh=Hm82BdzXohiLr1CaZ_KpeKqpKDP0j6pCj_cHs6s9Q@...278...>
References: <20170709144646.10352-1-chipitsine@...277...>
	<CAFHpkQEPAzvnkRAZLPgLwt8i8LjJrVcKwTp6H32v7Dxz4Jb0Lg@...278...>
	<CAKuzo_joBeJomLCzBMYB4qWnjV-AKCPB_auQ2zcWYdH1D50eHA@...278...>
	<CAFHpkQExC-X_e5_0Xd8w4BM=iYaW98ob7Fcnnx_3=tQG3i9MBw@...278...>
	<CAKuzo_gh=Hm82BdzXohiLr1CaZ_KpeKqpKDP0j6pCj_cHs6s9Q@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 12 Jul 2017 20:50:18 +0500
Message-ID: <CAFHpkQEFZ92ncqzBGjX7TXDPYRCob7QiU8tgoccudGi5kfkGzw@...278...>
Content-Type: multipart/alternative; boundary="94eb2c0d2332e82ce5055420c52a"
Subject: Re: [Openvpn-devel] [PATCH] win32 build: check for ENETUNREACH
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c0d2332e82ce5055420c52a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-07-12 20:06 GMT+05:00 Selva Nair <selva.nair@...277...>:

>
> On Wed, Jul 12, 2017 at 10:45 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=
=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...>
> wrote:
>
>> 2017-07-12 18:54 GMT+05:00 Selva Nair <selva.nair@...277...>:
>>
>>>
>>> On Wed, Jul 12, 2017 at 4:46 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=
=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...>
>>> wrote:
>>>
>>>> No interest ?
>>>>
>>>> 9 =D0=B8=D1=8E=D0=BB. 2017 =D0=B3. 19:46 =D0=BF=D0=BE=D0=BB=D1=8C=D0=
=B7=D0=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C "Ilya Shipitsin" <
>>>> chipitsine@...277...> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:
>>>>
>>>>> Currently, we do not check for mingw-gcc version. For example,
>>>>> Debian 7 is shipped with 4.6.3, which does not know about ENETUNREACH
>>>>> ---
>>>>>
>>>>> this is for 2.4 and HEAD branches
>>>>>
>>>>>  configure.ac | 14 ++++++++++++++
>>>>>  1 file changed, 14 insertions(+)
>>>>>
>>>>> diff --git a/configure.ac b/configure.ac
>>>>> index 60bb465..80b26ff 100644
>>>>> --- a/configure.ac
>>>>> +++ b/configure.ac
>>>>> @@ -708,6 +708,20 @@ m4_define(
>>>>>         [setsockopt getsockopt getsockname poll]dnl
>>>>>  )
>>>>>  if test "${WIN32}" =3D "yes"; then
>>>>> +
>>>>> +#
>>>>> +# check for ENETUNREACH
>>>>> +# at least Debian 7 is shipped with gcc-mingw-w64-4.6.3, which is too
>>>>> old
>>>>
>>>>
>>> Instead of checking for a particular define why not require a minimal
>>> version of gcc ? I do not know what version that would be, though..
>>>
>>
>>
>> if you would try to build using ubuntu-14.04, build would fail (I'll
>> submit configure patch for that soon as well).
>> however, if modified compiler would used https://community.openvpn.net/
>> openvpn/wiki/PatchingDebs ... the build will succeed
>>
>
> There is no reliable way to support arbitrarily patched build
> environments. If I patch mingw in ubuntu 14-04 to have ENETUNREACH
> defined, the above check would pass but build may still fail somewhere el=
se.
>


ENETUNREACH check is for Debian 7.

Ubuntu 14.04 is shipped with broken fwpmu.h:
https://github.com/chipitsine/openvpn/commit/03013fd6f5b57a122302ce1a534a70=
61acde9d5b
:)


>
> I still think we should just determine what official version of mingw-gcc
> is required and add a test for it.
>
> Selva
>

--94eb2c0d2332e82ce5055420c52a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-07-12 20:06 GMT+05:00 Selva Nair <span dir=3D"ltr">&lt;<a href=3D"=
mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;=
</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"l=
tr"><div class=3D"gmail_extra"><div><div class=3D"gmail-h5"><br><div class=
=3D"gmail_quote">On Wed, Jul 12, 2017 at 10:45 AM, =D0=98=D0=BB=D1=8C=D1=8F=
 =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <span dir=3D"ltr">&lt;<a href=
=3D"mailto:chipitsine@...277..." target=3D"_blank"><span id=3D"gmail-m_-601=
479893549234029:bfh.1">chipitsine</span>@gmail.com</a>&gt;</span> wrote:<br=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex"><span>2017-07-12 18:54 G=
MT+05:00 Selva Nair <span dir=3D"ltr">&lt;<a href=3D"mailto:selva.nair@...1665...=
77..." target=3D"_blank">selva.nair@...277...</a>&gt;</span>:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmai=
l_extra"><span class=3D"gmail-m_-601479893549234029m_8690419433193343298gma=
il-"><br><div class=3D"gmail_quote">On Wed, Jul 12, 2017 at 4:46 AM, =D0=98=
=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <span dir=3D"=
ltr">&lt;<a href=3D"mailto:chipitsine@...277..." target=3D"_blank">chipitsi=
ne@...277...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex"><div dir=3D"auto">No interest ?</div><div class=3D"gmail_extra=
"><br><div class=3D"gmail_quote">9 =D0=B8=D1=8E=D0=BB. 2017 =D0=B3. <span c=
lass=3D"gmail-m_-601479893549234029m_8690419433193343298gmail-m_47695962019=
45500580aBn"><span class=3D"gmail-m_-601479893549234029m_869041943319334329=
8gmail-m_4769596201945500580aQJ"><span class=3D"gmail-m_-601479893549234029=
aBn"><span class=3D"gmail-m_-601479893549234029aQJ">19:46</span></span></sp=
an></span> =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=
=BB=D1=8C &quot;Ilya Shipitsin&quot; &lt;<a href=3D"mailto:chipitsine@...1664...=
7..." target=3D"_blank">chipitsine@...277...</a>&gt; =D0=BD=D0=B0=D0=BF=D0=
=B8=D1=81=D0=B0=D0=BB:<br type=3D"attribution"><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">Currently, we do not check for mingw-gcc version. For=
 example,<br>
Debian 7 is shipped with 4.6.3, which does not know about ENETUNREACH<br>
---<br>
<br>
this is for 2.4 and HEAD branches<br>
<br>
=C2=A0<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a> | 14 ++++++++++++++<br>
=C2=A01 file changed, 14 insertions(+)<br>
<br>
diff --git a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_=
blank">configure.ac</a> b/<a href=3D"http://configure.ac" rel=3D"noreferrer=
" target=3D"_blank">configure.ac</a><br>
index 60bb465..80b26ff 100644<br>
--- a/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
+++ b/<a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_blank">=
configure.ac</a><br>
@@ -708,6 +708,20 @@ m4_define(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 [setsockopt getsockopt getsockname poll]dnl<br>
=C2=A0)<br>
=C2=A0if test &quot;${WIN32}&quot; =3D &quot;yes&quot;; then<br>
+<br>
+#<br>
+# check for ENETUNREACH<br>
+# at least Debian 7 is shipped with gcc-mingw-w64-4.6.3, which is too old<=
/blockquote></div></div></blockquote></div><br></span>Instead of checking f=
or a particular define why not require a minimal version of gcc ? I do not =
know what version that would be, though..</div></div></blockquote><div><br>=
<br></div></span><div>if you would try to build using ubuntu-14.04, build w=
ould fail (I&#39;ll submit configure patch for that soon as well).<br></div=
><div>however, if modified compiler would used <a href=3D"https://community=
.openvpn.net/openvpn/wiki/PatchingDebs" target=3D"_blank">https://community=
.openvpn.net/<wbr>openvpn/wiki/PatchingDebs</a> ... the build will succeed<=
/div></blockquote></div><br></div></div>There is no reliable way to support=
 arbitrarily patched build environments. If I patch <span id=3D"gmail-m_-60=
1479893549234029:bfh.3">mingw</span> in <span id=3D"gmail-m_-60147989354923=
4029:bfh.4">ubuntu</span> 14-04 to have <span id=3D"gmail-m_-60147989354923=
4029:bfh.5">ENETUNREACH</span> defined, the above check would pass but buil=
d may still fail somewhere else.</div></div></blockquote><div><br><br><span=
><span class=3D"gmail-m_-601479893549234029m_8690419433193343298gmail-">ENE=
TUNREACH check is for Debian 7.<br><br></span></span></div><div><span><span=
 class=3D"gmail-m_-601479893549234029m_8690419433193343298gmail-">Ubuntu 14=
.04 is shipped with broken fwpmu.h:=C2=A0 <a href=3D"https://github.com/chi=
pitsine/openvpn/commit/03013fd6f5b57a122302ce1a534a7061acde9d5b">https://gi=
thub.com/chipitsine/openvpn/commit/03013fd6f5b57a122302ce1a534a7061acde9d5b=
</a>=C2=A0 :)<br></span></span></div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_extra"><b=
r></div><div class=3D"gmail_extra">I still think we should just determine w=
hat official version of <span id=3D"gmail-m_-601479893549234029:bfh.7">ming=
w</span>-<span id=3D"gmail-m_-601479893549234029:bfh.8">gcc</span> is requi=
red and add a test for it.</div><span class=3D"gmail-HOEnZb"><font color=3D=
"#888888"><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><=
span id=3D"gmail-m_-601479893549234029:bfh.9">Selva</span></div></font></sp=
an></div>
</blockquote></div><br></div></div>

--94eb2c0d2332e82ce5055420c52a--

