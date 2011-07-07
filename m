MIME-Version: 1.0
Sender: adriaan@...1475...
In-Reply-To: <4E14939F.9020708@...1432...>
References: <4E12BE97.3000308@...1432...>
	<4E130E87.4070202@...1114...>
	<4E14939F.9020708@...1432...>
Date: Thu, 7 Jul 2011 21:06:57 +0200
Message-ID: <CAHyOtR=A9sRg8KduA_3hGD=7kAsNMF-RtJBcK5SNuf6c3boxAg@...278...>
From: Adriaan de Jong <openvpn@...1475...>
Content-Type: multipart/alternative; boundary=000e0cd6ab38c69b4804a77f6b0f
Subject: Re: [Openvpn-devel] Bug: extended x509-username-field broken in git
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Markus Koetter <koetter@...1432...>
Cc: openvpn-devel@lists.sourceforge.net

--000e0cd6ab38c69b4804a77f6b0f
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Jul 6, 2011 at 6:55 PM, Markus Koetter <
koetter@...1432...> wrote:

> On 07/05/2011 03:15 PM, David Sommerseth wrote:
>
>> Can you please use git bisect to locate the offending commit?
>>
>
> I figured out this never really worked with openvpn git at all.
> During discussing the patch, the check for the error_depth disappeared.
> So, if the root certificate lacked the extension, it would fail.
>
> Therefore, attached a patch which accepts this kind of error if the
> error_depth is != 0 - the lowest level of the cert is not reached yet.
> This duplicates the behavior which is used for the fields.
>
> I was wondering why the script tries to extract values from certificates
> for any level but 0 anyway?
>


Hi Markus,

A fix is included in my SSL separation patch set, in this patch to be
exact:
https://github.com/andj/openvpn-ssl-refactoring/commit/71e27b1e282bf8e10724b69fe4cbeac65dee325b
 .

Does that solve the problem?

Adriaan

--000e0cd6ab38c69b4804a77f6b0f
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Wed, Jul 6, 2011 at 6:55 PM, Markus Koetter <=
span dir=3D"ltr">&lt;<a href=3D"mailto:koetter@...1432...">koetter@...1476...=
..</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">
<div class=3D"im">On 07/05/2011 03:15 PM, David Sommerseth wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Can you please use git bisect to locate the offending commit?<br>
</blockquote>
<br></div>
I figured out this never really worked with openvpn git at all.<br>
During discussing the patch, the check for the error_depth disappeared.<br>
So, if the root certificate lacked the extension, it would fail.<br>
<br>
Therefore, attached a patch which accepts this kind of error if the error_d=
epth is !=3D 0 - the lowest level of the cert is not reached yet.<br>
This duplicates the behavior which is used for the fields.<br>
<br>
I was wondering why the script tries to extract values from certificates fo=
r any level but 0 anyway?<br></blockquote><div><br></div><font class=3D"App=
le-style-span" color=3D"#333333" face=3D"arial, sans-serif"><div class=3D"g=
mail_quote">
<font class=3D"Apple-style-span" color=3D"#333333" face=3D"arial, sans-seri=
f"><br></font></div></font><font class=3D"Apple-style-span" color=3D"#33333=
3" face=3D"arial, sans-serif">Hi Markus,<br></font></div><div class=3D"gmai=
l_quote"><span class=3D"Apple-style-span" style=3D"color: rgb(51, 51, 51); =
font-family: arial, sans-serif; background-color: rgb(255, 255, 255); "><di=
v>
<br></div><div>A fix is included in my SSL separation patch set, in this pa=
tch to be exact:=A0<a href=3D"https://github.com/andj/openvpn-ssl-refactori=
ng/commit/71e27b1e282bf8e10724b69fe4cbeac65dee325b" target=3D"_blank" style=
=3D"font-size: 13px; color: rgb(61, 84, 89); ">https://github.com/andj/open=
vpn-ssl-refactoring/commit/71e27b1e282bf8e10724b69fe4cbeac65dee325b</a>=A0.=
=A0</div>
<div style=3D"font-size: 13px; "><br></div></span><span class=3D"Apple-styl=
e-span" style=3D"color: rgb(51, 51, 51); font-family: arial, sans-serif; fo=
nt-size: 13px; background-color: rgb(255, 255, 255); ">Does that solve the =
problem?</span><span class=3D"Apple-style-span" style=3D"color: rgb(51, 51,=
 51); font-family: arial, sans-serif; font-size: 13px; background-color: rg=
b(255, 255, 255); "><div>
<br></div></span><div><span class=3D"Apple-style-span" style=3D"color: rgb(=
51, 51, 51); font-family: arial, sans-serif; font-size: 13px; background-co=
lor: rgb(255, 255, 255); ">Adriaan</span>=A0</div></div>

--000e0cd6ab38c69b4804a77f6b0f--

