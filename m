MIME-Version: 1.0
Sender: emmanueldeloget53@...277...
In-Reply-To: <9491d49e-a858-b3ad-21ab-1ee3b86ef41a@...1856...>
References: <CAKh=nwF5PZ2CbEARe7-D=0dxt-XjRR-+2Z=16pENVzzxfgZM8A@...278...>
 <707c4845-6d3b-e9ba-0e8a-36f27d85bab3@...1856...>
 <CAKh=nwEFfwQnRTMc1D-4tb8DWOpJOPPD82fBZ2pRwNYdihJA8g@...278...>
 <9491d49e-a858-b3ad-21ab-1ee3b86ef41a@...1856...>
From: Emmanuel Deloget <logout@...260...>
Date: Tue, 16 Jan 2018 00:07:44 +0100
Message-ID: <CAKh=nwGiHTZj8MqN6LmYjCAVAxGurOeatV8eVMPeELAGcXVXsg@...278...>
Content-Type: multipart/alternative; boundary="089e0826f81c9673b00562d8ae02"
Subject: Re: [Openvpn-devel] PKCS#11 - a little bit of help?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--089e0826f81c9673b00562d8ae02
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Steffan,

=E2=80=8B=E2=80=8BSorry fo=E2=80=8Br the delay - I was busy doing "things=
=E2=80=8B" :)


On Sat, Jan 6, 2018 at 12:11 AM, Steffan Karger <steffan@...1856...> wrote:

> Hi Emmanuel,
>
> On 03-01-18 18:13, Emmanuel Deloget wrote:
> > Hello Steffan,
> >
> > On Mon, Jan 1, 2018 at 4:36 PM, Steffan Karger <steffan@...1856...
> > <mailto:steffan@...1856...>> wrote:
> >
> >     Hi,
> >
> >     On 01-01-18 14:57, Emmanuel Deloget wrote:
> >     > I'm trying to get openvpn read my certificates from a TPM2 using a
> >     > specially crafted PKCS#11 provider (the existing tpm2-pk11 is qui=
te
> >     > limited for now but I might be able to extend it).
> >     >
> >     > However, the PKCS#11 API is not something I'm comfortable with,
> and I'd
> >     > like to know if there is some document (design or anything,
> really) that
> >     > could help me to understand what openvpn wants exactly in order
> for me
> >     > to provide the missing bits. I've read the documents at [1] but
> found
> >     > nothing here of interest (for me).
> >     >
> >     > So, does someone have any pointer?
> >
> >     You're right that OpenVPN's pkcs11 options lack some high-level
> >     documentation.  Maybe I can shed some light on the basics (probably
> >     taking a step further back than you need).
> >
> >     First, you need some shared object (.so, .dll) that provides the
> >     interface specified by the PKCS11 standard.  OpenVPN will load that
> >     module, and call its functions to provide private key operations.
> That
> >     shared object is usually provided by your smartcard vendor.  That
> shared
> >     object takes care of communication with the underlying key store
> (smart
> >     card, tpm, hsm, ...).  The openvpn manpage calls this a pkcs11
> >     'provider'.
> >
> >     $ openvpn --show-pkcs11-ids
> >     /usr/lib/x86_64-linux-gnu/pkcs11/gnome-keyring-pkcs11.so
> >
> >     The following objects are available for use.
> >     Each object shown below may be used as parameter to
> >     --pkcs11-id option please remember to use single quote mark.
> >
> >
> >
> > =E2=80=8BI seen that while testing. =E2=80=8B
> >
> >
> >
> >
> >     Certificate
> >            DN:             C=3DKG, ST=3DNA, O=3DOpenVPN-TEST, CN=3DTest=
-Client,
> >     emailAddress=3Dme@...430...
> >            Serial:         02
> >            Serialized id:
> >     Gnome\x20Keyring/1\x2E0/1\x3AUSER\x3ADEFAULT/Gnome2\
> x20Key\x20Storage/1A9D824585217F1BD54603E83F042F570A2EE9F2
> >
> >     (I have the openvpn client testkey in my local gnome keyring, to
> easily
> >     test pkcs11 without a hardware token.)
> >
> >     From that list, you pick the object you want to use, and specify the
> >     provider and id in your config file.  In this case:
> >
> >     pkcs11-providers
> >     "/usr/lib/x86_64-linux-gnu/pkcs11/gnome-keyring-pkcs11.so"
> >     pkcs11-id
> >     "Gnome\\x20Keyring/1\\x2E0/1\\x3AUSER\\x3ADEFAULT/Gnome2\\
> x20Key\\x20Storage/1B3B2BEBF36576443D3A903AFA8997221B93FCC1"
> >
> >     You specify this *instead* of the regular 'key' and 'cert' options.
> >     Note that you'll need toe escape backslashes.
> >
> >
> > =E2=80=8BGood to know :)=E2=80=8B
> >
> >
> >
> >     You should now be able to use pkcs11 for the private key operations.
> >
> >     Since each keystore behaves differently, I did not specify how to g=
et
> >     the private key in there.  But I guess your TPM vendor providers
> tooling
> >     for that.
> >
> >
>

=E2=80=8B<snip>=E2=80=8B



> >
> > In my understanding, and within a context of dual authentication (server
> > identifies client, client identifies server), I should see the following
> > set of operation:
> >
> > * fetch the certificate
> > * initiate communication and so some RSA magic
> > * everything's ok? continue
> >
> > Of course, I might be wrong. What I see is (with some printf within the
> > PKCS#11 provider, you can ignore them but they give you an idea of what
> > happens)
> >
> >
> =E2=80=8B <snip>=E2=80=8B
>
> >
> >
> > Unfortunately, there is no RSA-related log, so I cannot check what
> > openvpn is doing with the certificate it found - so at this point, I'm a
> > bit confused.
>
> It does not do any RSA operations, because it does not connect:
>
> Wed Jan  3 17:53:39 2018 us=3D959952 Attempting to establish TCP
> connection with [AF_INET6]2a01:240:1906:1:0:1850:6118:4075:443 [nonblock]
> Wed Jan  3 17:53:40 2018 us=3D961428 TCP: connect to
> [AF_INET6]2a01:240:1906:1:0:1850:6118:4075:443 failed: Connection refused
>
> ... and then it tears down the instance.
>
> TLS will only do the RSA operations after a few handshake messages have
> been exchanged, and it has something to sign.  If you connect to a real
> server (even with the wrong certificate), you should see more.
>


=E2=80=8BI got it a bit later. We have a =E2=80=8Bparticular way to connect=
 to our openvpn
instance. Before we do it, we have to tell the server we're going to
connect. And I forgot to do that ; as a result, the client does not even
find the server.

=E2=80=8BAnyway, I did some progress in my quest to have a working
TPM2-as-PKCS#11-provider. First of all, the tpm2-pk11 provider by Iwan
Timmer (https://github.com/irtimmer/tpm2-pk11)=E2=80=8B is able to read
certificates and private keys on a TPM2. It was a bit difficult to
understand how to configure things, but studying the code of both openvpn
and libpkcs11-helper did the trick. As a result, I was probably able to
connect to my server with the keys I got. Of course, the problem was now to
have the correct certificate (i.e. signed with the correct CA). It required
me to patch both tpm2-pk11 and libp11 to be able to use openssl to create a
CSR. But that eventually worked.

So, using the latest gits of tpm2-tss (https://github.com/intel/tpm2-tss,
the TPM2 system libraries), tpm2-abrmd (https://github.com/intel/tpm2-abrmd,
the TPM2 daemon), tpm2-tools (https://github.com/intel/tpm2-tools, tools to
manipulate the TPM2 state), libp11 (https://github.com/OpenSC/libp11,
including a PKCS#11 engine for OpenSSL) and tpm2-pk11 (
https://github.com/irtimmer/tpm2-pk11, a PKCS#11 provider for TPM2), it's
now possible to

* store RSA keys within the TPM2 (that part is done using tpm2-tools).
* sign a certificate request with OpenSSL using these keys (we are then
able to sign this CSR with our CA to generate the client certificate)
* use openvpn as an authentified-by-TPM2 client to connect to a
authentified server.

For testing, one can also install IBM's software TPM2 (
http://ibmswtpm.sourceforge.net/ibmswtpm2.html). Of course, you need a
decently recent linux kernel (4.9 or 4.10).

While the number of required changes were quite small (and have no impact
on openvpn), this was quite a journey. I guess some of the merits should go
to RSA, Microsoft and Intel, for their incredible effort in building
comprehensive industry standards that are as convoluted as they are
comprehensive :) (I'm kidding ; I think I begin to enjoy PKCS#11 and I
definitely had some fun while playing with my TPM2).

=E2=80=8BThose who are interested can contact me. =E2=80=8BI will probably =
try to write
something about this somewhere (I don't know where yet).

You may ask 'why is this important?'. To that I should answer that TPM2 are
pervasive (you cannot sell a Windows 10 compatible PC without a TPM or
TPM2) ; now, if you factor in the Spectre vulnerability, you may understand
that being able to store your secrets (your private RSA keys) in a
protected hardware device is of interest: if it's not in the memory then it
won't leak. So why not putting them in this TPM that you're very likely to
have instead of buying another piece of hardware? (but if you want one, you
should try a Nitrokey HSM ; they work great and they are quite cheap)



>
> -Steffan
>


=E2=80=8BBest regards and thank you Steffan for your support,

-- Emmanuel Deloget=E2=80=8B

--089e0826f81c9673b00562d8ae02
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:monospac=
e,monospace">Hello Steffan,=C2=A0</div><div class=3D"gmail_extra"><br></div=
><div class=3D"gmail_extra"><div class=3D"gmail_default" style=3D"font-fami=
ly:monospace,monospace">=E2=80=8B=E2=80=8BSorry fo=E2=80=8Br the delay - I =
was busy doing &quot;things=E2=80=8B&quot; :)</div><br></div><div class=3D"=
gmail_extra"><br><div class=3D"gmail_quote">On Sat, Jan 6, 2018 at 12:11 AM=
, Steffan Karger <span dir=3D"ltr">&lt;<a href=3D"mailto:steffan@...1856...=
" target=3D"_blank">steffan@...1856...</a>&gt;</span> wrote:<br><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">Hi Emmanuel,<br>
<span class=3D"gmail-"><br>
On 03-01-18 18:13, Emmanuel Deloget wrote:<br>
&gt; Hello Steffan,=C2=A0<br>
&gt;<br>
&gt; On Mon, Jan 1, 2018 at 4:36 PM, Steffan Karger &lt;<a href=3D"mailto:s=
teffan@...1856...">steffan@...1856...</a><br>
</span><div><div class=3D"gmail-h5">&gt; &lt;mailto:<a href=3D"mailto:steff=
an@...1856...">steffan@...1856...</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0On 01-01-18 14:57, Emmanuel Deloget wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; I&#39;m trying to get openvpn read my certific=
ates from a TPM2 using a<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; specially crafted PKCS#11 provider (the existi=
ng tpm2-pk11 is quite<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; limited for now but I might be able to extend =
it).=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; However, the PKCS#11 API is not something I&#3=
9;m comfortable with, and I&#39;d<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; like to know if there is some document (design=
 or anything, really) that<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; could help me to understand what openvpn wants=
 exactly in order for me<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; to provide the missing bits. I&#39;ve read the=
 documents at [1] but found<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; nothing here of interest (for me).=C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; So, does someone have any pointer?<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0You&#39;re right that OpenVPN&#39;s pkcs11 options =
lack some high-level<br>
&gt;=C2=A0 =C2=A0 =C2=A0documentation.=C2=A0 Maybe I can shed some light on=
 the basics (probably<br>
&gt;=C2=A0 =C2=A0 =C2=A0taking a step further back than you need).<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0First, you need some shared object (.so, .dll) that=
 provides the<br>
&gt;=C2=A0 =C2=A0 =C2=A0interface specified by the PKCS11 standard.=C2=A0 O=
penVPN will load that<br>
&gt;=C2=A0 =C2=A0 =C2=A0module, and call its functions to provide private k=
ey operations.=C2=A0 That<br>
&gt;=C2=A0 =C2=A0 =C2=A0shared object is usually provided by your smartcard=
 vendor.=C2=A0 That shared<br>
&gt;=C2=A0 =C2=A0 =C2=A0object takes care of communication with the underly=
ing key store (smart<br>
&gt;=C2=A0 =C2=A0 =C2=A0card, tpm, hsm, ...).=C2=A0 The openvpn manpage cal=
ls this a pkcs11<br>
&gt;=C2=A0 =C2=A0 =C2=A0&#39;provider&#39;.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0$ openvpn --show-pkcs11-ids<br>
&gt;=C2=A0 =C2=A0 =C2=A0/usr/lib/x86_64-linux-gnu/<wbr>pkcs11/gnome-keyring=
-pkcs11.so<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0The following objects are available for use.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Each object shown below may be used as parameter to=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0--pkcs11-id option please remember to use single qu=
ote mark.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; =E2=80=8BI seen that while testing. =E2=80=8B<br>
&gt;<br>
&gt; =C2=A0<br>
&gt;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Certificate<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0DN:=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0C=3DKG, ST=3DNA, O=3DOpenVPN-TEST, CN=3DTest-Cli=
ent,<br>
&gt;=C2=A0 =C2=A0 =C2=A0emailAddress=3Dme@...2372...<wbr>mydomain<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0Serial:=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A002<br>
&gt;=C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0Serialized id:<br>
&gt;=C2=A0 =C2=A0 =C2=A0Gnome\x20Keyring/1\x2E0/1\<wbr>x3AUSER\x3ADEFAULT/G=
nome2\<wbr>x20Key\x20Storage/<wbr>1A9D824585217F1BD54603E83F042F<wbr>570A2E=
E9F2<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0(I have the openvpn client testkey in my local gnom=
e keyring, to easily<br>
&gt;=C2=A0 =C2=A0 =C2=A0test pkcs11 without a hardware token.)<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0From that list, you pick the object you want to use=
, and specify the<br>
&gt;=C2=A0 =C2=A0 =C2=A0provider and id in your config file.=C2=A0 In this =
case:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0pkcs11-providers<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;/usr/lib/x86_64-linux-gnu/<wbr>pkcs11/gnome-k=
eyring-pkcs11.<wbr>so&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0pkcs11-id<br>
&gt;=C2=A0 =C2=A0 =C2=A0&quot;Gnome\\x20Keyring/1\\x2E0/1\\<wbr>x3AUSER\\x3=
ADEFAULT/Gnome2\\<wbr>x20Key\\x20Storage/<wbr>1B3B2BEBF36576443D3A903AFA899=
7<wbr>221B93FCC1&quot;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0You specify this *instead* of the regular &#39;key&=
#39; and &#39;cert&#39; options.<br>
&gt;=C2=A0 =C2=A0 =C2=A0Note that you&#39;ll need toe escape backslashes.<b=
r>
&gt;<br>
&gt;<br>
&gt; =E2=80=8BGood to know :)=E2=80=8B<br>
&gt;<br>
&gt; =C2=A0<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0You should now be able to use pkcs11 for the privat=
e key operations.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Since each keystore behaves differently, I did not =
specify how to get<br>
&gt;=C2=A0 =C2=A0 =C2=A0the private key in there.=C2=A0 But I guess your TP=
M vendor providers tooling<br>
&gt;=C2=A0 =C2=A0 =C2=A0for that.<br>
&gt;<br>
&gt;<br></div></div></blockquote><div><br></div><div><div class=3D"gmail_de=
fault" style=3D"font-family:monospace,monospace">=E2=80=8B&lt;snip&gt;=E2=
=80=8B</div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex"><div><div class=3D"gmail-h5">
&gt;<br>
&gt; In my understanding, and within a context of dual authentication (serv=
er<br>
&gt; identifies client, client identifies server), I should see the followi=
ng<br>
&gt; set of operation:=C2=A0<br>
&gt;<br>
&gt; * fetch the certificate<br>
&gt; * initiate communication and so some RSA magic<br>
&gt; * everything&#39;s ok? continue<br>
&gt;<br>
&gt; Of course, I might be wrong. What I see is (with some printf within th=
e<br>
&gt; PKCS#11 provider, you can ignore them but they give you an idea of wha=
t<br>
&gt; happens)<br>
&gt;<br>&gt;<div class=3D"gmail_default" style=3D"font-family:monospace,mon=
ospace;display:inline">=E2=80=8B &lt;snip&gt;=E2=80=8B</div><br>
&gt;<br>
&gt;<br>
&gt; Unfortunately, there is no RSA-related log, so I cannot check what<br>
&gt; openvpn is doing with the certificate it found - so at this point, I&#=
39;m a<br>
&gt; bit confused.<br>
<br>
</div></div>It does not do any RSA operations, because it does not connect:=
<br>
<span class=3D"gmail-"><br>
Wed Jan=C2=A0 3 17:53:39 2018 us=3D959952 Attempting to establish TCP<br>
connection with [AF_INET6]2a01:240:1906:1:0:<wbr>1850:6118:4075:443 [nonblo=
ck]<br>
Wed Jan=C2=A0 3 17:53:40 2018 us=3D961428 TCP: connect to<br>
[AF_INET6]2a01:240:1906:1:0:<wbr>1850:6118:4075:443 failed: Connection refu=
sed<br>
<br>
</span>... and then it tears down the instance.<br>
<br>
TLS will only do the RSA operations after a few handshake messages have<br>
been exchanged, and it has something to sign.=C2=A0 If you connect to a rea=
l<br>
server (even with the wrong certificate), you should see more.<br></blockqu=
ote><div><br></div><div><div class=3D"gmail_default" style=3D"font-family:m=
onospace,monospace"><br></div><div class=3D"gmail_default" style=3D"font-fa=
mily:monospace,monospace">=E2=80=8BI got it a bit later. We have a =E2=80=
=8Bparticular way to connect to our openvpn instance. Before we do it, we h=
ave to tell the server we&#39;re going to connect. And I forgot to do that =
; as a result, the client does not even find the server.=C2=A0</div></div><=
div><br></div><div><div class=3D"gmail_default" style=3D"font-family:monosp=
ace,monospace">=E2=80=8BAnyway, I did some progress in my quest to have a w=
orking TPM2-as-PKCS#11-provider. First of all, the tpm2-pk11 provider by Iw=
an Timmer (<a href=3D"https://github.com/irtimmer/tpm2-pk11)">https://githu=
b.com/irtimmer/tpm2-pk11)</a>=E2=80=8B is able to read certificates and pri=
vate keys on a TPM2. It was a bit difficult to understand how to configure =
things, but studying the code of both openvpn and libpkcs11-helper did the =
trick. As a result, I was probably able to connect to my server with the ke=
ys I got. Of course, the problem was now to have the correct certificate (i=
.e. signed with the correct CA). It required me to patch both tpm2-pk11 and=
 libp11 to be able to use openssl to create a CSR. But that eventually work=
ed.=C2=A0</div><div class=3D"gmail_default" style=3D"font-family:monospace,=
monospace"><br></div><div class=3D"gmail_default" style=3D"font-family:mono=
space,monospace">So, using the latest gits of tpm2-tss (<a href=3D"https://=
github.com/intel/tpm2-tss">https://github.com/intel/tpm2-tss</a>, the TPM2 =
system libraries), tpm2-abrmd (<a href=3D"https://github.com/intel/tpm2-abr=
md">https://github.com/intel/tpm2-abrmd</a>, the TPM2 daemon), tpm2-tools (=
<a href=3D"https://github.com/intel/tpm2-tools">https://github.com/intel/tp=
m2-tools</a>, tools to manipulate the TPM2 state), libp11 (<a href=3D"https=
://github.com/OpenSC/libp11">https://github.com/OpenSC/libp11</a>, includin=
g a PKCS#11 engine for OpenSSL) and tpm2-pk11 (<a href=3D"https://github.co=
m/irtimmer/tpm2-pk11">https://github.com/irtimmer/tpm2-pk11</a>, a PKCS#11 =
provider for TPM2), it&#39;s now possible to=C2=A0</div><div class=3D"gmail=
_default" style=3D"font-family:monospace,monospace"><br></div><div class=3D=
"gmail_default" style=3D"font-family:monospace,monospace">* store RSA keys =
within the TPM2 (that part is done using tpm2-tools).=C2=A0</div><div class=
=3D"gmail_default" style=3D"font-family:monospace,monospace">* sign a certi=
ficate request with OpenSSL using these keys (we are then able to sign this=
 CSR with our CA to generate the client certificate)</div><div class=3D"gma=
il_default" style=3D"font-family:monospace,monospace">* use openvpn as an a=
uthentified-by-TPM2 client to connect to a authentified server.</div><div c=
lass=3D"gmail_default" style=3D"font-family:monospace,monospace"><br></div>=
<div class=3D"gmail_default" style=3D"font-family:monospace,monospace">For =
testing, one can also install IBM&#39;s software TPM2 (<a href=3D"http://ib=
mswtpm.sourceforge.net/ibmswtpm2.html">http://ibmswtpm.sourceforge.net/ibms=
wtpm2.html</a>). Of course, you need a decently recent linux kernel (4.9 or=
 4.10).</div><div class=3D"gmail_default" style=3D"font-family:monospace,mo=
nospace"><br></div><div class=3D"gmail_default" style=3D"font-family:monosp=
ace,monospace">While the number of required changes were quite small (and h=
ave no impact on openvpn), this was quite a journey. I guess some of the me=
rits should go to RSA, Microsoft and Intel, for their incredible effort in =
building comprehensive industry standards that are as convoluted as they ar=
e comprehensive :) (I&#39;m kidding ; I think I begin to enjoy PKCS#11 and =
I definitely had some fun while playing with my TPM2).</div><br></div><div>=
<div class=3D"gmail_default" style=3D"font-family:monospace,monospace">=E2=
=80=8BThose who are interested can contact me. =E2=80=8BI will probably try=
 to write something about this somewhere (I don&#39;t know where yet).=C2=
=A0</div><div class=3D"gmail_default" style=3D"font-family:monospace,monosp=
ace"><br></div><div class=3D"gmail_default" style=3D"font-family:monospace,=
monospace">You may ask &#39;why is this important?&#39;. To that I should a=
nswer that TPM2 are pervasive (you cannot sell a Windows 10 compatible PC w=
ithout a TPM or TPM2) ; now, if you factor in the Spectre vulnerability, yo=
u may understand that being able to store your secrets (your private RSA ke=
ys) in a protected hardware device is of interest: if it&#39;s not in the m=
emory then it won&#39;t leak. So why not putting them in this TPM that you&=
#39;re very likely to have instead of buying another piece of hardware? (bu=
t if you want one, you should try a Nitrokey HSM ; they work great and they=
 are quite cheap)</div><br></div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
<span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br>
-Steffan<br></font></span></blockquote><div><br></div><div class=3D"gmail_d=
efault" style=3D"font-family:monospace,monospace"><br></div><div class=3D"g=
mail_default" style=3D"font-family:monospace,monospace">=E2=80=8BBest regar=
ds and thank you Steffan for your support,=C2=A0</div><div class=3D"gmail_d=
efault" style=3D"font-family:monospace,monospace"><br></div><div class=3D"g=
mail_default" style=3D"font-family:monospace,monospace">-- Emmanuel Deloget=
=E2=80=8B</div></div></div><div class=3D"gmail_extra"><div class=3D"gmail_d=
efault" style=3D"font-family:monospace,monospace"><br></div></div></div>

--089e0826f81c9673b00562d8ae02--

