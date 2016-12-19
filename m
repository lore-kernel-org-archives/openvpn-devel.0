MIME-Version: 1.0
In-Reply-To: <e93e0d67-963a-d677-7d67-323b46e6c3c7@...515...>
References: <CAFHpkQEKrJqNB2ZmhAwKGebVb6SB75HpnWcrw_niSaALL_S4mA@...278...>
	<CAA1AbxJZL70qY=ivMvskeUapj0V_+z_LVnM2Zp2LxAJT4t62vA@...278...>
	<CAFHpkQEnATPgCyxsLW6bpC5Qr-Cdh=+4X4MRXxgUD+orKpq+EQ@...278...>
	<20161121174953.GM28918@...1296...>
	<CAFHpkQFZD+hYzq_FW075wQt5AopcyCP20BEDzLsTx5Vq6uko3Q@...278...>
	<d48609b7-43df-80d5-a57f-e96e85ad4389@...2080...>
	<CAFHpkQHxVWvHSFK2hS7CV8ytUnxUHi5ZfjSOiuLBfWdufzMrCQ@...278...>
	<9048486e-03d9-7aa1-74f8-892a9cc7c1ee@...515...>
	<CAFHpkQHtPm2gPfHYEngJoMymUxt8iOFA7L0z+p54oVSNEmEPFQ@...278...>
	<4ea0b775-5681-b908-f06d-9251d28e8c8a@...515...>
	<c41ad01c-d1a2-cf2c-4876-c22954ae90a9@...2080...>
	<e93e0d67-963a-d677-7d67-323b46e6c3c7@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 19 Dec 2016 18:59:45 +0500
Message-ID: <CAFHpkQFo-W_4_1_6vmBaDfLk8nTHE_=uCi7ZcGES+1iq0sTKxA@...278...>
Content-Type: multipart/alternative; boundary=047d7bf10b4e0d712905440355c6
Subject: Re: [Openvpn-devel] https://travis-ci.org/OpenVPN/openvpn/builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--047d7bf10b4e0d712905440355c6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2016-12-19 18:49 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:

> Il 19/12/2016 15:44, David Sommerseth ha scritto:
>
>> On 19/12/16 11:01, Samuli Sepp=C3=A4nen wrote:
>> [...snip...]
>>
>>> Right now cmocka tests are skipped if
>>>
>>> a) cmocka Git submodule is not initialized
>>> b) CMake is not installed
>>>
>>> See commit 45f6e7991cf for details.
>>>
>>> Travis logs say this:
>>>
>>> $ git clone --depth=3D50 --branch=3Dmaster
>>> https://github.com/OpenVPN/openvpn.git OpenVPN/openvpn
>>> $ git submodule update --init --recursive
>>>
>>> Which means that cmocka Git submodule gets sucked in automatically. So
>>> that leaves us with the following options afaics:
>>>
>>> 1) Remove the cmocka directory after the fact (rather nasty)
>>>
>>
>> In deed nasty.  Why not rather detect if it os OSX and skip the 'git
>> submodule' step?
>>
>
> Yes, this would suck much less.
>
> Chipitsine: could you have a look how this could be done? Basically we'd
> need to different Git command than the above if MacOS X is detected.



?

--- configure.ac.orig    2016-12-19 18:50:30.657739835 +0500
+++ configure.ac    2016-12-19 18:57:43.145828431 +0500
@@ -1268,7 +1268,12 @@
 AC_CHECK_PROGS([CMAKE], [cmake])
 if test -n "${CMAKE}"; then
    if test -f "${srcdir}/vendor/cmocka/CMakeLists.txt"; then
-      AM_CONDITIONAL([CMOCKA_INITIALIZED], [true])
+       if test "${TRAVIS_OS_NAME}" !=3D "osx"; then
+          AM_CONDITIONAL([CMOCKA_INITIALIZED], [true])
+       else
+          AM_CONDITIONAL([CMOCKA_INITIALIZED], [false])
+          AC_MSG_RESULT([!! WARNING !! The cmoka is turned off on osx due
to missing linker functions.  Unit testing cannot be performed.])
+       fi
    else
       AM_CONDITIONAL([CMOCKA_INITIALIZED], [false])
       AC_MSG_RESULT([!! WARNING !! The cmoka git submodule has not been
initialized or updated.  Unit testing cannot be performed.])



I've no idea how to detect osx, but it is rather easy on travis-ci


>
>
>
>
>>
>> 2) Ensure that CMake is not installed on MacOS X (does mbedTLS require
>>> this?)
>>>
>>
>> If mbedTLS is built from source, then I believe CMake is needed.
>>
>>
>> 3) Allow the user to select if cmocka tests are run or not
>>>
>>
>> Try to avoid adding more options ... rather try to have some reasonable
>> defaults which is auto-detected based on reasonable triggers (such as
>> distro/platform)
>>
>>
>>

--047d7bf10b4e0d712905440355c6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2016-12-19 18:49 GMT+05:00 Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt;<=
a target=3D"_blank" href=3D"mailto:samuli@...515...">samuli@...515...</a>&g=
t;</span>:<br><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote"><span class=
=3D"gmail-">Il 19/12/2016 15:44, David Sommerseth ha scritto:<br>
<blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex" class=3D"gmail_quote">
On 19/12/16 11:01, Samuli Sepp=C3=A4nen wrote:<br>
[...snip...]<br>
<blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex" class=3D"gmail_quote">
Right now cmocka tests are skipped if<br>
<br>
a) cmocka Git submodule is not initialized<br>
b) CMake is not installed<br>
<br>
See commit 45f6e7991cf for details.<br>
<br>
Travis logs say this:<br>
<br>
$ git clone --depth=3D50 --branch=3Dmaster<br>
<a target=3D"_blank" rel=3D"noreferrer" href=3D"https://github.com/OpenVPN/=
openvpn.git">https://github.com/OpenVPN/ope<wbr>nvpn.git</a> OpenVPN/openvp=
n<br>
$ git submodule update --init --recursive<br>
<br>
Which means that cmocka Git submodule gets sucked in automatically. So<br>
that leaves us with the following options afaics:<br>
<br>
1) Remove the cmocka directory after the fact (rather nasty)<br>
</blockquote>
<br>
In deed nasty.=C2=A0 Why not rather detect if it os OSX and skip the &#39;g=
it<br>
submodule&#39; step?<br>
</blockquote>
<br></span>
Yes, this would suck much less.<br>
<br>
Chipitsine: could you have a look how this could be done? Basically we&#39;=
d need to different Git command than the above if MacOS X is detected.</blo=
ckquote><div><br><br>?<br><br>--- configure.ac.orig=C2=A0=C2=A0=C2=A0 2016-=
12-19 18:50:30.657739835 +0500<br>+++ <a href=3D"http://configure.ac">confi=
gure.ac</a>=C2=A0=C2=A0=C2=A0 2016-12-19 18:57:43.145828431 +0500<br>@@ -12=
68,7 +1268,12 @@<br>=C2=A0AC_CHECK_PROGS([CMAKE], [cmake])<br>=C2=A0if test=
 -n &quot;${CMAKE}&quot;; then<br>=C2=A0=C2=A0=C2=A0 if test -f &quot;${src=
dir}/vendor/cmocka/CMakeLists.txt&quot;; then<br>-=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 AM_CONDITIONAL([CMOCKA_INITIALIZED], [true])<br>+=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if test &quot;${TRAVIS_OS_NAME}&quot; !=3D &quot;osx&quo=
t;; then<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AM_COND=
ITIONAL([CMOCKA_INITIALIZED], [true])<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 else<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AM_COND=
ITIONAL([CMOCKA_INITIALIZED], [false])<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 AC_MSG_RESULT([!! WARNING !! The cmoka is turned o=
ff on osx due to missing linker functions.=C2=A0 Unit testing cannot be per=
formed.])<br>+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi<br>=C2=A0=C2=A0=C2=A0=
 else<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AM_CONDITIONAL([CMOCKA_INITIA=
LIZED], [false])<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AC_MSG_RESULT([!! =
WARNING !! The cmoka git submodule has not been initialized or updated.=C2=
=A0 Unit testing cannot be performed.])<br><br><br><br></div><div>I&#39;ve =
no idea how to detect osx, but it is rather easy on travis-ci<br></div><div=
>=C2=A0</div><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote"><div class=
=3D"gmail-HOEnZb"><div class=3D"gmail-h5"><br>
<br>
<br>
<blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex" class=3D"gmail_quote">
<br>
<br>
<blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex" class=3D"gmail_quote">
2) Ensure that CMake is not installed on MacOS X (does mbedTLS require<br>
this?)<br>
</blockquote>
<br>
If mbedTLS is built from source, then I believe CMake is needed.<br>
<br>
<br>
<blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex" class=3D"gmail_quote">
3) Allow the user to select if cmocka tests are run or not<br>
</blockquote>
<br>
Try to avoid adding more options ... rather try to have some reasonable<br>
defaults which is auto-detected based on reasonable triggers (such as<br>
distro/platform)<br>
<br>
<br>
</blockquote>
</div></div></blockquote></div><br></div></div>

--047d7bf10b4e0d712905440355c6--

