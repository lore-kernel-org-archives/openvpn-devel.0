MIME-Version: 1.0
References: <20200201135026.18074-1-chipitsine@...277...>
 <CAGyAFMX4hOKL1up6q9N6MLCzQYwVpVgnhd8CcgL7RucLPbWwgw@...278...>
 <CAFHpkQFszr8+iAmVy8P1D7b9WHuKATRnBtzU-x0vrrXdLAgNAA@...278...>
 <CAFHpkQEObnPX7duk8n2wmmCW9F_fj1RrPxKQX1HYarkLsedfNw@...278...>
In-Reply-To: <CAFHpkQEObnPX7duk8n2wmmCW9F_fj1RrPxKQX1HYarkLsedfNw@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 3 Feb 2020 13:04:49 +0500
Message-ID: <CAFHpkQHd87Cjg2TbCSCygN4aonGNSas_02LjyC0+WjWYBkb_VQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000003ff101059da76190"
Subject: Re: [Openvpn-devel] [PATCH v2] travis-ci: add arm64, s390x builds.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000003ff101059da76190
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

also, ARM64 builds are flaky. maybe we should add them as allow_failures.

=D0=BF=D0=BD, 3 =D1=84=D0=B5=D0=B2=D1=80. 2020 =D0=B3. =D0=B2 12:49, =D0=98=
=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...220...=
..277...>:

> https://travis-ci.org/chipitsine/openvpn/jobs/645173717#L62
>
> I expected it to be 30 minutes wait.
>
> =D0=BF=D0=BD, 3 =D1=84=D0=B5=D0=B2=D1=80. 2020 =D0=B3. =D0=B2 12:48, =D0=
=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsin=
e@...277...>:
>
>>
>>
>> =D0=BF=D0=BD, 3 =D1=84=D0=B5=D0=B2=D1=80. 2020 =D0=B3. =D0=B2 12:40, Lev=
 Stipakov <lstipakov@...277...>:
>>
>>> Hi,
>>>
>>> Could you provide a link to a travis build with your changes?
>>>
>>
>>
>> https://travis-ci.org/chipitsine/openvpn/builds/645173716
>>
>>
>> there's at least issue regarding "travis_wait 30", as I can see, windows
>> builds waits for 10 minutes.
>>
>> I'll fix it in "v3" (after all reviews)
>>
>>>
>>> --
>>> -Lev
>>>
>>

--0000000000003ff101059da76190
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">also, ARM64 builds are flaky. maybe we should add them as =
allow_failures.<br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cl=
ass=3D"gmail_attr">=D0=BF=D0=BD, 3 =D1=84=D0=B5=D0=B2=D1=80. 2020 =D0=B3. =
=D0=B2 12:49, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=
=D0=BD &lt;<a href=3D"mailto:chipitsine@...277...">chipitsine@...277...</a>=
&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=
=3D"ltr"><div><a href=3D"https://travis-ci.org/chipitsine/openvpn/jobs/6451=
73717#L62" target=3D"_blank">https://travis-ci.org/chipitsine/openvpn/jobs/=
645173717#L62</a></div><div><br></div><div>I expected it to be 30 minutes w=
ait.<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">=D0=BF=D0=BD, 3 =D1=84=D0=B5=D0=B2=D1=80. 2020 =D0=B3. =D0=
=B2 12:48, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=
=BD &lt;<a href=3D"mailto:chipitsine@...277..." target=3D"_blank">chipitsin=
e@...277...</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr">=D0=BF=D0=BD, 3 =D1=84=D0=B5=D0=
=B2=D1=80. 2020 =D0=B3. =D0=B2 12:40, Lev Stipakov &lt;<a href=3D"mailto:ls=
tipakov@...277..." target=3D"_blank">lstipakov@...277...</a>&gt;:<br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=
=3D"ltr">Hi,<div><br></div><div>Could you provide=C2=A0a link to a travis b=
uild with your changes?</div></div></div></blockquote><div><br></div><div><=
br></div><div><a href=3D"https://travis-ci.org/chipitsine/openvpn/builds/64=
5173716" target=3D"_blank">https://travis-ci.org/chipitsine/openvpn/builds/=
645173716</a></div><div><br></div><div><br></div><div>there&#39;s at least =
issue regarding &quot;travis_wait 30&quot;, as I can see, windows builds wa=
its for 10 minutes.</div><div><br></div><div>I&#39;ll fix it in &quot;v3&qu=
ot; (after all reviews)<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr"><br></div></div>-- <br><div dir=3D"ltr">-Lev</div></div>
</blockquote></div></div>
</blockquote></div>
</blockquote></div>

--0000000000003ff101059da76190--

