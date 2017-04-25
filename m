MIME-Version: 1.0
In-Reply-To: <078f6fd3-c344-6a02-d0c3-bfbe3167fbe4@...1856...>
References: <1493106641-16173-1-git-send-email-chipitsine@...277...>
	<078f6fd3-c344-6a02-d0c3-bfbe3167fbe4@...1856...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 25 Apr 2017 23:51:45 +0500
Message-ID: <CAFHpkQF5H_x5=cSFZxh6C76cGAnwiEdttrTtsxuT+7TdPvH8yw@...278...>
Content-Type: multipart/alternative; boundary=94eb2c0d70e02da154054e02376f
Subject: Re: [Openvpn-devel] [PATCH] travis-ci: add 2 mingw "build only"
	configurations
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

--94eb2c0d70e02da154054e02376f
Content-Type: text/plain; charset=UTF-8

2017-04-25 22:49 GMT+05:00 Steffan Karger <steffan@...1856...>:

> Hi,
>
> On 25-04-17 09:50, Ilya Shipitsin wrote:
> > Inspired by https://www.mail-archive.com/openvpn-devel@...1199...
> sourceforge.net/msg13032.html
> > build options are taken from regular windows installer builds
> >
> > Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
> > ---
> > v2: moved download/build dependencies into functions, changed cross build
> > detection from shell expansion ${CHOST+x} to more recognised -z
> "${CHOST}",
> > which required changing 'set -eux' to 'set -ex'. Added comments to make
> > code readable without looking into commit message.
>
> Thanks, this looks much better now!  Just one nit: if we give $CHOST a
> default value, we don't have to remove set -u:
>


defining CHOST when we actually do not need it does not make any sense.
I can keep "set -u" and use shell variable expansion trick

http://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash



>
> > --- a/.travis/build-deps.sh
> > +++ b/.travis/build-deps.sh
> > @@ -1,9 +1,58 @@
> >  #!/bin/sh
> > -set -eux
> > +set -ex
> >
> >  # Set defaults
> >  PREFIX="${PREFIX:-${HOME}/opt}"
>
> Just add a CHOST="${CHOST:-}" line here.  Keeping -u will help us catch
> future problems (typos in variable names, for example).
>

we already had problems with such complicated definition

https://github.com/OpenVPN/openvpn/commit/368991264d82f038bde30a67910ac6c7681a4ba9#diff-ff51f64442ce689bd8d8466e365dd600R6

those errors are not easy to catch, so I would avoid defining variables in
such way.

I think, we need to remove PREFIX definition as well.


>
> Samuli already verified that this does what it should, so once we can
> get -u back I too agree that this patch is ready to be applied.
>
> Thanks for improving the patch and not giving up :)
>
> -Steffan
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

--94eb2c0d70e02da154054e02376f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-04-25 22:49 GMT+05:00 Steffan Karger <span dir=3D"ltr">&lt;<a href=
=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>&gt;=
</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<span class=3D"gmail-"><br>
On 25-04-17 09:50, Ilya Shipitsin wrote:<br>
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
&gt; detection from shell expansion ${CHOST+x} to more recognised -z &quot;=
${CHOST}&quot;,<br>
&gt; which required changing &#39;set -eux&#39; to &#39;set -ex&#39;. Added=
 comments to make<br>
&gt; code readable without looking into commit message.<br>
<br>
</span>Thanks, this looks much better now!=C2=A0 Just one nit: if we give $=
CHOST a<br>
default value, we don&#39;t have to remove set -u:<br></blockquote><div><br=
><br></div><div>defining CHOST when we actually do not need it does not mak=
e any sense.<br></div><div>I can keep &quot;set -u&quot; and use shell vari=
able expansion trick<br><br><a href=3D"http://stackoverflow.com/questions/3=
601515/how-to-check-if-a-variable-is-set-in-bash">http://stackoverflow.com/=
questions/3601515/how-to-check-if-a-variable-is-set-in-bash</a><br></div><d=
iv><br>=C2=A0<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<span class=3D"gmail-"><br>
&gt; --- a/.travis/build-deps.sh<br>
&gt; +++ b/.travis/build-deps.sh<br>
&gt; @@ -1,9 +1,58 @@<br>
&gt;=C2=A0 #!/bin/sh<br>
&gt; -set -eux<br>
&gt; +set -ex<br>
&gt;<br>
&gt;=C2=A0 # Set defaults<br>
&gt;=C2=A0 PREFIX=3D&quot;${PREFIX:-${HOME}/opt}<wbr>&quot;<br>
<br>
</span>Just add a CHOST=3D&quot;${CHOST:-}&quot; line here.=C2=A0 Keeping -=
u will help us catch<br>
future problems (typos in variable names, for example). <br></blockquote><d=
iv><br></div><div>we already had problems with such complicated definition<=
br><br><a href=3D"https://github.com/OpenVPN/openvpn/commit/368991264d82f03=
8bde30a67910ac6c7681a4ba9#diff-ff51f64442ce689bd8d8466e365dd600R6">https://=
github.com/OpenVPN/openvpn/commit/368991264d82f038bde30a67910ac6c7681a4ba9#=
diff-ff51f64442ce689bd8d8466e365dd600R6</a><br><br></div><div>those errors =
are not easy to catch, so I would avoid defining variables in such way.<br>=
<br></div><div>I think, we need to remove PREFIX definition as well.<br></d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Samuli already verified that this does what it should, so once we can<br>
get -u back I too agree that this patch is ready to be applied.<br>
<br>
Thanks for improving the patch and not giving up :)<br>
<br>
-Steffan<br>
<br>
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
</blockquote></div><br></div></div>

--94eb2c0d70e02da154054e02376f--

