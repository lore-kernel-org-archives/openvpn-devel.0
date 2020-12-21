MIME-Version: 1.0
References: <20201220105430.GP976@...1296...>
 <CACDCbPrvwmEGyAt1C4pVmzmCi0p-7nWkBqmDgDZAR00Bw6S8Zg@...278...>
 <CAFHpkQG+vH5LfZXfN0Zs2PVaW1_40tjuFD8ObF7FhBCyXV_JtQ@...278...>
 <CACDCbPprxYNcNhrPufPSZ6tU_7fFmWUP7wNPuzz_0EfGzWDCHA@...278...>
 <20201221191127.GB976@...1296...>
 <96b776cd-6ed9-a310-523f-b78497f4a38f@...1227...>
In-Reply-To: <96b776cd-6ed9-a310-523f-b78497f4a38f@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 21 Dec 2020 15:51:59 -0500
Message-ID: <CAKuzo_hs0Y=+RptBaLSAYyN2-jeTAHYKyZ=mV6xx_j0Q36R8Bw@...278...>
Content-Type: multipart/alternative; boundary="000000000000170b9c05b6ffa211"
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
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, Greg Cox <gcox@...1057...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000170b9c05b6ffa211
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, Dec 21, 2020 at 3:27 PM Arne Schwabe <arne@...1227...> wrote:

> Am 21.12.20 um 20:11 schrieb Gert Doering:
> > Hi,
> >
> > On Mon, Dec 21, 2020 at 06:24:36PM +0000, Greg Cox wrote:
> >> My contention is, a VPN client has enough information from its own
> certs to
> >> know when its certs are expired and thus not going to work (Yes, there's
> >> plenty of OTHER reasons a connection can fail, but in a well designed
> >> setup, the user's certs will go stale long before the server).  It tells
> >> you this problem in the logs, which folks never read.
> >
> > We consciously decided to make this not more prominent (so, warning only,
> > not error) because the client's machine's time might be wrong - and
> > ultimately it's the server's notion of time that decides if the cert
> > is valid or not.  So this is a hint, but not a "IT WILL NOT WORK!" hard
> > error.
> >
> >> If the software were
> >> to contain a mechanism to make certain failure cases automatically more
> >> prominent, particularly for 'simple' users who have GUI clients, it'll
> be a
> >> big win for supportability on larger installs.
> >
> > This is indeed getting into philosophy... we do send different types of
> > AUTH_FAILED today (like, for token expired).  Maybe we could send an
> > "AUTH_FAILED,cert expired" and have the client display this?
> >
> > (I admit that I'm neither an expert on AUTH_FAILED message, nor on
> > "what is the client doing on variations of it", nor on "what *should*
> > be the expected outcome?".  Selva, Arne will know more).
>
> It is easy to add that message, however the question is if we want to.
> Sending different AUTH_FAILED message also leaks information. Especially
> with authentication you don't want to give an attacker an idea how they
> get before failing the authentication. I.e. if you send User disable,
> certificate expired, account not allow to use VPN etc. an attacker gets
> information about the account/profile he using to connect.
>
> So with these AUTH_FAILED codes you have to be very careful not to
> accidently leak information. I.e. AUTH_FAILED, cert expired happens only
> if user/pass is right/wrong, otherwise you get a normal AUTH_FAILED.
>
> HOWEVER, on the client side. We can transform a normal AUTH_FAILED into
> an AUTH_FAILED, server gave no reason, [client certificate is expired]
> or something like that.
>

We already warn on the client if the certificate has expired and warnings
show up in red at least in OpenvPN-GUI. Sure, UI's can add more bold-face
warnings and popups showing probable reasons, but better leave the core as
is.

To chime in with Arne, a client presenting an invalid cert (expired, in CRL
or otherwise bogus) has to be treated as rogue and should not be given any
additional feedback from the server on the reason for failure.

Selva

--000000000000170b9c05b6ffa211
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Mon, Dec 21, 2020 at 3:27 PM Arne Schwabe &lt;<=
a href=3D"mailto:arne@...1227...">arne@...1227...</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">Am 21.12.20 um 20:11 schri=
eb Gert Doering:<br>
&gt; Hi,<br>
&gt; <br>
&gt; On Mon, Dec 21, 2020 at 06:24:36PM +0000, Greg Cox wrote:<br>
&gt;&gt; My contention is, a VPN client has enough information from its own=
 certs to<br>
&gt;&gt; know when its certs are expired and thus not going to work (Yes, t=
here&#39;s<br>
&gt;&gt; plenty of OTHER reasons a connection can fail, but in a well desig=
ned<br>
&gt;&gt; setup, the user&#39;s certs will go stale long before the server).=
=C2=A0 It tells<br>
&gt;&gt; you this problem in the logs, which folks never read.=C2=A0 <br>
&gt; <br>
&gt; We consciously decided to make this not more prominent (so, warning on=
ly,<br>
&gt; not error) because the client&#39;s machine&#39;s time might be wrong =
- and <br>
&gt; ultimately it&#39;s the server&#39;s notion of time that decides if th=
e cert<br>
&gt; is valid or not.=C2=A0 So this is a hint, but not a &quot;IT WILL NOT =
WORK!&quot; hard<br>
&gt; error.<br>
&gt; <br>
&gt;&gt; If the software were<br>
&gt;&gt; to contain a mechanism to make certain failure cases automatically=
 more<br>
&gt;&gt; prominent, particularly for &#39;simple&#39; users who have GUI cl=
ients, it&#39;ll be a<br>
&gt;&gt; big win for supportability on larger installs.<br>
&gt; <br>
&gt; This is indeed getting into philosophy... we do send different types o=
f<br>
&gt; AUTH_FAILED today (like, for token expired).=C2=A0 Maybe we could send=
 an<br>
&gt; &quot;AUTH_FAILED,cert expired&quot; and have the client display this?=
<br>
&gt; <br>
&gt; (I admit that I&#39;m neither an expert on AUTH_FAILED message, nor on=
<br>
&gt; &quot;what is the client doing on variations of it&quot;, nor on &quot=
;what *should*<br>
&gt; be the expected outcome?&quot;.=C2=A0 Selva, Arne will know more).<br>
<br>
It is easy to add that message, however the question is if we want to.<br>
Sending different AUTH_FAILED message also leaks information. Especially<br>
with authentication you don&#39;t want to give an attacker an idea how they=
<br>
get before failing the authentication. I.e. if you send User disable,<br>
certificate expired, account not allow to use VPN etc. an attacker gets<br>
information about the account/profile he using to connect.<br>
<br>
So with these AUTH_FAILED codes you have to be very careful not to<br>
accidently leak information. I.e. AUTH_FAILED, cert expired happens only<br>
if user/pass is right/wrong, otherwise you get a normal AUTH_FAILED.<br>
<br>
HOWEVER, on the client side. We can transform a normal AUTH_FAILED into<br>
an AUTH_FAILED, server gave no reason, [client certificate is expired]<br>
or something like that.<br></blockquote><div><br></div><div>We already warn=
 on the client if the certificate has expired and warnings show up in red a=
t least in OpenvPN-GUI. Sure, UI&#39;s can add more bold-face warnings and =
popups showing probable reasons, but better leave the core as is.=C2=A0</di=
v><div><br></div><div>To chime in with Arne, a client presenting an invalid=
 cert (expired, in CRL or otherwise bogus) has to be treated as rogue and s=
hould not be given any additional feedback from the server on the reason fo=
r failure.</div><div><br></div><div>Selva=C2=A0</div></div></div>

--000000000000170b9c05b6ffa211--

