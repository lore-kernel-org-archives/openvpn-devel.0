MIME-Version: 1.0
In-Reply-To: <6beb138f-831e-edd7-d4dd-28beeadc5310@...515...>
References: <CAKuzo_jVbyE3kQkgT1aYgMSK-YGm2Ho=Evbsrck5Y4mNwAsKmQ@...278...>
 <6beb138f-831e-edd7-d4dd-28beeadc5310@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 30 Jan 2018 14:50:16 +0500
Message-ID: <CAFHpkQE5HPPJK2VeFzDoP7f=1unmCerxSjToWoVgzJnkbk4vTQ@...278...>
Content-Type: multipart/alternative; boundary="089e082b123c3f01a30563fb4a2d"
Subject: Re: [Openvpn-devel] [Openvpn-users] test latest binary on vista
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, "openvpn users list (openvpn-users@lists.sourceforge.net)" <openvpn-users@lists.sourceforge.net>

--089e082b123c3f01a30563fb4a2d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2018-01-30 14:33 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:

> Hi,
>
> Il 29/01/2018 20:09, Selva Nair ha scritto:
> > (Cross posting to users and devel)
> >
> > Hi,
> >
> > 2.4.x needs to support, Vista, isn't it?
>
> Good question and we have discussed in the past. Windows Vista is no
> longer supported by Microsoft:
>
> <https://support.microsoft.com/en-us/help/13853/windows-
> lifecycle-fact-sheet>
>
> But then again, we do provide installers which work on Windows XP, which
> is similarly EOL. So I guess we do support Windows Vista for the time
> being.
>
> >
> > Can anyone please latest 2.4 release branch on Windows Vista using an
> > RSA certificate in Windows cert store (using --cryptoapicert option) ?
> >
> > Need to be built with openssl 1.1. Not sure the snapshots are built that
> way..
> > https://build.openvpn.net/downloads/snapshots/
>
> Not yet. I will switch snapshot builds to OpenSSL 1.1 once
> openvpn-build's openvpn.nsi stops failing on OpenSSL 1.1 libraries
> (names have changed). A PR is pending but it still needs one minor fix.
>


snapshot builds are different from release builds (they do not support lzo,
for example)
I was going to unify snapshot/release builds. Hope to do that soon

but UI is the same :)


>
> > The recent changes to cryptoapi uses CNG api which is supposedly
> > supported on Vista but some testing would be useful. I no longer have
> > access to a Vista machine.
> >
> > Thanks,
> >
> > Selva
> >
>
>
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

--089e082b123c3f01a30563fb4a2d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2018-01-30 14:33 GMT+05:00 Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt;<=
a href=3D"mailto:samuli@...515..." target=3D"_blank">samuli@...515...</a>&g=
t;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
Il 29/01/2018 20:09, Selva Nair ha scritto:<br>
&gt; (Cross posting to users and devel)<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; 2.4.x needs to support, Vista, isn&#39;t it?<br>
<br>
</span>Good question and we have discussed in the past. Windows Vista is no=
<br>
longer supported by Microsoft:<br>
<br>
&lt;<a href=3D"https://support.microsoft.com/en-us/help/13853/windows-lifec=
ycle-fact-sheet" rel=3D"noreferrer" target=3D"_blank">https://support.micro=
soft.<wbr>com/en-us/help/13853/windows-<wbr>lifecycle-fact-sheet</a>&gt;<br>
<br>
But then again, we do provide installers which work on Windows XP, which<br>
is similarly EOL. So I guess we do support Windows Vista for the time being=
.<br>
<span class=3D""><br>
&gt;<br>
&gt; Can anyone please latest 2.4 release branch on Windows Vista using an<=
br>
&gt; RSA certificate in Windows cert store (using --cryptoapicert option) ?=
<br>
&gt;<br>
&gt; Need to be built with openssl 1.1. Not sure the snapshots are built th=
at way..<br>
&gt; <a href=3D"https://build.openvpn.net/downloads/snapshots/" rel=3D"nore=
ferrer" target=3D"_blank">https://build.openvpn.net/<wbr>downloads/snapshot=
s/</a><br>
<br>
</span>Not yet. I will switch snapshot builds to OpenSSL 1.1 once<br>
openvpn-build&#39;s openvpn.nsi stops failing on OpenSSL 1.1 libraries<br>
(names have changed). A PR is pending but it still needs one minor fix.<br>=
</blockquote><div><br></div><div><br></div><div>snapshot builds are differe=
nt from release builds (they do not support lzo, for example)</div><div>I w=
as going to unify snapshot/release builds. Hope to do that soon</div><div><=
br></div><div>but UI is the same :)<br></div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;=
padding-left:1ex">
<span class=3D""><br>
&gt; The recent changes to cryptoapi uses CNG api which is supposedly<br>
&gt; supported on Vista but some testing would be useful. I no longer have<=
br>
&gt; access to a Vista machine.<br>
&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt; Selva<br>
&gt;<br>
<br>
<br>
<br>
--<br>
</span>Samuli Sepp=C3=A4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
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

--089e082b123c3f01a30563fb4a2d--

