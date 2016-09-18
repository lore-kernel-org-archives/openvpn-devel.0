MIME-Version: 1.0
In-Reply-To: <2ea62e71-fe65-714b-2a2e-27bfa8f480eb@...2080...>
References: <1474208364-11251-1-git-send-email-chipitsine@...277...>
	<2ea62e71-fe65-714b-2a2e-27bfa8f480eb@...2080...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sun, 18 Sep 2016 21:07:02 +0500
Message-ID: <CAFHpkQFFkL_3Zv=F1y=CmPoe_PY14VnnnNS1BrxSpT-5A-KNuA@...278...>
Content-Type: multipart/alternative; boundary=089e0141a202dcdd5f053cca622d
Subject: Re: [Openvpn-devel] [PATCH] cppcheck finding: add "ASSERT(
 maxoutput > 0 || separator != NULL )" to prevent possible null pointer
 derefence
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--089e0141a202dcdd5f053cca622d
Content-Type: text/plain; charset=UTF-8

Hello,

this defect was found by cppcheck, however cppcheck still complains.
so, we did not make it happy yet.

I think, the best would be split this function into 2 separate functions
(with either null argument) or leave it like that.

2016-09-18 20:14 GMT+05:00 David Sommerseth <
openvpn@...2080...>:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> On 18/09/16 17:19, Ilya Shipitsin wrote:
> > --- src/openvpn/buffer.c | 6 ++++-- 1 file changed, 4
> > insertions(+), 2 deletions(-)
> >
> > diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c index
> > 52c6ab9..57bded9 100644 --- a/src/openvpn/buffer.c +++
> > b/src/openvpn/buffer.c @@ -438,10 +438,12 @@ format_hex_ex (const
> > uint8_t *data, int size, int maxoutput, unsigned int
> > space_break_flags, const char* separator, struct gc_arena *gc) { -
> > struct buffer out = alloc_buf_gc (maxoutput ? maxoutput : +  int i;
> > +  struct buffer out; +  ASSERT( maxoutput > 0 || separator != NULL
> > ); +  out = alloc_buf_gc (maxoutput ? maxoutput : ((size * 2) +
> > (size / (space_break_flags & FHE_SPACE_BREAK_MASK)) * (int) strlen
> > (separator) + 2), gc); -  int i; for (i = 0; i < size; ++i) { if
> > (separator && i && !(i % (space_break_flags &
> > FHE_SPACE_BREAK_MASK)))
> >
>
> This looks dangerous and somewhat wrong.  This can actually stop a
> server completely if the ASSERT() check fails.  I'm not sure we want
> to do that.
>
> The ASSERT() also expects maxoutput to be higher than 0, while the
> alloc_buf_gc() supports/allows maxoutput to be 0, which again confirms
> my bad feeling about this.  If maxoutput == 0, alloc_buf_gc() will
> actually allocate a reasonable buffer regardless.
>
> I do see that there might be an issue if separator == NULL
> (strlen(NULL) will segfault), so this needs to be checked far more
> carefully and compared against all the callers of format_hex_ex().
>
> The question which pops up in my head is: Is this patch purely
> targeted to silence a code analyser warning?  If so, this is most
> likely not the right fix for the OpenVPN code base.
>
>
> - --
> kind regards,
>
> David Sommerseth
> OpenVPN Technologies, Inc
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.22 (GNU/Linux)
>
> iQIcBAEBAgAGBQJX3q9BAAoJEIbPlEyWcf3yGkwQAKKZbI2idz6a7h5ZkbQJCHMk
> JDNIpdR6XTFmG16jBrycYeew+9IRvfwpF4vh2/QPaRjDNLnKvPHP+9uEetqYmUQi
> rWzJyg3nzXSEUhFRSbdJcOK7zEWoiUUsSTiBKIYP6D5qD+QBQOZaQseCCzafrt5b
> IKrUesWMWPXAjQBYbUvcc801+JR5S/gSaSbk9TuO8Nemiry/GW/pSt0OVTggPdcm
> LiUyutQ8HXeXS9uAL32FLqFH3qq7QTHjxdVoKGGx9w/lmznqp+EaKCuANsWnt/PW
> ZTzVYM5YG5jI8XNM/wyCklu5n3yqJ37Noxd3ZRSD6ATTL/MExVgWINOOGA7f+Pj3
> P6g4ZSc//zaWUCRpUKg4O8h6jaO+0stDS5eKDpyUCHYRHRdMI4IGLuwzIzKmxWq9
> LpNGGY3Ikpf5IM+i2R04HctnNp+izEeW3vBCKnBBUHSyegRQGQ191Z5QC3SPk6VP
> HwxkHCZiOsie8WsP0Sl2dur1GjV9uyslVTkmt1GBVuoOGxpmZLJRJRayO70goZ17
> ToavpadDjt193g79j1/dpE7OCPcCitso/+egxVzDWPTtLj+7rS/gfdJBNdCHr7xK
> Pf8KKbpD7yEbEln0K7wzsjVG749qZe103KmrhZulvu3H5+SrbT5ALhroaYidhRpg
> lLcx4g4A+nZjM6kabBGy
> =QvxV
> -----END PGP SIGNATURE-----
>

--089e0141a202dcdd5f053cca622d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Hello,<br><br></div>this defect was fo=
und by cppcheck, however cppcheck still complains.<br></div>so, we did not =
make it happy yet.<br><br></div>I think, the best would be split this funct=
ion into 2 separate functions (with either null argument) or leave it like =
that.<br></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2016-09-18 20:14 GMT+05:00 David Sommerseth <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2080...</a>&g=
t;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">-----BEGIN PGP SIGNED MESSAGE-=
----<br>
Hash: SHA1<br>
<br>
On 18/09/16 17:19, Ilya Shipitsin wrote:<br>
&gt; --- src/openvpn/buffer.c | 6 ++++-- 1 file changed, 4<br>
&gt; insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c index<br>
&gt; 52c6ab9..57bded9 100644 --- a/src/openvpn/buffer.c +++<br>
&gt; b/src/openvpn/buffer.c @@ -438,10 +438,12 @@ format_hex_ex (const<br>
&gt; uint8_t *data, int size, int maxoutput, unsigned int<br>
&gt; space_break_flags, const char* separator, struct gc_arena *gc) { -<br>
&gt; struct buffer out =3D alloc_buf_gc (maxoutput ? maxoutput : +=C2=A0 in=
t i;<br>
&gt; +=C2=A0 struct buffer out; +=C2=A0 ASSERT( maxoutput &gt; 0 || separat=
or !=3D NULL<br>
&gt; ); +=C2=A0 out =3D alloc_buf_gc (maxoutput ? maxoutput : ((size * 2) +=
<br>
&gt; (size / (space_break_flags &amp; FHE_SPACE_BREAK_MASK)) * (int) strlen=
<br>
&gt; (separator) + 2), gc); -=C2=A0 int i; for (i =3D 0; i &lt; size; ++i) =
{ if<br>
&gt; (separator &amp;&amp; i &amp;&amp; !(i % (space_break_flags &amp;<br>
&gt; FHE_SPACE_BREAK_MASK)))<br>
&gt;<br>
<br>
This looks dangerous and somewhat wrong.=C2=A0 This can actually stop a<br>
server completely if the ASSERT() check fails.=C2=A0 I&#39;m not sure we wa=
nt<br>
to do that.<br>
<br>
The ASSERT() also expects maxoutput to be higher than 0, while the<br>
alloc_buf_gc() supports/allows maxoutput to be 0, which again confirms<br>
my bad feeling about this.=C2=A0 If maxoutput =3D=3D 0, alloc_buf_gc() will=
<br>
actually allocate a reasonable buffer regardless.<br>
<br>
I do see that there might be an issue if separator =3D=3D NULL<br>
(strlen(NULL) will segfault), so this needs to be checked far more<br>
carefully and compared against all the callers of format_hex_ex().<br>
<br>
The question which pops up in my head is: Is this patch purely<br>
targeted to silence a code analyser warning?=C2=A0 If so, this is most<br>
likely not the right fix for the OpenVPN code base.<br>
<br>
<br>
- --<br>
kind regards,<br>
<br>
David Sommerseth<br>
OpenVPN Technologies, Inc<br>
<br>
-----BEGIN PGP SIGNATURE-----<br>
Version: GnuPG v2.0.22 (GNU/Linux)<br>
<br>
iQIcBAEBAgAGBQJX3q9BAAoJEIbPlE<wbr>yWcf3yGkwQAKKZbI2idz6a7h5ZkbQJ<wbr>CHMk<=
br>
JDNIpdR6XTFmG16jBrycYeew+<wbr>9IRvfwpF4vh2/QPaRjDNLnKvPHP+<wbr>9uEetqYmUQi<=
br>
rWzJyg3nzXSEUhFRSbdJcOK7zEWoiU<wbr>UsSTiBKIYP6D5qD+<wbr>QBQOZaQseCCzafrt5b<=
br>
IKrUesWMWPXAjQBYbUvcc801+JR5S/<wbr>gSaSbk9TuO8Nemiry/GW/<wbr>pSt0OVTggPdcm<=
br>
LiUyutQ8HXeXS9uAL32FLqFH3qq7QT<wbr>HjxdVoKGGx9w/lmznqp+<wbr>EaKCuANsWnt/PW<=
br>
ZTzVYM5YG5jI8XNM/<wbr>wyCklu5n3yqJ37Noxd3ZRSD6ATTL/<wbr>MExVgWINOOGA7f+Pj3<=
br>
P6g4ZSc//zaWUCRpUKg4O8h6jaO+<wbr>0stDS5eKDpyUCHYRHRdMI4IGLuwzIz<wbr>KmxWq9<=
br>
LpNGGY3Ikpf5IM+i2R04HctnNp+<wbr>izEeW3vBCKnBBUHSyegRQGQ191Z5QC<wbr>3SPk6VP<=
br>
HwxkHCZiOsie8WsP0Sl2dur1GjV9uy<wbr>slVTkmt1GBVuoOGxpmZLJRJRayO70g<wbr>oZ17<=
br>
ToavpadDjt193g79j1/<wbr>dpE7OCPcCitso/+egxVzDWPTtLj+<wbr>7rS/gfdJBNdCHr7xK<=
br>
Pf8KKbpD7yEbEln0K7wzsjVG749qZe<wbr>103KmrhZulvu3H5+<wbr>SrbT5ALhroaYidhRpg<=
br>
lLcx4g4A+nZjM6kabBGy<br>
=3DQvxV<br>
-----END PGP SIGNATURE-----<br>
</blockquote></div><br></div>

--089e0141a202dcdd5f053cca622d--

