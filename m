MIME-Version: 1.0
In-Reply-To: <CAOAUwZGs4934tC9P3zvmrN6qp-L9vkSMOi3_UwXT4Q7NCvdp5w@...278...>
References: <CAOAUwZH8aRg-5XLJaYjpzw6y9yptx-ma7QJVPJT-yKFE7cmUrw@...278...>
	<c3f91fee-f629-fd60-c66c-19d45df6f24f@...1856...>
	<CAOAUwZF0LYNAYESg1fKeNUhJr70pLcf89HTyxTQmf2S3RnoUBA@...278...>
	<0cdcbed7-801c-9cec-cd03-1252c06b4466@...1856...>
	<CAOAUwZEiSjAEmTka=w-4TePAoGEZBZG1r_5gS-wpXL+TLX7qCQ@...278...>
	<20170213083137.GK93896@...1296...>
	<CAOAUwZF2-KXfMTwOuLj-B3wzWtD-i-8NytNkbS3gyvexaCpWGw@...278...>
	<20170213175000.GU93896@...1296...>
	<b38fcbe0-fc2b-1bd5-ac98-f930334b6925@...2080...>
	<CAOAUwZGs4934tC9P3zvmrN6qp-L9vkSMOi3_UwXT4Q7NCvdp5w@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 13 Feb 2017 16:34:39 -0500
Message-ID: <CAKuzo_gwjVdfLbqAQH=4PyvKU2Hha6cd3dJZGkRBTkDTCiB7aQ@...278...>
Content-Type: multipart/alternative; boundary=001a1146fde033076d05487038f8
Subject: Re: [Openvpn-devel] [PATCH] Fix building with LibreSSL 2.5.1 by
 cleaning a hack.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Olivier W <olivierw.ml@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1146fde033076d05487038f8
Content-Type: text/plain; charset=UTF-8

Hi,

On Mon, Feb 13, 2017 at 3:55 PM, Olivier W <olivierw.ml@...277...> wrote:

> >> That's a not exactly helpful error message... :( - I tend to just turn
> >> off SSL on stuff that goes to public mailing lists anyway if it causes
> >> issues...
> >
> > OpenSSL errors requires quite some efforts to get used to.  And in
> > addition the git-send-email errors on top doesn't always make life
> easier.
>
> I've just tried git-send-email with "--smtp-debug=1" and the error
> isn't much useful, I'm getting:
> "...
> Net::SMTP=GLOB(0x8048189a8)<<< 250 SMTPUTF8
> Net::SMTP=GLOB(0x8048189a8)>>> STARTTLS
> Net::SMTP=GLOB(0x8048189a8)<<< 220 2.0.0 Ready to start TLS
> Net::SMTP=GLOB(0x8048189a8)>>> STARTTLS
> Net::SMTP: Net::Cmd::getline(): unexpected EOF on command channel:
> Connection reset by peer at /usr/local/libexec/git-core/git-send-email
> line 1371.
> STARTTLS failed!  at /usr/local/libexec/git-core/git-send-email line
> 1371."
>

On Debian jessie, the following .gitconfig works fo me.

[sendemail]
          smtpEncryption = tls
          smtpServer = smtp.gmail.com
          smtpUser = user.name@...277... <selva.nair@...277...>
          smtpServerPort = 587

No smtpsslcertpath specified, I suppose it verifies the cert using
/etc/ssl/certs as the capath, which is the default.

Possibly your /etc/ssl/cert.pem is to blame? I do not have such a file, so
no idea what it contains.

Selva

--001a1146fde033076d05487038f8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Mon, Feb 13, 2017 at 3:55 PM, Olivie=
r W <span dir=3D"ltr">&lt;<a href=3D"mailto:olivierw.ml@...277..." target=
=3D"_blank">olivierw.ml@...277...</a>&gt;</span> wrote:<br><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;b=
order-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex"=
><div id=3D"m_-6106276495154256903m_1111471421777192376gmail-:35b" class=3D=
"m_-6106276495154256903m_1111471421777192376gmail-a3s m_-610627649515425690=
3m_1111471421777192376gmail-aXjCH m_-6106276495154256903m_11114714217771923=
76gmail-m15a39468b963afde">&gt;&gt; That&#39;s a not exactly helpful error =
message... :( - I tend to just turn<br>
&gt;&gt; off SSL on stuff that goes to public mailing lists anyway if it ca=
uses<br>
&gt;&gt; issues...<br>
&gt;<br>
&gt; OpenSSL errors requires quite some efforts to get used to.=C2=A0 And i=
n<br>
&gt; addition the git-send-email errors on top doesn&#39;t always make life=
 easier.<br>
<br>
I&#39;ve just tried git-send-email with &quot;--smtp-debug=3D1&quot; and th=
e error<br>
isn&#39;t much useful, I&#39;m getting:<br>
&quot;...<br>
Net::SMTP=3DGLOB(0x8048189a8)&lt;&lt;&lt; 250 SMTPUTF8<br>
Net::SMTP=3DGLOB(0x8048189a8)&gt;&gt;&gt; STARTTLS<br>
Net::SMTP=3DGLOB(0x8048189a8)&lt;&lt;&lt; 220 2.0.0 Ready to start TLS<br>
Net::SMTP=3DGLOB(0x8048189a8)&gt;&gt;&gt; STARTTLS<br>
Net::SMTP: Net::Cmd::getline(): unexpected EOF on command channel:<br>
Connection reset by peer at /usr/local/libexec/git-core/gi<wbr>t-send-email=
<br>
line 1371.<br>
STARTTLS failed!=C2=A0 at /usr/local/libexec/git-core/gi<wbr>t-send-email l=
ine 1371.&quot;</div></blockquote></div><br>On Debian jessie, the following=
 .gitconfig works fo me.</div><div class=3D"gmail_extra"><br></div><div cla=
ss=3D"gmail_extra"><div class=3D"gmail_extra">[sendemail]</div><div class=
=3D"gmail_extra">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smtpEncryption =3D tls<=
/div><div class=3D"gmail_extra">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smtpServ=
er =3D <a href=3D"http://smtp.gmail.com" target=3D"_blank">smtp.gmail.com</=
a></div><div class=3D"gmail_extra">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smtpU=
ser =3D <a href=3D"http://user.name" target=3D"_blank">user.name</a><a href=
=3D"mailto:selva.nair@...277..." target=3D"_blank">@gmail.com</a></div><div=
 class=3D"gmail_extra">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 smtpServerPort =
=3D 587</div><div><br></div><div>No smtpsslcertpath specified, I suppose it=
 verifies the cert using /etc/ssl/certs as the capath, which is the default=
.</div><div><br></div><div>Possibly your /etc/ssl/cert.pem is to blame? I d=
o not have such a file, so no idea what it contains.</div><div><br></div><d=
iv>Selva</div></div></div>

--001a1146fde033076d05487038f8--

