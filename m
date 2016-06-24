MIME-Version: 1.0
In-Reply-To: <20160624140526.GV79504@...1296...>
References: <20160624140526.GV79504@...1296...>
Date: Fri, 24 Jun 2016 19:44:18 +0500
Message-ID: <CAFHpkQEtXO1aWSF5v=ivNCx2TzK870tm_StjComxrNWLp1_9LQ@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Content-Type: multipart/alternative; boundary=001a11c3af2e9ce2d50536073429
Subject: Re: [Openvpn-devel] brainstorming: t_client system test equivalent
 for windows?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

--001a11c3af2e9ce2d50536073429
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I would suggest powershell instead of perl. I can write powershell stuff
24 =D0=B8=D1=8E=D0=BD=D1=8F 2016 =D0=B3. 19:07 =D0=BF=D0=BE=D0=BB=D1=8C=D0=
=B7=D0=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C "Gert Doering" <gert@...1725...=
..>
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:

> Hi,
>
> a new patch set from Heiko is coming up, which is going to change the
> "IFCONFIG_BEFORE_TUN_OPEN" to "what everyone else does" (because what
> we currently have is older than anyone remembers, and makes life much
> more complicated than needed).
>
> Now, we are not currently properly testing Windows - on the unix systems,
> I'd build a t_client.rc test set with like 5 extra tests for
> "--route-method
> adaptive/ipapi/exe", "IPv4 only", "IPv6 and IPv6", interactive service
> or not, etc. - but I'm not sure what the best way is to do this on
> windows.
>
> Would "use mingw/msys bash" work for stuff like "put regular openvpn.exe
> into background with 'openvpn.exe & pid=3D$! ' and kill with "kill $opid"?
>
> I have been toying with the idea of replacing t_client.sh with a perl
> script that uses the management interface to control openvpn (at least
> the "has our startup finished?  have we exploded?  shutdown orderly now!"
> bits...) - but that's also not trivially implemented as one would have
> to redo the whole "look at ifconfig/route output and parse in a system
> dependent way" - and test on a gazillion of platforms :-)
>
>
> So... other ideas?  Selva, Valdikss, how do you test windows builds?
>
> Jens, since you have dived into t_client improvements - any nice ideas
> how to make this happen with "reasonable effort"?
>
> gert
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //
> www.muc.de/~gert/
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025
> gert@...1297...
>
>
> -------------------------------------------------------------------------=
-----
> Attend Shape: An AT&T Tech Expo July 15-16. Meet us at AT&T Park in San
> Francisco, CA to explore cutting-edge tech and listen to tech luminaries
> present their vision of the future. This family event has something for
> everyone, including kids. Get more information and register today.
> http://sdm.link/attshape
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>

--001a11c3af2e9ce2d50536073429
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">I would suggest powershell instead of perl. I can write powe=
rshell stuff</p>
<div class=3D"gmail_quote">24 =D0=B8=D1=8E=D0=BD=D1=8F 2016 =D0=B3. 19:07 =
=D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C &q=
uot;Gert Doering&quot; &lt;<a href=3D"mailto:gert@...1296...">gert@...1725...=
..</a>&gt; =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:<br type=3D"attributi=
on"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
a new patch set from Heiko is coming up, which is going to change the<br>
&quot;IFCONFIG_BEFORE_TUN_OPEN&quot; to &quot;what everyone else does&quot;=
 (because what<br>
we currently have is older than anyone remembers, and makes life much<br>
more complicated than needed).<br>
<br>
Now, we are not currently properly testing Windows - on the unix systems,<b=
r>
I&#39;d build a t_client.rc test set with like 5 extra tests for &quot;--ro=
ute-method<br>
adaptive/ipapi/exe&quot;, &quot;IPv4 only&quot;, &quot;IPv6 and IPv6&quot;,=
 interactive service<br>
or not, etc. - but I&#39;m not sure what the best way is to do this on<br>
windows.<br>
<br>
Would &quot;use mingw/msys bash&quot; work for stuff like &quot;put regular=
 openvpn.exe<br>
into background with &#39;openvpn.exe &amp; pid=3D$! &#39; and kill with &q=
uot;kill $opid&quot;?<br>
<br>
I have been toying with the idea of replacing t_client.sh with a perl<br>
script that uses the management interface to control openvpn (at least<br>
the &quot;has our startup finished?=C2=A0 have we exploded?=C2=A0 shutdown =
orderly now!&quot;<br>
bits...) - but that&#39;s also not trivially implemented as one would have<=
br>
to redo the whole &quot;look at ifconfig/route output and parse in a system=
<br>
dependent way&quot; - and test on a gazillion of platforms :-)<br>
<br>
<br>
So... other ideas?=C2=A0 Selva, Valdikss, how do you test windows builds?<b=
r>
<br>
Jens, since you have dived into t_client improvements - any nice ideas<br>
how to make this happen with &quot;reasonable effort&quot;?<br>
<br>
gert<br>
--<br>
USENET is *not* the non-clickable part of WWW!<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//<a href=3D"=
http://www.muc.de/~gert/" rel=3D"noreferrer" target=3D"_blank">www.muc.de/~=
gert/</a><br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296...">gert@...1296...</a><br>
fax: +49-89-35655025=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:gert@...1297...">gert@...1826...=
7...</a><br>
<br>-----------------------------------------------------------------------=
-------<br>
Attend Shape: An AT&amp;T Tech Expo July 15-16. Meet us at AT&amp;T Park in=
 San<br>
Francisco, CA to explore cutting-edge tech and listen to tech luminaries<br>
present their vision of the future. This family event has something for<br>
everyone, including kids. Get more information and register today.<br>
<a href=3D"http://sdm.link/attshape" rel=3D"noreferrer" target=3D"_blank">h=
ttp://sdm.link/attshape</a><br>____________________________________________=
___<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
<br></blockquote></div>

--001a11c3af2e9ce2d50536073429--

