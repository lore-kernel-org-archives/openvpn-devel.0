MIME-Version: 1.0
In-Reply-To: <572716F5.5010909@...515...>
References: <CAFHpkQENgyAaaWCsWOS1vj+9YR=Cc65muXmsYfmcKc8n09BkPQ@...278...>
	<5727056E.1000701@...515...>
	<CAA1Abx+hbUT6ZpdeCrYVEiRdQ+awA7woZyTm7DD=Lv8OyPDQ2Q@...278...>
	<572716F5.5010909@...515...>
Date: Mon, 2 May 2016 14:38:40 +0500
Message-ID: <CAFHpkQFxYTwQhaSENzVQwuQCZLHvGWemh0Hdxtb9MmvQBeCEAA@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Content-Type: multipart/alternative; boundary=14dae93a11ebfdb8680531d8c15e
Subject: Re: [Openvpn-devel] CI for openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--14dae93a11ebfdb8680531d8c15e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

it is already running at "coverity_scan" branch:
https://travis-ci.org/OpenVPN/openvpn/builds/120718429

so, it definitely good

however, I would add (to make build running on ubuntu trusty)

sudo: required
dist: trusty

2016-05-02 13:59 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:

>
> On Mon, May 2, 2016 at 9:44 AM, Samuli Sepp=C3=A4nen <samuli@...515...>
>> wrote:
>>
>>>
>>> 1) add travis-ci support (there are few tests in "t" and we can run
>>>> cppcheck)
>>>>
>>>
>>> I assume cppcheck produces the same results regardless of the
>>> OS/distribution it is running on. If this is the case, then we should
>>> add cppcheck tests to Travis-CI.
>>>
>>
>> Yes, I think this makes sense.  As a first step, someone could review
>> my patch from December to enable travis-ci on our repo:
>>
>> https://sourceforge.net/p/openvpn/mailman/message/34709650/
>>
>> -Steffan
>>
>
> Ilya (<- is that the correct translitteration?): can you have a look? You
> seem to have a fair bit of knowledge in Travis-CI.
>
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>

--14dae93a11ebfdb8680531d8c15e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>it is already running at &quot;coverity_scan&quo=
t; branch: <a href=3D"https://travis-ci.org/OpenVPN/openvpn/builds/12071842=
9">https://travis-ci.org/OpenVPN/openvpn/builds/120718429</a><br><br></div>=
so, it definitely good<br><br></div>however, I would add (to make build run=
ning on ubuntu trusty)<br><div><div><br><span class=3D"">sudo:</span> <span=
 class=3D"">required</span>
=20=20=20=20=20=20
=20=20=20=20=20=20
=20=20=20=20=20=20=20=20
        <span class=3D""><span class=3D""><br>dist:</span> <span class=3D""=
>trusty</span></span></div></div></div><div class=3D"gmail_extra"><br><div =
class=3D"gmail_quote">2016-05-02 13:59 GMT+05:00 Samuli Sepp=C3=A4nen <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:samuli@...515..." target=3D"_blank">samu=
li@...515...</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=
=3D"HOEnZb"><div class=3D"h5"><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On Mon, May 2, 2016 at 9:44 AM, Samuli Sepp=C3=A4nen &lt;<a href=3D"mailto:=
samuli@...515..." target=3D"_blank">samuli@...515...</a>&gt; wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
1) add travis-ci support (there are few tests in &quot;t&quot; and we can r=
un<br>
cppcheck)<br>
</blockquote>
<br>
I assume cppcheck produces the same results regardless of the<br>
OS/distribution it is running on. If this is the case, then we should<br>
add cppcheck tests to Travis-CI.<br>
</blockquote>
<br>
Yes, I think this makes sense.=C2=A0 As a first step, someone could review<=
br>
my patch from December to enable travis-ci on our repo:<br>
<br>
<a href=3D"https://sourceforge.net/p/openvpn/mailman/message/34709650/" rel=
=3D"noreferrer" target=3D"_blank">https://sourceforge.net/p/openvpn/mailman=
/message/34709650/</a><br>
<br>
-Steffan<br>
</blockquote>
<br></div></div>
Ilya (&lt;- is that the correct translitteration?): can you have a look? Yo=
u seem to have a fair bit of knowledge in Travis-CI.<div class=3D"HOEnZb"><=
div class=3D"h5"><br>
<br>
-- <br>
Samuli Sepp=C3=A4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
</div></div></blockquote></div><br></div>

--14dae93a11ebfdb8680531d8c15e--

