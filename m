MIME-Version: 1.0
References: <20201220105430.GP976@...1296...>
 <CACDCbPrvwmEGyAt1C4pVmzmCi0p-7nWkBqmDgDZAR00Bw6S8Zg@...278...>
 <CAFHpkQG+vH5LfZXfN0Zs2PVaW1_40tjuFD8ObF7FhBCyXV_JtQ@...278...>
In-Reply-To: <CAFHpkQG+vH5LfZXfN0Zs2PVaW1_40tjuFD8ObF7FhBCyXV_JtQ@...278...>
From: Greg Cox <gcox@...1057...>
Date: Mon, 21 Dec 2020 18:24:36 +0000
Message-ID: <CACDCbPprxYNcNhrPufPSZ6tU_7fFmWUP7wNPuzz_0EfGzWDCHA@...278...>
Content-Type: multipart/alternative; boundary="000000000000b314ce05b6fd92dc"
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000b314ce05b6fd92dc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 21, 2020 at 7:57 AM =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=
=D0=B8=D1=86=D0=B8=D0=BD <chipitsine@...277...> wrote:

> that's interesting point.
> being dependent on whether users logs or not does not look very good.
>

We only go to their logs when they come to us with issues.  When we can
head the users off ahead of time, it's easier.


> I'd say it is identity management related thing to renew user cert when it
> is about to expire.
> i.e. notify user in proper way and tell him to renew.
>
> as a side question, how do you inform users ? i.e. is it some self service
> portal ?
>

It's definitely "an IAM problem" to begin with... but it becomes "a VPN
problem" eventually.  (abstractly speaking).

We have a cron that, every day, looks at the CA's VPN certs.  If you are at
14, 7, 3, 2, or 1 days left, you get an email warning of the impending
expiration and links to the login portal + docs so you can renew (or revoke
the cert and stop being nagged).  At 2 days expired you get a final mail
explaining that it's expired and you won't be nagged anymore and what to do
if you need back in.

This helps tickets a lot, but when people filter their mail and never read
it, the lack of access falls through to being "a VPN problem."  We did what
we could to head off the issue ahead of time from the IAM side, and it
becomes a situation where, as the support personnel, "well, there MUST be
something vastly wrong because surely nobody would miss 6 emails and end up
here asking me to look at a problem." ... except, they do.

My contention is, a VPN client has enough information from its own certs to
know when its certs are expired and thus not going to work (Yes, there's
plenty of OTHER reasons a connection can fail, but in a well designed
setup, the user's certs will go stale long before the server).  It tells
you this problem in the logs, which folks never read.  If the software were
to contain a mechanism to make certain failure cases automatically more
prominent, particularly for 'simple' users who have GUI clients, it'll be a
big win for supportability on larger installs.

And I realize this is getting into advocacy and away from what's right for
a -devel list, so I'll stop here on this thread.

--000000000000b314ce05b6fd92dc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr" class=3D"gmail_attr">On =
Mon, Dec 21, 2020 at 7:57 AM =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=
=B8=D1=86=D0=B8=D0=BD &lt;<a href=3D"mailto:chipitsine@...277...">chipitsin=
e@...277...</a>&gt; wrote:<br></div></div><div class=3D"gmail_quote"><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">that&#39;s int=
eresting point.<div class=3D"gmail_quote"><div>being dependent on whether u=
sers logs or not does not look very good.</div></div></div></blockquote><di=
v><br></div><div><div style=3D"font-family:courier new,monospace" class=3D"=
gmail_default">We only go to their logs when they come to us with issues.=
=C2=A0 When we can head the users off ahead of time, it&#39;s easier.<br></=
div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><div dir=3D"ltr"><div class=3D"gmail_quote"><div>I&#39;d say it is identi=
ty management related thing to renew user cert when it is about to expire.<=
/div><div>i.e. notify user in proper way and tell him to renew.</div><div><=
br></div><div>as a side question, how do you inform users ? i.e. is it some=
 self service portal ?<br></div></div></div></blockquote><div><br></div><di=
v style=3D"font-family:courier new,monospace" class=3D"gmail_default">It&#3=
9;s definitely &quot;an IAM problem&quot; to begin with... but it becomes &=
quot;a VPN problem&quot; eventually.=C2=A0 (abstractly speaking).</div><div=
 style=3D"font-family:courier new,monospace" class=3D"gmail_default"><br></=
div><div style=3D"font-family:courier new,monospace" class=3D"gmail_default=
">We have a cron that, every day, looks at the CA&#39;s VPN certs.=C2=A0 If=
 you are at 14, 7, 3, 2, or 1 days left, you get an email warning of the im=
pending expiration and links to the login portal + docs so you can renew (o=
r revoke the cert and stop being nagged).=C2=A0 At 2 days expired you get a=
 final mail explaining that it&#39;s expired and you won&#39;t be nagged an=
ymore and what to do if you need back in.</div><div style=3D"font-family:co=
urier new,monospace" class=3D"gmail_default"><br></div><div style=3D"font-f=
amily:courier new,monospace" class=3D"gmail_default">This helps tickets a l=
ot, but when people filter their mail and never read it, the lack of access=
 falls through to being &quot;a VPN problem.&quot;=C2=A0 We did what we cou=
ld to head off the issue ahead of time from the IAM side, and it becomes a =
situation where, as the support personnel, &quot;well, there MUST be someth=
ing vastly wrong because surely nobody would miss 6 emails and end up here =
asking me to look at a problem.&quot; ... except, they do.<br></div><div st=
yle=3D"font-family:courier new,monospace" class=3D"gmail_default"><br></div=
><div style=3D"font-family:courier new,monospace" class=3D"gmail_default">M=
y contention is, a VPN client has enough information from its own certs to =
know when its certs are expired and thus not going to work (Yes, there&#39;=
s plenty of OTHER reasons a connection can fail, but in a well designed set=
up, the user&#39;s certs will go stale long before the server).=C2=A0 It te=
lls you this problem in the logs, which folks never read.=C2=A0 If the soft=
ware were to contain a mechanism to make certain failure cases automaticall=
y more prominent, particularly for &#39;simple&#39; users who have GUI clie=
nts, it&#39;ll be a big win for supportability on larger installs.<br></div=
><div style=3D"font-family:courier new,monospace" class=3D"gmail_default"><=
br></div><div style=3D"font-family:courier new,monospace" class=3D"gmail_de=
fault">And I realize this is getting into advocacy and away from what&#39;s=
 right for a -devel list, so I&#39;ll stop here on this thread.</div><div s=
tyle=3D"font-family:courier new,monospace" class=3D"gmail_default"><br></di=
v></div></div>

--000000000000b314ce05b6fd92dc--

