MIME-Version: 1.0
References: <20191009143422.9419-3-a@...2181...>
 <201911062041.xA6KfP8R010468@...2054...>
 <CAGyAFMWBd2GzuZdBfTfGwROPw-hEzqSMUCUY3vrWENeqd1A46w@...278...>
 <20191107122743.GQ40538@...1296...>
In-Reply-To: <20191107122743.GQ40538@...1296...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 7 Nov 2019 14:42:17 +0200
Message-ID: <CAGyAFMU5VAWDPuR7V3dTMKBsDbn2vgH61sgn6O9dtZNi-OTebQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000a6aa4e0596c0ff7a"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: VLAN: add basic VLAN
 tagging support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Antonio Quartulli <a@...2181...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000a6aa4e0596c0ff7a
Content-Type: text/plain; charset="UTF-8"

Hi,


> I'm a bit unhappy with that one, as it changes behaviour for all
> non-windows
> builds (including all the openssl build output even if it succeeds).
>

The only place it changes behavior is this

 install:
   - if [ ! -z "${CHOST}" ]; then unset CC; fi
-  - .travis/build-deps.sh > build-deps.log 2>&1 || (cat build-deps.log &&
exit 1)
+  - .travis/build-deps.sh

I don't see it as an issue to print output when building dependencies. The
reason why
it is done is that travis aborts build if there is no output for more than
10 minutes.


> Besides this, we need to fix this whole MSVC mess - all other platforms
> are just done with "add new source file to the Makefile.ac" and done
> (including mingw builds), and then MSVC is broken again, and this will
> happen again and again.


> Is there no reasonable way to build these project files from Makefile.ac?
>

I see no reasonable way. Selva, Simon - opinions?

We could probably have a templatized project file and script which inserts
source files to there
based on content of Makefile.ac, but I don't like it. I consider necessity
of modifying VS project
a lesser evil.

(you open it and it just works)

-Lev

--000000000000a6aa4e0596c0ff7a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><div class=3D"gmail_quote"><div>=
=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">I&#39;m a bit=
 unhappy with that one, as it changes behaviour for all non-windows<br>
builds (including all the openssl build output even if it succeeds).<br></b=
lockquote><div><br></div><div>The only place it changes behavior is this</d=
iv><div><br></div>=C2=A0install:<br>=C2=A0 =C2=A0- if [ ! -z &quot;${CHOST}=
&quot; ]; then unset CC; fi<br>- =C2=A0- .travis/build-deps.sh &gt; build-d=
eps.log 2&gt;&amp;1 || (cat build-deps.log &amp;&amp; exit 1)<br><div>+ =C2=
=A0- .travis/build-deps.sh</div><div><br></div><div>I don&#39;t see it as a=
n issue to print output when building dependencies. The reason why</div><di=
v>it is done is that travis aborts build if there is no output for more tha=
n 10 minutes.=C2=A0</div><div>=C2=A0<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
Besides this, we need to fix this whole MSVC mess - all other platforms<br>
are just done with &quot;add new source file to the Makefile.ac&quot; and d=
one<br>
(including mingw builds), and then MSVC is broken again, and this will<br>
happen again and again.=C2=A0 =C2=A0</blockquote><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
<br>
Is there no reasonable way to build these project files from Makefile.ac?<b=
r></blockquote><div><br></div><div>I see no reasonable way. Selva, Simon - =
opinions?</div><div><br></div><div>We could probably have a templatized pro=
ject file and script which inserts source files to there</div><div>based on=
 content of Makefile.ac, but I don&#39;t like it. I consider necessity of m=
odifying VS project</div><div>a lesser evil.=C2=A0</div><div><br></div><div=
>(you open it and it just works)</div><div>=C2=A0</div></div><div dir=3D"lt=
r" class=3D"gmail_signature">-Lev</div></div>

--000000000000a6aa4e0596c0ff7a--

