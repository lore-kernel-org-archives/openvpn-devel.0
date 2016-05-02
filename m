MIME-Version: 1.0
In-Reply-To: <CAFHpkQHzTQSUqLP2o=x5LPDWJrPtaUVo5JDfsFfhFUK_P4FbQA@...278...>
References: <CAFHpkQENgyAaaWCsWOS1vj+9YR=Cc65muXmsYfmcKc8n09BkPQ@...278...>
	<5727056E.1000701@...515...>
	<CAFHpkQEtWE-4MJ_djqgQtqXSJTKxkfEXnOoAbhebYGwmLKwR-Q@...278...>
	<CAFHpkQHzTQSUqLP2o=x5LPDWJrPtaUVo5JDfsFfhFUK_P4FbQA@...278...>
Date: Mon, 2 May 2016 12:51:28 +0500
Message-ID: <CAFHpkQFwQFn4B6AQzNuBAmaY1OyKLhrysXbQiatSGQazkNRt3Q@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Content-Type: multipart/alternative; boundary=047d7bacb0aa9577640531d74249
Subject: Re: [Openvpn-devel] CI for openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--047d7bacb0aa9577640531d74249
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I can prepare .travis.yml for openvpn, however, I'm not prepared for "pack
your commit so and so... We are short on time to merge it"

Is it ok if I send .travis.yml to you? Can you proceed with commit/review
procedure?
2 =D0=BC=D0=B0=D1=8F 2016 =D0=B3. 12:44 =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=
=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C "Samuli Sepp=C3=A4nen" <samuli@...1696...=
15...>
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:


Hello,
>
> I just run cppcheck and ...
>
> [src/openvpnserv/interactive.c:601]: (error) Memory pointed to by
> 'addr_row' is freed twice.
> [src/openvpnserv/interactive.c:700]: (error) Memory pointed to by
> 'fwd_row' is freed twice.
> [src/openvpnserv/interactive.c:1329]: (error) Common realloc mistake:
> 'handles' nulled but not freed upon failure
>
> I suggest to either
>
> 1) add travis-ci support (there are few tests in "t" and we can run
> cppcheck)
> 2) add cppcheck to buildbot (however it is not transparent, I've no idea
> where can I have a look at buildbot logs, for example)
>

I assume cppcheck produces the same results regardless of the
OS/distribution it is running on. If this is the case, then we should add
cppcheck tests to Travis-CI.

Using buildbot to running an identical check 150+ times per commit makes no
sense.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--047d7bacb0aa9577640531d74249
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">I can prepare .travis.yml for openvpn, however, I&#39;m not =
prepared for &quot;pack your commit so and so... We are short on time to me=
rge it&quot;</p>
<p dir=3D"ltr">Is it ok if I send .travis.yml to you? Can you proceed with =
commit/review procedure?</p>
<div class=3D"gmail_quote">2 =D0=BC=D0=B0=D1=8F 2016 =D0=B3. 12:44 =D0=BF=
=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C &quot;Sa=
muli Sepp=C3=A4nen&quot; &lt;<a href=3D"mailto:samuli@...515...">samuli@...493...=
515...</a>&gt; =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:<br type=3D"attri=
bution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex"><div class=3D"elided-text"><br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hello,<br>
<br>
I just run cppcheck and ...<br>
<br>
[src/openvpnserv/interactive.c:601]: (error) Memory pointed to by<br>
&#39;addr_row&#39; is freed twice.<br>
[src/openvpnserv/interactive.c:700]: (error) Memory pointed to by<br>
&#39;fwd_row&#39; is freed twice.<br>
[src/openvpnserv/interactive.c:1329]: (error) Common realloc mistake:<br>
&#39;handles&#39; nulled but not freed upon failure<br>
<br>
I suggest to either<br>
<br>
1) add travis-ci support (there are few tests in &quot;t&quot; and we can r=
un<br>
cppcheck)<br>
2) add cppcheck to buildbot (however it is not transparent, I&#39;ve no ide=
a<br>
where can I have a look at buildbot logs, for example)<br>
</blockquote>
<br></div>
I assume cppcheck produces the same results regardless of the OS/distributi=
on it is running on. If this is the case, then we should add cppcheck tests=
 to Travis-CI.<br>
<br>
Using buildbot to running an identical check 150+ times per commit makes no=
 sense.<font color=3D"#888888"><br>
<br>
-- <br>
Samuli Sepp=C3=A4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
</font></blockquote></div>

--047d7bacb0aa9577640531d74249--

