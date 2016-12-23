MIME-Version: 1.0
In-Reply-To: <1feee9f2-b989-713e-7c2d-79a54aab285c@...1856...>
References: <949ac6c4-093f-3c03-c597-2ac6855b3477@...1856...>
	<1482085616-17149-1-git-send-email-steffan@...1856...>
	<075c4a8e-e2b6-c4e6-f55e-86a0236d3a21@...2080...>
	<CAA1AbxJADeM7N67CmXdBuZ7t69LN+MOAjToUg5GaiDt9MA_G-g@...278...>
	<0311294b-9902-c813-6649-9597a867fbea@...2080...>
	<1feee9f2-b989-713e-7c2d-79a54aab285c@...1856...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 23 Dec 2016 16:10:21 -0500
Message-ID: <CAKuzo_gsa32Cjv3FQ6WcZEopdbg0QOw6DX-Kc4rx5nzBVqnELQ@...278...>
Content-Type: multipart/alternative; boundary=001a114230968a6f50054459d13f
Subject: Re: [Openvpn-devel] [PATCH v2] reformatting: fix style in
	crypto*.{c, h}
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114230968a6f50054459d13f
Content-Type: text/plain; charset=UTF-8

On Fri, Dec 23, 2016 at 2:39 PM, Steffan Karger <steffan@...1856...> wrote:

> > On 21/12/16 23:03, Steffan Karger wrote:
> >> On 21 December 2016 at 22:09, David Sommerseth
> >> <openvpn@...2080...> wrote:
> >>> On 18/12/16 19:26, Steffan Karger wrote:
> >>>> Now that we have touched each and every file anyway, I decided to go
> over
> >>>> the code I regularly work with and reformat it some more by hand.
> This is
> >>>> how for I got today, and is a large enough patch I think.
> >>>>
> >>>> This commit is mostly just reordering and changing whitespace, with
> one
> >>>> exception: it removes the #if 0 around some debugging code in
> >>>> read_key_file(), and now always print the debugging if D_SHOW_KEYS is
> >>>> enabled.
> >>>>
> >>>> This patch is best reviewed with something like
> >>>> 'git diff --ignore-space-change'.
> >>>>
> >>>> Signed-off-by: Steffan Karger <steffan@...1856...>
> >>>> ---
> >>>> v2: fix wrong indent, add more 'for () {' -> 'for ()\n{' fixes.
> >>>>
> >>>>  src/openvpn/crypto.c         | 425 ++++++++++++++++++++++--------
> -------------
> >>>>  src/openvpn/crypto.h         |  27 ++-
> >>>>  src/openvpn/crypto_mbedtls.c |  63 ++++---
> >>>>  src/openvpn/crypto_openssl.c |  38 ++--
> >>>>  src/openvpn/cryptoapi.c      | 101 ++++++----
> >>>>  5 files changed, 356 insertions(+), 298 deletions(-)
> >>>>
> >>> [...snip...]
> >>>
> >>> Hmmm ... I like that we're trying to clean up the formatting further.
> >>> But I'm not too happy that uncrustify seems to disagree slightly ...
> >>> See the attached patch what happened after applying your patch and then
> >>> running:
> >>>
> >>>    $ uncrustify --no-backup -l C $files
> >>>
> >>> We should either see if our uncrustify config is correct or need slight
> >>> adjustments (without needing to re-run it on the complete tree once
> again)
> >>
> >> This seems to be due to 2 things:
> >>
> >> 1) I adhered to the CodeStyle page 'When lines exceed this length,
> >> wrap them using a double indent (ie 8 spaces)', while the crustify
> >> config uses a single indent.  Since this double indent was somewhat
> >> arbitrary, I think we should just change the CodeStyle page to single
> >> indent.
> >
> > And this goes against what was agreed upon in the Munich 2014 hackathon:
> >
> >   o line length?
> >      - breaking a line in the middle: align to opening (round) brackets
> >        in line above
> >
> >   <http://community.openvpn.net/openvpn/wiki/MunichHackathon2014>
>
> That's about 2), not 1), but I get the point.  As before, I'll just have
> to accept the "we decided on this before argument", and deal with it.
> (I'm not sure how to keep the code readable with this requirement, but I
> guess we'll find out.)


Do we have to be so strict about the coding style which itself is so
ill-defined?
I'll happily adhere to any style if that becomes a requirement for patches,
but
overly depending on an external tool to ensure a style that's not even
precisely
defined by the CodeStyle page (except by the uncrustify config) sounds lame
to me.

Aiming towards a uniform coding style is a good goal. Requiring that
patches should be invariant under "uncrustify -c some-config" is not, imho.

Selva

--001a114230968a6f50054459d13f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Dec 23, 2016 at 2:39 PM, Steffan Karger <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span>&gt; On 21/12/16 2=
3:03, Steffan Karger wrote:<br>
</span><div><div class=3D"m_-1273066189951961039h5">&gt;&gt; On 21 December=
 2016 at 22:09, David Sommerseth<br>
&gt;&gt; &lt;<a href=3D"mailto:openvpn@...2080..." target=3D"_blank">openvp=
n@...2156...<wbr>.net</a>&gt; wrote:<br>
&gt;&gt;&gt; On 18/12/16 19:26, Steffan Karger wrote:<br>
&gt;&gt;&gt;&gt; Now that we have touched each and every file anyway, I dec=
ided to go over<br>
&gt;&gt;&gt;&gt; the code I regularly work with and reformat it some more b=
y hand.=C2=A0 This is<br>
&gt;&gt;&gt;&gt; how for I got today, and is a large enough patch I think.<=
br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; This commit is mostly just reordering and changing whitesp=
ace, with one<br>
&gt;&gt;&gt;&gt; exception: it removes the #if 0 around some debugging code=
 in<br>
&gt;&gt;&gt;&gt; read_key_file(), and now always print the debugging if D_S=
HOW_KEYS is<br>
&gt;&gt;&gt;&gt; enabled.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; This patch is best reviewed with something like<br>
&gt;&gt;&gt;&gt; &#39;git diff --ignore-space-change&#39;.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt; Signed-off-by: Steffan Karger &lt;<a href=3D"mailto:steffa=
n@...1856..." target=3D"_blank">steffan@...1856...</a>&gt;<br>
&gt;&gt;&gt;&gt; ---<br>
&gt;&gt;&gt;&gt; v2: fix wrong indent, add more &#39;for () {&#39; -&gt; &#=
39;for ()\n{&#39; fixes.<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt;&gt;=C2=A0 src/openvpn/crypto.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| 425 ++++++++++++++++++++++--------<wbr>-------------<br>
&gt;&gt;&gt;&gt;=C2=A0 src/openvpn/crypto.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 27 ++-<br>
&gt;&gt;&gt;&gt;=C2=A0 src/openvpn/crypto_mbedtls.c |=C2=A0 63 ++++---<br>
&gt;&gt;&gt;&gt;=C2=A0 src/openvpn/crypto_openssl.c |=C2=A0 38 ++--<br>
&gt;&gt;&gt;&gt;=C2=A0 src/openvpn/cryptoapi.c=C2=A0 =C2=A0 =C2=A0 | 101 ++=
++++----<br>
&gt;&gt;&gt;&gt;=C2=A0 5 files changed, 356 insertions(+), 298 deletions(-)=
<br>
&gt;&gt;&gt;&gt;<br>
&gt;&gt;&gt; [...snip...]<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Hmmm ... I like that we&#39;re trying to clean up the formatti=
ng further.<br>
&gt;&gt;&gt; But I&#39;m not too happy that uncrustify seems to disagree sl=
ightly ...<br>
&gt;&gt;&gt; See the attached patch what happened after applying your patch=
 and then<br>
&gt;&gt;&gt; running:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;=C2=A0 =C2=A0 $ uncrustify --no-backup -l C $files<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; We should either see if our uncrustify config is correct or ne=
ed slight<br>
&gt;&gt;&gt; adjustments (without needing to re-run it on the complete tree=
 once again)<br>
&gt;&gt;<br>
&gt;&gt; This seems to be due to 2 things:<br>
&gt;&gt;<br>
&gt;&gt; 1) I adhered to the CodeStyle page &#39;When lines exceed this len=
gth,<br>
&gt;&gt; wrap them using a double indent (ie 8 spaces)&#39;, while the crus=
tify<br>
&gt;&gt; config uses a single indent.=C2=A0 Since this double indent was so=
mewhat<br>
&gt;&gt; arbitrary, I think we should just change the CodeStyle page to sin=
gle<br>
&gt;&gt; indent.<br>
&gt;<br>
&gt; And this goes against what was agreed upon in the Munich 2014 hackatho=
n:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0o line length?<br>
&gt;=C2=A0 =C2=A0 =C2=A0 - breaking a line in the middle: align to opening =
(round) brackets<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 in line above<br>
&gt;<br>
&gt;=C2=A0 =C2=A0&lt;<a href=3D"http://community.openvpn.net/openvpn/wiki/M=
unichHackathon2014" rel=3D"noreferrer" target=3D"_blank">http://community.o=
penvpn.<wbr>net/openvpn/wiki/MunichHackath<wbr>on2014</a>&gt;<br>
<br>
</div></div>That&#39;s about 2), not 1), but I get the point.=C2=A0 As befo=
re, I&#39;ll just have<br>
to accept the &quot;we decided on this before argument&quot;, and deal with=
 it.<br>
(I&#39;m not sure how to keep the code readable with this requirement, but =
I<br>
guess we&#39;ll find out.)</blockquote></div><br>Do we have to be so strict=
 about the coding style which itself is so ill-defined?</div><div class=3D"=
gmail_extra">I&#39;ll happily adhere to any style if that becomes a require=
ment for patches, but</div><div class=3D"gmail_extra">overly depending on a=
n external tool to ensure a style that&#39;s not even precisely</div><div c=
lass=3D"gmail_extra">defined by the CodeStyle page (except by the uncrustif=
y config) sounds lame</div><div class=3D"gmail_extra">to me.</div><div clas=
s=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Aiming towards a uni=
form coding style is a good goal. Requiring that</div><div class=3D"gmail_e=
xtra">patches should be invariant under &quot;uncrustify -c some-config&quo=
t; is not, imho.</div><div class=3D"gmail_extra"><br></div><div class=3D"gm=
ail_extra">Selva</div><div class=3D"gmail_extra"><br></div></div>

--001a114230968a6f50054459d13f--

