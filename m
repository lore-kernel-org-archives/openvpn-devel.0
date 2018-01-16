MIME-Version: 1.0
Sender: emmanueldeloget53@...277...
In-Reply-To: <1516058323.3169.59.camel@...2316...>
References: <CAKh=nwF5PZ2CbEARe7-D=0dxt-XjRR-+2Z=16pENVzzxfgZM8A@...278...>
 <707c4845-6d3b-e9ba-0e8a-36f27d85bab3@...1856...>
 <CAKh=nwEFfwQnRTMc1D-4tb8DWOpJOPPD82fBZ2pRwNYdihJA8g@...278...>
 <9491d49e-a858-b3ad-21ab-1ee3b86ef41a@...1856...>
 <CAKh=nwGiHTZj8MqN6LmYjCAVAxGurOeatV8eVMPeELAGcXVXsg@...278...>
 <1516058323.3169.59.camel@...2316...>
From: Emmanuel Deloget <logout@...260...>
Date: Tue, 16 Jan 2018 01:30:51 +0100
Message-ID: <CAKh=nwHGW74CD+XVt9DCzpTiQQOX+cWEexmvxycx9ryNpXHSQA@...278...>
Content-Type: multipart/alternative; boundary="94eb2c06e58ed307ce0562d9d7ca"
Subject: Re: [Openvpn-devel] PKCS#11 - a little bit of help?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Bottomley <James.Bottomley@...2317...>
Cc: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

--94eb2c06e58ed307ce0562d9d7ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi James,

On Tue, Jan 16, 2018 at 12:18 AM, James Bottomley <
James.Bottomley@...2317...> wrote:

> On Tue, 2018-01-16 at 00:07 +0100, Emmanuel Deloget wrote:
> > While the number of required changes were quite small (and have no
> > impact on openvpn), this was quite a journey. I guess some of the
> > merits should go to RSA, Microsoft and Intel, for their incredible
> > effort in building comprehensive industry standards that are as
> > convoluted as they are comprehensive :) (I'm kidding ; I think I
> > begin to enjoy PKCS#11 and I definitely had some fun while playing
> > with my TPM2).
> >
> > Those who are interested can contact me. I will probably try to
> > write something about this somewhere (I don't know where yet).
>
> Just a note that there is an easier way of doing this.  The engine key
> patch:
>
> https://sourceforge.net/p/openvpn/mailman/message/36147533/
>
> Achieves the same thing somewhat more simply.  You use the tpm2 engine:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jejb/
> openssl_tpm2_engine.git/
>
> And convert an existing private key into engine format with
> create_tpm2_key and place it in /etc/openvpn/ where the private key
> file usually goes.  Then all private key signature transactions go via
> the TPM.
>

The engine is of interest (although it would require me to change all my
scripts to remove the intel TPM2 stack and replace it with IBM tools ;
there is no sane reason to keep both of them in my setup). I missed it when
I tried to find an openssl engine for TPM2. The fact that I choose a
PKCS#11 engine is now final, unfortunately, at least for now. But I'll keep
an eye on it.

For the openvpn patches, I would not go this way for multiple reasons
(number one being: I already have to many patches on many things around ;
it becomes difficult to handle after a while, so I try to be as upstream as
possible) ; but this is interesting as well.



>
> James
>
>
=E2=80=8BThanks for your links,

-- Emmanuel Deloget=E2=80=8B

--94eb2c06e58ed307ce0562d9d7ca
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:monospac=
e,monospace">Hi James,=C2=A0</div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On Tue, Jan 16, 2018 at 12:18 AM, James Bottomley <span di=
r=3D"ltr">&lt;<a href=3D"mailto:James.Bottomley@...2317..." target=3D"_blan=
k">James.Bottomley@...2317...</a>&gt;</span> wrote:<br><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex"><span class=3D"">On Tue, 2018-01-16 at 00:07 +0100, Emmanuel Del=
oget wrote:<br>
&gt; While the number of required changes were quite small (and have no<br>
&gt; impact on openvpn), this was quite a journey. I guess some of the<br>
&gt; merits should go to RSA, Microsoft and Intel, for their incredible<br>
&gt; effort in building comprehensive industry standards that are as<br>
&gt; convoluted as they are comprehensive :) (I&#39;m kidding ; I think I<b=
r>
&gt; begin to enjoy PKCS#11 and I definitely had some fun while playing<br>
&gt; with my TPM2).<br>
&gt;<br>
&gt; Those who are interested can contact me. I will probably try to<br>
&gt; write something about this somewhere (I don&#39;t know where yet).<br>
<br>
</span>Just a note that there is an easier way of doing this.=C2=A0 The eng=
ine key<br>
patch:<br>
<br>
<a href=3D"https://sourceforge.net/p/openvpn/mailman/message/36147533/" rel=
=3D"noreferrer" target=3D"_blank">https://sourceforge.net/p/<wbr>openvpn/ma=
ilman/message/<wbr>36147533/</a><br>
<br>
Achieves the same thing somewhat more simply.=C2=A0 You use the tpm2 engine=
:<br>
<br>
<a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm=
2_engine.git/" rel=3D"noreferrer" target=3D"_blank">https://git.kernel.org/=
pub/<wbr>scm/linux/kernel/git/jejb/<wbr>openssl_tpm2_engine.git/</a><br>
<br>
And convert an existing private key into engine format with<br>
create_tpm2_key and place it in /etc/openvpn/ where the private key<br>
file usually goes.=C2=A0 Then all private key signature transactions go via=
<br>
the TPM.<br></blockquote><div><br></div><div><div class=3D"gmail_default" s=
tyle=3D"font-family:monospace,monospace">The engine is of interest (althoug=
h it would require me to change all my scripts to remove the intel TPM2 sta=
ck and replace it with IBM tools ; there is no sane reason to keep both of =
them in my setup). I missed it when I tried to find an openssl engine for T=
PM2. The fact that I choose a PKCS#11 engine is now final, unfortunately, a=
t least for now. But I&#39;ll keep an eye on it.</div><div class=3D"gmail_d=
efault" style=3D"font-family:monospace,monospace"><br></div><div class=3D"g=
mail_default" style=3D"font-family:monospace,monospace">For the openvpn pat=
ches, I would not go this way for multiple reasons (number one being: I alr=
eady have to many patches on many things around ; it becomes difficult to h=
andle after a while, so I try to be as upstream as possible) ; but this is =
interesting as well.=C2=A0</div><br></div><div>=C2=A0</div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
James<br>
<br></font></span></blockquote><div><br></div><div class=3D"gmail_default" =
style=3D"font-family:monospace,monospace">=E2=80=8BThanks for your links,=
=C2=A0</div><div class=3D"gmail_default" style=3D"font-family:monospace,mon=
ospace"><br></div><div class=3D"gmail_default" style=3D"font-family:monospa=
ce,monospace">-- Emmanuel Deloget=E2=80=8B</div></div><br></div></div>

--94eb2c06e58ed307ce0562d9d7ca--

