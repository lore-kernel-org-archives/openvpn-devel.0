MIME-Version: 1.0
In-Reply-To: <b67daad4-362b-3605-5716-3e17c5f0c362@...2080...>
References: <20170701112951.19119-1-steffan@...1856...>
 <b67daad4-362b-3605-5716-3e17c5f0c362@...2080...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 15 Aug 2017 13:26:59 +0500
Message-ID: <CAFHpkQFADMG50xb4UD_bAvT4a94EbLVstAuPEmhkxhUEnZoXQg@...278...>
Content-Type: multipart/alternative; boundary="001a113ee18a109cdb0556c68bce"
Subject: Re: [Openvpn-devel] [PATCH] Deprecate --keysize
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113ee18a109cdb0556c68bce
Content-Type: text/plain; charset="UTF-8"

2017-08-14 15:36 GMT+05:00 David Sommerseth <
openvpn@...2080...>:

> On 01/07/17 13:29, Steffan Karger wrote:
> > The --keysize option can only be used with already deprecated ciphers,
> > such as CAST5, RC2 or BF.  Deviating from the default keysize is
> > generally not a good idea (see man page text), and otherwise only
> > complicates our code.>
> > (If this patch is accepted, I'll send a follow-up patch to remove the
> > option from the master branch.)
>
> I agree to the wanted intention of this change.  But, it hits badly if
> we remove --keysize on configurations still enforcing BF-CBC with
> --keysize 256.  I don't have any numbers of how many users uses it; but
> I know many have preferred BF-CBC for a long time - at least before
> SWEET32 came and hit us all.  Bare in mind that BF-CBC was the default
> since 2002-ish (probably even longer, if considering the OpenVPN v1.x
> branch). And many have added --cipher BF-CBC in their configs despite it
> was the default.
>
> As long as BF-CBC is available, we cannot remove --keysize.  And to
> remove BF-CBC support, I think that needs a bit longer timespan than
> v2.5.  Users *must* be far better prepared for that and we need to make
> loud and clear announcements with such a change.
>
> Yes, in all this, I know that NCP is a nice rescue.  As long as everyone
> either runs v2.4 everywhere or deploys --ncp-ciphers and starts the
> migration.  But I've lost confidence that the vast majority of our users
> pays closely attention to such feature changes - thus they won't notice
> until it stops working.  We need to PUSH this information into their
> faces, with large posters carrying promises of rainbow coloured unicorns
> if they comply today(!).  In addition to adding clear warnings in the
> log files for a looong time.
>
> So I propose:
>
> - We add the warning about removing --keysize for both v2.4 and v2.5.
>
> - Add a warning in v2.4 and v2.5 that ciphers with block sizes < 128
>   bits will be *removed* in v2.6
>
> - When removing those ciphers in v2.6, we can remove --keysize together
>   with the ciphers, as it will no longer be valid.  But --keysize needs
>   to be a NOP for some time (with a warning it has no effect), to avoid
>   OpenVPN stopping to run on upgrades.
>
> - Ensure these changes are synchronised within OpenVPN 3 as well
>
> - Start a new wiki page: "How-To: Migrate to secure and modern
>   OpenVPN configurations" where we list all deprecated features/options
>   and their replacement (including examples).  We also need to have a
>   description on the reasoning for deprecating and removing these
>   options.
>

there are special cases like Mikrotik openvpn (pretty popular), where
user simply use what hardware vendor installed (without possibility to
recompile).

should we contact such hardware vendors as well ?


>
> - And the most tricky one: Get some publicity that OpenVPN is going to
>   deprecate and remove support for weak ciphers out to the public.  Not
>   just on crypto focused sites, but more broadly reaching "media
>   channels".   (I believe we can facilitate some of the PR work done by
>   the company, but we do need more than that).  Channels/sites I'm
>   pondering on:
>
>    ~ An official Press Release by the company? (Samuli and I can check)
>    ~ twitter (via the @OpenVPN account)
>    ~ reddit? (and similar sites)
>    ~ LWN.net
>    ~ arstechnica
>    ~ ThreatPost
>    ~ OS Distribution channels (blog posts, mailing lists, etc)
>    ~ Our own wiki and web pages
>    ~ others?
>
>   The first round is to clearly state that BF-CBC, CAST and RC2 are
>   deprecated and their support will be removed in a coming release (not
>   mentioning version, on purpose!).  Users are strongly advised to
>   upgrade to OpenVPN v2.4 or server and client side instantly, to
>   benefit from NCP (byt more less-tech worded) and to point at the
>   "How-To" described above.
>
>   And then we try to re-iterate this once again with the release of
>   v2.5 and v2.6.
>
>
> I know and understand this hurts security focused people, and probably
> in even more those who understand crypto very well.  But my personal
> experience is that the average users are usually less understanding than
> security minded people.  (Yes, I've burnt my, and other's, fingers
> within the Fedora community with the v2.4 upgrade)
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

--001a113ee18a109cdb0556c68bce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-08-14 15:36 GMT+05:00 David Sommerseth <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2080...</a>&g=
t;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">On 01/07/17 13:29, Steffan Kar=
ger wrote:<br>
&gt; The --keysize option can only be used with already deprecated ciphers,=
<br>
&gt; such as CAST5, RC2 or BF.=C2=A0 Deviating from the default keysize is<=
br>
&gt; generally not a good idea (see man page text), and otherwise only<br>
&gt; complicates our code.&gt;<br>
&gt; (If this patch is accepted, I&#39;ll send a follow-up patch to remove =
the<br>
&gt; option from the master branch.)<br>
<br>
I agree to the wanted intention of this change.=C2=A0 But, it hits badly if=
<br>
we remove --keysize on configurations still enforcing BF-CBC with<br>
--keysize 256.=C2=A0 I don&#39;t have any numbers of how many users uses it=
; but<br>
I know many have preferred BF-CBC for a long time - at least before<br>
SWEET32 came and hit us all.=C2=A0 Bare in mind that BF-CBC was the default=
<br>
since 2002-ish (probably even longer, if considering the OpenVPN v1.x<br>
branch). And many have added --cipher BF-CBC in their configs despite it<br>
was the default.<br>
<br>
As long as BF-CBC is available, we cannot remove --keysize.=C2=A0 And to<br>
remove BF-CBC support, I think that needs a bit longer timespan than<br>
v2.5.=C2=A0 Users *must* be far better prepared for that and we need to mak=
e<br>
loud and clear announcements with such a change.<br>
<br>
Yes, in all this, I know that NCP is a nice rescue.=C2=A0 As long as everyo=
ne<br>
either runs v2.4 everywhere or deploys --ncp-ciphers and starts the<br>
migration.=C2=A0 But I&#39;ve lost confidence that the vast majority of our=
 users<br>
pays closely attention to such feature changes - thus they won&#39;t notice=
<br>
until it stops working.=C2=A0 We need to PUSH this information into their<b=
r>
faces, with large posters carrying promises of rainbow coloured unicorns<br>
if they comply today(!).=C2=A0 In addition to adding clear warnings in the<=
br>
log files for a looong time.<br>
<br>
So I propose:<br>
<br>
- We add the warning about removing --keysize for both v2.4 and v2.5.<br>
<br>
- Add a warning in v2.4 and v2.5 that ciphers with block sizes &lt; 128<br>
=C2=A0 bits will be *removed* in v2.6<br>
<br>
- When removing those ciphers in v2.6, we can remove --keysize together<br>
=C2=A0 with the ciphers, as it will no longer be valid.=C2=A0 But --keysize=
 needs<br>
=C2=A0 to be a NOP for some time (with a warning it has no effect), to avoi=
d<br>
=C2=A0 OpenVPN stopping to run on upgrades.<br>
<br>
- Ensure these changes are synchronised within OpenVPN 3 as well<br>
<br>
- Start a new wiki page: &quot;How-To: Migrate to secure and modern<br>
=C2=A0 OpenVPN configurations&quot; where we list all deprecated features/o=
ptions<br>
=C2=A0 and their replacement (including examples).=C2=A0 We also need to ha=
ve a<br>
=C2=A0 description on the reasoning for deprecating and removing these<br>
=C2=A0 options.<br></blockquote><div><br></div><div>there are special cases=
 like Mikrotik openvpn (pretty popular), where<br></div><div>user simply us=
e what hardware vendor installed (without possibility to recompile).<br><br=
></div><div>should we contact such hardware vendors as well ?<br></div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">
<br>
- And the most tricky one: Get some publicity that OpenVPN is going to<br>
=C2=A0 deprecate and remove support for weak ciphers out to the public.=C2=
=A0 Not<br>
=C2=A0 just on crypto focused sites, but more broadly reaching &quot;media<=
br>
=C2=A0 channels&quot;.=C2=A0 =C2=A0(I believe we can facilitate some of the=
 PR work done by<br>
=C2=A0 the company, but we do need more than that).=C2=A0 Channels/sites I&=
#39;m<br>
=C2=A0 pondering on:<br>
<br>
=C2=A0 =C2=A0~ An official Press Release by the company? (Samuli and I can =
check)<br>
=C2=A0 =C2=A0~ twitter (via the @OpenVPN account)<br>
=C2=A0 =C2=A0~ reddit? (and similar sites)<br>
=C2=A0 =C2=A0~ LWN.net<br>
=C2=A0 =C2=A0~ arstechnica<br>
=C2=A0 =C2=A0~ ThreatPost<br>
=C2=A0 =C2=A0~ OS Distribution channels (blog posts, mailing lists, etc)<br>
=C2=A0 =C2=A0~ Our own wiki and web pages<br>
=C2=A0 =C2=A0~ others?<br>
<br>
=C2=A0 The first round is to clearly state that BF-CBC, CAST and RC2 are<br>
=C2=A0 deprecated and their support will be removed in a coming release (no=
t<br>
=C2=A0 mentioning version, on purpose!).=C2=A0 Users are strongly advised t=
o<br>
=C2=A0 upgrade to OpenVPN v2.4 or server and client side instantly, to<br>
=C2=A0 benefit from NCP (byt more less-tech worded) and to point at the<br>
=C2=A0 &quot;How-To&quot; described above.<br>
<br>
=C2=A0 And then we try to re-iterate this once again with the release of<br>
=C2=A0 v2.5 and v2.6.<br>
<br>
<br>
I know and understand this hurts security focused people, and probably<br>
in even more those who understand crypto very well.=C2=A0 But my personal<b=
r>
experience is that the average users are usually less understanding than<br>
security minded people.=C2=A0 (Yes, I&#39;ve burnt my, and other&#39;s, fin=
gers<br>
within the Fedora community with the v2.4 upgrade)<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
--<br>
kind regards,<br>
<br>
David Sommerseth<br>
OpenVPN Technologies, Inc<br>
<br>
<br>
</font></span><br>------------------------------<wbr>----------------------=
--------<wbr>------------------<br>
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
<br></blockquote></div><br></div></div>

--001a113ee18a109cdb0556c68bce--

