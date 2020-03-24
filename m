MIME-Version: 1.0
References: <20200323171156.295122f1@...1661...>
 <276a2e33-fa92-0b23-1572-27596052ab33@...1227...>
 <20200324143702.21f24651@...1265...>
In-Reply-To: <20200324143702.21f24651@...1265...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 24 Mar 2020 23:15:59 +0500
Message-ID: <CAFHpkQFXEn8VzBnRVseT5+ynzw+RtvE5A10_nR_S39NKuR44ww@...278...>
Content-Type: multipart/alternative; boundary="0000000000001114e005a19dbf6f"
Subject: Re: [Openvpn-devel] Possible memory alignment Problem in 2.4 ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Michael Kress <lists@...1660...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000001114e005a19dbf6f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 24 =D0=BC=D0=B0=D1=80. 2020 =D0=B3. =D0=B2 22:19, Michael Kre=
ss <lists@...1660...>:

> Am Tue, 24 Mar 2020 11:21:56 +0100
> schrieb Arne Schwabe <arne@...1227...>:
>
> > Am 23.03.20 um 17:11 schrieb Michael Kress:
> > > Hello list,
> > >
> > > There seems to be some kind of alignment problem in OpenVPN 2.4
> > > versions on ARMv4 based machines (32 bit), especially when lzo
> > > compression kicks in.
> >
> > LZO is known to miscompile with gcc 10 and requires
> > -fno-strict-aliasing to compile. and also in my OpenVPN for Android
> > app I have to compile lzo with -O1 instead -O2 since it otherwise
> > segfaults on armv7a. Android uses LLVM/clang to compile so the broken
> > behaviour is present also on other compilers. I never investigated
> > which optimisation flag does break in clang/llvm/armv7a.
>
> The alignment errors happen in OpenVPN code, not in LZO code.
> We have to use the (ancient) gcc 4.0.0. After upgrading OpenVPN from
> 2.3 to 2.4 we did not even upgrade LZO from 2.0.6, but linked
> statically to the old compiled lib. I doubt that the compiler itself
> changes anything here.
>
> > But bottom line is that you probably are running in a similar and I
> > would advise to compile lzo with less optimisation.
>
> Thanks for the suggestion!
>
> Anyways I recompiled LZO without any optimazations and then OpenVPN
> 2.4.8. Unfortunatelly this changed nothing.
>
> A few questions:
> ----------------
> 1) Do you run automated tests of the OpenVPN code on any build server?
>
> 2) If that is the case, is there any test with a version, where
>    -DVERIFY_ALIGNMENT is enabled?
>

there are several test suites that you can run using "make check" (it
performs several e2e tests and cmocka testing).
also, there's openvpn vagrant suite intended for running several VMs on
VirtualBox (and build and test openvpn on them)

also, there's buildbot (not exposed to internet, but build logs available
on mailing list)

and there's travis-ci for express tests (actually "make check") for several
build configurations: https://travis-ci.org/github/OpenVPN/openvpn

I think we can add -DVERIFY_ALIGNMENT to some travis-ci builds



>
> 3) If that is also the case, can you see any ERRORS regarding the
>    alignment in the logs?
>
> The problem is, that we do not have any power over the clients. It
> might well be, that there are even OpenVPN 2.2 clients out there.
>
> --
> Servus
>   Michael
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--0000000000001114e005a19dbf6f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">=D0=B2=D1=82, 24 =D0=BC=D0=B0=D1=80. =
2020 =D0=B3. =D0=B2 22:19, Michael Kress &lt;<a href=3D"mailto:lists@...2547...=
0...">lists@...1660...</a>&gt;:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">Am Tue, 24 Mar 2020 11:21:56 +0100<br>
schrieb Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=3D"_blan=
k">arne@...1227...</a>&gt;:<br>
<br>
&gt; Am 23.03.20 um 17:11 schrieb Michael Kress:<br>
&gt; &gt; Hello list,<br>
&gt; &gt; <br>
&gt; &gt; There seems to be some kind of alignment problem in OpenVPN 2.4<b=
r>
&gt; &gt; versions on ARMv4 based machines (32 bit), especially when lzo <b=
r>
&gt; &gt; compression kicks in.<br>
&gt; <br>
&gt; LZO is known to miscompile with gcc 10 and requires<br>
&gt; -fno-strict-aliasing to compile. and also in my OpenVPN for Android<br>
&gt; app I have to compile lzo with -O1 instead -O2 since it otherwise<br>
&gt; segfaults on armv7a. Android uses LLVM/clang to compile so the broken<=
br>
&gt; behaviour is present also on other compilers. I never investigated<br>
&gt; which optimisation flag does break in clang/llvm/armv7a.<br>
<br>
The alignment errors happen in OpenVPN code, not in LZO code. <br>
We have to use the (ancient) gcc 4.0.0. After upgrading OpenVPN from<br>
2.3 to 2.4 we did not even upgrade LZO from 2.0.6, but linked<br>
statically to the old compiled lib. I doubt that the compiler itself<br>
changes anything here.<br>
<br>
&gt; But bottom line is that you probably are running in a similar and I<br>
&gt; would advise to compile lzo with less optimisation.<br>
<br>
Thanks for the suggestion! <br>
<br>
Anyways I recompiled LZO without any optimazations and then OpenVPN<br>
2.4.8. Unfortunatelly this changed nothing.<br>
<br>
A few questions:<br>
----------------<br>
1) Do you run automated tests of the OpenVPN code on any build server? <br>
<br>
2) If that is the case, is there any test with a version, where <br>
=C2=A0 =C2=A0-DVERIFY_ALIGNMENT is enabled?<br></blockquote><div><br></div>=
<div>there are several test suites that you can run using &quot;make check&=
quot; (it performs several e2e tests and cmocka testing).</div><div>also, t=
here&#39;s openvpn vagrant suite intended for running several VMs on Virtua=
lBox (and build and test openvpn on them)</div><div><br></div><div>also, th=
ere&#39;s buildbot (not exposed to internet, but build logs available on ma=
iling list)</div><div><br></div><div>and there&#39;s travis-ci for express =
tests (actually &quot;make check&quot;) for several build configurations: <=
a href=3D"https://travis-ci.org/github/OpenVPN/openvpn">https://travis-ci.o=
rg/github/OpenVPN/openvpn</a></div><div><br></div><div>I think we can add -=
DVERIFY_ALIGNMENT to some travis-ci builds<br></div><div><br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
3) If that is also the case, can you see any ERRORS regarding the<br>
=C2=A0 =C2=A0alignment in the logs?<br>
<br>
The problem is, that we do not have any power over the clients. It<br>
might well be, that there are even OpenVPN 2.2 clients out there.<br>
<br>
-- <br>
Servus<br>
=C2=A0 Michael<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div></div>

--0000000000001114e005a19dbf6f--

