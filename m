MIME-Version: 1.0
In-Reply-To: <edab23db-978e-ec86-c9c2-5768b468cbdd@...2080...>
References: <efe4c17a-1d4d-d20f-cc77-cf7564ea1184@...2080...>
	<1472133483.61594.587.camel@...1866...>
	<8e9eb1dd-2505-7414-4828-6d6b6d1e25f0@...2080...>
	<CAKuzo_j0XwQ7OR8E-wGcTQDwEjdRbTZZy84wK68qgZLS30sT7g@...278...>
	<edab23db-978e-ec86-c9c2-5768b468cbdd@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 25 Aug 2016 12:53:13 -0400
Message-ID: <CAKuzo_iF5TsPDgVrjTfKfRWJp=1T=ZuejazTwK0OQpBWTbuwnw@...278...>
Content-Type: multipart/alternative; boundary=001a113bc7ca00cc12053ae83dc6
Subject: Re: [Openvpn-devel] [RFC] - Enable 2FA to be used with
	renegotiations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113bc7ca00cc12053ae83dc6
Content-Type: text/plain; charset=UTF-8

On Thu, Aug 25, 2016 at 11:36 AM, David Sommerseth <openvpn@...2142...
topphemmelig.net> wrote:

>
> On 25/08/16 16:32, Selva Nair wrote:
> >
> > On Thu, Aug 25, 2016 at 10:15 AM, David Sommerseth
> > <openvpn@...2080...
> > <mailto:openvpn@...2080...>> wrote:
> >
> > On 25/08/16 15:58, David Woodhouse wrote:
> >> On Thu, 2016-08-25 at 15:45 +0200, David Sommerseth wrote:
> >>>
> >>>
> >>> I've been working a bit on a new patch-set which enables
> >>> third-party user/password authentication mechanisms using two
> >>> factor authentications [2FA] (such as OTP) and not needing to
> >>> disable the renegotiation features of OpenVPN.
> >>
> >> Hm, you handle the server side of OTP through PAM alone?
> >
> > This change does not change the initial authentication at all.
> > You still need an authentication plug-in or
> > --auth-user-pass-verify script.  But once this first authentication
> > passes successfully, the OpenVPN server takes over the coming
> > authentications required due to re-negotiations.
> >
> >
> > Why not let the auth-user-pass-verify script do this verification
> > bypass? The server knows whether its an initial CONNECT or REAUTH
> > and can pass that info to the verify script. Then the script can
> > bypass verification if appropriate. Currently
> > management-client-auth is already capable of doing this as "REAUTH"
> > versus "CONNECT" info is passed to it. Adding that to the env and
> > passing to scripts should be easy.
>
> This is to avoid needing to modify any third-party authentication
> mechanisms.  But passing information that it is a re-auth is might be
> a good idea, that isn't too hard to add.
>
> However, it would need to be a flag to --auth-gen-token in addition -
> otherwise third party authentication mechanisms which have not been
> updated will fail.  On the other hand, if anyone is willing to update
> an auth-plugin or script to support this, they could just as well
> implement the auth-token generation themselves independently and not
> require --auth-gen-token at all; which speaks against such a flag.
>
> Also remember that this implementation covers both --plugin and
> - --auth-user-pass-verify.  For many it will be quite hard to modify a
> plug-in compared to updating a script.
>
> I'll grant that the 'auth-token' feature is a well hidden and not
> documented.  But the issue with 2FA and --reneg-* options have been a
> long standing issue, which have not been fixed in most of the
> authentication plug-ins used by the community.
>
> In regards to documentation, I'll try to improve that as well -
> regardless of this patch-set.  And there's another benefit if making
> use of this auth-token feature itself, as the client doesn't need to
> cache the users password any more. (I do need to verify that though,
> but there is no reason why it would be needed.)
>

I  was not aware of this auth-token feature. Just scanned through the
implementation: looks like a good way of handling user-auth during reneg.
And possibly safer than just distinguishing reauth vs connect in the
script. As is, it could be used from a verify-script or a
management-client-auth script by setting the token at first connect and
verifying it (instead of username/password) during reauth.

Agreed, an option for the server itself to generate the token would be a
good addition. And yes, the token could be made the default user-auth
mechanism during reneg regardless of 2FA is in use or not.  As for caching,
either the token will have to be cached unless management is in use in
which case the UI/GUI can remember the token and supply it during reneg.

Selva

--001a113bc7ca00cc12053ae83dc6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Aug 25, 2016 at 11:36 AM, David Sommerseth <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2142...<wb=
r>topphemmelig.net</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-colo=
r:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><span><br>
</span><span>On 25/08/16 16:32, Selva Nair wrote:<br>
&gt;<br>
&gt; On Thu, Aug 25, 2016 at 10:15 AM, David Sommerseth<br>
&gt; &lt;<a href=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...1186...=
.2156...<wbr>.net</a><br>
</span><span>&gt; &lt;mailto:<a href=3D"mailto:openvpn@...2080..." target=
=3D"_blank">openvpn@...2157...<wbr>emmelig.net</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt; On 25/08/16 15:58, David Woodhouse wrote:<br>
&gt;&gt; On Thu, 2016-08-25 at 15:45 +0200, David Sommerseth wrote:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; I&#39;ve been working a bit on a new patch-set which enables<b=
r>
&gt;&gt;&gt; third-party user/password authentication mechanisms using two<=
br>
&gt;&gt;&gt; factor authentications [2FA] (such as OTP) and not needing to<=
br>
&gt;&gt;&gt; disable the renegotiation features of OpenVPN.<br>
&gt;&gt;<br>
&gt;&gt; Hm, you handle the server side of OTP through PAM alone?<br>
&gt;<br>
&gt; This change does not change the initial authentication at all.<br>
&gt; You still need an authentication plug-in or<br>
&gt; --auth-user-pass-verify script.=C2=A0 But once this first authenticati=
on<br>
&gt; passes successfully, the OpenVPN server takes over the coming<br>
&gt; authentications required due to re-negotiations.<br>
&gt;<br>
&gt;<br>
&gt; Why not let the auth-user-pass-verify script do this verification<br>
&gt; bypass? The server knows whether its an initial CONNECT or REAUTH<br>
&gt; and can pass that info to the verify script. Then the script can<br>
&gt; bypass verification if appropriate. Currently<br>
&gt; management-client-auth is already capable of doing this as &quot;REAUT=
H&quot;<br>
&gt; versus &quot;CONNECT&quot; info is passed to it. Adding that to the en=
v and<br>
&gt; passing to scripts should be easy.<br>
<br>
</span>This is to avoid needing to modify any third-party authentication<br>
mechanisms.=C2=A0 But passing information that it is a re-auth is might be<=
br>
a good idea, that isn&#39;t too hard to add.<br>
<br>
However, it would need to be a flag to --auth-gen-token in addition -<br>
otherwise third party authentication mechanisms which have not been<br>
updated will fail.=C2=A0 On the other hand, if anyone is willing to update<=
br>
an auth-plugin or script to support this, they could just as well<br>
implement the auth-token generation themselves independently and not<br>
require --auth-gen-token at all; which speaks against such a flag.<br>
<br>
Also remember that this implementation covers both --plugin and<br>
- --auth-user-pass-verify.=C2=A0 For many it will be quite hard to modify a=
<br>
plug-in compared to updating a script.<br>
<br>
I&#39;ll grant that the &#39;auth-token&#39; feature is a well hidden and n=
ot<br>
documented.=C2=A0 But the issue with 2FA and --reneg-* options have been a<=
br>
long standing issue, which have not been fixed in most of the<br>
authentication plug-ins used by the community.<br>
<br>
In regards to documentation, I&#39;ll try to improve that as well -<br>
regardless of this patch-set.=C2=A0 And there&#39;s another benefit if maki=
ng<br>
use of this auth-token feature itself, as the client doesn&#39;t need to<br>
cache the users password any more. (I do need to verify that though,<br>
but there is no reason why it would be needed.)<br></blockquote><div><br></=
div><div>I =C2=A0was not aware of this auth-token feature. Just scanned thr=
ough the implementation: looks like a good way of handling user-auth during=
 reneg. And possibly safer than just distinguishing reauth vs connect in th=
e script. As is, it could be used from a verify-script or a management-clie=
nt-auth script by setting the token at first connect and verifying it (inst=
ead of username/password) during reauth.=C2=A0</div><div><br></div><div>Agr=
eed, an option for the server itself to generate the token would be a good =
addition. And yes, the token could be made the default user-auth mechanism =
during reneg regardless of 2FA is in use or not.=C2=A0=C2=A0As for caching,=
 either the token will have to be cached unless management is in use in whi=
ch case the UI/GUI can remember the token and supply it during reneg.</div>=
<div><br></div><div>Selva</div></div></div></div>

--001a113bc7ca00cc12053ae83dc6--

