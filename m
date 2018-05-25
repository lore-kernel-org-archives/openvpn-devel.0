Content-Type: multipart/alternative;
 boundary=Apple-Mail-6628867E-02F2-421B-9865-E39FC97E6905
Mime-Version: 1.0 (1.0)
From: Eric Crist <ecrist@...1286...>
In-Reply-To: <99D61A626FDA8A4B90A270669121BE1086A99E72@...2294...>
Date: Fri, 25 May 2018 16:05:31 -0500
Content-Transfer-Encoding: 7bit
Message-Id: <51C480DB-1492-4C6C-8B28-C74B00F52729@...1286...>
References: <20180417165000.3872-1-Jason@...2390...>
 <10978590-889a-0ccc-4cb8-31c862ee565c@...1856...>
 <33fe1382-9dd6-82b4-1215-7f748e521a48@...1147...>
 <fd348cf4-8d17-24b1-cace-f238d319c550@...1227...>
 <03f8402c-a603-3405-543a-e5eaa1ebc224@...1147...>
 <1d803ca0-2f28-585c-eeca-4c64ac2d745f@...1227...>
 <d8fe4a16-fc48-f1f9-3d4d-b82a906bb322@...2080...>
 <99D61A626FDA8A4B90A270669121BE1086A96359@...2294...>
 <82af2541-5e7a-7ba3-5fea-e11f6a2aa52e@...1147...>
 <CAKuzo_j_W0Op+hN6p4muUhrdi42Vib44Vi_7zFtaG9SRMcb0-g@...278...>
 <eb1f2d00-6780-899d-7c1e-61a771350c31@...1147...>
 <99D61A626FDA8A4B90A270669121BE1086A99E72@...2294...>
Subject: Re: [Openvpn-devel] [PATCH] Support fingerprint authentication
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: Jan Just Keijser <janjust@...1147...>, Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--Apple-Mail-6628867E-02F2-421B-9865-E39FC97E6905
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

What does this accomplish you can=E2=80=99t just basically do with =E2=80=
=94client-cert-not-required?

Eric Crist

> On May 25, 2018, at 3:56 PM, Simon Rozman <simon@...2293...> wrote:
>=20
> Hi,
>=20
>>> JJK, I think you are misreading this proposal. No hash is being sent
>>> as a part of the handshake  -- its still client and server
>>> certificates that are exchanged and checked during handshake. The hash
>>> is exchanged by a separate channel (say snail mail:) in advance, and
>>> serves the purpose of establishing trust (ie., the prior knowledge of
>>> hash replaces the prior knowledge of a trusted CA). How the hash is
>>> exchanged is beyond the scope of openvpn or TLS handshake in this
>>> case.
>=20
> Right to the point, Selva. This is the best description of this proposal.
>=20
>> no, I've heard a lot and talked a lot about this proposal before it ende=
d up=20
>> on
>> the list. I do know what the purpose is, it's just that I have serious=20
>> doubts
>> about replacing
>>   ( pub/priv key plus  'trust anchors' such as CA certificates ) by
>>   ( we all trust each other because we know each other's SHA2 hashes )
>> There are downsides to a PKI with certificates but I think we're throwin=
g=20
>> out
>> too much of the good stuff by allowing "just a hash" as the basis for
>> trust.  And one of my main concerns is that people keep comparing it to
>> "that's just like how SSH does it" - *THAT* is simply not true.
>=20
> JJK, I am sorry I brought SSH as an example. I didn't mean "exactly" like=
 SSH.=20
> Just, "kind of like" SSH.
>=20
> In this proposal, we leave the TLS handshake to handle public key exchang=
e as=20
> usual. No need to modify client<->server communication.
> The only difference is how server and client verify peer's certificate=20
> validity. Normally, they check peer's certificate fields like "Not valid=
=20
> before", "Not valid after", "Issued By" etc. In this proposal, they'd onl=
y=20
> check peer certificate by its SHA thumbprint - and skip all other standar=
d=20
> certificate checks.
>=20
> This would allow you to have a CA-less OpenVPN setup:
> - Make self-signed certificate on server and each client (with like 100 y=
ears=20
> validity),
> - Deploy server certificate hash in client.ovpn,
> - List acceptable client certificate hashes in server.ovpn (Or use an ext=
ernal=20
> script to do the hash lookup)
>=20
> Best regards,
> Simon
>=20
> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--Apple-Mail-6628867E-02F2-421B-9865-E39FC97E6905
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"content-type" content=3D"text/html; charset=
=3Dutf-8"></head><body dir=3D"auto">What does this accomplish you can=E2=80=
=99t just basically do with =E2=80=94client-cert-not-required?<br><br><div =
id=3D"AppleMailSignature"><div style=3D"direction: inherit;">Eric Crist</di=
v></div><div><br>On May 25, 2018, at 3:56 PM, Simon Rozman &lt;<a href=3D"m=
ailto:simon@...2293...">simon@...2293...</a>&gt; wrote:<br><br></div><block=
quote type=3D"cite"><div><span>Hi,</span><br><span></span><br><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span>JJK, I think you are misreadin=
g this proposal. No hash is being sent</span><br></blockquote></blockquote>=
<blockquote type=3D"cite"><blockquote type=3D"cite"><span>as a part of the =
handshake &nbsp;-- its still client and server</span><br></blockquote></blo=
ckquote><blockquote type=3D"cite"><blockquote type=3D"cite"><span>certifica=
tes that are exchanged and checked during handshake. The hash</span><br></b=
lockquote></blockquote><blockquote type=3D"cite"><blockquote type=3D"cite">=
<span>is exchanged by a separate channel (say snail mail:) in advance, and<=
/span><br></blockquote></blockquote><blockquote type=3D"cite"><blockquote t=
ype=3D"cite"><span>serves the purpose of establishing trust (ie., the prior=
 knowledge of</span><br></blockquote></blockquote><blockquote type=3D"cite"=
><blockquote type=3D"cite"><span>hash replaces the prior knowledge of a tru=
sted CA). How the hash is</span><br></blockquote></blockquote><blockquote t=
ype=3D"cite"><blockquote type=3D"cite"><span>exchanged is beyond the scope =
of openvpn or TLS handshake in this</span><br></blockquote></blockquote><bl=
ockquote type=3D"cite"><blockquote type=3D"cite"><span>case.</span><br></bl=
ockquote></blockquote><span></span><br><span>Right to the point, Selva. Thi=
s is the best description of this proposal.</span><br><span></span><br><blo=
ckquote type=3D"cite"><span>no, I've heard a lot and talked a lot about thi=
s proposal before it ended up </span><br></blockquote><blockquote type=3D"c=
ite"><span>on</span><br></blockquote><blockquote type=3D"cite"><span>the li=
st. I do know what the purpose is, it's just that I have serious </span><br=
></blockquote><blockquote type=3D"cite"><span>doubts</span><br></blockquote=
><blockquote type=3D"cite"><span>about replacing</span><br></blockquote><bl=
ockquote type=3D"cite"><span> &nbsp;&nbsp;( pub/priv key plus &nbsp;'trust =
anchors' such as CA certificates ) by</span><br></blockquote><blockquote ty=
pe=3D"cite"><span> &nbsp;&nbsp;( we all trust each other because we know ea=
ch other's SHA2 hashes )</span><br></blockquote><blockquote type=3D"cite"><=
span>There are downsides to a PKI with certificates but I think we're throw=
ing </span><br></blockquote><blockquote type=3D"cite"><span>out</span><br><=
/blockquote><blockquote type=3D"cite"><span>too much of the good stuff by a=
llowing "just a hash" as the basis for</span><br></blockquote><blockquote t=
ype=3D"cite"><span>trust. &nbsp;And one of my main concerns is that people =
keep comparing it to</span><br></blockquote><blockquote type=3D"cite"><span=
>"that's just like how SSH does it" - *THAT* is simply not true.</span><br>=
</blockquote><span></span><br><span>JJK, I am sorry I brought SSH as an exa=
mple. I didn't mean "exactly" like SSH. </span><br><span>Just, "kind of lik=
e" SSH.</span><br><span></span><br><span>In this proposal, we leave the TLS=
 handshake to handle public key exchange as </span><br><span>usual. No need=
 to modify client&lt;-&gt;server communication.</span><br><span>The only di=
fference is how server and client verify peer's certificate </span><br><spa=
n>validity. Normally, they check peer's certificate fields like "Not valid =
</span><br><span>before", "Not valid after", "Issued By" etc. In this propo=
sal, they'd only </span><br><span>check peer certificate by its SHA thumbpr=
int - and skip all other standard </span><br><span>certificate checks.</spa=
n><br><span></span><br><span>This would allow you to have a CA-less OpenVPN=
 setup:</span><br><span>- Make self-signed certificate on server and each c=
lient (with like 100 years </span><br><span>validity),</span><br><span>- De=
ploy server certificate hash in client.ovpn,</span><br><span>- List accepta=
ble client certificate hashes in server.ovpn (Or use an external </span><br=
><span>script to do the hash lookup)</span><br><span></span><br><span>Best =
regards,</span><br><span>Simon</span><br><span></span><br></div></blockquot=
e><blockquote type=3D"cite"><div><span>------------------------------------=
------------------------------------------</span><br><span>Check out the vi=
brant tech community on one of the world's most</span><br><span>engaging te=
ch sites, <a href=3D"http://Slashdot.org">Slashdot.org</a>! <a href=3D"http=
://sdm.link/slashdot">http://sdm.link/slashdot</a></span></div></blockquote=
><blockquote type=3D"cite"><div><span>_____________________________________=
__________</span><br><span>Openvpn-devel mailing list</span><br><span><a hr=
ef=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1011...=
eforge.net</a></span><br><span><a href=3D"https://lists.sourceforge.net/lis=
ts/listinfo/openvpn-devel">https://lists.sourceforge.net/lists/listinfo/ope=
nvpn-devel</a></span><br></div></blockquote></body></html>=

--Apple-Mail-6628867E-02F2-421B-9865-E39FC97E6905--

