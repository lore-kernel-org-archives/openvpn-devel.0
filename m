MIME-Version: 1.0
In-Reply-To: <CAFHpkQExC-X_e5_0Xd8w4BM=iYaW98ob7Fcnnx_3=tQG3i9MBw@...278...>
References: <20170709144646.10352-1-chipitsine@...277...>
	<CAFHpkQEPAzvnkRAZLPgLwt8i8LjJrVcKwTp6H32v7Dxz4Jb0Lg@...278...>
	<CAKuzo_joBeJomLCzBMYB4qWnjV-AKCPB_auQ2zcWYdH1D50eHA@...278...>
	<CAFHpkQExC-X_e5_0Xd8w4BM=iYaW98ob7Fcnnx_3=tQG3i9MBw@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 12 Jul 2017 11:06:43 -0400
Message-ID: <CAKuzo_gh=Hm82BdzXohiLr1CaZ_KpeKqpKDP0j6pCj_cHs6s9Q@...278...>
Content-Type: multipart/alternative; boundary="001a113d53bc35f5e00554202beb"
Subject: Re: [Openvpn-devel] [PATCH] win32 build: check for ENETUNREACH
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113d53bc35f5e00554202beb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2017 at 10:45 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:

> 2017-07-12 18:54 GMT+05:00 Selva Nair <selva.nair@...277...>:
>
>>
>> On Wed, Jul 12, 2017 at 4:46 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=
=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...>
>> wrote:
>>
>>> No interest ?
>>>
>>> 9 =D0=B8=D1=8E=D0=BB. 2017 =D0=B3. 19:46 =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=
=D0=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C "Ilya Shipitsin" <chipitsine@...493...=
277...>
>>> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:
>>>
>>>> Currently, we do not check for mingw-gcc version. For example,
>>>> Debian 7 is shipped with 4.6.3, which does not know about ENETUNREACH
>>>> ---
>>>>
>>>> this is for 2.4 and HEAD branches
>>>>
>>>>  configure.ac | 14 ++++++++++++++
>>>>  1 file changed, 14 insertions(+)
>>>>
>>>> diff --git a/configure.ac b/configure.ac
>>>> index 60bb465..80b26ff 100644
>>>> --- a/configure.ac
>>>> +++ b/configure.ac
>>>> @@ -708,6 +708,20 @@ m4_define(
>>>>         [setsockopt getsockopt getsockname poll]dnl
>>>>  )
>>>>  if test "${WIN32}" =3D "yes"; then
>>>> +
>>>> +#
>>>> +# check for ENETUNREACH
>>>> +# at least Debian 7 is shipped with gcc-mingw-w64-4.6.3, which is too
>>>> old
>>>
>>>
>> Instead of checking for a particular define why not require a minimal
>> version of gcc ? I do not know what version that would be, though..
>>
>
>
> if you would try to build using ubuntu-14.04, build would fail (I'll
> submit configure patch for that soon as well).
> however, if modified compiler would used https://community.openvpn.net/
> openvpn/wiki/PatchingDebs ... the build will succeed
>

There is no reliable way to support arbitrarily patched build environments.
If I patch mingw in ubuntu 14-04 to have ENETUNREACH defined, the above
check would pass but build may still fail somewhere else.

I still think we should just determine what official version of mingw-gcc
is required and add a test for it.

Selva

--001a113d53bc35f5e00554202beb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Jul 12, 2017 at 10:45 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <span dir=3D"ltr">&lt;<a href=3D"mailto:chipits=
ine@...277..." target=3D"_blank"><span class=3D"" id=3D":bfh.1" tabindex=3D=
"-1">chipitsine</span>@gmail.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><span class=3D"">2017-07-12 18:54 GMT+05:00 Selva Nair <span =
dir=3D"ltr">&lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank">s=
elva.nair@...277...</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_extra"><span class=3D"m_=
8690419433193343298gmail-"><br><div class=3D"gmail_quote">On Wed, Jul 12, 2=
017 at 4:46 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=
=B8=D0=BD <span dir=3D"ltr">&lt;<a href=3D"mailto:chipitsine@...277..." tar=
get=3D"_blank">chipitsine@...277...</a>&gt;</span> wrote:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex"><div dir=3D"auto">No interest ?</div><d=
iv class=3D"gmail_extra"><br><div class=3D"gmail_quote">9 =D0=B8=D1=8E=D0=
=BB. 2017 =D0=B3. <span class=3D"m_8690419433193343298gmail-m_4769596201945=
500580aBn"><span class=3D"m_8690419433193343298gmail-m_4769596201945500580a=
QJ"><span class=3D"aBn" tabindex=3D"0"><span class=3D"aQJ">19:46</span></sp=
an></span></span> =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D0=
=B5=D0=BB=D1=8C &quot;Ilya Shipitsin&quot; &lt;<a href=3D"mailto:chipitsine=
@...277..." target=3D"_blank">chipitsine@...277...</a>&gt; =D0=BD=D0=B0=D0=
=BF=D0=B8=D1=81=D0=B0=D0=BB:<br type=3D"attribution"><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">Currently, we do not check for mingw-gcc versio=
n. For example,<br>
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
/div></blockquote></div><br>There is no reliable way to support arbitrarily=
 patched build environments. If I patch <span class=3D"" id=3D":bfh.3" tabi=
ndex=3D"-1">mingw</span> in <span class=3D"" id=3D":bfh.4" tabindex=3D"-1">=
ubuntu</span> 14-04 to have <span class=3D"" id=3D":bfh.5" tabindex=3D"-1">=
ENETUNREACH</span> defined, the above check would pass but build may still =
fail somewhere else.</div><div class=3D"gmail_extra"><br></div><div class=
=3D"gmail_extra">I still think we should just determine what official versi=
on of <span class=3D"" id=3D":bfh.7" tabindex=3D"-1">mingw</span>-<span cla=
ss=3D"" id=3D":bfh.8" tabindex=3D"-1">gcc</span> is required and add a test=
 for it.</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extr=
a"><span class=3D"" id=3D":bfh.9" tabindex=3D"-1">Selva</span></div></div>

--001a113d53bc35f5e00554202beb--

