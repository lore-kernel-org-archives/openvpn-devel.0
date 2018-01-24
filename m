MIME-Version: 1.0
Sender: emmanueldeloget53@...277...
In-Reply-To: <CAKuzo_jG-O8tc5RH5h-ZhS+HqYvqifdP7wwj3BLdf_LKEv-_og@...278...>
References: <CAKh=nwEOYB6Ab42xZUPkaHEWDwx-ECJVn79kh-rz0Y8HvG4Dbw@...278...>
 <20180117131046.32402-1-logout@...260...>
 <1308db23-8bcc-83e9-ffb7-d6badff095e1@...1856...>
 <CAKuzo_jG-O8tc5RH5h-ZhS+HqYvqifdP7wwj3BLdf_LKEv-_og@...278...>
From: Emmanuel Deloget <logout@...260...>
Date: Wed, 24 Jan 2018 12:33:01 +0100
Message-ID: <CAKh=nwHSuaHjDRHFw3b_kaASDyYMCrjph8i77NmzgjEvEVrjYA@...278...>
Content-Type: multipart/alternative; boundary="001a11426a08b59ee90563840610"
Subject: Re: [Openvpn-devel] [PATCH v3 1/2] OpenSSL: remove some EVP_PKEY
 type checks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Steffan Karger <steffan@...1856...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a11426a08b59ee90563840610
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

and sorry for the delay (things like 'real life', you know).

On Sat, Jan 20, 2018 at 3:22 PM, Selva Nair <selva.nair@...277...> wrote:

> Hi,
>
> On Sat, Jan 20, 2018 at 6:30 AM, Steffan Karger <steffan@...1856...> wrot=
e:
> > Hi,
> >
> > On 17-01-18 14:10, Emmanuel Deloget wrote:
> >> Calling EVP_KEY_id() before EVP_PKEY_get0_*() is unnecessary as
> >> the same check is also performed in the later.
> >>
> >> We also make the code a bit better by not calling the various
> >> EVP_PKEY_get0_*() functions twice (this needs a bit or reordering to
> >> avoid introducing yet another #ifndef OPENSSL_NO_EC in the code).
> >>
> >> Signed-off-by: Emmanuel Deloget <logout@...260...>
> >> ---
>
> ..
>
> > Unfortunately, OpenSSL 1.1.0 treats calling EVP_PKEY_get0_foo on a
> > non-foo key as an error.  Running 'make check' with this patch and
> > openssl 1.1.0 fails:
> >
> > Sat Jan 20 12:23:41 2018 Control Channel: TLSv1.2, cipher TLSv1.2
> > ECDHE-RSA-AES256-GCM-SHA384, 2048 bit RSA
> > Sat Jan 20 12:23:41 2018 OpenSSL: error:06078081:digital envelope
> > routines:EVP_PKEY_get0_DSA:expecting a dsa key
> > Sat Jan 20 12:23:41 2018 OpenSSL: error:0608308E:digital envelope
> > routines:EVP_PKEY_get0_EC_KEY:expecting a ec key
> > Sat Jan 20 12:23:41 2018 TLS_ERROR: BIO read tls_read_plaintext error
> >
> > So, NAK.  (And Selva gets to keep EPV_PKEY_id() ;-) )
> >
> > Sorry for not spotting this earlier, could have saved us quite a bit of
> > work...
>


=E2=80=8BI should have spotted that before I sent the change, but I only te=
sted it
with 1.0.2 and compile-tested it against 1.1. I'm going to refactor my test
environment in order to avoid any further error like this one.



>
> I'm surprised that my argument about
>
> if (EVP_PKEY_id(foo) =3D=3D ...EC..) { do EC stuff }
> else if (EVP_PKEY_id(foo) =3D=3D ..RSA..) { do RSA stuff }
>
> or switch(EVP_PKEY_id(foo))
>
> being stylistically better[tm] did not work!
>
> Still pleased by the end result. Now I get to spit out some of the
> "if (EVP_PKEY_get0_RSA(..))"  that was pushed down my throat :).
> For patches already on the ML will do so after review.
>
>
=E2=80=8BI like the switch - I find it elegant - but it does not avoid an i=
nternal
'if', so the code would look like:

switch (EVP_PKEY_id(foo)) {
case ..RSA..: {
    RSA *rsa =3D EVP_PKEY_get0_RSA(foo);
    if (rsa) {
       openvpn_printf(...);
    }
  }
  break;
case ...
}

=E2=80=8BIf this is acceptable, I can =E2=80=8Brespin patch 2. Otherwise, f=
eel free to
discard both patch 2 and patch 3 of the series as any change in patch 2
would not be a largen enhancement of the already existing code.



> Selva
>
>
=E2=80=8BBest regards,

-- Emmanuel Deloget
=E2=80=8B

--001a11426a08b59ee90563840610
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:monospac=
e,monospace">Hello,=C2=A0</div><div class=3D"gmail_default" style=3D"font-f=
amily:monospace,monospace"><br></div><div class=3D"gmail_default" style=3D"=
font-family:monospace,monospace">and sorry for the delay (things like &#39;=
real life&#39;, you know).=C2=A0</div><div class=3D"gmail_extra"><br><div c=
lass=3D"gmail_quote">On Sat, Jan 20, 2018 at 3:22 PM, Selva Nair <span dir=
=3D"ltr">&lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank">selv=
a.nair@...277...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">Hi,<br>
<span class=3D"gmail-"><br>
On Sat, Jan 20, 2018 at 6:30 AM, Steffan Karger &lt;<a href=3D"mailto:steff=
an@...1856...">steffan@...1856...</a>&gt; wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; On 17-01-18 14:10, Emmanuel Deloget wrote:<br>
&gt;&gt; Calling EVP_KEY_id() before EVP_PKEY_get0_*() is unnecessary as<br>
&gt;&gt; the same check is also performed in the later.<br>
&gt;&gt;<br>
&gt;&gt; We also make the code a bit better by not calling the various<br>
&gt;&gt; EVP_PKEY_get0_*() functions twice (this needs a bit or reordering =
to<br>
&gt;&gt; avoid introducing yet another #ifndef OPENSSL_NO_EC in the code).<=
br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Emmanuel Deloget &lt;<a href=3D"mailto:logout@...2375...=
0...">logout@...260...</a>&gt;<br>
&gt;&gt; ---<br>
<br>
</span>..<br>
<span class=3D"gmail-"><br>
&gt; Unfortunately, OpenSSL 1.1.0 treats calling EVP_PKEY_get0_foo on a<br>
&gt; non-foo key as an error.=C2=A0 Running &#39;make check&#39; with this =
patch and<br>
&gt; openssl 1.1.0 fails:<br>
&gt;<br>
&gt; Sat Jan 20 12:23:41 2018 Control Channel: TLSv1.2, cipher TLSv1.2<br>
&gt; ECDHE-RSA-AES256-GCM-SHA384, 2048 bit RSA<br>
&gt; Sat Jan 20 12:23:41 2018 OpenSSL: error:06078081:digital envelope<br>
&gt; routines:EVP_PKEY_get0_DSA:<wbr>expecting a dsa key<br>
&gt; Sat Jan 20 12:23:41 2018 OpenSSL: error:0608308E:digital envelope<br>
&gt; routines:EVP_PKEY_get0_EC_KEY:<wbr>expecting a ec key<br>
&gt; Sat Jan 20 12:23:41 2018 TLS_ERROR: BIO read tls_read_plaintext error<=
br>
&gt;<br>
&gt; So, NAK.=C2=A0 (And Selva gets to keep EPV_PKEY_id() ;-) )<br>
&gt;<br>
&gt; Sorry for not spotting this earlier, could have saved us quite a bit o=
f<br>
&gt; work...<br></span></blockquote><div><br></div><div><div class=3D"gmail=
_default" style=3D"font-family:monospace,monospace"><br></div><div class=3D=
"gmail_default" style=3D"font-family:monospace,monospace">=E2=80=8BI should=
 have spotted that before I sent the change, but I only tested it with 1.0.=
2 and compile-tested it against 1.1. I&#39;m going to refactor my test envi=
ronment in order to avoid any further error like this one.=C2=A0</div><br><=
/div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><sp=
an class=3D"gmail-">
<br>
</span>I&#39;m surprised that my argument about<br>
<br>
if (EVP_PKEY_id(foo) =3D=3D ...EC..) { do EC stuff }<br>
else if (EVP_PKEY_id(foo) =3D=3D ..RSA..) { do RSA stuff }<br>
<br>
or switch(EVP_PKEY_id(foo))<br>
<br>
being stylistically better[tm] did not work!<br>
<br>
Still pleased by the end result. Now I get to spit out some of the<br>
&quot;if (EVP_PKEY_get0_RSA(..))&quot;=C2=A0 that was pushed down my throat=
 :).<br>
For patches already on the ML will do so after review.<br>
<span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br></font></span></bl=
ockquote><div><br></div><div><div class=3D"gmail_default" style=3D"font-fam=
ily:monospace,monospace">=E2=80=8BI like the switch - I find it elegant - b=
ut it does not avoid an internal &#39;if&#39;, so the code would look like:=
</div><div class=3D"gmail_default" style=3D"font-family:monospace,monospace=
"><br></div><div class=3D"gmail_default" style=3D"font-family:monospace,mon=
ospace">switch (EVP_PKEY_id(foo)) {</div><div class=3D"gmail_default" style=
=3D"font-family:monospace,monospace">case ..RSA..: {</div><div class=3D"gma=
il_default" style=3D"font-family:monospace,monospace">=C2=A0 =C2=A0 RSA *rs=
a =3D EVP_PKEY_get0_RSA(foo);</div><div class=3D"gmail_default" style=3D"fo=
nt-family:monospace,monospace">=C2=A0 =C2=A0 if (rsa) {</div><div class=3D"=
gmail_default" style=3D"font-family:monospace,monospace">=C2=A0 =C2=A0 =C2=
=A0 =C2=A0openvpn_printf(...);</div><div class=3D"gmail_default" style=3D"f=
ont-family:monospace,monospace">=C2=A0 =C2=A0 }</div><div class=3D"gmail_de=
fault" style=3D"font-family:monospace,monospace">=C2=A0 }</div><div class=
=3D"gmail_default" style=3D"font-family:monospace,monospace">=C2=A0 break;<=
/div><div class=3D"gmail_default" style=3D"font-family:monospace,monospace"=
>case ...</div><div class=3D"gmail_default" style=3D"font-family:monospace,=
monospace">}<br></div><br></div><div><div class=3D"gmail_default" style=3D"=
font-family:monospace,monospace">=E2=80=8BIf this is acceptable, I can =E2=
=80=8Brespin patch 2. Otherwise, feel free to discard both patch 2 and patc=
h 3 of the series as any change in patch 2 would not be a largen enhancemen=
t of the already existing code.=C2=A0</div><br></div><div><div class=3D"gma=
il_default" style=3D"font-family:monospace,monospace"><span style=3D"font-f=
amily:arial,sans-serif">=C2=A0</span><br></div></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex"><span class=3D"gmail-HOEnZb"><font color=3D"#88=
8888">
Selva<br>
</font></span><div class=3D"gmail-HOEnZb"><div class=3D"gmail-h5"><br></div=
></div></blockquote><div><br></div><div class=3D"gmail_default" style=3D"fo=
nt-family:monospace,monospace">=E2=80=8BBest regards,=C2=A0</div><div><div =
class=3D"gmail_default" style=3D"font-family:monospace,monospace"><br></div=
><div class=3D"gmail_default" style=3D"font-family:monospace,monospace">-- =
Emmanuel Deloget</div></div><div class=3D"gmail_default" style=3D"font-fami=
ly:monospace,monospace">=E2=80=8B</div></div></div></div>

--001a11426a08b59ee90563840610--

