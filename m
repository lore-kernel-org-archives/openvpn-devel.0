MIME-Version: 1.0
In-Reply-To: <20161219154649.GG78624@...1296...>
References: <CAFHpkQFZD+hYzq_FW075wQt5AopcyCP20BEDzLsTx5Vq6uko3Q@...278...>
	<d48609b7-43df-80d5-a57f-e96e85ad4389@...2080...>
	<CAFHpkQHxVWvHSFK2hS7CV8ytUnxUHi5ZfjSOiuLBfWdufzMrCQ@...278...>
	<9048486e-03d9-7aa1-74f8-892a9cc7c1ee@...515...>
	<CAFHpkQHtPm2gPfHYEngJoMymUxt8iOFA7L0z+p54oVSNEmEPFQ@...278...>
	<4ea0b775-5681-b908-f06d-9251d28e8c8a@...515...>
	<c41ad01c-d1a2-cf2c-4876-c22954ae90a9@...2080...>
	<e93e0d67-963a-d677-7d67-323b46e6c3c7@...515...>
	<CAFHpkQFo-W_4_1_6vmBaDfLk8nTHE_=uCi7ZcGES+1iq0sTKxA@...278...>
	<ad02b1ab-1552-7108-e951-65daa05a6680@...2080...>
	<20161219154649.GG78624@...1296...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 23 Dec 2016 13:18:03 +0500
Message-ID: <CAFHpkQH7p3C+eMvFjmKHA_w5SsT6kgZzzuxYYbuBuV_GVuwZSA@...278...>
Content-Type: multipart/alternative; boundary=001a11417a9a64e85b05444f06a0
Subject: Re: [Openvpn-devel] https://travis-ci.org/OpenVPN/openvpn/builds
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

--001a11417a9a64e85b05444f06a0
Content-Type: text/plain; charset=UTF-8

any progress on the subject ?
any hope to get green builds again ?

2016-12-19 20:46 GMT+05:00 Gert Doering <gert@...1296...>:

> Hi,
>
> On Mon, Dec 19, 2016 at 04:31:26PM +0100, David Sommerseth wrote:
> > > I've no idea how to detect osx, but it is rather easy on travis-ci
> >
> > I'm strongly leaning towards a NAK on this approach, unless there exist
> > absolutely no other way.  I don't want to see configure.ac carrying
> > Travis references for no good reason.
>
> For a change, I agree with David :-)
>
> Given that configure.ac does a good job in OS autodetection already
>
>         *-*-darwin*)
>                 AC_DEFINE([TARGET_DARWIN], [1], [Are we running on Mac OS
> X?])
>                 AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["M"], [Target
> prefix])
>                 have_tap_header="yes"
>                 dnl some Mac OS X tendering (we use vararg macros...)
>                 CPPFLAGS="$CPPFLAGS -no-cpp-precomp"
>                 ac_cv_type_struct_in_pktinfo=no
>                 ;;
>
> ... it should not be too hard to add a check for "TARGET_DARWIN" to
> the CMOCKA_INITIALIZED section.
>
> Or add a "disable_cmocka=yes" to the *-*-darwin* section and test for
> that later on (makes it easier to add other platforms that are not
> using GNU ld).
>
> *Or* just check for GNU ld, and disable cmocka testing if that's not
> available - we already have a check in there that talks about
> "checking for ld used by $CC", which seems to result in
>
>   "with_gnu_ld=yes"
>
> if, well, GNU ld is used.  So the cmocka init part could just add a
> check
>
>    if [ yes != "$with_gnu_ld" ] ...
>
> and set CMOCKA_INITIALIZED to "false".  Done.
>
>
> (I'm not very good in actual coding using the right macros, so I'm not
> even suggesting a patch - but I'm happy to help concept-wise and run
> tests)
>
> gert
>
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //
> www.muc.de/~gert/
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025                        gert@...1816...
> muenchen.de
>

--001a11417a9a64e85b05444f06a0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>any progress on the subject ?<br></div>any hope to ge=
t green builds again ?<br></div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">2016-12-19 20:46 GMT+05:00 Gert Doering <span dir=3D"ltr">=
&lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a=
>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On Mon, Dec 19, 2016 at 04:31:26PM +0100, David Sommerseth wrote:<br>
&gt; &gt; I&#39;ve no idea how to detect osx, but it is rather easy on trav=
is-ci<br>
&gt;<br>
&gt; I&#39;m strongly leaning towards a NAK on this approach, unless there =
exist<br>
&gt; absolutely no other way.=C2=A0 I don&#39;t want to see <a href=3D"http=
://configure.ac" rel=3D"noreferrer" target=3D"_blank">configure.ac</a> carr=
ying<br>
&gt; Travis references for no good reason.<br>
<br>
</span>For a change, I agree with David :-)<br>
<br>
Given that <a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_bl=
ank">configure.ac</a> does a good job in OS autodetection already<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 *-*-darwin*)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AC_DEFINE([TARGET_D=
ARWIN], [1], [Are we running on Mac OS X?])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 AC_DEFINE_UNQUOTED(=
[TARGET_<wbr>PREFIX], [&quot;M&quot;], [Target prefix])<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 have_tap_header=3D&=
quot;yes&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dnl some Mac OS X t=
endering (we use vararg macros...)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 CPPFLAGS=3D&quot;$C=
PPFLAGS -no-cpp-precomp&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ac_cv_type_struct_i=
n_pktinfo=3D<wbr>no<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ;;<br>
<br>
... it should not be too hard to add a check for &quot;TARGET_DARWIN&quot; =
to<br>
the CMOCKA_INITIALIZED section.<br>
<br>
Or add a &quot;disable_cmocka=3Dyes&quot; to the *-*-darwin* section and te=
st for<br>
that later on (makes it easier to add other platforms that are not<br>
using GNU ld).<br>
<br>
*Or* just check for GNU ld, and disable cmocka testing if that&#39;s not<br>
available - we already have a check in there that talks about<br>
&quot;checking for ld used by $CC&quot;, which seems to result in<br>
<br>
=C2=A0 &quot;with_gnu_ld=3Dyes&quot;<br>
<br>
if, well, GNU ld is used.=C2=A0 So the cmocka init part could just add a<br>
check<br>
<br>
=C2=A0 =C2=A0if [ yes !=3D &quot;$with_gnu_ld&quot; ] ...<br>
<br>
and set CMOCKA_INITIALIZED to &quot;false&quot;.=C2=A0 Done.<br>
<br>
<br>
(I&#39;m not very good in actual coding using the right macros, so I&#39;m =
not<br>
even suggesting a patch - but I&#39;m happy to help concept-wise and run<br>
tests)<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
gert<br>
<br>
--<br>
USENET is *not* the non-clickable part of WWW!<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//<a href=3D"=
http://www.muc.de/~gert/" rel=3D"noreferrer" target=3D"_blank">www.muc.de/~=
gert/</a><br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296...">gert@...1296...</a><br>
fax: +49-89-35655025=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:gert@...1297...">gert@...2165...=
6...<wbr>muenchen.de</a><br>
</div></div></blockquote></div><br></div>

--001a11417a9a64e85b05444f06a0--

