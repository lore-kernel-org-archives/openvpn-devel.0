MIME-Version: 1.0
In-Reply-To: <b6adb528-5d31-fa7b-cd0c-e87b69e0854c@...515...>
References: <f7687ebf-a75f-095d-67ca-e32a5c4e53e7@...515...>
 <1500293278.28621.32.camel@...1866...>
 <b6adb528-5d31-fa7b-cd0c-e87b69e0854c@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 25 Jul 2017 22:18:53 +0500
Message-ID: <CAFHpkQH-vpQJb043xsdy4BmD0khxCD1dPrJ=KZ2OQoiLvDxS3Q@...278...>
Content-Type: multipart/alternative; boundary="001a11444d3c9bda2c0555278693"
Subject: Re: [Openvpn-devel] Windows installer with updated pkcs11-helper
 (1.22) available for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: David Woodhouse <dwmw2@...1866...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11444d3c9bda2c0555278693
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-07-25 21:53 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:

> On 17/07/2017 15:07, David Woodhouse wrote:
> > On Fri, 2017-07-14 at 17:07 +0300, Samuli Sepp=C3=A4nen wrote:
> >> Hi all,
> >>
> >> Those of you who use pkcs11 on Windows: could you please test this new
> >> Windows installer:
> >>
> >>
> >>
> >> The previous installer(s) had pkcs11-helper 1.11. This one has 1.22, so
> >> some regression testing would be good to have.
> >
> > Please include the pkcs11-helper patch from
> > https://github.com/OpenSC/pkcs11-helper/pull/4 to make it support using
> > RFC7512 PKCS#11 URIs to specify certificates/keys instead of its own
> > non-standard identifiers.
> >
> > (It still accepts the old form, for compatibility).
> >
>
> I released the new Windows installer but without this patch. That said,
> the patch/PR you linked to makes sense. Does the patch have an active
> maintainer? If yes, then I propose is that we
>
> - Fork OpenSC/pkcs11-helper to OpenVPN/pkcs11-helper
> - Apply the patch to our fork
> - Produce and publish our own pkcs11-helper tarballs
> - Point openvpn-build to our tarballs
> - Periodically rebase our fork with upstream
>
> Thoughts?
>


well, I think we should unify build events across all projects.
i.e. openvpn should be built the same way no matter who builds (openvpn
itself, openvpn-build, travis ci or whatever).


that said, I think such build events should go to openvpn's Makefile.
and we will need to update things in the single place (currently - a lot of
places).


another idea is to rework the patch and merge it into the main fork.


>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
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

--001a11444d3c9bda2c0555278693
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-07-25 21:53 GMT+05:00 Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt;<=
a href=3D"mailto:samuli@...515..." target=3D"_blank">samuli@...515...</a>&g=
t;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div cla=
ss=3D"h5">On 17/07/2017 15:07, David Woodhouse wrote:<br>
&gt; On Fri, 2017-07-14 at 17:07 +0300, Samuli Sepp=C3=A4nen wrote:<br>
&gt;&gt; Hi all,<br>
&gt;&gt;<br>
&gt;&gt; Those of you who use pkcs11 on Windows: could you please test this=
 new<br>
&gt;&gt; Windows installer:<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; The previous installer(s) had pkcs11-helper 1.11. This one has 1.2=
2, so<br>
&gt;&gt; some regression testing would be good to have.<br>
&gt;<br>
&gt; Please include the pkcs11-helper patch from<br>
&gt; <a href=3D"https://github.com/OpenSC/pkcs11-helper/pull/4" rel=3D"nore=
ferrer" target=3D"_blank">https://github.com/OpenSC/<wbr>pkcs11-helper/pull=
/4</a> to make it support using<br>
&gt; RFC7512 PKCS#11 URIs to specify certificates/keys instead of its own<b=
r>
&gt; non-standard identifiers.<br>
&gt;<br>
&gt; (It still accepts the old form, for compatibility).<br>
&gt;<br>
<br>
</div></div>I released the new Windows installer but without this patch. Th=
at said,<br>
the patch/PR you linked to makes sense. Does the patch have an active<br>
maintainer? If yes, then I propose is that we<br>
<br>
- Fork OpenSC/pkcs11-helper to OpenVPN/pkcs11-helper<br>
- Apply the patch to our fork<br>
- Produce and publish our own pkcs11-helper tarballs<br>
- Point openvpn-build to our tarballs<br>
- Periodically rebase our fork with upstream<br>
<br>
Thoughts?<br></blockquote><div><br><br></div><div>well, I think we should u=
nify build events across all projects.<br></div><div>i.e. openvpn should be=
 built the same way no matter who builds (openvpn itself, openvpn-build, tr=
avis ci or whatever).<br><br><br></div><div>that said, I think such build e=
vents should go to openvpn&#39;s Makefile.<br></div><div>and we will need t=
o update things in the single place (currently - a lot of places).<br><br><=
br></div><div>another idea is to rework the patch and merge it into the mai=
n fork.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<span class=3D"im HOEnZb"><br>
--<br>
Samuli Sepp=C3=A4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
<br>
</span><div class=3D"HOEnZb"><div class=3D"h5">----------------------------=
--<wbr>------------------------------<wbr>------------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, Slashdot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
</div></div></blockquote></div><br></div></div>

--001a11444d3c9bda2c0555278693--

