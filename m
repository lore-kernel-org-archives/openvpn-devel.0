MIME-Version: 1.0
In-Reply-To: <a2e7511e-2416-cfbc-4b0f-5ffcf8f15e17@...2080...>
References: <20170807132301.22759-1-chipitsine@...277...>
 <20170807132301.22759-3-chipitsine@...277...>
 <a2e7511e-2416-cfbc-4b0f-5ffcf8f15e17@...2080...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 7 Aug 2017 23:25:21 +0500
Message-ID: <CAFHpkQHkXWR512UXjQiTFf78fOJE+9_xo6fpYvhm8xRS8y3Aqg@...278...>
Content-Type: multipart/alternative; boundary="001a1147bd7e45909205562df8a6"
Subject: Re: [Openvpn-devel] [PATCH 3/3] add a test to "openvpn --help"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--001a1147bd7e45909205562df8a6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

7 =D0=B0=D0=B2=D0=B3. 2017 =D0=B3. 20:34 =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=
=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C "David Sommerseth" <
openvpn@...2080...> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:

On 07/08/17 15:23, Ilya Shipitsin wrote:
> inspired by https://www.mail-archive.com/openvpn-devel@...1199...
sourceforge.net/msg13808.html
> ---
>  tests/Makefile.am |  2 +-
>  tests/t_usage.sh  | 29 +++++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 1 deletion(-)
>  create mode 100755 tests/t_usage.sh
>
> diff --git a/tests/Makefile.am b/tests/Makefile.am
> index 0795680c..7306d1d1 100644
> --- a/tests/Makefile.am
> +++ b/tests/Makefile.am
> @@ -14,7 +14,7 @@ MAINTAINERCLEANFILES =3D \
>
>  SUBDIRS =3D unit_tests
>
> -test_scripts =3D t_client.sh
> +test_scripts =3D t_client.sh t_usage.sh
>  if ENABLE_CRYPTO
>  test_scripts +=3D t_lpback.sh t_cltsrv.sh
>  endif
> diff --git a/tests/t_usage.sh b/tests/t_usage.sh
> new file mode 100755
> index 00000000..f4845468
> --- /dev/null
> +++ b/tests/t_usage.sh
> @@ -0,0 +1,29 @@
> +#!/bin/sh
> +#
> +# run "openvpn --help"
> +# - check that openvpn did not crash
> +#
> +# prerequisites:
> +# - openvpn binary in current directory
> +#
> +# inspired by https://www.mail-archive.com/openvpn-devel@...1199...
sourceforge.net/msg13808.html
> +#
> +
> +top_builddir=3D"${top_builddir:-..}"
> +
> +if [ ! -x "${top_builddir}/src/openvpn/openvpn" ]
> +then
> +    echo "no (executable) openvpn binary in current build tree. FAIL."
>&2
> +    exit 1
> +fi
> +
> +exit_code=3D0
> +
> +"${top_builddir}/src/openvpn/openvpn" --help >/dev/null
> +
> +if [ $? -ne 1 ]
> +then
> +   exit_code=3D1
> +fi

This check is odd.  Where the --help option is parsed, it calls usage(),
usage_small().  And those functions will always call:


Sometimes it segfaults.



   openvpn_exit(OPENVPN_EXIT_STATUS_USAGE);

And OPENVPN_EXIT_STATUS_USAGE is defined as:

error.h:#define OPENVPN_EXIT_STATUS_USAGE                   1

I would rather recommend you to grep for some information you expect to
be listed in --help and check if that was found instead.


I tried to implement it with cmocka. However, I gave up




For example:

$ ./openvpn --help | grep -- ^-- | wc -l
238

As we might vary number of options from time to time, I wouldn't check
against 238.  But that it should be above 220 in the foreseeable future
would not be an unreasonable assumption.  *BUT* the number of options
might differ more in some other builds (depending on
--enable-*/--disable-* arguments given to ./configure).


--
kind regards,

David Sommerseth
OpenVPN Technologies, Inc

--001a1147bd7e45909205562df8a6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">7 =D0=B0=D0=B2=D0=B3. 2017 =D0=B3. 20:34 =D0=BF=D0=BE=D0=BB=D1=8C=
=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C &quot;David Sommerseth&quo=
t; &lt;<a href=3D"mailto:openvpn@...2080...">openvpn@...2080...</a>&gt; =D0=
=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:<br type=3D"attribution"><blockquot=
e class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex"><div class=3D"elided-text">On 07/08/17 15:23, Ilya Shipitsin=
 wrote:<br>
&gt; inspired by <a href=3D"https://www.mail-archive.com/openvpn-devel@...1514...=
s.sourceforge.net/msg13808.html" rel=3D"noreferrer" target=3D"_blank">https=
://www.mail-archive.com/<wbr>openvpn-devel@...1199...<wbr>sourceforge.net/m=
sg13808.html</a><br>
&gt; ---<br>
&gt;=C2=A0 tests/Makefile.am |=C2=A0 2 +-<br>
&gt;=C2=A0 tests/t_usage.sh=C2=A0 | 29 +++++++++++++++++++++++++++++<br>
&gt;=C2=A0 2 files changed, 30 insertions(+), 1 deletion(-)<br>
&gt;=C2=A0 create mode 100755 tests/t_usage.sh<br>
&gt;<br>
&gt; diff --git a/tests/Makefile.am b/tests/Makefile.am<br>
&gt; index 0795680c..7306d1d1 100644<br>
&gt; --- a/tests/Makefile.am<br>
&gt; +++ b/tests/Makefile.am<br>
&gt; @@ -14,7 +14,7 @@ MAINTAINERCLEANFILES =3D \<br>
&gt;<br>
&gt;=C2=A0 SUBDIRS =3D unit_tests<br>
&gt;<br>
&gt; -test_scripts =3D t_client.sh<br>
&gt; +test_scripts =3D t_client.sh t_usage.sh<br>
&gt;=C2=A0 if ENABLE_CRYPTO<br>
&gt;=C2=A0 test_scripts +=3D t_lpback.sh t_cltsrv.sh<br>
&gt;=C2=A0 endif<br>
&gt; diff --git a/tests/t_usage.sh b/tests/t_usage.sh<br>
&gt; new file mode 100755<br>
&gt; index 00000000..f4845468<br>
&gt; --- /dev/null<br>
&gt; +++ b/tests/t_usage.sh<br>
&gt; @@ -0,0 +1,29 @@<br>
&gt; +#!/bin/sh<br>
&gt; +#<br>
&gt; +# run &quot;openvpn --help&quot;<br>
&gt; +# - check that openvpn did not crash<br>
&gt; +#<br>
&gt; +# prerequisites:<br>
&gt; +# - openvpn binary in current directory<br>
&gt; +#<br>
&gt; +# inspired by <a href=3D"https://www.mail-archive.com/openvpn-devel@...465...=
ists.sourceforge.net/msg13808.html" rel=3D"noreferrer" target=3D"_blank">ht=
tps://www.mail-archive.com/<wbr>openvpn-devel@...1199...<wbr>sourceforge.ne=
t/msg13808.html</a><br>
&gt; +#<br>
&gt; +<br>
&gt; +top_builddir=3D&quot;${top_builddir:<wbr>-..}&quot;<br>
&gt; +<br>
&gt; +if [ ! -x &quot;${top_builddir}/src/openvpn/<wbr>openvpn&quot; ]<br>
&gt; +then<br>
&gt; +=C2=A0 =C2=A0 echo &quot;no (executable) openvpn binary in current bu=
ild tree. FAIL.&quot; &gt;&amp;2<br>
&gt; +=C2=A0 =C2=A0 exit 1<br>
&gt; +fi<br>
&gt; +<br>
&gt; +exit_code=3D0<br>
&gt; +<br>
&gt; +&quot;${top_builddir}/src/openvpn/<wbr>openvpn&quot; --help &gt;/dev/=
null<br>
&gt; +<br>
&gt; +if [ $? -ne 1 ]<br>
&gt; +then<br>
&gt; +=C2=A0 =C2=A0exit_code=3D1<br>
&gt; +fi<br>
<br>
</div>This check is odd.=C2=A0 Where the --help option is parsed, it calls =
usage(),<br>
usage_small().=C2=A0 And those functions will always call:<br></blockquote>=
</div></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Sometimes i=
t segfaults.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><=
div dir=3D"auto"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blo=
ckquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<br>
=C2=A0 =C2=A0openvpn_exit(OPENVPN_EXIT_<wbr>STATUS_USAGE);<br>
<br>
And OPENVPN_EXIT_STATUS_USAGE is defined as:<br>
<br>
error.h:#define OPENVPN_EXIT_STATUS_USAGE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A01<br>
<br>
I would rather recommend you to grep for some information you expect to<br>
be listed in --help and check if that was found instead.<br></blockquote></=
div></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">I tried to im=
plement it with cmocka. However, I gave up</div><div dir=3D"auto"><br></div=
><div dir=3D"auto"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><b=
lockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex"><br><br><br>
For example:<br>
<br>
$ ./openvpn --help | grep -- ^-- | wc -l<br>
238<br>
<br>
As we might vary number of options from time to time, I wouldn&#39;t check<=
br>
against 238.=C2=A0 But that it should be above 220 in the foreseeable futur=
e<br>
would not be an unreasonable assumption.=C2=A0 *BUT* the number of options<=
br>
might differ more in some other builds (depending on<br>
--enable-*/--disable-* arguments given to ./configure).<br>
<font color=3D"#888888"><br>
<br>
--<br>
kind regards,<br>
<br>
David Sommerseth<br>
OpenVPN Technologies, Inc<br>
<br>
<br>
</font></blockquote></div><br></div></div></div>

--001a1147bd7e45909205562df8a6--

