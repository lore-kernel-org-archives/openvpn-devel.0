MIME-Version: 1.0
In-Reply-To: <CAFHpkQG8Lw5Va2PHT=BA86z-WgXv2Lqe+r9Q+fBeFsgRniKSCw@...278...>
References: <1502207741-31750-1-git-send-email-steffan.karger@...1435...>
 <CAFHpkQG8Lw5Va2PHT=BA86z-WgXv2Lqe+r9Q+fBeFsgRniKSCw@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 9 Aug 2017 10:47:00 +0500
Message-ID: <CAFHpkQE+2_BCADNJFVDreLagvhNONQP8eP_s7W4s835ChfSpiA@...278...>
Content-Type: multipart/alternative; boundary="001a1147bd7ed7477d05564b9b12"
Subject: Re: [Openvpn-devel] [PATCH] Add coverity static analysis to Travis
 CI config
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1147bd7ed7477d05564b9b12
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-08-09 10:41 GMT+05:00 =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=
=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...>:

>
>
> 2017-08-08 20:55 GMT+05:00 Steffan Karger <steffan.karger@...1435...>:
>
>> Enable coverity analysis for the release/2.4 branch.
>>
>> We can only do a limited number of coverity scans per week with our FOSS
>> account, but since we only occasionally push commits, that should work o=
ut
>> fine.  But this limit is the reason we don't use the standard travis
>> addon,
>> because that would cause the coverity script to run on all of our matrix
>> builds.  That would cause us to reach our limit faster, and waste travis'
>> resources.
>>
>> Since our FOSS coverity account doesn't handle multiple branches very
>> well,
>> we have to pick one branch to run coverity on.  I think it's best to use
>> the most recent stable branch for that (i.e. for now, release/2.4).
>> Though for ease of maintenance, it's probably best to apply the patch to
>> both master and release/2.4.
>>
>
>
> I would refactor it like that https://gist.github.com/chipitsine/
> 8dcae4ff1d59eb43df39f6015c6106fd
> however, your is ok as well
>


maybe, "script" would be better here
https://gist.github.com/chipitsine/8dcae4ff1d59eb43df39f6015c6106fd#file-gi=
stfile1-txt-L74
than "before_script"


>
>
>>
>> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
>> ---
>>  .travis.yml         |  8 +++++++-
>>  .travis/coverity.sh | 17 +++++++++++++++++
>>  2 files changed, 24 insertions(+), 1 deletion(-)
>>  create mode 100755 .travis/coverity.sh
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index db90e03..131d002 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -21,10 +21,13 @@ env:
>>      - OPENSSL_VERSION=3D"1.0.2k"
>>      - OPENSSL_CFLAGS=3D"-I${PREFIX}/include"
>>      - OPENSSL_LIBS=3D"-L${PREFIX}/lib -lssl -lcrypto"
>> +    # The next declaration is the encrypted COVERITY_SCAN_TOKEN, created
>> +    #   via the "travis encrypt" command using the project repo's public
>> key
>> +    - secure: "l9mSnEW4LJqjxftH5i1NdDaYfGmQB
>> 1mPXnSB3DXnsjzkCWZ+yJLfBemfQ0tx/wS7chBYxqUaUIMT0hw4zJVp/LANF
>> Jo2vfh//ymTS6h0uApRY1ofg9Pp1BFcV1laG6/u8pwSZ2EBy/GhCd3DS436o
>> E8sYBRaFM9FU62L/oeQBfJ7r4ID/0eB1b8bqlbD4paty9MHui2P8EZJwR+KA
>> D84prtfpZOcrSMxPh9OUhJxzxUvvVoP4s4+lZ5Kgg1bBQ3yzKGDqe8VOgK2B
>> WCEuezqhMMc8oeKmAe7CUkoz5gsGYH++k3I9XzP9Z4xeJKoQnC/82qi4xkJm
>> laOxdionej9bHIcjfRt7D8j1J0U+wOj4p8VrDy7yHaxuN2fi0K5MGa/CaXQS
>> rkna8dePniCng+xQ2MY/zxuRX2gA6xPNLUyQLU9LqIug7wj4z84Hk9iWib4L
>> 20MoPjeEo+vAUNq8FtjOPxMuHNpv4iGGx6kgJm7RXl5vC5hxfK6MprrnYe2U
>> 5Mcd8jpzagKBaKHL3zV2FxX9k0jRO9Mccz7M2WnaV0MQ6zcngzTN4+s0kCjh
>> fGKd2F2ANT2Gkhj3Me36eNHfuE0dBbvYCMh4b3Mgd7b/OuXwQWdJ8PjJ1WHX
>> jSOw5sHw1suaV6cEO2Meyz5j1tOkyOi0M9QF+LFenQ9vLH4sBCww8U=3D"
>>
>>  matrix:
>>    include:
>> -    - env: SSLLIB=3D"openssl"
>> +    - env: SSLLIB=3D"openssl" RUN_COVERITY=3D"1"
>>        os: linux
>>        compiler: gcc
>>      - env: SSLLIB=3D"openssl" OPENSSL_VERSION=3D"1.1.0f"
>> @@ -91,5 +94,8 @@ install:
>>    - if [ ! -z "${CHOST}" ]; then unset CC; fi
>>    - .travis/build-deps.sh > build-deps.log 2>&1 || (cat build-deps.log
>> && exit 1)
>>
>> +before_script:
>> +  - .travis/coverity.sh
>> +
>>  script:
>>    - .travis/build-check.sh
>> diff --git a/.travis/coverity.sh b/.travis/coverity.sh
>> new file mode 100755
>> index 0000000..8bb40f4
>> --- /dev/null
>> +++ b/.travis/coverity.sh
>> @@ -0,0 +1,17 @@
>> +#!/bin/sh
>> +set -eu
>> +
>> +RUN_COVERITY=3D"${RUN_COVERITY:-0}"
>> +
>> +export COVERITY_SCAN_PROJECT_NAME=3D"OpenVPN/openvpn"
>> +export COVERITY_SCAN_BRANCH_PATTERN=3D"release\/2.4"
>> +export COVERITY_SCAN_NOTIFICATION_EMAIL=3D"scan-reports@...515..."
>> +export COVERITY_SCAN_BUILD_COMMAND_PREPEND=3D"autoreconf -vi &&
>> ./configure --enable-iproute2 && make clean"
>> +export COVERITY_SCAN_BUILD_COMMAND=3D"make"
>> +
>> +if [ "${RUN_COVERITY}" =3D "1" ]; then
>> +    # Ignore exit code, script exits with 1 if we're not on the right
>> branch
>> +    curl -s "https://scan.coverity.com/scripts/travisci_build_coverity_
>> scan.sh" | bash || true
>> +else
>> +    echo "Skipping coverity scan because \$RUN_COVERITY !=3D \"1\""
>> +fi
>> --
>> 2.7.4
>>
>>
>> ------------------------------------------------------------
>> ------------------
>> Check out the vibrant tech community on one of the world's most
>> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
>
>

--001a1147bd7ed7477d05564b9b12
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-08-09 10:41 GMT+05:00 =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=
=D0=B8=D1=86=D0=B8=D0=BD <span dir=3D"ltr">&lt;<a href=3D"mailto:chipitsine=
@...277..." target=3D"_blank">chipitsine@...277...</a>&gt;</span>:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><br><div clas=
s=3D"gmail_extra"><br><div class=3D"gmail_quote"><span class=3D"gmail-">201=
7-08-08 20:55 GMT+05:00 Steffan Karger <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:steffan.karger@...1435..." target=3D"_blank">steffan.karger@...1435...<=
/a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Enable=
 coverity analysis for the release/2.4 branch.<br>
<br>
We can only do a limited number of coverity scans per week with our FOSS<br>
account, but since we only occasionally push commits, that should work out<=
br>
fine.=C2=A0 But this limit is the reason we don&#39;t use the standard trav=
is addon,<br>
because that would cause the coverity script to run on all of our matrix<br>
builds.=C2=A0 That would cause us to reach our limit faster, and waste trav=
is&#39;<br>
resources.<br>
<br>
Since our FOSS coverity account doesn&#39;t handle multiple branches very w=
ell,<br>
we have to pick one branch to run coverity on.=C2=A0 I think it&#39;s best =
to use<br>
the most recent stable branch for that (i.e. for now, release/2.4).<br>
Though for ease of maintenance, it&#39;s probably best to apply the patch t=
o<br>
both master and release/2.4.<br></blockquote><div><br><br></div></span><div=
>I would refactor it like that <a href=3D"https://gist.github.com/chipitsin=
e/8dcae4ff1d59eb43df39f6015c6106fd" target=3D"_blank">https://gist.github.c=
om/<wbr>chipitsine/<wbr>8dcae4ff1d59eb43df39f6015c6106<wbr>fd</a><br></div>=
<div>however, your is ok as well<br></div></div></div></div></blockquote><d=
iv><br><br></div><div>maybe, &quot;script&quot; would be better here <a hre=
f=3D"https://gist.github.com/chipitsine/8dcae4ff1d59eb43df39f6015c6106fd#fi=
le-gistfile1-txt-L74">https://gist.github.com/chipitsine/8dcae4ff1d59eb43df=
39f6015c6106fd#file-gistfile1-txt-L74</a> than &quot;before_script&quot;<br=
></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div>=
</div><div><div class=3D"gmail-h5"><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
<br>
Signed-off-by: Steffan Karger &lt;<a href=3D"mailto:steffan.karger@...2191...=
.." target=3D"_blank">steffan.karger@...1435...</a>&gt;<br>
---<br>
=C2=A0.travis.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 8 +++++++-<br>
=C2=A0.travis/coverity.sh | 17 +++++++++++++++++<br>
=C2=A02 files changed, 24 insertions(+), 1 deletion(-)<br>
=C2=A0create mode 100755 .travis/coverity.sh<br>
<br>
diff --git a/.travis.yml b/.travis.yml<br>
index db90e03..131d002 100644<br>
--- a/.travis.yml<br>
+++ b/.travis.yml<br>
@@ -21,10 +21,13 @@ env:<br>
=C2=A0 =C2=A0 =C2=A0- OPENSSL_VERSION=3D&quot;1.0.2k&quot;<br>
=C2=A0 =C2=A0 =C2=A0- OPENSSL_CFLAGS=3D&quot;-I${PREFIX}/in<wbr>clude&quot;=
<br>
=C2=A0 =C2=A0 =C2=A0- OPENSSL_LIBS=3D&quot;-L${PREFIX}/lib -lssl -lcrypto&q=
uot;<br>
+=C2=A0 =C2=A0 # The next declaration is the encrypted COVERITY_SCAN_TOKEN,=
 created<br>
+=C2=A0 =C2=A0 #=C2=A0 =C2=A0via the &quot;travis encrypt&quot; command usi=
ng the project repo&#39;s public key<br>
+=C2=A0 =C2=A0 - secure: &quot;l9mSnEW4LJqjxftH5i1NdDaYfGmQB<wbr>1mPXnSB3DX=
nsjzkCWZ+yJLfBemfQ0t<wbr>x/wS7chBYxqUaUIMT0hw4zJVp/LANF<wbr>Jo2vfh//ymTS6h0=
uApRY1ofg9Pp1BF<wbr>cV1laG6/u8pwSZ2EBy/GhCd3DS436o<wbr>E8sYBRaFM9FU62L/oeQB=
fJ7r4ID/0e<wbr>B1b8bqlbD4paty9MHui2P8EZJwR+KA<wbr>D84prtfpZOcrSMxPh9OUhJxzx=
UvvVo<wbr>P4s4+lZ5Kgg1bBQ3yzKGDqe8VOgK2B<wbr>WCEuezqhMMc8oeKmAe7CUkoz5gsGYH=
<wbr>++k3I9XzP9Z4xeJKoQnC/82qi4xkJm<wbr>laOxdionej9bHIcjfRt7D8j1J0U+wO<wbr>=
j4p8VrDy7yHaxuN2fi0K5MGa/CaXQS<wbr>rkna8dePniCng+xQ2MY/zxuRX2gA6x<wbr>PNLUy=
QLU9LqIug7wj4z84Hk9iWib4L<wbr>20MoPjeEo+vAUNq8FtjOPxMuHNpv4i<wbr>GGx6kgJm7R=
Xl5vC5hxfK6MprrnYe2U<wbr>5Mcd8jpzagKBaKHL3zV2FxX9k0jRO9<wbr>Mccz7M2WnaV0MQ6=
zcngzTN4+s0kCjh<wbr>fGKd2F2ANT2Gkhj3Me36eNHfuE0dBb<wbr>vYCMh4b3Mgd7b/OuXwQW=
dJ8PjJ1WHX<wbr>jSOw5sHw1suaV6cEO2Meyz5j1tOkyO<wbr>i0M9QF+LFenQ9vLH4sBCww8U=
=3D&quot;<br>
<br>
=C2=A0matrix:<br>
=C2=A0 =C2=A0include:<br>
-=C2=A0 =C2=A0 - env: SSLLIB=3D&quot;openssl&quot;<br>
+=C2=A0 =C2=A0 - env: SSLLIB=3D&quot;openssl&quot; RUN_COVERITY=3D&quot;1&q=
uot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0os: linux<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0compiler: gcc<br>
=C2=A0 =C2=A0 =C2=A0- env: SSLLIB=3D&quot;openssl&quot; OPENSSL_VERSION=3D&=
quot;1.1.0f&quot;<br>
@@ -91,5 +94,8 @@ install:<br>
=C2=A0 =C2=A0- if [ ! -z &quot;${CHOST}&quot; ]; then unset CC; fi<br>
=C2=A0 =C2=A0- .travis/build-deps.sh &gt; build-deps.log 2&gt;&amp;1 || (ca=
t build-deps.log &amp;&amp; exit 1)<br>
<br>
+before_script:<br>
+=C2=A0 - .travis/coverity.sh<br>
+<br>
=C2=A0script:<br>
=C2=A0 =C2=A0- .travis/build-check.sh<br>
diff --git a/.travis/coverity.sh b/.travis/coverity.sh<br>
new file mode 100755<br>
index 0000000..8bb40f4<br>
--- /dev/null<br>
+++ b/.travis/coverity.sh<br>
@@ -0,0 +1,17 @@<br>
+#!/bin/sh<br>
+set -eu<br>
+<br>
+RUN_COVERITY=3D&quot;${RUN_COVERITY:<wbr>-0}&quot;<br>
+<br>
+export COVERITY_SCAN_PROJECT_NAME=3D&quot;Op<wbr>enVPN/openvpn&quot;<br>
+export COVERITY_SCAN_BRANCH_PATTERN=3D&quot;<wbr>release\/2.4&quot;<br>
+export COVERITY_SCAN_NOTIFICATION_EMA<wbr>IL=3D&quot;<a href=3D"mailto:sca=
n-reports@...515..." target=3D"_blank">scan-reports@...515...</a>&quot;<br>
+export COVERITY_SCAN_BUILD_COMMAND_PR<wbr>EPEND=3D&quot;autoreconf -vi &am=
p;&amp; ./configure --enable-iproute2 &amp;&amp; make clean&quot;<br>
+export COVERITY_SCAN_BUILD_COMMAND=3D&quot;m<wbr>ake&quot;<br>
+<br>
+if [ &quot;${RUN_COVERITY}&quot; =3D &quot;1&quot; ]; then<br>
+=C2=A0 =C2=A0 # Ignore exit code, script exits with 1 if we&#39;re not on =
the right branch<br>
+=C2=A0 =C2=A0 curl -s &quot;<a href=3D"https://scan.coverity.com/scripts/t=
ravisci_build_coverity_scan.sh" rel=3D"noreferrer" target=3D"_blank">https:=
//scan.coverity.com/scr<wbr>ipts/travisci_build_coverity_<wbr>scan.sh</a>&q=
uot; | bash || true<br>
+else<br>
+=C2=A0 =C2=A0 echo &quot;Skipping coverity scan because \$RUN_COVERITY !=
=3D \&quot;1\&quot;&quot;<br>
+fi<br>
<span class=3D"gmail-m_-1826432574035277617gmail-HOEnZb"><font color=3D"#88=
8888">--<br>
2.7.4<br>
<br>
<br>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, Slashdot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@...1483...<wbr>e.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
</font></span></blockquote></div></div></div><br></div></div>
</blockquote></div><br></div></div>

--001a1147bd7ed7477d05564b9b12--

