MIME-Version: 1.0
References: <CAFHpkQEbh-5aOm-R7HPUBYq2TcFXYQ=XNd8rAo3955LVFjaK9Q@...278...>
 <3437a0a5-6522-9f29-4e98-b3b90f490f4d@...1147...>
 <CAFHpkQHAhBJctSON82bstHdcq89z8TLAyRA5M443yoTa6oKxag@...278...>
In-Reply-To: <CAFHpkQHAhBJctSON82bstHdcq89z8TLAyRA5M443yoTa6oKxag@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 13 Jan 2021 14:10:10 -0500
Message-ID: <CAKuzo_i+As22Fnoe-jO7MeuaqqfaaXeuaMKHxz6iU8NnNKGMzw@...278...>
Content-Type: multipart/alternative; boundary="0000000000004f80ba05b8cce4db"
Subject: Re: [Openvpn-devel] is it possible to store saved password in tpm
 instead of registry ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: Jan Just Keijser <janjust@...1147...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000004f80ba05b8cce4db
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

The blob stored in the registry is encrypted by DPAPI and requires access
to the user's session to decrypt. No matter where the blob is stored, if an
attacker has access to the session, anything the GUI can read can be read
by the attacker too.

That said, if there is a well-defined API for protecting data using a
non-exportable key in TPM, respecting security boundaries, we could use it.
The blob has to be still stored in registry or Windows password store
(which also stores it in registry). TPM is useful for storing
non-exportable private keys. For exportable data, if at all possible and
space permits, I see little point in putting it in TPM.

DPAPI supports an app-specific salt, and we could have it wrapped by TPM to
add some extra protection but I would be wary of inventing our own schemes
like that.

Storing the certificate private key in TPM makes sense.

Selva

On Wed, Jan 13, 2021 at 1:31 PM =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=
=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:

>
>
> =D1=81=D1=80, 13 =D1=8F=D0=BD=D0=B2. 2021 =D0=B3. =D0=B2 22:01, Jan Just =
Keijser <janjust@...1147...>:
>
>> Hi,
>>
>> On 13/01/21 17:20, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
>> > Hello,
>> >
>> > if user save password, it might be stolen from well known location
>> > (there are popular password stealers).
>> >
>> > in theory, is it possible to keep password in tpm ? will it prevent
>> > password from being stolen ?
>> >
>> in theory, yes, but as always, it depends on the circumstances.
>>
>> With TPM 1.2 you can only store a very limited amount of data in the TPM
>> chip; the (open source) implementation I have seen (tss, trousers) store
>>
>
> I meant openvpn-gui + user/password authentication + password is kept in
> registry encrypted by data protection api (not clear text, but might be
> decrypted and stolen easily).
>
> trousers is linux, right ?
>
>
>> a key in the TPM to scramble other data with; thus, you can encrypt a
>> private key or password with a key stored on the TPM and only if you
>> have the TPM will you be able to decrypt it.
>> I've never been particularly impressed with the security of this setup,
>> however, as trousers seems to suggest to store the actualy decryption
>> key in an environment variable...
>>
>> With TPM 2.0 you can store more data in the chip, including a full
>> private key. This makes it behave more like a regular PKCS#11 device,
>> where you store the private key, not the user password on it. Of course,
>> it will/should also be possible to store a user password on it.
>>
>> cheers,
>>
>> JJK
>>
>> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--0000000000004f80ba05b8cce4db
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div><div>The blob stored in=
 the registry is encrypted by DPAPI and requires access to the user&#39;s s=
ession to decrypt. No matter where the blob is stored, if an attacker has a=
ccess to the session, anything the GUI can read can be read by the attacker=
 too.</div><div><br></div><div>That said, if there is a well-defined API fo=
r protecting data using a non-exportable key in TPM, respecting security bo=
undaries, we could use it. The blob has to be still=C2=A0stored in registry=
 or Windows password store (which also stores it in registry). TPM is usefu=
l for storing=C2=A0 non-exportable private keys. For exportable data, if at=
 all possible and space permits, I see little point in putting it in TPM.</=
div></div><div><br></div>DPAPI supports an app-specific salt, and we could =
have it wrapped by TPM to add some extra protection but I would be wary of =
inventing our own schemes like that.<div><br></div><div>Storing the certifi=
cate private key in TPM makes sense.</div><div><br></div><div>Selva</div><d=
iv><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On =
Wed, Jan 13, 2021 at 1:31 PM =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=
=B8=D1=86=D0=B8=D0=BD &lt;<a href=3D"mailto:chipitsine@...277..." target=3D=
"_blank">chipitsine@...277...</a>&gt; wrote:<br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><b=
r><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D1=81=
=D1=80, 13 =D1=8F=D0=BD=D0=B2. 2021 =D0=B3. =D0=B2 22:01, Jan Just Keijser =
&lt;<a href=3D"mailto:janjust@...1147..." target=3D"_blank">janjust@...2303...=
...</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,=
<br>
<br>
On 13/01/21 17:20, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:<br>
&gt; Hello,<br>
&gt;<br>
&gt; if user save password, it might be stolen from well known location <br>
&gt; (there are popular password stealers).<br>
&gt;<br>
&gt; in theory, is it possible to keep password in tpm ? will it prevent <b=
r>
&gt; password from being stolen ?<br>
&gt;<br>
in theory, yes, but as always, it depends on the circumstances.<br>
<br>
With TPM 1.2 you can only store a very limited amount of data in the TPM <b=
r>
chip; the (open source) implementation I have seen (tss, trousers) store <b=
r></blockquote><div><br></div><div>I meant openvpn-gui + user/password auth=
entication + password is kept in registry encrypted by data protection api =
(not clear text, but might be decrypted and stolen easily).</div><div><br><=
/div><div>trousers is linux, right ? <br></div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
a key in the TPM to scramble other data with; thus, you can encrypt a <br>
private key or password with a key stored on the TPM and only if you <br>
have the TPM will you be able to decrypt it.<br>
I&#39;ve never been particularly impressed with the security of this setup,=
 <br>
however, as trousers seems to suggest to store the actualy decryption <br>
key in an environment variable...<br>
<br>
With TPM 2.0 you can store more data in the chip, including a full <br>
private key. This makes it behave more like a regular PKCS#11 device, <br>
where you store the private key, not the user password on it. Of course, <b=
r>
it will/should also be possible to store a user password on it.<br>
<br>
cheers,<br>
<br>
JJK<br>
<br>
</blockquote></div></div>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div></div></div>

--0000000000004f80ba05b8cce4db--

