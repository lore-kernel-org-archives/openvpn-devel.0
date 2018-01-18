MIME-Version: 1.0
In-Reply-To: <caf0faaa-428f-29c4-797f-8be8ac4f0f47@...1435...>
References: <1515959073-10376-1-git-send-email-selva.nair@...277...>
 <1515959073-10376-3-git-send-email-selva.nair@...277...>
 <e059b07e-5684-1dbe-cfdf-1271efc594dc@...1227...>
 <CAKuzo_jN9EOK5aPr2dn+m+ynarY-Snt2pwOmz9cV32BpKSFq=w@...278...>
 <CAKuzo_hYwcRDJjYW7i=Ekmi93TAXRb+n=sNyi4y=+gS+vbbtAA@...278...>
 <caf0faaa-428f-29c4-797f-8be8ac4f0f47@...1435...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 18 Jan 2018 10:49:33 -0500
Message-ID: <CAKuzo_jRh+7KSfw6GTVuXTDnMQCDfrH3g5m=N9GGDTDVLijBhg@...278...>
Content-Type: multipart/alternative; boundary="001a113a60d23964f605630eea16"
Subject: Re: [Openvpn-devel] [PATCH 2/3] Allow external EC key through
 --management-external-key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a113a60d23964f605630eea16
Content-Type: text/plain; charset="UTF-8"

Hi

On Wed, Jan 17, 2018 at 3:53 AM, Steffan Karger <steffan.karger@...1435...>
wrote:

> Hi,
>
> On 17-01-18 05:24, Selva Nair wrote:
> > Also I'm toying with the idea of renaming ecdsa-sig/ECDSA-SIGN by
> > pkey-sig/PKEY-SIGN so that eventually we may be able to use it for
> > all types of keys and retire rsa-sig. Any thoughts on that?
>
> This was my first though when looking at these patches.  Haven't looked
> at the code yet, but functionally I think that's the way to go.  Even if
> it were that Ed25519 / Ed448 sigs are technically not ECDSA sigs.
>

I was waiting for the chatlog before finalizing v2. Looks like there are a
number of opinions
that seem to converge towards the same view.

This is what I have in my current v2 ready to go out:

(i) Current behaviour for rsa signatures stays for now: daemon sends
>RSA_SIGN  client responds
with rsa-sig
(ii) Daemon sends >PK_SIG client responds with pk-sig [*]
Initially this will be used only for EC, but trivial to switch RSA to this
in future.
So document that new mgmt clients should be prepared to handle all supported
key types via >PK_SIGN/pk-sig and >RSA_SIGN will be eventually removed.

As a nice side effect, clients are allowed to respond with pk-sig even if
the challenge was
>RSA_SIGN. As a not so nice side effect, the daemon will reply with
"SUCCESS rsa-sign
succeeded" because that's what it asked for -- I suppose we can live with
that.

We can deprecate and remove >RSA_SIGN at a later date by a hard switch when
all known clients are capable of handling >PK_SIGN

Does this sound like an acceptable solution?

Question: while at it should we alter the syntax to
>PK_SIGN,xxx,<base64>

where xxx will be empty for now, but it reserves space for extra info that
may come handy for some future signature types (like use PSS padding for
RSA or use PureEdDSA or whatever).

Thanks,

Selva

--001a113a60d23964f605630eea16
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<br><div class=3D"gmail_extra"><br><div class=3D"gmail_q=
uote">On Wed, Jan 17, 2018 at 3:53 AM, Steffan Karger <span dir=3D"ltr">&lt=
;<a href=3D"mailto:steffan.karger@...1435..." target=3D"_blank">steffan.kar=
ger@...1435...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">Hi,<br>
<span class=3D"gmail-"><br>
On 17-01-18 05:24, Selva Nair wrote:<br>
&gt; Also I&#39;m toying with the idea of renaming ecdsa-sig/ECDSA-SIGN by<=
br>
&gt; pkey-sig/PKEY-SIGN so that eventually we may be able to use it for<br>
&gt; all types of keys and retire rsa-sig. Any thoughts on that?<br>
<br>
</span>This was my first though when looking at these patches.=C2=A0 Haven&=
#39;t looked<br>
at the code yet, but functionally I think that&#39;s the way to go.=C2=A0 E=
ven if<br>
it were that Ed25519 / Ed448 sigs are technically not ECDSA sigs.<br></bloc=
kquote><div><br></div><div>I was waiting for the chatlog before finalizing =
v2. Looks like there are a number of opinions</div><div>that seem to conver=
ge towards the same view.</div><div><br></div><div>This is what I have in m=
y current v2 ready to go out:</div><div><br></div><div>(i) Current behaviou=
r for rsa signatures stays for now: daemon sends &gt;RSA_SIGN=C2=A0 client =
responds</div><div>with rsa-sig</div><div>(ii) Daemon sends &gt;PK_SIG clie=
nt responds with pk-sig [*]=C2=A0</div><div>Initially this will be used onl=
y for EC, but trivial to switch RSA to this in future.</div><div>So documen=
t that new mgmt clients should be prepared to handle all supported</div><di=
v>key types via &gt;PK_SIGN/pk-sig and &gt;RSA_SIGN will be eventually remo=
ved.</div><div><br></div><div>As a nice side effect, clients are allowed to=
 respond with pk-sig even if the challenge was</div><div>&gt;RSA_SIGN. As a=
 not so nice side effect, the daemon will reply with &quot;SUCCESS rsa-sign=
</div><div>succeeded&quot; because that&#39;s what it asked for -- I suppos=
e we can live with that.</div><div><br></div><div>We can deprecate and remo=
ve &gt;RSA_SIGN at a later date by a hard switch when</div><div>all known c=
lients are capable of handling &gt;PK_SIGN</div><div><div><br></div><div>Do=
es this sound like an acceptable solution?</div></div><div><br></div><div>Q=
uestion: while at it should we alter the syntax to</div><div>&gt;PK_SIGN,xx=
x,&lt;base64&gt;</div><div><br></div><div>where xxx will be empty for now, =
but it reserves space for extra info that may come handy for some future si=
gnature types (like use PSS padding for RSA or use PureEdDSA or whatever).=
=C2=A0</div><div><br></div><div>Thanks,</div><div><br></div><div>Selva</div=
></div></div></div>

--001a113a60d23964f605630eea16--

