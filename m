MIME-Version: 1.0
References: <6c0e8ca1-9518-1bc0-65cb-f742311ef08f@...1227...>
In-Reply-To: <6c0e8ca1-9518-1bc0-65cb-f742311ef08f@...1227...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sun, 15 Jan 2023 18:21:21 +0600
Message-ID: <CAFHpkQF4dtn0DV-nHMeUfowA2EszAscpbMVeGk6boiXYhWc5Kw@...278...>
Content-Type: multipart/alternative; boundary="000000000000cb52d005f24c810d"
Subject: Re: [Openvpn-devel] Amend OpenVPN license to allow continued mbed
 TLS support (allow mbed TLS 3.x linking)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000cb52d005f24c810d
Content-Type: text/plain; charset="UTF-8"

I am fine with dropping MBED TLS for good

On Sat, Jan 14, 2023, 11:30 PM Arne Schwabe <arne@...1227...> wrote:

> Hey,
>
> This is the first round and will be only to the openvpn-devel list.
> After that I will also write to individuals email addresses but I want
> to start with sending this to the devel list.
>
> We are writing to you since you are or were a contributor in past to
> OpenVPN and we would like to  ask for your permission to amend the
> license of OpenVPN.
>
> OpenVPN 2.x is licensed under the GPL v2. This license has served us
> well in the past and we are not trying to change that. However, changes
> in licenses of our dependencies make this change necessary.
>
> Both mbed TLS and OpenSSL nowadays use the Apache 2.x license. For the
> OpenSSL library we have a special exception that allows us linking with
> it. For newer mbed TLS version, we cannot do this any more.
> Compatibility of Apache 2.x and GPL 2.x has to our knowledge never been
> tested in court and even FSF and ASF disagree about the issue
> (https://www.apache.org/licenses/GPL-compatibility.html)
>
> We would like to be able to continue to build/ship OpenVPN with mbed
> TLS. We want all contributors to ask if they agree to license change
> that adds explicit permission to link with Apache 2 licensed libraries:
>
>
> Special exception for linking OpenVPN with Apache 2 licensed libraries:
>
>    In addition, as a special exception, OpenVPN Inc and contributors
>    give permission to link the code of this program to libraries with the
>    "APACHE LICENSE, VERSION 2.0", and distribute linked combination
>    including the two.  You must obey the GNU General Public License in
>    all respects for all of the code used other than these libraries.  If
>    you modify this file, you may extend this exception to your version of
>    the file, but you are not obligated to do so.  If you do not wish to
>    do so, delete this exception statement from your version.
>
>
> You might wonder why we are going for a generic Apache 2 exception
> rather than one targeted at mbed TLS specifically. We believe that a
> generic exemption is better since it also implicitly allows forks of
> mbed TLS and even if a SSL library might emerge in the future we do not
> have to discuss if it is a fork or not. Also granting an explicit
> exception for Apache 2 style licenses reaffirms the linking to OpenSSL.
>
> We also considered going for a change from GPL2 to GPL2+ but we think
> that GPL3 would hurt the ability to distribute OpenVPN as part of router
> or other embedded devices as the GPL3 has been explicitly developed (at
> least in part) to make this use case harder/impossible
> (https://en.wikipedia.org/wiki/Tivoization)
>
> If you are okay with this, please reply to this mail and confirm that.
> Otherwise we might be forced to remove and/or rewrite your code.
>
>
> As a reminder, the The current OpenSSL exception reads as follows
> (COPYING). We don't intend to change or remote it:
>
>    Special exception for linking OpenVPN with OpenSSL:
>
>    In addition, as a special exception, OpenVPN Inc gives
>    permission to link the code of this program with the OpenSSL
>    library (or with modified versions of OpenSSL that use the same
>    license as OpenSSL), and distribute linked combinations including
>    the two.  You must obey the GNU General Public License in all
>    respects for all of the code used other than OpenSSL.  If you modify
>    this file, you may extend this exception to your version of the
>    file, but you are not obligated to do so.  If you do not wish to
>    do so, delete this exception statement from your version.
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--000000000000cb52d005f24c810d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I am fine with dropping MBED TLS for good</div><br><div c=
lass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Jan 14, =
2023, 11:30 PM Arne Schwabe &lt;<a href=3D"mailto:arne@...1227...">arne@...493...=
1227...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hey,<br>
<br>
This is the first round and will be only to the openvpn-devel list. <br>
After that I will also write to individuals email addresses but I want <br>
to start with sending this to the devel list.<br>
<br>
We are writing to you since you are or were a contributor in past to <br>
OpenVPN and we would like to=C2=A0 ask for your permission to amend the <br>
license of OpenVPN.<br>
<br>
OpenVPN 2.x is licensed under the GPL v2. This license has served us <br>
well in the past and we are not trying to change that. However, changes <br>
in licenses of our dependencies make this change necessary.<br>
<br>
Both mbed TLS and OpenSSL nowadays use the Apache 2.x license. For the <br>
OpenSSL library we have a special exception that allows us linking with <br>
it. For newer mbed TLS version, we cannot do this any more. <br>
Compatibility of Apache 2.x and GPL 2.x has to our knowledge never been <br>
tested in court and even FSF and ASF disagree about the issue <br>
(<a href=3D"https://www.apache.org/licenses/GPL-compatibility.html" rel=3D"=
noreferrer noreferrer" target=3D"_blank">https://www.apache.org/licenses/GP=
L-compatibility.html</a>)<br>
<br>
We would like to be able to continue to build/ship OpenVPN with mbed <br>
TLS. We want all contributors to ask if they agree to license change <br>
that adds explicit permission to link with Apache 2 licensed libraries:<br>
<br>
<br>
Special exception for linking OpenVPN with Apache 2 licensed libraries:<br>
<br>
=C2=A0 =C2=A0In addition, as a special exception, OpenVPN Inc and contribut=
ors<br>
=C2=A0 =C2=A0give permission to link the code of this program to libraries =
with the<br>
=C2=A0 =C2=A0&quot;APACHE LICENSE, VERSION 2.0&quot;, and distribute linked=
 combination<br>
=C2=A0 =C2=A0including the two.=C2=A0 You must obey the GNU General Public =
License in<br>
=C2=A0 =C2=A0all respects for all of the code used other than these librari=
es.=C2=A0 If<br>
=C2=A0 =C2=A0you modify this file, you may extend this exception to your ve=
rsion of<br>
=C2=A0 =C2=A0the file, but you are not obligated to do so.=C2=A0 If you do =
not wish to<br>
=C2=A0 =C2=A0do so, delete this exception statement from your version.<br>
<br>
<br>
You might wonder why we are going for a generic Apache 2 exception <br>
rather than one targeted at mbed TLS specifically. We believe that a <br>
generic exemption is better since it also implicitly allows forks of <br>
mbed TLS and even if a SSL library might emerge in the future we do not <br>
have to discuss if it is a fork or not. Also granting an explicit <br>
exception for Apache 2 style licenses reaffirms the linking to OpenSSL.<br>
<br>
We also considered going for a change from GPL2 to GPL2+ but we think <br>
that GPL3 would hurt the ability to distribute OpenVPN as part of router <b=
r>
or other embedded devices as the GPL3 has been explicitly developed (at <br>
least in part) to make this use case harder/impossible <br>
(<a href=3D"https://en.wikipedia.org/wiki/Tivoization" rel=3D"noreferrer no=
referrer" target=3D"_blank">https://en.wikipedia.org/wiki/Tivoization</a>)<=
br>
<br>
If you are okay with this, please reply to this mail and confirm that. <br>
Otherwise we might be forced to remove and/or rewrite your code.<br>
<br>
<br>
As a reminder, the The current OpenSSL exception reads as follows <br>
(COPYING). We don&#39;t intend to change or remote it:<br>
<br>
=C2=A0 =C2=A0Special exception for linking OpenVPN with OpenSSL:<br>
<br>
=C2=A0 =C2=A0In addition, as a special exception, OpenVPN Inc gives<br>
=C2=A0 =C2=A0permission to link the code of this program with the OpenSSL<b=
r>
=C2=A0 =C2=A0library (or with modified versions of OpenSSL that use the sam=
e<br>
=C2=A0 =C2=A0license as OpenSSL), and distribute linked combinations includ=
ing<br>
=C2=A0 =C2=A0the two.=C2=A0 You must obey the GNU General Public License in=
 all<br>
=C2=A0 =C2=A0respects for all of the code used other than OpenSSL.=C2=A0 If=
 you modify<br>
=C2=A0 =C2=A0this file, you may extend this exception to your version of th=
e<br>
=C2=A0 =C2=A0file, but you are not obligated to do so.=C2=A0 If you do not =
wish to<br>
=C2=A0 =C2=A0do so, delete this exception statement from your version.<br>
<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank" re=
l=3D"noreferrer">Openvpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer noreferrer" target=3D"_blank">https://lists.sourceforge.net/=
lists/listinfo/openvpn-devel</a><br>
</blockquote></div>

--000000000000cb52d005f24c810d--

