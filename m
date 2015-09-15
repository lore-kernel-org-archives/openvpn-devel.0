MIME-Version: 1.0
In-Reply-To: <55F7EFD0.1040501@...2010...>
References: <55DB4C39.9040105@...2010...>
	<55DDBBE2.9010205@...1114...>
	<55F7EFD0.1040501@...2010...>
Date: Tue, 15 Sep 2015 23:49:55 +0200
Message-ID: <CAA1Abx+EBkkGhSLBnGonHdLur4g3w4cm44U_nDP7UhMuNxXrUg@...278...>
From: Steffan Karger <steffan@...1856...>
Content-Type: multipart/alternative; boundary=001a113ba3bca02daf051fd0294e
Subject: Re: [Openvpn-devel] Log cert serial no if it is revoked
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Boris Lytochkin <lytboris@...2010...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a113ba3bca02daf051fd0294e
Content-Type: text/plain; charset=UTF-8

Hi,

I agree that the functionality makes, but need to look at the code.  I'm
currently on a long holiday and haven't had enough spare cycles to spend on
openvpn. After I get back (next week), this will be part of my backlog :)

-Steffan
On 15 Sep 2015 03:34, "Boris Lytochkin" <lytboris@...2010...> wrote:

> Hi.
>
> Any news on importing this patch into codebase?
>
> On 26.08.2015 16:15, David Sommerseth wrote:
> > On 24/08/15 18:54, Boris Lytochkin wrote:
> >> Hi.
> >>
> >> Author: Boris Lytochkin <lytboris@...2010...>
> >> Sponsored-by: Yandex LLC
> >>
> >> Log serial number of revoked certificate
> >>
> >> In most of situations admin of OpenVPN server needs to know which
> >> particular certificate is used by client.
> >> In the case when certificate is OK, environment variable can be used for
> >> that but once it is revoked no user scripts are invoked so there is no
> >> way to get serial number: only subject is printed in logs. Patch
> >> attached addresses this issue logging certificate directly on the line
> >> with certificate subject.
> >>
> >> Tested with OpenSSL but PolarSSL should be good too.
> >>
> >> Signed-off-by Boris Lytochkin <lytboris@...2010...>
> > Feature-wise, this makes a lot of sense.  And as Gert has said, the
> > serial numbers are unique to the CA being used, which fits OpenVPN use
> > cases well.  The vast majority of OpenVPN installations with PKI uses an
> > internal CA which the admins have full control over.
> >
> > I have only done a code review and a quick compile with 'make check'.
> >  From that perspective, I can give it an ACK on the code side.  It looks
> > correct as far as I can understand.  It would be good if Steffan could
> > give especially the PolarSSL side an extra check, but even that looks
> > good to me.
> >
> > I have *not* tested this against a CRL file yet.  I hope I don't jinx it
> > when I say I think the behaviour in that case will be very predictable.
> >
> >
>
> --
> Boris Lytochkin
> Yandex NOC
> +7 (495) 739 70 00 ext. 7671
>
>
>
> ------------------------------------------------------------------------------
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--001a113ba3bca02daf051fd0294e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Hi,</p>
<p dir=3D"ltr">I agree that the functionality makes, but need to look at th=
e code.=C2=A0 I&#39;m currently on a long holiday and haven&#39;t had enoug=
h spare cycles to spend on openvpn. After I get back (next week), this will=
 be part of my backlog :)</p>
<p dir=3D"ltr">-Steffan</p>
<div class=3D"gmail_quote">On 15 Sep 2015 03:34, &quot;Boris Lytochkin&quot=
; &lt;<a href=3D"mailto:lytboris@...2010...">lytboris@...2010...</a>&gt; wr=
ote:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi.<br>
<br>
Any news on importing this patch into codebase?<br>
<br>
On <a href=3D"tel:26.08.2015%2016" value=3D"+12608201516">26.08.2015 16</a>=
:15, David Sommerseth wrote:<br>
&gt; On 24/08/15 18:54, Boris Lytochkin wrote:<br>
&gt;&gt; Hi.<br>
&gt;&gt;<br>
&gt;&gt; Author: Boris Lytochkin &lt;<a href=3D"mailto:lytboris@...2010..."=
>lytboris@...2010...</a>&gt;<br>
&gt;&gt; Sponsored-by: Yandex LLC<br>
&gt;&gt;<br>
&gt;&gt; Log serial number of revoked certificate<br>
&gt;&gt;<br>
&gt;&gt; In most of situations admin of OpenVPN server needs to know which<=
br>
&gt;&gt; particular certificate is used by client.<br>
&gt;&gt; In the case when certificate is OK, environment variable can be us=
ed for<br>
&gt;&gt; that but once it is revoked no user scripts are invoked so there i=
s no<br>
&gt;&gt; way to get serial number: only subject is printed in logs. Patch<b=
r>
&gt;&gt; attached addresses this issue logging certificate directly on the =
line<br>
&gt;&gt; with certificate subject.<br>
&gt;&gt;<br>
&gt;&gt; Tested with OpenSSL but PolarSSL should be good too.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by Boris Lytochkin &lt;<a href=3D"mailto:lytboris@...2064...=
10...">lytboris@...2010...</a>&gt;<br>
&gt; Feature-wise, this makes a lot of sense.=C2=A0 And as Gert has said, t=
he<br>
&gt; serial numbers are unique to the CA being used, which fits OpenVPN use=
<br>
&gt; cases well.=C2=A0 The vast majority of OpenVPN installations with PKI =
uses an<br>
&gt; internal CA which the admins have full control over.<br>
&gt;<br>
&gt; I have only done a code review and a quick compile with &#39;make chec=
k&#39;.<br>
&gt;=C2=A0 From that perspective, I can give it an ACK on the code side.=C2=
=A0 It looks<br>
&gt; correct as far as I can understand.=C2=A0 It would be good if Steffan =
could<br>
&gt; give especially the PolarSSL side an extra check, but even that looks<=
br>
&gt; good to me.<br>
&gt;<br>
&gt; I have *not* tested this against a CRL file yet.=C2=A0 I hope I don&#3=
9;t jinx it<br>
&gt; when I say I think the behaviour in that case will be very predictable=
.<br>
&gt;<br>
&gt;<br>
<br>
--<br>
Boris Lytochkin<br>
Yandex NOC<br>
<a href=3D"tel:%2B7%20%28495%29%20739%2070%2000%20ext.%207671" value=3D"+74=
957397000">+7 (495) 739 70 00 ext. 7671</a><br>
<br>
<br>
---------------------------------------------------------------------------=
---<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div>

--001a113ba3bca02daf051fd0294e--

