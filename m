MIME-Version: 1.0
Sender: r.owen.mays@...277...
In-Reply-To: <8d258197-8137-aa00-043f-132d5e06faa6@...515...>
References: <CACtGRr8ZoT9xi_MFsqOrRnGEAZqM9yVwZCCy1H1zWDpc0PGo3Q@...278...>
 <8d258197-8137-aa00-043f-132d5e06faa6@...515...>
From: Lefty <leftygamer@...277...>
Date: Sun, 29 Oct 2017 10:09:47 -0700
Message-ID: <CACtGRr-rHVMcJK8Hgxkw3MEE4D+Taovij=L=g8YqvTDk=X+vJQ@...278...>
Content-Type: multipart/alternative; boundary="f403043e2154054273055cb2985c"
Subject: Re: [Openvpn-devel] Windows build 2.4.4 fails signature verification
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: Lefty <leftygamer@...277...>, openvpn-devel@lists.sourceforge.net

--f403043e2154054273055cb2985c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Samuli. I mis-read the description and thought that your "new
key" was being used for all Windows releases. The download verified
correctly with the mailing list key.

-Lefty

On Fri, Oct 27, 2017 at 12:31 AM, Samuli Sepp=C3=A4nen <samuli@...515...>
wrote:

> On 27/10/2017 08:20, Lefty wrote:
> > Hi all,
> >
> > I recently downloaded the openvpn-install-2.4.4-I601.exe Windows
> > installer, along with the openvpn-install-2.4.4-I601.exe.asc signature
> file.
> >
> > I imported Samuli's new key ( fingerprint 6D04 F8F1 B017 3111 F499 795E
> > 2958 4D9F 4086 4578).
> > When I run PGP I get the following output:
> >
> > gpg: armor header: Version: GnuPG v1
> > gpg: assuming signed data in 'openvpn-install-2.4.4-I601.exe'
> > gpg: Signature made 09/26/17 06:19:55 Pacific Daylight Time
> > gpg:                using RSA key D72AF3448CC2B034
> > gpg: Can't check signature: No public key
> >
> > It appears the installer has been signed with the "Security Mailing List
> > GPG Key" instead of the key described on the sig page.
> >
> > Am I doing the verification wrong?
> > Any suggestions much appreciated!
> >
> > -Lefty
> >
>
> Hi,
>
> There's a link to the Security Mailing List key on the GnuPG public key
> page:
>
> <https://openvpn.net/index.php/open-source/documentation/sig.html>
>
> As mentioned on that page the Security Mailing List key has been used to
> sign releases from 2.3.16 and 2.4.3 onwards.
>
> I hope we don't have to shuffle the keys anymore in the near future.
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>

--f403043e2154054273055cb2985c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thank you Samuli. I mis-read the description and thou=
ght that your &quot;new key&quot; was being used for all Windows releases. =
The download verified correctly with the mailing list key.<br><br></div>-Le=
fty<br></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On F=
ri, Oct 27, 2017 at 12:31 AM, Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:samuli@...515..." target=3D"_blank">samuli@...515...</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><di=
v class=3D"h5">On 27/10/2017 08:20, Lefty wrote:<br>
&gt; Hi all,<br>
&gt;<br>
&gt; I recently downloaded the openvpn-install-2.4.4-I601.exe Windows<br>
&gt; installer, along with the openvpn-install-2.4.4-I601.<wbr>exe.asc sign=
ature file.<br>
&gt;<br>
&gt; I imported Samuli&#39;s new key ( fingerprint 6D04 F8F1 B017 3111 F499=
 795E<br>
&gt; 2958 4D9F 4086 4578).<br>
&gt; When I run PGP I get the following output:<br>
&gt;<br>
&gt; gpg: armor header: Version: GnuPG v1<br>
&gt; gpg: assuming signed data in &#39;openvpn-install-2.4.4-I601.<wbr>exe&=
#39;<br>
&gt; gpg: Signature made 09/26/17 06:19:55 Pacific Daylight Time<br>
&gt; gpg:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 using RSA key D72AF3448CC2B034<br>
&gt; gpg: Can&#39;t check signature: No public key<br>
&gt;<br>
&gt; It appears the installer has been signed with the &quot;Security Maili=
ng List<br>
&gt; GPG Key&quot; instead of the key described on the sig page.<br>
&gt;<br>
&gt; Am I doing the verification wrong?<br>
&gt; Any suggestions much appreciated!<br>
&gt;<br>
&gt; -Lefty<br>
&gt;<br>
<br>
</div></div>Hi,<br>
<br>
There&#39;s a link to the Security Mailing List key on the GnuPG public key=
<br>
page:<br>
<br>
&lt;<a href=3D"https://openvpn.net/index.php/open-source/documentation/sig.=
html" rel=3D"noreferrer" target=3D"_blank">https://openvpn.net/index.<wbr>p=
hp/open-source/documentation/<wbr>sig.html</a>&gt;<br>
<br>
As mentioned on that page the Security Mailing List key has been used to<br>
sign releases from 2.3.16 and 2.4.3 onwards.<br>
<br>
I hope we don&#39;t have to shuffle the keys anymore in the near future.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Samuli Sepp=C3=A4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
</font></span></blockquote></div><br></div>

--f403043e2154054273055cb2985c--

