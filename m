MIME-Version: 1.0
References: <20201220105430.GP976@...1296...>
 <CACDCbPrvwmEGyAt1C4pVmzmCi0p-7nWkBqmDgDZAR00Bw6S8Zg@...278...>
 <CAFHpkQG+vH5LfZXfN0Zs2PVaW1_40tjuFD8ObF7FhBCyXV_JtQ@...278...>
 <CACDCbPprxYNcNhrPufPSZ6tU_7fFmWUP7wNPuzz_0EfGzWDCHA@...278...>
In-Reply-To: <CACDCbPprxYNcNhrPufPSZ6tU_7fFmWUP7wNPuzz_0EfGzWDCHA@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 22 Dec 2020 10:37:11 +0500
Message-ID: <CAFHpkQEFZKrDNjNZTf2yJ-iUiQg83FZTCqxmq5c6i3vx3HY8gg@...278...>
Content-Type: multipart/alternative; boundary="00000000000009e55805b706f860"
Subject: Re: [Openvpn-devel] wanted: mechanism to send text messages to
 client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Greg Cox <gcox@...1057...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000009e55805b706f860
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 21 =D0=B4=D0=B5=D0=BA. 2020 =D0=B3. =D0=B2 23:26, Greg Cox <g=
cox@...1057...>:

> On Mon, Dec 21, 2020 at 7:57 AM =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=
=BF=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:
>
>> that's interesting point.
>> being dependent on whether users logs or not does not look very good.
>>
>
> We only go to their logs when they come to us with issues.  When we can
> head the users off ahead of time, it's easier.
>
>
>> I'd say it is identity management related thing to renew user cert when
>> it is about to expire.
>> i.e. notify user in proper way and tell him to renew.
>>
>> as a side question, how do you inform users ? i.e. is it some self
>> service portal ?
>>
>
> It's definitely "an IAM problem" to begin with... but it becomes "a VPN
> problem" eventually.  (abstractly speaking).
>
> We have a cron that, every day, looks at the CA's VPN certs.  If you are
> at 14, 7, 3, 2, or 1 days left, you get an email warning of the impending
> expiration and links to the login portal + docs so you can renew (or revo=
ke
> the cert and stop being nagged).  At 2 days expired you get a final mail
> explaining that it's expired and you won't be nagged anymore and what to =
do
> if you need back in.
>

wow.

it is exactly how I meant it :)


>
> This helps tickets a lot, but when people filter their mail and never read
> it, the lack of access falls through to being "a VPN problem."  We did wh=
at
> we could to head off the issue ahead of time from the IAM side, and it
> becomes a situation where, as the support personnel, "well, there MUST be
> something vastly wrong because surely nobody would miss 6 emails and end =
up
> here asking me to look at a problem." ... except, they do.
>

if there's self service portal, can we use dhcp option 114 (which is used
for captive portal) ?



> My contention is, a VPN client has enough information from its own certs
> to know when its certs are expired and thus not going to work (Yes, there=
's
> plenty of OTHER reasons a connection can fail, but in a well designed
> setup, the user's certs will go stale long before the server).  It tells
> you this problem in the logs, which folks never read.  If the software we=
re
> to contain a mechanism to make certain failure cases automatically more
> prominent, particularly for 'simple' users who have GUI clients, it'll be=
 a
> big win for supportability on larger installs.
>
> And I realize this is getting into advocacy and away from what's right for
> a -devel list, so I'll stop here on this thread.
>

we are still on topic.


>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--00000000000009e55805b706f860
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">=D0=BF=D0=BD, 21 =D0=B4=D0=B5=D0=BA. =
2020 =D0=B3. =D0=B2 23:26, Greg Cox &lt;<a href=3D"mailto:gcox@...1057...">=
gcox@...1057...</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Mon, Dec 21, 2020 at 7:57 AM =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=
=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD &lt;<a href=3D"mailto:chipitsine@...1663...=
." target=3D"_blank">chipitsine@...277...</a>&gt; wrote:<br></div></div><di=
v class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><=
div dir=3D"ltr">that&#39;s interesting point.<div class=3D"gmail_quote"><di=
v>being dependent on whether users logs or not does not look very good.</di=
v></div></div></blockquote><div><br></div><div><div style=3D"font-family:co=
urier new,monospace">We only go to their logs when they come to us with iss=
ues.=C2=A0 When we can head the users off ahead of time, it&#39;s easier.<b=
r></div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div>I&#39;d say it is id=
entity management related thing to renew user cert when it is about to expi=
re.</div><div>i.e. notify user in proper way and tell him to renew.</div><d=
iv><br></div><div>as a side question, how do you inform users ? i.e. is it =
some self service portal ?<br></div></div></div></blockquote><div><br></div=
><div style=3D"font-family:courier new,monospace">It&#39;s definitely &quot=
;an IAM problem&quot; to begin with... but it becomes &quot;a VPN problem&q=
uot; eventually.=C2=A0 (abstractly speaking).</div><div style=3D"font-famil=
y:courier new,monospace"><br></div><div style=3D"font-family:courier new,mo=
nospace">We have a cron that, every day, looks at the CA&#39;s VPN certs.=
=C2=A0 If you are at 14, 7, 3, 2, or 1 days left, you get an email warning =
of the impending expiration and links to the login portal + docs so you can=
 renew (or revoke the cert and stop being nagged).=C2=A0 At 2 days expired =
you get a final mail explaining that it&#39;s expired and you won&#39;t be =
nagged anymore and what to do if you need back in.</div></div></div></block=
quote><div><br></div><div>wow.</div><div><br></div><div>it is exactly how I=
 meant it :)<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div style=3D"fon=
t-family:courier new,monospace"><br></div><div style=3D"font-family:courier=
 new,monospace">This helps tickets a lot, but when people filter their mail=
 and never read it, the lack of access falls through to being &quot;a VPN p=
roblem.&quot;=C2=A0 We did what we could to head off the issue ahead of tim=
e from the IAM side, and it becomes a situation where, as the support perso=
nnel, &quot;well, there MUST be something vastly wrong because surely nobod=
y would miss 6 emails and end up here asking me to look at a problem.&quot;=
 ... except, they do.<br></div></div></div></blockquote><div><br></div><div=
>if there&#39;s self service portal, can we use dhcp option 114 (which is u=
sed for captive portal) ? <br></div><div><br></div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"g=
mail_quote"><div style=3D"font-family:courier new,monospace"></div><div sty=
le=3D"font-family:courier new,monospace">My contention is, a VPN client has=
 enough information from its own certs to know when its certs are expired a=
nd thus not going to work (Yes, there&#39;s plenty of OTHER reasons a conne=
ction can fail, but in a well designed setup, the user&#39;s certs will go =
stale long before the server).=C2=A0 It tells you this problem in the logs,=
 which folks never read.=C2=A0 If the software were to contain a mechanism =
to make certain failure cases automatically more prominent, particularly fo=
r &#39;simple&#39; users who have GUI clients, it&#39;ll be a big win for s=
upportability on larger installs.<br></div><div style=3D"font-family:courie=
r new,monospace"><br></div><div style=3D"font-family:courier new,monospace"=
>And I realize this is getting into advocacy and away from what&#39;s right=
 for a -devel list, so I&#39;ll stop here on this thread.</div></div></div>=
</blockquote><div><br></div><div>we are still on topic.<br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"=
><div class=3D"gmail_quote"><div style=3D"font-family:courier new,monospace=
"><br></div></div></div>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div></div>

--00000000000009e55805b706f860--

