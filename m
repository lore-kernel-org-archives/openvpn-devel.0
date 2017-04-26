MIME-Version: 1.0
In-Reply-To: <20170425203458.GX14992@...1518...>
References: <1493106641-16173-1-git-send-email-chipitsine@...277...>
	<20170425203458.GX14992@...1518...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 26 Apr 2017 08:31:00 +0500
Message-ID: <CAFHpkQGahNaCs7EnJtN2QSDW+Z4JfdrXM1H_Rs5OXjKHAjrJjA@...278...>
Content-Type: multipart/alternative; boundary=94eb2c0d70e029a196054e0978aa
Subject: Re: [Openvpn-devel] travis-ci: add 2 mingw "build only"
	configurations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Nathan Stratton Treadway <nathanst@...1517...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c0d70e029a196054e0978aa
Content-Type: text/plain; charset=UTF-8

2017-04-26 1:34 GMT+05:00 Nathan Stratton Treadway <nathanst@...1517...>:

> On Tue, Apr 25, 2017 at 12:50:41 +0500, Ilya Shipitsin wrote:
> > Inspired by https://www.mail-archive.com/openvpn-devel@...1199...
> sourceforge.net/msg13032.html
> > build options are taken from regular windows installer builds
> >
> > Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
> > ---
> > v2: moved download/build dependencies into functions, changed cross build
>
> [....]
> > +if [ ! -z "${CHOST}" ]; then
> > +      #
> > +      # openvpn requires at least mingw-gcc-4.9, which is available at
> xenial repo
> > +      #
> > +      echo "deb http://archive.ubuntu.com/ubuntu xenial main universe"
> | sudo tee -a /etc/apt/sources.list.d/xenial.list
> > +      echo "deb http://archive.ubuntu.com/ubuntu xenial main" | sudo
> tee -a /etc/apt/sources.list.d/xenial.list
>
> I haven't been following all the history of this discussion on the list,
> but skimming this most recent version of the patch I noticed that the
> above-quoted code adds two separate "deb" lines to xenial.list, both of
> which include "main".  Presumably that won't actually cause any
> problems, but it seemed unlikely to have been intentional....
>
> (I am not familiar with travis, but I take it this code is run in a
> context where there's no need to make sure that the "xenial" lines
> aren't added repeatedly by multiple runs of this script?)
>

nice catch.

while it does not matter for travis-ci (because vm is created from scratch
on every build), we should keep build scripts reusable for any build
environment.

I'll fix that


>
>                                                         Nathan
>
> ------------------------------------------------------------
> ----------------
> Nathan Stratton Treadway  -  nathanst@...1517...  -  Mid-Atlantic region
> Ray Ontko & Co.  -  Software consulting services  -
> http://www.ontko.com/
>  GPG Key: http://www.ontko.com/~nathanst/gpg_key.txt   ID: 1023D/ECFB6239
>  Key fingerprint = 6AD8 485E 20B9 5C71 231C  0C32 15F3 ADCD ECFB 6239
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

--94eb2c0d70e029a196054e0978aa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-04-26 1:34 GMT+05:00 Nathan Stratton Treadway <span dir=3D"ltr">&l=
t;<a href=3D"mailto:nathanst@...1517..." target=3D"_blank">nathanst@...2265...=
...</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On T=
ue, Apr 25, 2017 at 12:50:41 +0500, Ilya Shipitsin wrote:<br>
&gt; Inspired by <a href=3D"https://www.mail-archive.com/openvpn-devel@...1514...=
s.sourceforge.net/msg13032.html" rel=3D"noreferrer" target=3D"_blank">https=
://www.mail-archive.com/<wbr>openvpn-devel@...1199...<wbr>sourceforge.net/m=
sg13032.html</a><br>
&gt; build options are taken from regular windows installer builds<br>
&gt;<br>
&gt; Signed-off-by: Ilya Shipitsin &lt;<a href=3D"mailto:chipitsine@...1354...=
..">chipitsine@...277...</a>&gt;<br>
&gt; ---<br>
&gt; v2: moved download/build dependencies into functions, changed cross bu=
ild<br>
<br>
</span>[....]<br>
<span class=3D"">&gt; +if [ ! -z &quot;${CHOST}&quot; ]; then<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 #<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 # openvpn requires at least mingw-gcc-4.9, which=
 is available at xenial repo<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 #<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 echo &quot;deb <a href=3D"http://archive.ubuntu.=
com/ubuntu" rel=3D"noreferrer" target=3D"_blank">http://archive.ubuntu.com/=
<wbr>ubuntu</a> xenial main universe&quot; | sudo tee -a /etc/apt/sources.l=
ist.d/<wbr>xenial.list<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 echo &quot;deb <a href=3D"http://archive.ubuntu.=
com/ubuntu" rel=3D"noreferrer" target=3D"_blank">http://archive.ubuntu.com/=
<wbr>ubuntu</a> xenial main&quot; | sudo tee -a /etc/apt/sources.list.d/<wb=
r>xenial.list<br>
<br>
</span>I haven&#39;t been following all the history of this discussion on t=
he list,<br>
but skimming this most recent version of the patch I noticed that the<br>
above-quoted code adds two separate &quot;deb&quot; lines to xenial.list, b=
oth of<br>
which include &quot;main&quot;.=C2=A0 Presumably that won&#39;t actually ca=
use any<br>
problems, but it seemed unlikely to have been intentional....<br>
<br>
(I am not familiar with travis, but I take it this code is run in a<br>
context where there&#39;s no need to make sure that the &quot;xenial&quot; =
lines<br>
aren&#39;t added repeatedly by multiple runs of this script?)<br></blockquo=
te><div><br></div><div>nice catch.<br><br></div><div>while it does not matt=
er for travis-ci (because vm is created from scratch on every build), we sh=
ould keep build scripts reusable for any build environment.<br><br></div><d=
iv>I&#39;ll fix that<br></div><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Nathan<br>
<br>
------------------------------<wbr>------------------------------<wbr>-----=
-----------<br>
Nathan Stratton Treadway=C2=A0 -=C2=A0 <a href=3D"mailto:nathanst@...2266...=
.">nathanst@...1517...</a>=C2=A0 -=C2=A0 Mid-Atlantic region<br>
Ray Ontko &amp; Co.=C2=A0 -=C2=A0 Software consulting services=C2=A0 -=C2=
=A0 =C2=A0<a href=3D"http://www.ontko.com/" rel=3D"noreferrer" target=3D"_b=
lank">http://www.ontko.com/</a><br>
=C2=A0GPG Key: <a href=3D"http://www.ontko.com/~nathanst/gpg_key.txt" rel=
=3D"noreferrer" target=3D"_blank">http://www.ontko.com/~<wbr>nathanst/gpg_k=
ey.txt</a>=C2=A0 =C2=A0ID: 1023D/ECFB6239<br>
=C2=A0Key fingerprint =3D 6AD8 485E 20B9 5C71 231C=C2=A0 0C32 15F3 ADCD ECF=
B 6239<br>
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

--94eb2c0d70e029a196054e0978aa--

