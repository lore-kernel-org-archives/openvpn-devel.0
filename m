MIME-Version: 1.0
In-Reply-To: <b524e527-9881-1e25-2ba0-fd7e4117afc4@...1856...>
References: <CAFHpkQHXhe4UBAePJQXkBYJ+Sahc-3XpVPfPBo5oT6EKbzm3mA@...278...>
 <b524e527-9881-1e25-2ba0-fd7e4117afc4@...1856...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 21 Aug 2017 13:23:22 +0500
Message-ID: <CAFHpkQHbGSsU7gsRcogr+7JzpDXoBd9r669cOpRxp1k8h91Smg@...278...>
Content-Type: multipart/alternative; boundary="001a113f9f8c25481605573f31f2"
Subject: Re: [Openvpn-devel] testing openvpn on gitlab-ci cloud ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113f9f8c25481605573f31f2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-08-20 14:10 GMT+05:00 Steffan Karger <steffan@...1856...>:

> Hi,
>
> On 20-08-17 09:43, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
> > I was playing with gitlab-ci:
> >
> > https://gitlab.com/chipitsine/openvpn/pipelines/11012659
> >
> >
> > are we interested in something like that ? thoughts?
> >
> > some benefits of gitlab-ci:
> >
> > 1) ipv6 on loopback (travis-ci runs in GCE without ipv6)
> > 2) ability to attach own gitlab-ci runners to repo
> > (freebsd/netbsd/.../windows/.../etc)
>
> This does look nice, but I think we should not add another CI setup.  We
> now have:
>
> 1) The private buildbot setup for the maintainers, which runs a wide
> variety of platforms, configs and real-network tests (across various
> combinations platforms, to test e.g. endianness).
>

I've seen buildbot matrix, its (mbedtls, openssl) x (various configure
options) x (various distros) - it's really big. and it includes real world
tests.


>
> 2) The travis-ci setup for coverity and an early check of github pull
> requests (which only is an early staging area for patches to be sent to
> the -devel list later).
>
> So I think we have everything that gitlab offers covered.  Let's not add
> another setup to maintain.
>

what I suggest is not "implement gitlab-ci immediately", I also do not want
to support more configurations. It's rather "let us take gitlab-ci into
account and implement it when there'll be appropriate task for it"


>
> -Steffan
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

--001a113f9f8c25481605573f31f2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-08-20 14:10 GMT+05:00 Steffan Karger <span dir=3D"ltr">&lt;<a href=
=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>&gt;=
</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On 20-08-17 09:43, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:<br>
&gt; I was playing with gitlab-ci:<br>
&gt;<br>
&gt; <a href=3D"https://gitlab.com/chipitsine/openvpn/pipelines/11012659" r=
el=3D"noreferrer" target=3D"_blank">https://gitlab.com/chipitsine/<wbr>open=
vpn/pipelines/11012659</a><br>
&gt;<br>
&gt;<br>
&gt; are we interested in something like that ? thoughts?<br>
&gt;<br>
&gt; some benefits of gitlab-ci:<br>
&gt;<br>
&gt; 1) ipv6 on loopback (travis-ci runs in GCE without ipv6)<br>
&gt; 2) ability to attach own gitlab-ci runners to repo<br>
&gt; (freebsd/netbsd/.../windows/..<wbr>./etc)<br>
<br>
</span>This does look nice, but I think we should not add another CI setup.=
=C2=A0 We<br>
now have:<br>
<br>
1) The private buildbot setup for the maintainers, which runs a wide<br>
variety of platforms, configs and real-network tests (across various<br>
combinations platforms, to test e.g. endianness).<br></blockquote><div><br>=
</div><div>I&#39;ve seen buildbot matrix, its (mbedtls, openssl) x (various=
 configure options) x (various distros) - it&#39;s really big. and it inclu=
des real world tests.<br></div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">
<br>
2) The travis-ci setup for coverity and an early check of github pull<br>
requests (which only is an early staging area for patches to be sent to<br>
the -devel list later).<br>
<br>
So I think we have everything that gitlab offers covered.=C2=A0 Let&#39;s n=
ot add<br>
another setup to maintain.<br></blockquote><div><br></div><div>what I sugge=
st is not &quot;implement gitlab-ci immediately&quot;, I also do not want t=
o support more configurations. It&#39;s rather &quot;let us take gitlab-ci =
into account and implement it when there&#39;ll be appropriate task for it&=
quot;<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
-Steffan<br>
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
</blockquote></div><br></div></div>

--001a113f9f8c25481605573f31f2--

