MIME-Version: 1.0
In-Reply-To: <5593FDEE.3010809@...1147...>
References: <99A30EB899EB448B846248EC2E9A353A@...1853...>
	<5593EBF6.4060203@...1114...>
	<1896EA4F53C84141B287C36403D7DE21@...1853...>
	<20150701144158.GD382@...1296...> <5593FDEE.3010809@...1147...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 1 Jul 2015 11:57:44 -0400
Message-ID: <CAKuzo_hnKMd+50j3MR7f9A3pzuuzyCiz7y=cpw_5x8Kg8Vg6CQ@...278...>
Content-Type: multipart/alternative; boundary=047d7b10c8895433740519d263cc
Subject: Re: [Openvpn-devel] OpenVPN 2.3.7-I602-x86_64.exe download 404 Error
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--047d7b10c8895433740519d263cc
Content-Type: text/plain; charset=UTF-8

On Wed, Jul 1, 2015 at 10:49 AM, Jan Just Keijser <janjust@...1147...> wrote:

> On 01/07/15 16:41, Gert Doering wrote:
> > Hi,
> >
> > On Wed, Jul 01, 2015 at 03:05:44PM +0100, debbie10t@...277... wrote:
> >> Resolving swupdate.openvpn.org (swupdate.openvpn.org)... 104.28.1.12,
> >> 104.28.0.12
> >> Connecting to swupdate.openvpn.org
> >> (swupdate.openvpn.org)|104.28.1.12|:443... connected.
> >
> > Something interesting is going on.  I thought it might be related to
> > the two different IP addresses, and maybe one has the file and one
> > does not - but it works for both from here...
> >
> > Connecting to swupdate.openvpn.org (swupdate.openvpn.org)|104.28.0.12|:443...
> connected.
> > openvpn-install-2.3 100%[=====================>]   1.72M  1.06MB/s   in
> 1.6s
> >
> > Connecting to swupdate.openvpn.org (swupdate.openvpn.org)|104.28.1.12|:443...
> connected.
> > openvpn-install-2.3 100%[=====================>]   1.72M  1.04MB/s   in
> 1.6s
> >
> > funny.
> >
> > Samuli, can you investigate?
> >
> I'm getting something else entirely:
>
> from EL5:
>
> Resolving swupdate.openvpn.org... 104.28.1.12, 104.28.0.12
> Connecting to swupdate.openvpn.org|104.28.1.12|:443... connected.
> OpenSSL: error:14077438:SSL routines:SSL23_GET_SERVER_HELLO:tlsv1 alert
> internal error
> Unable to establish SSL connection.
>
>
> from EL6 it just works
>

Works from a couple of networks I tried, but the hosting server appears to
require SNI support in the client/browser. May be your wget does not
support SNI? Try with curl

 Selva

--047d7b10c8895433740519d263cc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Wed, Jul 1, 2015 at 10:49 AM, Jan Just Keijser <span dir=3D"ltr">&lt=
;<a href=3D"mailto:janjust@...1147..." target=3D"_blank">janjust@...1147...=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204)=
;border-left-style:solid;padding-left:1ex"><span>On 01/07/15 16:41, Gert Do=
ering wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; On Wed, Jul 01, 2015 at 03:05:44PM +0100, <a href=3D"mailto:debbie10t@=
...277..." target=3D"_blank">debbie10t@...277...</a> wrote:<br>
&gt;&gt; Resolving <a href=3D"http://swupdate.openvpn.org" rel=3D"noreferre=
r" target=3D"_blank">swupdate.openvpn.org</a> (<a href=3D"http://swupdate.o=
penvpn.org" rel=3D"noreferrer" target=3D"_blank">swupdate.openvpn.org</a>).=
.. 104.28.1.12,<br>
&gt;&gt; 104.28.0.12<br>
&gt;&gt; Connecting to <a href=3D"http://swupdate.openvpn.org" rel=3D"noref=
errer" target=3D"_blank">swupdate.openvpn.org</a><br>
&gt;&gt; (<a href=3D"http://swupdate.openvpn.org" rel=3D"noreferrer" target=
=3D"_blank">swupdate.openvpn.org</a>)|104.28.1.12|:443... connected.<br>
&gt;<br>
&gt; Something interesting is going on.=C2=A0 I thought it might be related=
 to<br>
&gt; the two different IP addresses, and maybe one has the file and one<br>
&gt; does not - but it works for both from here...<br>
&gt;<br>
&gt; Connecting to <a href=3D"http://swupdate.openvpn.org" rel=3D"noreferre=
r" target=3D"_blank">swupdate.openvpn.org</a> (<a href=3D"http://swupdate.o=
penvpn.org" rel=3D"noreferrer" target=3D"_blank">swupdate.openvpn.org</a>)|=
104.28.0.12|:443... connected.<br>
&gt; openvpn-install-2.3 100%[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D&gt;]=C2=A0 =C2=A01.72M=C2=A0 1.06MB/s=C2=A0 =C2=A0in 1.6=
s<br>
&gt;<br>
&gt; Connecting to <a href=3D"http://swupdate.openvpn.org" rel=3D"noreferre=
r" target=3D"_blank">swupdate.openvpn.org</a> (<a href=3D"http://swupdate.o=
penvpn.org" rel=3D"noreferrer" target=3D"_blank">swupdate.openvpn.org</a>)|=
104.28.1.12|:443... connected.<br>
&gt; openvpn-install-2.3 100%[=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D&gt;]=C2=A0 =C2=A01.72M=C2=A0 1.04MB/s=C2=A0 =C2=A0in 1.6=
s<br>
&gt;<br>
&gt; funny.<br>
&gt;<br>
&gt; Samuli, can you investigate?<br>
&gt;<br>
</span>I&#39;m getting something else entirely:<br>
<br>
from EL5:<br>
<br>
Resolving swupdate.openvpn.org... 104.28.1.12, 104.28.0.12<br>
Connecting to <a href=3D"http://swupdate.openvpn.org" rel=3D"noreferrer" ta=
rget=3D"_blank">swupdate.openvpn.org</a>|104.28.1.12|:443... connected.<br>
OpenSSL: error:14077438:SSL routines:SSL23_GET_SERVER_HELLO:tlsv1 alert<br>
internal error<br>
Unable to establish SSL connection.<br>
<br>
<br>
from EL6 it just works<br></blockquote><div>=C2=A0</div><div>Works from a c=
ouple of networks I tried, but the hosting server appears to require SNI su=
pport in the client/browser. May be your wget does not support SNI? Try wit=
h curl<br></div><div><br></div><div>=C2=A0Selva</div></div></div></div>

--047d7b10c8895433740519d263cc--

