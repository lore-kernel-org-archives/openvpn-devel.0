MIME-Version: 1.0
References: <13E5C41C-8358-4252-A751-8FDA9EE95B7D@...2722...>
 <0acc8d93-6175-4d7e-a39a-269a9652ac3e@...1823...>
 <f2f54207-f37c-4c0d-96a3-a600cd2bb811@...1823...>
 <ZU3aVt0EgPyOQWEe@...1296...>
 <ae5ddbf4-44fd-4d4b-a045-53274aa9cc5d@...1823...>
 <fe0a4e43-4015-4834-a9bd-8764baf0134a@...1823...>
 <ZU39JoRBq8R_NgD6@...1296...> <ZU6I1MMD980Ervm-@...1296...>
In-Reply-To: <ZU6I1MMD980Ervm-@...1296...>
From: Greg Cox <gcox@...1057...>
Date: Sun, 12 Nov 2023 18:08:48 +0000
Message-ID: <CACDCbPq3O71Pjvaj0aBE8Dd-JQA3idZOxP+eyb=9if_MiLREQw@...278...>
Content-Type: multipart/alternative; boundary="00000000000094a7230609f87268"
Subject: Re: [Openvpn-devel] OpenVPN 2.6.7 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Dmitry Melekhov <dm@...1823...>, openvpn-devel@lists.sourceforge.net

--00000000000094a7230609f87268
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Segfaulting STR:

Rocky9 host, used 2.6.7 from the copr repo.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
port 1194
proto tcp-server
dev tun1
ca /etc/openvpn/server/keys/ca.crt
cert /etc/openvpn/server/keys/server.crt
key /etc/openvpn/server/keys/server.key
dh none
tls-groups secp521r1:secp384r1
topology subnet
server 10.50.236.0 255.255.255.0
keepalive 10 120
tls-auth /etc/openvpn/server/keys/ta.key 0
data-ciphers AES-256-GCM
auth SHA512
tls-version-min 1.2
user openvpn
group openvpn
persist-key
persist-tun
log-append         /var/log/openvpn/openvpn.log
verb 4
auth-gen-token 0 3600
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

Spun this config up, then ran:

iptables -t nat -A PREROUTING -i eth0 -p tcp -m multiport --dports 443,80
-j REDIRECT --to-ports 1194

Within 5 minutes the random web scanners found and segfaulted me.

Hope this helps.


On Fri, Nov 10, 2023 at 7:48=E2=80=AFPM Gert Doering <gert@...1296...> wrot=
e:

> Hi,
>
> On Fri, Nov 10, 2023 at 10:51:34AM +0100, Gert Doering wrote:
> > I'll see if I can reproduce this case here and we'll fix it ASAP.
>
> We couldn't reproduce it yet, but we have a crash dump in GH issue #449,
> which hints at the commit cd4d819c99266 getting this double-extra-check
> wrong.
>
> So if you build from git, can you do a checkout of release/2.6, and
> then do "git revert cd4d819c99266", and build from that?  This would
> give you a 2.6.7 "with both CVE fixes, but without the extra safeguard
> check" - which isn't *really* needed, but its intention was "should
> another mistake of sort addressed in the CVE fixes happen again, it
> would get caught" - so double belt and suspenders...
>
> gert
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never
> doubted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh
> Mistress
>
> Gert Doering - Munich, Germany
> gert@...1296...
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--00000000000094a7230609f87268
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:monospac=
e">Segfaulting STR:</div><div class=3D"gmail_default" style=3D"font-family:=
monospace"><br></div><div class=3D"gmail_default" style=3D"font-family:mono=
space">Rocky9 host, used 2.6.7 from the copr repo.<br></div><div class=3D"g=
mail_default" style=3D"font-family:monospace">=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div>=
<div class=3D"gmail_default" style=3D"font-family:monospace">port 1194<br>p=
roto tcp-server<br>dev tun1<br>ca /etc/openvpn/server/keys/ca.crt<br>cert /=
etc/openvpn/server/keys/server.crt<br>key /etc/openvpn/server/keys/server.k=
ey<br>dh none<br>tls-groups secp521r1:secp384r1<br>topology subnet<br>serve=
r 10.50.236.0 255.255.255.0<br>keepalive 10 120<br>tls-auth /etc/openvpn/se=
rver/keys/ta.key 0<br>data-ciphers AES-256-GCM<br>auth SHA512<br>tls-versio=
n-min 1.2<br>user openvpn<br>group openvpn<br>persist-key<br>persist-tun<br=
>log-append =C2=A0 =C2=A0 =C2=A0 =C2=A0 /var/log/openvpn/openvpn.log<br>ver=
b 4<br>auth-gen-token 0 3600</div><div class=3D"gmail_default" style=3D"fon=
t-family:monospace">=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div><div class=3D"gmail_default=
" style=3D"font-family:monospace"><br></div><div class=3D"gmail_default" st=
yle=3D"font-family:monospace">Spun this config up, then ran:</div><div clas=
s=3D"gmail_default" style=3D"font-family:monospace"><br></div><div class=3D=
"gmail_default" style=3D"font-family:monospace">iptables -t nat -A PREROUTI=
NG -i eth0 -p tcp -m multiport --dports 443,80 -j REDIRECT --to-ports 1194<=
/div><div class=3D"gmail_default" style=3D"font-family:monospace"><br></div=
><div class=3D"gmail_default" style=3D"font-family:monospace">Within 5 minu=
tes the random web scanners found and segfaulted me.</div><div class=3D"gma=
il_default" style=3D"font-family:monospace"><br></div><div class=3D"gmail_d=
efault" style=3D"font-family:monospace">Hope this helps.</div><div class=3D=
"gmail_default" style=3D"font-family:monospace"><br></div></div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Nov 10, 2=
023 at 7:48=E2=80=AFPM Gert Doering &lt;<a href=3D"mailto:gert@...1296...">=
gert@...1296...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">Hi,<br>
<br>
On Fri, Nov 10, 2023 at 10:51:34AM +0100, Gert Doering wrote:<br>
&gt; I&#39;ll see if I can reproduce this case here and we&#39;ll fix it AS=
AP.<br>
<br>
We couldn&#39;t reproduce it yet, but we have a crash dump in GH issue #449=
,<br>
which hints at the commit cd4d819c99266 getting this double-extra-check<br>
wrong.<br>
<br>
So if you build from git, can you do a checkout of release/2.6, and<br>
then do &quot;git revert cd4d819c99266&quot;, and build from that?=C2=A0 Th=
is would<br>
give you a 2.6.7 &quot;with both CVE fixes, but without the extra safeguard=
<br>
check&quot; - which isn&#39;t *really* needed, but its intention was &quot;=
should <br>
another mistake of sort addressed in the CVE fixes happen again, it<br>
would get caught&quot; - so double belt and suspenders...<br>
<br>
gert<br>
-- <br>
&quot;If was one thing all people took for granted, was conviction that if =
you <br>
=C2=A0feed honest figures into a computer, honest figures come out. Never d=
oubted <br>
=C2=A0it myself till I met a computer with a sense of humor.&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Robert A. Heinlein, The Moon is a Harsh Mist=
ress<br>
<br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296..." target=3D"_blank">gert@...1296...</a><br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div>

--00000000000094a7230609f87268--

