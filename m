MIME-Version: 1.0
In-Reply-To: <93f91c48-94cb-c421-3f06-d7d76eb58511@...2080...>
References: <6b3b8a029cd8761642ac3f8174238aa2.squirrel@...2260...>
	<063244418e0b88138db5b490037cb7a4.squirrel@...2257...>
	<267890da-2186-dddb-d4c4-d6374da7e086@...277...>
	<049b9d27-d6a4-41cf-9742-bed02b2cc39b@...2080...>
	<18a96a72-4778-22b3-8a57-ce87d3f7060b@...2080...>
	<11253b26-cb11-8b7a-02e0-d5b1ad89e199@...277...>
	<2465b076-35e8-6144-f1b8-085ad5a016f0@...277...>
	<e09e9fbc1ce629510c439bbc06569b1a.squirrel@...2260...>
	<f6a87e19-4ac0-4ea2-69f3-2f424cbe8891@...1227...>
	<86ef0241-5144-206a-4691-6713434fdaa4@...277...>
	<20170405204236.GM93896@...1296...>
	<31b0e79c-99b3-0372-8e47-762dbc3990d7@...277...>
	<93f91c48-94cb-c421-3f06-d7d76eb58511@...2080...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 6 Apr 2017 02:43:37 +0500
Message-ID: <CAFHpkQFqq2HEdqeQL+f4W_vQtvuVswOVP9tXcoPPTU4=LMtYUw@...278...>
Content-Type: multipart/alternative; boundary=001a113c3a1afa3ab5054c72481a
Subject: Re: [Openvpn-devel] [PATCH v2] Add per session pseudo-random
 component to --reneg-sec intervals
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113c3a1afa3ab5054c72481a
Content-Type: text/plain; charset=UTF-8

hello!

just curious how renegotiation is handled in "https" ?
is it "an abbrevated ssl handshake" (RFC 2246) or ... ?

2017-04-06 2:39 GMT+05:00 David Sommerseth <
openvpn@...2080...>:

> On 05/04/17 23:13, debbie10t wrote:
> > I don't believe there is any need to specify "max" because that would be
> > --reneg-sec as is. Otherwise specify a smaller or larger --reneg-sec
>
> I think you, probably without being aware of it, are agreeing to what
> the current proposal is:
>
>   --reneg-sec max
>     A renegotiation happens within 'max' seconds, but with a 10%-ish
>     randomness
>
>   --reneg-sec min max
>     A renegotiation happens within 'min' and 'max' seconds, fully
>     controllable
>
> So using --reneg-sec 3600 3600, effectively removes the randomness.
>
>
> --
> kind regards,
>
> David Sommerseth
> OpenVPN Technologies, Inc
>
>
>
> ------------------------------------------------------------
> ------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>

--001a113c3a1afa3ab5054c72481a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>hello!<br><br></div>just curious how renegotiati=
on is handled in &quot;https&quot; ?<br></div>is it &quot;an abbrevated ssl=
 handshake&quot; (RFC 2246) or ... ?<br></div><div class=3D"gmail_extra"><b=
r><div class=3D"gmail_quote">2017-04-06 2:39 GMT+05:00 David Sommerseth <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:openvpn@...2080..." target=3D"_blank">=
openvpn@...2080...</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span =
class=3D"">On 05/04/17 23:13, debbie10t wrote:<br>
&gt; I don&#39;t believe there is any need to specify &quot;max&quot; becau=
se that would be<br>
&gt; --reneg-sec as is. Otherwise specify a smaller or larger --reneg-sec<b=
r>
<br>
</span>I think you, probably without being aware of it, are agreeing to wha=
t<br>
the current proposal is:<br>
<br>
=C2=A0 --reneg-sec max<br>
=C2=A0 =C2=A0 A renegotiation happens within &#39;max&#39; seconds, but wit=
h a 10%-ish<br>
=C2=A0 =C2=A0 randomness<br>
<br>
=C2=A0 --reneg-sec min max<br>
=C2=A0 =C2=A0 A renegotiation happens within &#39;min&#39; and &#39;max&#39=
; seconds, fully<br>
=C2=A0 =C2=A0 controllable<br>
<br>
So using --reneg-sec 3600 3600, effectively removes the randomness.<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
--<br>
kind regards,<br>
<br>
David Sommerseth<br>
OpenVPN Technologies, Inc<br>
<br>
<br>
</div></div><br>------------------------------<wbr>------------------------=
------<wbr>------------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, Slashdot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>_________=
_____________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
<br></blockquote></div><br></div>

--001a113c3a1afa3ab5054c72481a--

