MIME-Version: 1.0
In-Reply-To: <1502207741-31750-1-git-send-email-steffan.karger@...1435...>
References: <1502207741-31750-1-git-send-email-steffan.karger@...1435...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 9 Aug 2017 10:41:08 +0500
Message-ID: <CAFHpkQG8Lw5Va2PHT=BA86z-WgXv2Lqe+r9Q+fBeFsgRniKSCw@...278...>
Content-Type: multipart/alternative; boundary="001a11419072dd48f205564b86ca"
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

--001a11419072dd48f205564b86ca
Content-Type: text/plain; charset="UTF-8"

2017-08-08 20:55 GMT+05:00 Steffan Karger <steffan.karger@...1435...>:

> Enable coverity analysis for the release/2.4 branch.
>
> We can only do a limited number of coverity scans per week with our FOSS
> account, but since we only occasionally push commits, that should work out
> fine.  But this limit is the reason we don't use the standard travis addon,
> because that would cause the coverity script to run on all of our matrix
> builds.  That would cause us to reach our limit faster, and waste travis'
> resources.
>
> Since our FOSS coverity account doesn't handle multiple branches very well,
> we have to pick one branch to run coverity on.  I think it's best to use
> the most recent stable branch for that (i.e. for now, release/2.4).
> Though for ease of maintenance, it's probably best to apply the patch to
> both master and release/2.4.
>


I would refactor it like that
https://gist.github.com/chipitsine/8dcae4ff1d59eb43df39f6015c6106fd
however, your is ok as well


>
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
>  .travis.yml         |  8 +++++++-
>  .travis/coverity.sh | 17 +++++++++++++++++
>  2 files changed, 24 insertions(+), 1 deletion(-)
>  create mode 100755 .travis/coverity.sh
>
> diff --git a/.travis.yml b/.travis.yml
> index db90e03..131d002 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -21,10 +21,13 @@ env:
>      - OPENSSL_VERSION="1.0.2k"
>      - OPENSSL_CFLAGS="-I${PREFIX}/include"
>      - OPENSSL_LIBS="-L${PREFIX}/lib -lssl -lcrypto"
> +    # The next declaration is the encrypted COVERITY_SCAN_TOKEN, created
> +    #   via the "travis encrypt" command using the project repo's public
> key
> +    - secure: "l9mSnEW4LJqjxftH5i1NdDaYfGmQB1mPXnSB3DXnsjzkCWZ+
> yJLfBemfQ0tx/wS7chBYxqUaUIMT0hw4zJVp/LANFJo2vfh//
> ymTS6h0uApRY1ofg9Pp1BFcV1laG6/u8pwSZ2EBy/GhCd3DS436oE8sYBRaFM9FU62L/
> oeQBfJ7r4ID/0eB1b8bqlbD4paty9MHui2P8EZJwR+KAD84prtfpZOcrSMxPh9OUhJxzxUvv
> VoP4s4+lZ5Kgg1bBQ3yzKGDqe8VOgK2BWCEuezqhMMc8oeKmAe7CUkoz5gsGYH++
> k3I9XzP9Z4xeJKoQnC/82qi4xkJmlaOxdionej9bHIcjfRt7D8j1J0U+
> wOj4p8VrDy7yHaxuN2fi0K5MGa/CaXQSrkna8dePniCng+xQ2MY/
> zxuRX2gA6xPNLUyQLU9LqIug7wj4z84Hk9iWib4L20MoPjeEo+
> vAUNq8FtjOPxMuHNpv4iGGx6kgJm7RXl5vC5hxfK6MprrnYe2U5Mcd8jpzag
> KBaKHL3zV2FxX9k0jRO9Mccz7M2WnaV0MQ6zcngzTN4+s0kCjhfGKd2F2ANT2Gkhj3Me36eNHf
> uE0dBbvYCMh4b3Mgd7b/OuXwQWdJ8PjJ1WHXjSOw5sHw1suaV6cEO2Meyz5j1tOkyOi0M9QF+
> LFenQ9vLH4sBCww8U="
>
>  matrix:
>    include:
> -    - env: SSLLIB="openssl"
> +    - env: SSLLIB="openssl" RUN_COVERITY="1"
>        os: linux
>        compiler: gcc
>      - env: SSLLIB="openssl" OPENSSL_VERSION="1.1.0f"
> @@ -91,5 +94,8 @@ install:
>    - if [ ! -z "${CHOST}" ]; then unset CC; fi
>    - .travis/build-deps.sh > build-deps.log 2>&1 || (cat build-deps.log &&
> exit 1)
>
> +before_script:
> +  - .travis/coverity.sh
> +
>  script:
>    - .travis/build-check.sh
> diff --git a/.travis/coverity.sh b/.travis/coverity.sh
> new file mode 100755
> index 0000000..8bb40f4
> --- /dev/null
> +++ b/.travis/coverity.sh
> @@ -0,0 +1,17 @@
> +#!/bin/sh
> +set -eu
> +
> +RUN_COVERITY="${RUN_COVERITY:-0}"
> +
> +export COVERITY_SCAN_PROJECT_NAME="OpenVPN/openvpn"
> +export COVERITY_SCAN_BRANCH_PATTERN="release\/2.4"
> +export COVERITY_SCAN_NOTIFICATION_EMAIL="scan-reports@...515..."
> +export COVERITY_SCAN_BUILD_COMMAND_PREPEND="autoreconf -vi &&
> ./configure --enable-iproute2 && make clean"
> +export COVERITY_SCAN_BUILD_COMMAND="make"
> +
> +if [ "${RUN_COVERITY}" = "1" ]; then
> +    # Ignore exit code, script exits with 1 if we're not on the right
> branch
> +    curl -s "https://scan.coverity.com/scripts/travisci_build_
> coverity_scan.sh" | bash || true
> +else
> +    echo "Skipping coverity scan because \$RUN_COVERITY != \"1\""
> +fi
> --
> 2.7.4
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

--001a11419072dd48f205564b86ca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-08-08 20:55 GMT+05:00 Steffan Karger <span dir=3D"ltr">&lt;<a href=
=3D"mailto:steffan.karger@...1435..." target=3D"_blank">steffan.karger@...1386...=
435...</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>Enable coverity analysis for the release/2.4 branch.<br>
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
both master and release/2.4.<br></blockquote><div><br><br></div><div>I woul=
d refactor it like that <a href=3D"https://gist.github.com/chipitsine/8dcae=
4ff1d59eb43df39f6015c6106fd">https://gist.github.com/chipitsine/8dcae4ff1d5=
9eb43df39f6015c6106fd</a><br></div><div>however, your is ok as well<br></di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Signed-off-by: Steffan Karger &lt;<a href=3D"mailto:steffan.karger@...2191...=
..">steffan.karger@...1435...</a>&gt;<br>
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
=C2=A0 =C2=A0 =C2=A0- OPENSSL_CFLAGS=3D&quot;-I${PREFIX}/<wbr>include&quot;=
<br>
=C2=A0 =C2=A0 =C2=A0- OPENSSL_LIBS=3D&quot;-L${PREFIX}/lib -lssl -lcrypto&q=
uot;<br>
+=C2=A0 =C2=A0 # The next declaration is the encrypted COVERITY_SCAN_TOKEN,=
 created<br>
+=C2=A0 =C2=A0 #=C2=A0 =C2=A0via the &quot;travis encrypt&quot; command usi=
ng the project repo&#39;s public key<br>
+=C2=A0 =C2=A0 - secure: &quot;<wbr>l9mSnEW4LJqjxftH5i1NdDaYfGmQB1<wbr>mPXn=
SB3DXnsjzkCWZ+<wbr>yJLfBemfQ0tx/<wbr>wS7chBYxqUaUIMT0hw4zJVp/<wbr>LANFJo2vf=
h//<wbr>ymTS6h0uApRY1ofg9Pp1BFcV1laG6/<wbr>u8pwSZ2EBy/<wbr>GhCd3DS436oE8sYB=
RaFM9FU62L/<wbr>oeQBfJ7r4ID/<wbr>0eB1b8bqlbD4paty9MHui2P8EZJwR+<wbr>KAD84pr=
tfpZOcrSMxPh9OUhJxzxUvv<wbr>VoP4s4+<wbr>lZ5Kgg1bBQ3yzKGDqe8VOgK2BWCEue<wbr>=
zqhMMc8oeKmAe7CUkoz5gsGYH++<wbr>k3I9XzP9Z4xeJKoQnC/<wbr>82qi4xkJmlaOxdionej=
9bHIcjfRt7D<wbr>8j1J0U+<wbr>wOj4p8VrDy7yHaxuN2fi0K5MGa/<wbr>CaXQSrkna8dePni=
Cng+xQ2MY/<wbr>zxuRX2gA6xPNLUyQLU9LqIug7wj4z8<wbr>4Hk9iWib4L20MoPjeEo+<wbr>=
vAUNq8FtjOPxMuHNpv4iGGx6kgJm7R<wbr>Xl5vC5hxfK6MprrnYe2U5Mcd8jpzag<wbr>KBaKH=
L3zV2FxX9k0jRO9Mccz7M2Wna<wbr>V0MQ6zcngzTN4+<wbr>s0kCjhfGKd2F2ANT2Gkhj3Me36=
eNHf<wbr>uE0dBbvYCMh4b3Mgd7b/<wbr>OuXwQWdJ8PjJ1WHXjSOw5sHw1suaV6<wbr>cEO2Me=
yz5j1tOkyOi0M9QF+<wbr>LFenQ9vLH4sBCww8U=3D&quot;<br>
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
+export COVERITY_SCAN_PROJECT_NAME=3D&quot;<wbr>OpenVPN/openvpn&quot;<br>
+export COVERITY_SCAN_BRANCH_PATTERN=3D&quot;<wbr>release\/2.4&quot;<br>
+export COVERITY_SCAN_NOTIFICATION_<wbr>EMAIL=3D&quot;<a href=3D"mailto:sca=
n-reports@...515...">scan-reports@...2292...<wbr>net</a>&quot;<br>
+export COVERITY_SCAN_BUILD_COMMAND_<wbr>PREPEND=3D&quot;autoreconf -vi &am=
p;&amp; ./configure --enable-iproute2 &amp;&amp; make clean&quot;<br>
+export COVERITY_SCAN_BUILD_COMMAND=3D&quot;<wbr>make&quot;<br>
+<br>
+if [ &quot;${RUN_COVERITY}&quot; =3D &quot;1&quot; ]; then<br>
+=C2=A0 =C2=A0 # Ignore exit code, script exits with 1 if we&#39;re not on =
the right branch<br>
+=C2=A0 =C2=A0 curl -s &quot;<a href=3D"https://scan.coverity.com/scripts/t=
ravisci_build_coverity_scan.sh" rel=3D"noreferrer" target=3D"_blank">https:=
//scan.coverity.com/<wbr>scripts/travisci_build_<wbr>coverity_scan.sh</a>&q=
uot; | bash || true<br>
+else<br>
+=C2=A0 =C2=A0 echo &quot;Skipping coverity scan because \$RUN_COVERITY !=
=3D \&quot;1\&quot;&quot;<br>
+fi<br>
<span class=3D"gmail-HOEnZb"><font color=3D"#888888">--<br>
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
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
</font></span></blockquote></div><br></div></div>

--001a11419072dd48f205564b86ca--

