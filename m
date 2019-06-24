MIME-Version: 1.0
References: <20190623185408.GQ1097@...1296...>
In-Reply-To: <20190623185408.GQ1097@...1296...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 24 Jun 2019 11:17:22 +0500
Message-ID: <CAFHpkQEi=Y0K3hXOqt2z_g+K8xD=Qu4iQ-fdo-zAc10C+0ZK3Q@...278...>
Content-Type: multipart/alternative; boundary="000000000000a16739058c0bc4ee"
Subject: Re: [Openvpn-devel] [builds@...2512...: Still Failing:
 OpenVPN/openvpn#874 (master - 7473f32)]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000a16739058c0bc4ee
Content-Type: text/plain; charset="UTF-8"

Thank you for the investigation, Gert.
I'll have a look soon

On Sun, Jun 23, 2019, 11:55 PM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> travis CI builds for MacOS fail (and have failed for quite some time,
> it seems) because LZO is not installed as pre-requisite - the configure
> run in the log below ends in line 632 with
>
>  configure: error: lzo enabled but missing
>
> ... but it *should* be built by ".travis/build-deps.sh" - so it seems
> that script is failing.  In any case it is not communicating errors
> back to the caller, because otherwise we'd see the output in the
> main travis build log...
>
> Not sure what is needed to fix these two issues
>
>  - get output from build-deps.sh in case of failure
>  - make the failure go away
>
>
> A naive reading of build-deps.sh seems to suggest that "build_lzo"
> is only ever called on MinGW cross-builds and not on MacOS - so, that
> would explain why it's not failing.  But then, how to teach Travis
> that we want LZO?
>
> Anyway, I leave this for somebody who understands Travis-CI better than
> I do to fix and send a patch.
>
> gert
>
>
> ----- Forwarded message from Travis CI <builds@...2512...> -----
>
> Date: Sun, 23 Jun 2019 18:44:30 +0000
> From: Travis CI <builds@...2512...>
> To: gert@...1296..., steffan@...1856...
> Subject: Still Failing: OpenVPN/openvpn#874 (master - 7473f32)
>
> Build Update for OpenVPN/openvpn
> -------------------------------------
>
> Build: #874
> Status: Still Failing
>
> Duration: 20 mins and 54 secs
> Commit: 7473f32 (master)
> Author: Steffan Karger
> Message: configure.ac: add lzo CFLAGS/LIBS to the test flags
>
> This fixes "make check" builds on systems with lzo on a non-standard
> location.
>
> Signed-off-by: Steffan Karger <steffan@...1856...>
> Acked-by: David Sommerseth <davids@...515...>
> Message-Id: <20190602101831.21216-1-steffan@...1856...>
> URL:
> https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18482.html
> Signed-off-by: Gert Doering <gert@...1296...>
>
> View the changeset:
> https://github.com/OpenVPN/openvpn/compare/06f65a0cbfcb...7473f326366f
>
> View the full build log and details:
> https://travis-ci.org/OpenVPN/openvpn/builds/549429549?utm_medium=notification&utm_source=email
>
> --
>
> You can unsubscribe from build emails from the OpenVPN/openvpn repository
> going to
> https://travis-ci.org/account/preferences/unsubscribe?repository=6518989&utm_medium=notification&utm_source=email
> .
> Or unsubscribe from *all* email updating your settings at
> https://travis-ci.org/account/preferences/unsubscribe?utm_medium=notification&utm_source=email
> .
> Or configure specific recipients for build notifications in your
> .travis.yml file. See https://docs.travis-ci.com/user/notifications.
>
>
> ----- End forwarded message -----
>
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never
> doubted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh
> Mistress
>
> Gert Doering - Munich, Germany
> gert@...1296...
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--000000000000a16739058c0bc4ee
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Thank you for the investigation, Gert.<div dir=3D"auto">I=
&#39;ll have a look soon</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Sun, Jun 23, 2019, 11:55 PM Gert Doering &=
lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
travis CI builds for MacOS fail (and have failed for quite some time,<br>
it seems) because LZO is not installed as pre-requisite - the configure<br>
run in the log below ends in line 632 with<br>
<br>
=C2=A0configure: error: lzo enabled but missing<br>
<br>
... but it *should* be built by &quot;.travis/build-deps.sh&quot; - so it s=
eems<br>
that script is failing.=C2=A0 In any case it is not communicating errors<br>
back to the caller, because otherwise we&#39;d see the output in the<br>
main travis build log...<br>
<br>
Not sure what is needed to fix these two issues<br>
<br>
=C2=A0- get output from build-deps.sh in case of failure<br>
=C2=A0- make the failure go away<br>
<br>
<br>
A naive reading of build-deps.sh seems to suggest that &quot;build_lzo&quot=
;<br>
is only ever called on MinGW cross-builds and not on MacOS - so, that<br>
would explain why it&#39;s not failing.=C2=A0 But then, how to teach Travis=
 <br>
that we want LZO?<br>
<br>
Anyway, I leave this for somebody who understands Travis-CI better than<br>
I do to fix and send a patch.<br>
<br>
gert<br>
<br>
<br>
----- Forwarded message from Travis CI &lt;<a href=3D"mailto:builds@...2513...=
..." target=3D"_blank" rel=3D"noreferrer">builds@...2512...</a>&gt; -----<b=
r>
<br>
Date: Sun, 23 Jun 2019 18:44:30 +0000<br>
From: Travis CI &lt;<a href=3D"mailto:builds@...2512..." target=3D"_blank" =
rel=3D"noreferrer">builds@...2512...</a>&gt;<br>
To: <a href=3D"mailto:gert@...1296..." target=3D"_blank" rel=3D"noreferrer"=
>gert@...1296...</a>, <a href=3D"mailto:steffan@...1856..." target=3D"_blan=
k" rel=3D"noreferrer">steffan@...1856...</a><br>
Subject: Still Failing: OpenVPN/openvpn#874 (master - 7473f32)<br>
<br>
Build Update for OpenVPN/openvpn<br>
-------------------------------------<br>
<br>
Build: #874<br>
Status: Still Failing<br>
<br>
Duration: 20 mins and 54 secs<br>
Commit: 7473f32 (master)<br>
Author: Steffan Karger<br>
Message: <a href=3D"http://configure.ac" rel=3D"noreferrer noreferrer" targ=
et=3D"_blank">configure.ac</a>: add lzo CFLAGS/LIBS to the test flags<br>
<br>
This fixes &quot;make check&quot; builds on systems with lzo on a non-stand=
ard<br>
location.<br>
<br>
Signed-off-by: Steffan Karger &lt;<a href=3D"mailto:steffan@...1856..." tar=
get=3D"_blank" rel=3D"noreferrer">steffan@...1856...</a>&gt;<br>
Acked-by: David Sommerseth &lt;<a href=3D"mailto:davids@...515..." target=
=3D"_blank" rel=3D"noreferrer">davids@...515...</a>&gt;<br>
Message-Id: &lt;<a href=3D"mailto:20190602101831.21216-1-steffan@...1856...=
" target=3D"_blank" rel=3D"noreferrer">20190602101831.21216-1-steffan@...1883...=
56...</a>&gt;<br>
URL: <a href=3D"https://www.mail-archive.com/openvpn-devel@...1483...=
e.net/msg18482.html" rel=3D"noreferrer noreferrer" target=3D"_blank">https:=
//www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18482.html</a=
><br>
Signed-off-by: Gert Doering &lt;<a href=3D"mailto:gert@...1296..." target=
=3D"_blank" rel=3D"noreferrer">gert@...1296...</a>&gt;<br>
<br>
View the changeset: <a href=3D"https://github.com/OpenVPN/openvpn/compare/0=
6f65a0cbfcb...7473f326366f" rel=3D"noreferrer noreferrer" target=3D"_blank"=
>https://github.com/OpenVPN/openvpn/compare/06f65a0cbfcb...7473f326366f</a>=
<br>
<br>
View the full build log and details: <a href=3D"https://travis-ci.org/OpenV=
PN/openvpn/builds/549429549?utm_medium=3Dnotification&amp;utm_source=3Demai=
l" rel=3D"noreferrer noreferrer" target=3D"_blank">https://travis-ci.org/Op=
enVPN/openvpn/builds/549429549?utm_medium=3Dnotification&amp;utm_source=3De=
mail</a><br>
<br>
--<br>
<br>
You can unsubscribe from build emails from the OpenVPN/openvpn repository g=
oing to <a href=3D"https://travis-ci.org/account/preferences/unsubscribe?re=
pository=3D6518989&amp;utm_medium=3Dnotification&amp;utm_source=3Demail" re=
l=3D"noreferrer noreferrer" target=3D"_blank">https://travis-ci.org/account=
/preferences/unsubscribe?repository=3D6518989&amp;utm_medium=3Dnotification=
&amp;utm_source=3Demail</a>.<br>
Or unsubscribe from *all* email updating your settings at <a href=3D"https:=
//travis-ci.org/account/preferences/unsubscribe?utm_medium=3Dnotification&a=
mp;utm_source=3Demail" rel=3D"noreferrer noreferrer" target=3D"_blank">http=
s://travis-ci.org/account/preferences/unsubscribe?utm_medium=3Dnotification=
&amp;utm_source=3Demail</a>.<br>
Or configure specific recipients for build notifications in your .travis.ym=
l file. See <a href=3D"https://docs.travis-ci.com/user/notifications" rel=
=3D"noreferrer noreferrer" target=3D"_blank">https://docs.travis-ci.com/use=
r/notifications</a>.<br>
<br>
<br>
----- End forwarded message -----<br>
<br>
-- <br>
&quot;If was one thing all people took for granted, was conviction that if =
you <br>
=C2=A0feed honest figures into a computer, honest figures come out. Never d=
oubted <br>
=C2=A0it myself till I met a computer with a sense of humor.&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Robert A. Heinlein, The Moon is a Harsh Mist=
ress<br>
<br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296..." target=3D"_blank" rel=3D"noreferrer">gert@...1296...</a>=
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank" re=
l=3D"noreferrer">Openvpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer noreferrer" target=3D"_blank">https://lists.sourceforge.net/=
lists/listinfo/openvpn-devel</a><br>
</blockquote></div>

--000000000000a16739058c0bc4ee--

