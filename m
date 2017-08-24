MIME-Version: 1.0
In-Reply-To: <CAFHpkQHi0==66QDo8zVkktdCS4evKhQBkpkTZLbnt0WPMpXzsQ@...278...>
References: <20170824133305.25604-1-a@...2181...>
 <CAFHpkQEJefeuqwbfy638M0AYO4EvcN8tamQQAHfxH-uPDwm=+g@...278...>
 <CAFHpkQHi0==66QDo8zVkktdCS4evKhQBkpkTZLbnt0WPMpXzsQ@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 24 Aug 2017 19:37:37 +0500
Message-ID: <CAFHpkQFfWXACzHXuxXDDHOiZSQRaFro=QJoEcfcSx01Ao-m9iw@...278...>
Content-Type: multipart/alternative; boundary="94eb2c05aab426844f055780c5cb"
Subject: Re: [Openvpn-devel] [PATCH] bash: substitute legacy `` with modern
 $()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--94eb2c05aab426844f055780c5cb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

openvpn is also built on many non bash systems. what about them?

24 =D0=B0=D0=B2=D0=B3. 2017 =D0=B3. 18:34 =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=
=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C "Antonio Quartulli" <a@...2181...>
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:

The backquotes for command substitution in bash are
considered old-style in favour of the more modern $() [1].
Substitute them.

[1]https://www.gnu.org/software/bash/manual/html_node/Command-Substitution.
html#Command-Substitution

Signed-off-by: Antonio Quartulli <a@...2181...>
---

note: I did not really know how to test this patch.

 dev-tools/gen-release-tarballs.sh | 10 +++++-----
 tests/t_cltsrv.sh                 |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/dev-tools/gen-release-tarballs.sh b/dev-tools/gen-release-
tarballs.sh
index f9c620e3..550e5cd2 100755
--- a/dev-tools/gen-release-tarballs.sh
+++ b/dev-tools/gen-release-tarballs.sh
@@ -49,7 +49,7 @@ if [ $? -ne 0 ]; then
 fi

 # Extract the git URL
-giturl=3D"`git remote get-url $arg_remote_name 2>/dev/null`"
+giturl=3D"$(git remote get-url $arg_remote_name 2>/dev/null)"
 if [ $? -ne 0 ]; then
     echo "** ERROR ** Invalid git remote name: $arg_remote_name"
     exit 2
@@ -71,7 +71,7 @@ get_filename()
 {
     local wildcard=3D"$1"

-    res=3D"`find . -maxdepth 1 -type f -name \"$wildcard\" | head -n1 | cut
-d/ -f2-`"
+    res=3D"$(find . -maxdepth 1 -type f -name \"$wildcard\" | head -n1 | c=
ut
-d/ -f2-)"
     if [ $? -ne 0 ]; then
         echo "-- 'find' failed."
         exit 5
@@ -88,7 +88,7 @@ copy_files()
     local fileext=3D"$1"
     local dest=3D"$2"

-    file=3D"`get_filename openvpn-*.*.*.$fileext`"
+    file=3D"$(get_filename openvpn-*.*.*.$fileext)"
     if [ -z "$file" ]; then
         echo "** ERROR Failed to find source file"
         exit 5
@@ -106,7 +106,7 @@ sign_file()
     local signkey=3D"$1"
     local srchfile=3D"$2"
     local signtype=3D"$3"
-    local file=3D"`get_filename $srchfile`"
+    local file=3D"$(get_filename $srchfile)"

     echo "-- Signing $file ..."
     case "$signtype" in
@@ -169,7 +169,7 @@ fi
 #

 # Clone the remote repository
-workdir=3D"`mktemp -d -p /var/tmp openvpn-build-release-XXXXXX`"
+workdir=3D"$(mktemp -d -p /var/tmp openvpn-build-release-XXXXXX)"
 cd $workdir
 echo "-- Working directory: $workdir"
 echo "-- git clone $giturl"
diff --git a/tests/t_cltsrv.sh b/tests/t_cltsrv.sh
index 752251e4..1ab3db3e 100755
--- a/tests/t_cltsrv.sh
+++ b/tests/t_cltsrv.sh
@@ -25,14 +25,14 @@ top_builddir=3D"${top_builddir:-..}"
 trap "rm -f log.$$ log.$$.signal ; trap 0 ; exit 77" 1 2 15
 trap "rm -f log.$$ log.$$.signal ; exit 1" 0 3
 addopts=3D
-case `uname -s` in
+case $(uname -s) in
     FreeBSD)
     # FreeBSD jails map the outgoing IP to the jail IP - we need to
     # allow the real IP unless we want the test to run forever.
-    if test "`sysctl 2>/dev/null -n security.jail.jailed`" =3D 1 \
+    if test "$(sysctl 2>/dev/null -n security.jail.jailed)" =3D 1 \
     || ps -ostate=3D -p $$ | grep -q J; then
        addopts=3D"--float"
-       if test "x`ifconfig | grep inet`" =3D x ; then
+       if test "x$(ifconfig | grep inet)" =3D x ; then
            echo "###"
            echo "### To run the test in a FreeBSD jail, you MUST add an IP
alias for the jail's IP."
            echo "###"
--
2.14.1


------------------------------------------------------------
------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--94eb2c05aab426844f055780c5cb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">openvpn is also built on many non bash systems. what abou=
t them?</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">24 =
=D0=B0=D0=B2=D0=B3. 2017 =D0=B3. 18:34 =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=
=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C &quot;Antonio Quartulli&quot; &lt;a@...1186...=
.2181...&gt; =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:<br type=3D"attribu=
tion"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">The backquotes for command substitution in b=
ash are<br>
considered old-style in favour of the more modern $() [1].<br>
Substitute them.<br>
<br>
[1]<a href=3D"https://www.gnu.org/software/bash/manual/html_node/Command-Su=
bstitution.html#Command-Substitution" rel=3D"noreferrer" target=3D"_blank">=
https://www.gnu.org/<wbr>software/bash/manual/html_<wbr>node/Command-Substi=
tution.<wbr>html#Command-Substitution</a><br>
<br>
Signed-off-by: Antonio Quartulli &lt;a@...2181...&gt;<br>
---<br>
<br>
note: I did not really know how to test this patch.<br>
<br>
=C2=A0dev-tools/gen-release-<wbr>tarballs.sh | 10 +++++-----<br>
=C2=A0tests/t_cltsrv.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 6 +++---<br>
=C2=A02 files changed, 8 insertions(+), 8 deletions(-)<br>
<br>
diff --git a/dev-tools/gen-release-<wbr>tarballs.sh b/dev-tools/gen-release=
-<wbr>tarballs.sh<br>
index f9c620e3..550e5cd2 100755<br>
--- a/dev-tools/gen-release-<wbr>tarballs.sh<br>
+++ b/dev-tools/gen-release-<wbr>tarballs.sh<br>
@@ -49,7 +49,7 @@ if [ $? -ne 0 ]; then<br>
=C2=A0fi<br>
<br>
=C2=A0# Extract the git URL<br>
-giturl=3D&quot;`git remote get-url $arg_remote_name 2&gt;/dev/null`&quot;<=
br>
+giturl=3D&quot;$(git remote get-url $arg_remote_name 2&gt;/dev/null)&quot;=
<br>
=C2=A0if [ $? -ne 0 ]; then<br>
=C2=A0 =C2=A0 =C2=A0echo &quot;** ERROR ** Invalid git remote name: $arg_re=
mote_name&quot;<br>
=C2=A0 =C2=A0 =C2=A0exit 2<br>
@@ -71,7 +71,7 @@ get_filename()<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0local wildcard=3D&quot;$1&quot;<br>
<br>
-=C2=A0 =C2=A0 res=3D&quot;`find . -maxdepth 1 -type f -name \&quot;$wildca=
rd\&quot; | head -n1 | cut -d/ -f2-`&quot;<br>
+=C2=A0 =C2=A0 res=3D&quot;$(find . -maxdepth 1 -type f -name \&quot;$wildc=
ard\&quot; | head -n1 | cut -d/ -f2-)&quot;<br>
=C2=A0 =C2=A0 =C2=A0if [ $? -ne 0 ]; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;-- &#39;find&#39; failed.&quot=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 5<br>
@@ -88,7 +88,7 @@ copy_files()<br>
=C2=A0 =C2=A0 =C2=A0local fileext=3D&quot;$1&quot;<br>
=C2=A0 =C2=A0 =C2=A0local dest=3D&quot;$2&quot;<br>
<br>
-=C2=A0 =C2=A0 file=3D&quot;`get_filename openvpn-*.*.*.$fileext`&quot;<br>
+=C2=A0 =C2=A0 file=3D&quot;$(get_filename openvpn-*.*.*.$fileext)&quot;<br>
=C2=A0 =C2=A0 =C2=A0if [ -z &quot;$file&quot; ]; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo &quot;** ERROR Failed to find source=
 file&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exit 5<br>
@@ -106,7 +106,7 @@ sign_file()<br>
=C2=A0 =C2=A0 =C2=A0local signkey=3D&quot;$1&quot;<br>
=C2=A0 =C2=A0 =C2=A0local srchfile=3D&quot;$2&quot;<br>
=C2=A0 =C2=A0 =C2=A0local signtype=3D&quot;$3&quot;<br>
-=C2=A0 =C2=A0 local file=3D&quot;`get_filename $srchfile`&quot;<br>
+=C2=A0 =C2=A0 local file=3D&quot;$(get_filename $srchfile)&quot;<br>
<br>
=C2=A0 =C2=A0 =C2=A0echo &quot;-- Signing $file ...&quot;<br>
=C2=A0 =C2=A0 =C2=A0case &quot;$signtype&quot; in<br>
@@ -169,7 +169,7 @@ fi<br>
=C2=A0#<br>
<br>
=C2=A0# Clone the remote repository<br>
-workdir=3D&quot;`mktemp -d -p /var/tmp openvpn-build-release-XXXXXX`&quot;=
<br>
+workdir=3D&quot;$(mktemp -d -p /var/tmp openvpn-build-release-XXXXXX)&quot=
;<br>
=C2=A0cd $workdir<br>
=C2=A0echo &quot;-- Working directory: $workdir&quot;<br>
=C2=A0echo &quot;-- git clone $giturl&quot;<br>
diff --git a/tests/t_cltsrv.sh b/tests/t_cltsrv.sh<br>
index 752251e4..1ab3db3e 100755<br>
--- a/tests/t_cltsrv.sh<br>
+++ b/tests/t_cltsrv.sh<br>
@@ -25,14 +25,14 @@ top_builddir=3D&quot;${top_builddir:-<wbr>..}&quot;<br>
=C2=A0trap &quot;rm -f log.$$ log.$$.signal ; trap 0 ; exit 77&quot; 1 2 15=
<br>
=C2=A0trap &quot;rm -f log.$$ log.$$.signal ; exit 1&quot; 0 3<br>
=C2=A0addopts=3D<br>
-case `uname -s` in<br>
+case $(uname -s) in<br>
=C2=A0 =C2=A0 =C2=A0FreeBSD)<br>
=C2=A0 =C2=A0 =C2=A0# FreeBSD jails map the outgoing IP to the jail IP - we=
 need to<br>
=C2=A0 =C2=A0 =C2=A0# allow the real IP unless we want the test to run fore=
ver.<br>
-=C2=A0 =C2=A0 if test &quot;`sysctl 2&gt;/dev/null -n security.jail.jailed=
`&quot; =3D 1 \<br>
+=C2=A0 =C2=A0 if test &quot;$(sysctl 2&gt;/dev/null -n security.jail.jaile=
d)&quot; =3D 1 \<br>
=C2=A0 =C2=A0 =C2=A0|| ps -ostate=3D -p $$ | grep -q J; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 addopts=3D&quot;--float&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if test &quot;x`ifconfig | grep inet`&quot; =3D=
 x ; then<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if test &quot;x$(ifconfig | grep inet)&quot; =
=3D x ; then<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;###&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;### To run the test in=
 a FreeBSD jail, you MUST add an IP alias for the jail&#39;s IP.&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 echo &quot;###&quot;<br>
<font color=3D"#888888">--<br>
2.14.1<br>
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
</font></blockquote></div><br></div>

--94eb2c05aab426844f055780c5cb--

