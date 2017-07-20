MIME-Version: 1.0
In-Reply-To: <CAKuzo_gDSfORaizb4rjzYJVFhMEkQAGPJkU3OAmxg4U-F4Zrkg@...278...>
References: <20170709144646.10352-1-chipitsine@...277...>
	<CAFHpkQEPAzvnkRAZLPgLwt8i8LjJrVcKwTp6H32v7Dxz4Jb0Lg@...278...>
	<CAKuzo_joBeJomLCzBMYB4qWnjV-AKCPB_auQ2zcWYdH1D50eHA@...278...>
	<CAFHpkQExC-X_e5_0Xd8w4BM=iYaW98ob7Fcnnx_3=tQG3i9MBw@...278...>
	<CAKuzo_gh=Hm82BdzXohiLr1CaZ_KpeKqpKDP0j6pCj_cHs6s9Q@...278...>
	<CAFHpkQEFZ92ncqzBGjX7TXDPYRCob7QiU8tgoccudGi5kfkGzw@...278...>
	<CAFHpkQHzTp1Zg6cukMqZRxMqaKrHkqTxj-pUeQ-U=hWG-BQO+Q@...278...>
	<CAKuzo_gDSfORaizb4rjzYJVFhMEkQAGPJkU3OAmxg4U-F4Zrkg@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 20 Jul 2017 20:41:08 +0500
Message-ID: <CAFHpkQHAXg3N4QYX9xQW6=-Brjj7wVLg9VSQ0cViQXSDkv4XEA@...278...>
Content-Type: multipart/alternative; boundary="001a114545fcd6bc000554c1938a"
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
Cc: openvpn-devel@lists.sourceforge.net

--001a114545fcd6bc000554c1938a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

20 =D0=B8=D1=8E=D0=BB. 2017 =D0=B3. 19:50 =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=
=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C "Selva Nair" <selva.nair@...277...>
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:

Hi,

On Thu, Jul 20, 2017 at 4:36 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:

> any news ?
>
> 2017-07-12 20:50 GMT+05:00 =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=
=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...>:
>
>>
>>
>> 2017-07-12 20:06 GMT+05:00 Selva Nair <selva.nair@...277...>:
>>
>>>
>>> On Wed, Jul 12, 2017 at 10:45 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=
=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...>
>>> wrote:
>>>
>>>> 2017-07-12 18:54 GMT+05:00 Selva Nair <selva.nair@...277...>:
>>>>
>>>>>
>>>>> On Wed, Jul 12, 2017 at 4:46 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=
=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...>
>>>>> wrote:
>>>>>
>>>>>> No interest ?
>>>>>>
>>>>>> 9 =D0=B8=D1=8E=D0=BB. 2017 =D0=B3. 19:46 =D0=BF=D0=BE=D0=BB=D1=8C=D0=
=B7=D0=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C "Ilya Shipitsin" <
>>>>>> chipitsine@...277...> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:
>>>>>>
>>>>>>> Currently, we do not check for mingw-gcc version. For example,
>>>>>>> Debian 7 is shipped with 4.6.3, which does not know about ENETUNREA=
CH
>>>>>>> ---
>>>>>>>
>>>>>>> this is for 2.4 and HEAD branches
>>>>>>>
>>>>>>>  configure.ac | 14 ++++++++++++++
>>>>>>>  1 file changed, 14 insertions(+)
>>>>>>>
>>>>>>> diff --git a/configure.ac b/configure.ac
>>>>>>> index 60bb465..80b26ff 100644
>>>>>>> --- a/configure.ac
>>>>>>> +++ b/configure.ac
>>>>>>> @@ -708,6 +708,20 @@ m4_define(
>>>>>>>         [setsockopt getsockopt getsockname poll]dnl
>>>>>>>  )
>>>>>>>  if test "${WIN32}" =3D "yes"; then
>>>>>>> +
>>>>>>> +#
>>>>>>> +# check for ENETUNREACH
>>>>>>> +# at least Debian 7 is shipped with gcc-mingw-w64-4.6.3, which is
>>>>>>> too old
>>>>>>
>>>>>>
>>>>> Instead of checking for a particular define why not require a minimal
>>>>> version of gcc ? I do not know what version that would be, though..
>>>>>
>>>>
>>>>
>>>> if you would try to build using ubuntu-14.04, build would fail (I'll
>>>> submit configure patch for that soon as well).
>>>> however, if modified compiler would used https://community.openvpn.net/
>>>> openvpn/wiki/PatchingDebs ... the build will succeed
>>>>
>>>
>>> There is no reliable way to support arbitrarily patched build
>>> environments. If I patch mingw in ubuntu 14-04 to have ENETUNREACH
>>> defined, the above check would pass but build may still fail somewhere =
else.
>>>
>>
>>
>> ENETUNREACH check is for Debian 7.
>>
>> Ubuntu 14.04 is shipped with broken fwpmu.h:
>> https://github.com/chipitsine/openvpn/commit/03013fd6f5b57a1
>> 22302ce1a534a7061acde9d5b  :)
>>
>>
>>>
>>> I still think we should just determine what official version of mingw-
>>> gcc is required and add a test for it.
>>>
>>> Selva
>>>
>>
>
I still think we should just determine what official version of mingw-gcc
is required and add a test for it. :) If its just one define missing add it
to sources as we already do for some fwpm defines in block_dns.c



I generally agree with you. However, your approach needs some future
investigation.

1) I do not know the minimal required version

2) it might turn out that version itself means almost nothing. For example,
openssl shipped with alnost any linux distro is constantly updated, while
its version remains the same (just patch level is increased). Same with
mingw, ubuntu 14.04 is shipped with broken mingw, while Samuli supports
patched repo, which is ok

So, while I agree your approach sounds resonable, I still suggest to start
with my patch


Selva

--001a114545fcd6bc000554c1938a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">20 =D0=B8=D1=8E=D0=BB. 2017 =D0=B3. 19:50 =D0=BF=D0=BE=D0=BB=D1=
=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C &quot;Selva Nair&quot; =
&lt;<a href=3D"mailto:selva.nair@...277...">selva.nair@...277...</a>&gt; =
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:<br type=3D"attribution"><blockq=
uote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex"><div dir=3D"ltr"><div>Hi,</div><div><br></div><div class=
=3D"gmail_extra"><div class=3D"gmail_quote"><div class=3D"elided-text">On T=
hu, Jul 20, 2017 at 4:36 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=
=B8=D1=86=D0=B8=D0=BD <span dir=3D"ltr">&lt;<a href=3D"mailto:chipitsine@...1186...=
.277..." target=3D"_blank">chipitsine@...277...</a>&gt;</span> wrote:<br><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">any news ?=
<br></div><div class=3D"m_8439928515446752261m_2079926727299857902gmail-m_2=
591072804001150756HOEnZb"><div class=3D"m_8439928515446752261m_207992672729=
9857902gmail-m_2591072804001150756h5"><div class=3D"gmail_extra"><br><div c=
lass=3D"gmail_quote">2017-07-12 20:50 GMT+05:00 =D0=98=D0=BB=D1=8C=D1=8F =
=D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <span dir=3D"ltr">&lt;<a href=3D=
"mailto:chipitsine@...277..." target=3D"_blank">chipitsine@...277...</a>&gt=
;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"=
ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quote"><div><di=
v class=3D"m_8439928515446752261m_2079926727299857902gmail-m_25910728040011=
50756m_-629656752960720536h5">2017-07-12 20:06 GMT+05:00 Selva Nair <span d=
ir=3D"ltr">&lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank">se=
lva.nair@...277...</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_extra"><div><div class=3D=
"m_8439928515446752261m_2079926727299857902gmail-m_2591072804001150756m_-62=
9656752960720536m_2072090559873341923gmail-h5"><br><div class=3D"gmail_quot=
e">On Wed, Jul 12, 2017 at 10:45 AM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=
=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <span dir=3D"ltr">&lt;<a href=3D"mailto:chip=
itsine@...277..." target=3D"_blank"><span id=3D"m_8439928515446752261m_2079=
926727299857902gmail-m_2591072804001150756m_-629656752960720536m_2072090559=
873341923gmail-m_-601479893549234029:bfh.1">chipitsine</span>@gmail.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><sp=
an>2017-07-12 18:54 GMT+05:00 Selva Nair <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;<=
/span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"lt=
r"><div class=3D"gmail_extra"><span class=3D"m_8439928515446752261m_2079926=
727299857902gmail-m_2591072804001150756m_-629656752960720536m_2072090559873=
341923gmail-m_-601479893549234029m_8690419433193343298gmail-"><br><div clas=
s=3D"gmail_quote">On Wed, Jul 12, 2017 at 4:46 AM, =D0=98=D0=BB=D1=8C=D1=8F=
 =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <span dir=3D"ltr">&lt;<a href=
=3D"mailto:chipitsine@...277..." target=3D"_blank">chipitsine@...277...</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><di=
v dir=3D"auto">No interest ?</div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">9 =D0=B8=D1=8E=D0=BB. 2017 =D0=B3. <span class=3D"m_843992=
8515446752261m_2079926727299857902gmail-m_2591072804001150756m_-62965675296=
0720536m_2072090559873341923gmail-m_-601479893549234029m_869041943319334329=
8gmail-m_4769596201945500580aBn"><span class=3D"m_8439928515446752261m_2079=
926727299857902gmail-m_2591072804001150756m_-629656752960720536m_2072090559=
873341923gmail-m_-601479893549234029m_8690419433193343298gmail-m_4769596201=
945500580aQJ"><span class=3D"m_8439928515446752261m_2079926727299857902gmai=
l-m_2591072804001150756m_-629656752960720536m_2072090559873341923gmail-m_-6=
01479893549234029aBn"><span class=3D"m_8439928515446752261m_207992672729985=
7902gmail-m_2591072804001150756m_-629656752960720536m_2072090559873341923gm=
ail-m_-601479893549234029aQJ">19:46</span></span></span></span> =D0=BF=D0=
=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C &quot;Ilya =
Shipitsin&quot; &lt;<a href=3D"mailto:chipitsine@...277..." target=3D"_blan=
k">chipitsine@...277...</a>&gt; =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:=
<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
Currently, we do not check for mingw-gcc version. For example,<br>
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
 arbitrarily patched build environments. If I patch <span id=3D"m_843992851=
5446752261m_2079926727299857902gmail-m_2591072804001150756m_-62965675296072=
0536m_2072090559873341923gmail-m_-601479893549234029:bfh.3">mingw</span> in=
 <span id=3D"m_8439928515446752261m_2079926727299857902gmail-m_259107280400=
1150756m_-629656752960720536m_2072090559873341923gmail-m_-60147989354923402=
9:bfh.4">ubuntu</span> 14-04 to have <span id=3D"m_8439928515446752261m_207=
9926727299857902gmail-m_2591072804001150756m_-629656752960720536m_207209055=
9873341923gmail-m_-601479893549234029:bfh.5">ENETUNREACH</span> defined, th=
e above check would pass but build may still fail somewhere else.</div></di=
v></blockquote></div></div><div><br><br><span><span class=3D"m_843992851544=
6752261m_2079926727299857902gmail-m_2591072804001150756m_-62965675296072053=
6m_2072090559873341923gmail-m_-601479893549234029m_8690419433193343298gmail=
-">ENETUNREACH check is for Debian 7.<br><br></span></span></div><div><span=
><span class=3D"m_8439928515446752261m_2079926727299857902gmail-m_259107280=
4001150756m_-629656752960720536m_2072090559873341923gmail-m_-60147989354923=
4029m_8690419433193343298gmail-">Ubuntu 14.04 is shipped with broken fwpmu.=
h:=C2=A0 <a href=3D"https://github.com/chipitsine/openvpn/commit/03013fd6f5=
b57a122302ce1a534a7061acde9d5b" target=3D"_blank">https://github.com/chipit=
sine/<wbr>openvpn/commit/03013fd6f5b57a1<wbr>22302ce1a534a7061acde9d5b</a>=
=C2=A0 :)<br></span></span></div><span><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_extra=
"><br></div><div class=3D"gmail_extra">I still think we should just determi=
ne what official version of <span id=3D"m_8439928515446752261m_207992672729=
9857902gmail-m_2591072804001150756m_-629656752960720536m_207209055987334192=
3gmail-m_-601479893549234029:bfh.7">mingw</span>-<span id=3D"m_843992851544=
6752261m_2079926727299857902gmail-m_2591072804001150756m_-62965675296072053=
6m_2072090559873341923gmail-m_-601479893549234029:bfh.8">gcc</span> is requ=
ired and add a test for it.</div><span class=3D"m_8439928515446752261m_2079=
926727299857902gmail-m_2591072804001150756m_-629656752960720536m_2072090559=
873341923gmail-HOEnZb"><font color=3D"#888888"><div class=3D"gmail_extra"><=
br></div><div class=3D"gmail_extra"><span id=3D"m_8439928515446752261m_2079=
926727299857902gmail-m_2591072804001150756m_-629656752960720536m_2072090559=
873341923gmail-m_-601479893549234029:bfh.9">Selva</span></div></font></span=
></div>
</blockquote></span></div></div></div></blockquote></div><br></div></div></=
div></blockquote><div><br></div></div><div>I still think we should just det=
ermine what official version of mingw-gcc is required and add a test for it=
. :) If its just one define missing add it to sources as we already do for =
some fwpm defines in block_dns.c</div></div></div></div></blockquote></div>=
</div></div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div di=
r=3D"auto">I generally agree with you. However, your approach needs some fu=
ture investigation.</div><div dir=3D"auto"><br></div><div dir=3D"auto">1) I=
 do not know the minimal required version</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">2) it might turn out that version itself means almost not=
hing. For example, openssl shipped with alnost any linux distro is constant=
ly updated, while its version remains the same (just patch level is increas=
ed). Same with mingw, ubuntu 14.04 is shipped with broken mingw, while Samu=
li supports patched repo, which is ok</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">So, while I agree your approach sounds resonable, I still sug=
gest to start with my patch</div><div dir=3D"auto"><br></div><div dir=3D"au=
to"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=
=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quo=
te"><font color=3D"#888888"><div><br></div><div>Selva=C2=A0</div></font></d=
iv><br></div></div>
</blockquote></div><br></div></div></div>

--001a114545fcd6bc000554c1938a--

