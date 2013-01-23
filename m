MIME-Version: 1.0
In-Reply-To: <50FFDC58.3050202@...1114...>
References: <CAM2vnFOwy-1=5VzUYFnssAMavmGgFYiqO7=GiEUNs2n+EpC-BQ@...278...>
	<50FFDC58.3050202@...1114...>
From: 77 77 <siren1117@...277...>
Date: Wed, 23 Jan 2013 21:42:47 +0800
Message-ID: <CAM2vnFP-S62qf0OQ5YSdJm_tH+zkcz6gYUapvt==Le0OjciFvw@...278...>
Content-Type: multipart/alternative; boundary=20cf307f31a4e39f0704d3f4dfda
Subject: Re: [Openvpn-devel] [PATCH] OpenVPN Obfuscation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--20cf307f31a4e39f0704d3f4dfda
Content-Type: text/plain; charset=UTF-8

On Wed, Jan 23, 2013 at 8:49 PM, David Sommerseth <
openvpn.list@...1114...> wrote:

> On 23/01/13 11:21, 77 77 wrote:
> > Hi all,
> >
> > I wrote a patch to obfuscate OpenVPN's traffic to avoid protocol
> > identification. Compared with other traffic obfuscation methods like
> > using static keys or obfsproxy, it only adds one more config parameter,
> > and supports both TCP and UDP. If OpenVPN releases support this, lots of
> > devices will benefit from traffic obfuscation without installing
> > additional softwares -- for exsample, the newly released OpenVPN Connect
> > for iOS or Openvpn for Android.
> >
> > The patch is based on openvpn-2.2.1, but works fine with openvpn-2.2.2.
>
> Gert said one very important thing about openvpn 2.2.  Even though, he
> said to bring it up to openvpn-2.3 or git-master .... I'm saying
> git-master is the natural point.  If you need to have it in openvpn-2.3,
> backporting it from git-master is far easier than going the other way.
>
> I've looked quickly at your patch.   And the first instinct is that,
> yes, this looks reasonably well.  This is also a feature which I think
> will be very useful in the coming future.
>

I hope OpenVPN be more connectively from every place, every device. My
friends and I have been using this patch for a while.


>
> Just a few comments ...
>
> - Have you looked at the obfsproxy project from TOR?  That does pretty
> much a similar thing and does work together with OpenVPN (but only via
> TCP, as it uses the socks5 proxy mode of obfsproxy).  Could it be
> considered a better approach to integrate tighter against obfsproxy?
> obfsproxy provides a more "plug-in" oriented approach where there
> obfuscator logic can be changed at runtime, and doesn't necessarily
> depend on a encryption/obfuscation key.  What you basically do is to RC4
> encrypt the data.
>

The shortcome of obfsproxy is that you have to run the proxy along with
OpenVPN. If people want to use OpenVPN on mobile devices, it's easier to
use if we have in-place obfuscation ability. For example, OpenVPN Connect
is avaliable on iOS, but failed to connect from some countries. *In such
circumstances obfsproxy can't help, but in-place obfuscation would work.*

Currently, this patch *JUST* works. And I agree that a "plug-in" system for
obfuscation is more robust and easier to extend.


>
> - Have you looked into issues related with the RC4 algorithm?  IIRC, the
> first 256 bytes of a RC4 stream should always be discarded and the
> keying material should at minimum be hashed, otherwise weaknesses in RC4
> makes it easier to crack the encryption.  I know and understand that
> this is purely for obfuscation, but this encrypting isn't even
> obfuscation if you can crack the key fairly easily.  Which again makes
> me think of obfsproxy, which have established a fairly well stabilised
> code base for traffic obfuscation.
>

A "plug-in" system for obfuscation would work much better than one simple
encrytion method.

This is a cat and mouse game. Sometime a little modification will cause the
other side hard to catch up and had to use much more resources.


>
> - Have your patch been tested in both UDP and TCP mode?
>
Yes.


>
> - What is the purpose of the obfuscation_preprocess_incomming_link() and
> obfuscation_preprocess_outgoing_link() functions?  Why isn't
> obfuscation_process_incoming() or obfuscation_process_outgoing() used
> directly?
>
yes they can be used directly.


>
> - In OpenVPN 2.3 (including git-master) we also added support for
> PolarSSL as an alternative to OpenSSL.  It would be good if the code
> base could add PolarSSL support by using the SSL wrapper layer we now
> have implemented.
>
Ok.


>
> For further information on the OpenVPN development methods, please look
> here:
>
> <https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation>
>
> And if you're not familiar with git ... here's a git crash course, which
> hopefully will help you get started quicker.
>
> <https://community.openvpn.net/openvpn/wiki/GitCrashCourse>
>
> Our code repositories can be found here:
>
> <https://community.openvpn.net/openvpn/wiki/CodeRepositories>
>
>
> --
> kind regards,
>
> David Sommerseth
>
>

--20cf307f31a4e39f0704d3f4dfda
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Wed, Jan 23, 2013 at 8:49 PM, David Sommerseth <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:openvpn.list@...1114..." target=3D"_blank">openvpn.l=
ist@...1114...</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div class=3D""><div class=3D"h5">On 23/01/13 11:21, 77 77=
 wrote:<br>


&gt; Hi all,<br>
&gt;<br>
&gt; I wrote a patch to obfuscate OpenVPN&#39;s traffic to avoid protocol<b=
r>
&gt; identification. Compared with other traffic obfuscation methods like<b=
r>
&gt; using static keys or obfsproxy, it only adds one more config parameter=
,<br>
&gt; and supports both TCP and UDP. If OpenVPN releases support this, lots =
of<br>
&gt; devices will benefit from traffic obfuscation without installing<br>
&gt; additional softwares -- for exsample, the newly released OpenVPN Conne=
ct<br>
&gt; for iOS or Openvpn for Android.<br>
&gt;<br>
&gt; The patch is based on openvpn-2.2.1, but works fine with openvpn-2.2.2=
.<br>
<br>
</div></div>Gert said one very important thing about openvpn 2.2. =C2=A0Eve=
n though, he<br>
said to bring it up to openvpn-2.3 or git-master .... I&#39;m saying<br>
git-master is the natural point. =C2=A0If you need to have it in openvpn-2.=
3,<br>
backporting it from git-master is far easier than going the other way.<br>
<br>
I&#39;ve looked quickly at your patch. =C2=A0 And the first instinct is tha=
t,<br>
yes, this looks reasonably well. =C2=A0This is also a feature which I think=
<br>
will be very useful in the coming future.<br></blockquote><div><br></div><d=
iv style>I hope OpenVPN be more connectively from every place, every device=
. My friends and I have been using this patch for a while.</div><div>=C2=A0=
</div>

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
<br>
Just a few comments ...<br>
<br>
- Have you looked at the obfsproxy project from TOR? =C2=A0That does pretty=
<br>
much a similar thing and does work together with OpenVPN (but only via<br>
TCP, as it uses the socks5 proxy mode of obfsproxy). =C2=A0Could it be<br>
considered a better approach to integrate tighter against obfsproxy?<br>
obfsproxy provides a more &quot;plug-in&quot; oriented approach where there=
<br>
obfuscator logic can be changed at runtime, and doesn&#39;t necessarily<br>
depend on a encryption/obfuscation key. =C2=A0What you basically do is to R=
C4<br>
encrypt the data.<br></blockquote><div><br></div><div style>The shortcome o=
f obfsproxy is that you have to run the proxy along with OpenVPN. If people=
 want to use OpenVPN on mobile devices, it&#39;s easier to use if we have i=
n-place obfuscation ability. For example, OpenVPN Connect is avaliable on i=
OS, but failed to connect from some coun<font color=3D"#000000">tries.=C2=
=A0<em style=3D"font-style:normal;line-height:14.545454025268555px">In such=
 circumstances obfsproxy can&#39;t help, but in-place obfuscation would wor=
k.</em></font></div>

<div style><br></div><div style>Currently, this patch *JUST* works. And I a=
gree that a &quot;plug-in&quot; system for obfuscation is more robust and e=
asier to extend.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb=
(204,204,204);border-left-style:solid;padding-left:1ex">


<br>
- Have you looked into issues related with the RC4 algorithm? =C2=A0IIRC, t=
he<br>
first 256 bytes of a RC4 stream should always be discarded and the<br>
keying material should at minimum be hashed, otherwise weaknesses in RC4<br>
makes it easier to crack the encryption. =C2=A0I know and understand that<b=
r>
this is purely for obfuscation, but this encrypting isn&#39;t even<br>
obfuscation if you can crack the key fairly easily. =C2=A0Which again makes=
<br>
me think of obfsproxy, which have established a fairly well stabilised<br>
code base for traffic obfuscation.<br></blockquote><div><br></div><div>A &q=
uot;plug-in&quot; system for obfuscation would work much better than one si=
mple encrytion method.=C2=A0</div><div><br></div><div>This is a cat and mou=
se game. Sometime a little modification will cause the other side hard to c=
atch up and had to use much more resources.</div>

<div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-l=
eft-style:solid;padding-left:1ex">
<br>
- Have your patch been tested in both UDP and TCP mode?<br></blockquote><di=
v style>Yes.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(20=
4,204,204);border-left-style:solid;padding-left:1ex">


<br>
- What is the purpose of the obfuscation_preprocess_incomming_link() and<br>
obfuscation_preprocess_outgoing_link() functions? =C2=A0Why isn&#39;t<br>
obfuscation_process_incoming() or obfuscation_process_outgoing() used<br>
directly?<br></blockquote><div style>yes they can be used directly.</div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);border-lef=
t-style:solid;padding-left:1ex">


<br>
- In OpenVPN 2.3 (including git-master) we also added support for<br>
PolarSSL as an alternative to OpenSSL. =C2=A0It would be good if the code<b=
r>
base could add PolarSSL support by using the SSL wrapper layer we now<br>
have implemented.<br></blockquote><div style>Ok.</div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;paddi=
ng-left:1ex">


<br>
For further information on the OpenVPN development methods, please look<br>
here:<br>
<br>
&lt;<a href=3D"https://community.openvpn.net/openvpn/wiki/DeveloperDocument=
ation" target=3D"_blank">https://community.openvpn.net/openvpn/wiki/Develop=
erDocumentation</a>&gt;<br>
<br>
And if you&#39;re not familiar with git ... here&#39;s a git crash course, =
which<br>
hopefully will help you get started quicker.<br>
<br>
&lt;<a href=3D"https://community.openvpn.net/openvpn/wiki/GitCrashCourse" t=
arget=3D"_blank">https://community.openvpn.net/openvpn/wiki/GitCrashCourse<=
/a>&gt;<br>
<br>
Our code repositories can be found here:<br>
<br>
&lt;<a href=3D"https://community.openvpn.net/openvpn/wiki/CodeRepositories"=
 target=3D"_blank">https://community.openvpn.net/openvpn/wiki/CodeRepositor=
ies</a>&gt;<br>
<span class=3D""><font color=3D"#888888"><br>
<br>
--<br>
kind regards,<br>
<br>
David Sommerseth<br>
<br>
</font></span></blockquote></div><br></div></div>

--20cf307f31a4e39f0704d3f4dfda--

