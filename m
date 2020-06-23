MIME-Version: 1.0
References: <202006230628.05N6Sa3g001325@...2054...>
 <20200623072123.GA2034@...1296...>
 <1592917531.4768.4.camel@...2316...>
 <CAFHpkQF5tz91P_UJxMuNCRDUYodw8QPV8=h8mmkSTHOUH5AdfA@...278...>
 <CAFHpkQH-yGFBJ=-Eaz5XCSaUcD-=S00y=MvPs6Vmr5nE_PcTRg@...278...>
 <1592936237.4768.43.camel@...2316...>
 <CAFHpkQGQgQm2cEA1kw1JpRkf4Ldu4kT=y-YXF-6cLTXbEx_zDQ@...278...>
 <20200623184733.GK1431@...1296...> <20200623192627.GA11911@...1296...>
 <1592940762.4768.52.camel@...2316...>
 <20200623193702.GL1431@...1296...>
In-Reply-To: <20200623193702.GL1431@...1296...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 24 Jun 2020 01:18:52 +0500
Message-ID: <CAFHpkQEz+eE76vN3s3bOiVWRCOdD6opNkdRMibfPMAh6GfeUUA@...278...>
Content-Type: multipart/alternative; boundary="0000000000001998b805a8c6125c"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Add unit tests for engine
 keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: James Bottomley <James.Bottomley@...2317...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000001998b805a8c6125c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 24 =D0=B8=D1=8E=D0=BD. 2020 =D0=B3. =D0=B2 00:37, Gert Doerin=
g <gert@...1296...>:

> Hi,
>
> On Tue, Jun 23, 2020 at 12:32:42PM -0700, James Bottomley wrote:
> > > James, are you triggering on specific openvpn messages?  "--enable-
> > > small"
> > > changes these (trimming some warnings and help texts).  Can you test
> > > with
> > > "configure --enable-small", please?
> > >
> > > https://travis-ci.org/github/OpenVPN/openvpn/builds/701385033?utm_med
> > > ium=3Dnotification&utm_source=3Demail
> >
> > Yes, that's it.  The problem is the message output by openssl is
> >
> > 2020-06-23 19:28:46 OpenSSL: error:0B080074:lib(11):func(128):reason(11=
6)
> >
> > Instead of:
> >
> > 2020-06-23 12:30:43 OpenSSL: error:0B080074:x509 certificate
> routines:X509_check_private_key:key values mismatch
>
> Indeed :-)
>
> > I think I can make the grep work with the former.
>
> Please do not forget to output log.txt when it fails - it eases diagnosing
> remote failures where we do not have easy access to "file system things"
> (like travis or buildbot).
>

I've added output of log.txt, if you are going to modify "grep" magic, can
you adopt something like that, please ?


https://travis-ci.org/github/chipitsine/openvpn/jobs/701409750


diff --git a/tests/unit_tests/engine-key/check_engine_keys.sh
b/tests/unit_tests/engine-key/check_engine_keys.sh
index e0c9d7b0..770a0c9c 100755
--- a/tests/unit_tests/engine-key/check_engine_keys.sh
+++ b/tests/unit_tests/engine-key/check_engine_keys.sh
@@ -8,6 +8,10 @@ password=3D'AT3S4PASSWD'
 key=3D"${builddir}/client.key"
 pwdfile=3D"${builddir}/passwd"

+grep_a_log () {
+  grep -q $1 $2 || { echo $3; cat $2 ; exit 1; }
+}
+
 # create an engine key for us
 sed 's/PRIVATE KEY/TEST ENGINE KEY/' <
${top_srcdir}/sample/sample-keys/client.key > ${key}
 echo "$password" > $pwdfile
@@ -21,10 +25,10 @@ ${top_builddir}/src/openvpn/openvpn --cd
${top_srcdir}/sample --config sample-co
 # first off check we died because of a key mismatch.  If this doesn't
 # pass, suspect openssl of returning different messages and update the
 # test accordingly
-grep -q 'X509_check_private_key:key values mismatch' log.txt || { echo
"Key mismatch not detected"; exit 1; }
+grep_a_log 'X509_check_private_key:key values mismatch' log.txt 'Key
mismatch not detected'

 # now look for the engine prints (these are under our control)
-grep -q 'ENGINE: engine_init called' log.txt || { echo "Engine
initialization not detected"; exit 1; }
-grep -q 'ENGINE: engine_load_key called' log.txt || { echo "Key was not
loaded from engine"; exit 1; }
-grep -q "ENGINE: engine_load_key got password ${password}" log.txt || {
echo "Key password was not retrieved by the engine"; exit 1; }
+grep_a_log 'ENGINE: engine_init called' log.txt 'Engine initialization not
detected'
+grep_a_log 'ENGINE: engine_load_key called' log.txt 'Key was not loaded
from engine'
+grep_a_log "ENGINE: engine_load_key got password ${password}" log.txt 'Key
password was not retrieved by the engine'
 exit 0
--=20
2.26.2







>
> gert
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
>

--0000000000001998b805a8c6125c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">=D1=81=D1=80, 24 =D0=B8=D1=8E=D0=BD. =
2020 =D0=B3. =D0=B2 00:37, Gert Doering &lt;<a href=3D"mailto:gert@...1725...=
..">gert@...1296...</a>&gt;:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">Hi,<br>
<br>
On Tue, Jun 23, 2020 at 12:32:42PM -0700, James Bottomley wrote:<br>
&gt; &gt; James, are you triggering on specific openvpn messages?=C2=A0 &qu=
ot;--enable-<br>
&gt; &gt; small&quot;<br>
&gt; &gt; changes these (trimming some warnings and help texts).=C2=A0 Can =
you test<br>
&gt; &gt; with<br>
&gt; &gt; &quot;configure --enable-small&quot;, please?<br>
&gt; &gt; <br>
&gt; &gt; <a href=3D"https://travis-ci.org/github/OpenVPN/openvpn/builds/70=
1385033?utm_med" rel=3D"noreferrer" target=3D"_blank">https://travis-ci.org=
/github/OpenVPN/openvpn/builds/701385033?utm_med</a><br>
&gt; &gt; ium=3Dnotification&amp;utm_source=3Demail<br>
&gt; <br>
&gt; Yes, that&#39;s it.=C2=A0 The problem is the message output by openssl=
 is<br>
&gt; <br>
&gt; 2020-06-23 19:28:46 OpenSSL: error:0B080074:lib(11):func(128):reason(1=
16)<br>
&gt; <br>
&gt; Instead of:<br>
&gt; <br>
&gt; 2020-06-23 12:30:43 OpenSSL: error:0B080074:x509 certificate routines:=
X509_check_private_key:key values mismatch<br>
<br>
Indeed :-)<br>
<br>
&gt; I think I can make the grep work with the former.<br>
<br>
Please do not forget to output log.txt when it fails - it eases diagnosing<=
br>
remote failures where we do not have easy access to &quot;file system thing=
s&quot; <br>
(like travis or buildbot).<br></blockquote><div><br></div><div>I&#39;ve add=
ed output of log.txt, if you are going to modify &quot;grep&quot; magic, ca=
n you adopt something like that, please ?</div><div><br></div><div><br></di=
v><div><a href=3D"https://travis-ci.org/github/chipitsine/openvpn/jobs/7014=
09750">https://travis-ci.org/github/chipitsine/openvpn/jobs/701409750</a></=
div><div><br></div><div><br></div><div>diff --git a/tests/unit_tests/engine=
-key/check_engine_keys.sh b/tests/unit_tests/engine-key/check_engine_keys.s=
h<br>index e0c9d7b0..770a0c9c 100755<br>--- a/tests/unit_tests/engine-key/c=
heck_engine_keys.sh<br>+++ b/tests/unit_tests/engine-key/check_engine_keys.=
sh<br>@@ -8,6 +8,10 @@ password=3D&#39;AT3S4PASSWD&#39;<br>=C2=A0key=3D&quo=
t;${builddir}/client.key&quot;<br>=C2=A0pwdfile=3D&quot;${builddir}/passwd&=
quot;<br>=C2=A0<br>+grep_a_log () {<br>+ =C2=A0grep -q $1 $2 || { echo $3; =
cat $2 ; exit 1; }<br>+}<br>+<br>=C2=A0# create an engine key for us<br>=C2=
=A0sed &#39;s/PRIVATE KEY/TEST ENGINE KEY/&#39; &lt; ${top_srcdir}/sample/s=
ample-keys/client.key &gt; ${key}<br>=C2=A0echo &quot;$password&quot; &gt; =
$pwdfile<br>@@ -21,10 +25,10 @@ ${top_builddir}/src/openvpn/openvpn --cd ${=
top_srcdir}/sample --config sample-co<br>=C2=A0# first off check we died be=
cause of a key mismatch.=C2=A0 If this doesn&#39;t<br>=C2=A0# pass, suspect=
 openssl of returning different messages and update the<br>=C2=A0# test acc=
ordingly<br>-grep -q &#39;X509_check_private_key:key values mismatch&#39; l=
og.txt || { echo &quot;Key mismatch not detected&quot;; exit 1; }<br>+grep_=
a_log &#39;X509_check_private_key:key values mismatch&#39; log.txt &#39;Key=
 mismatch not detected&#39;<br>=C2=A0<br>=C2=A0# now look for the engine pr=
ints (these are under our control)<br>-grep -q &#39;ENGINE: engine_init cal=
led&#39; log.txt || { echo &quot;Engine initialization not detected&quot;; =
exit 1; }<br>-grep -q &#39;ENGINE: engine_load_key called&#39; log.txt || {=
 echo &quot;Key was not loaded from engine&quot;; exit 1; }<br>-grep -q &qu=
ot;ENGINE: engine_load_key got password ${password}&quot; log.txt || { echo=
 &quot;Key password was not retrieved by the engine&quot;; exit 1; }<br>+gr=
ep_a_log &#39;ENGINE: engine_init called&#39; log.txt &#39;Engine initializ=
ation not detected&#39;<br>+grep_a_log &#39;ENGINE: engine_load_key called&=
#39; log.txt &#39;Key was not loaded from engine&#39;<br>+grep_a_log &quot;=
ENGINE: engine_load_key got password ${password}&quot; log.txt &#39;Key pas=
sword was not retrieved by the engine&#39;<br>=C2=A0exit 0<br>-- <br>2.26.2=
<br></div><div><br></div><div><br></div><div><br></div><div><br></div><div>=
<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
<br>
gert<br>
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
o:gert@...1296..." target=3D"_blank">gert@...1296...</a><br>
</blockquote></div></div>

--0000000000001998b805a8c6125c--

