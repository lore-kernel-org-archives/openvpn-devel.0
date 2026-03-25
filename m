MIME-Version: 1.0
References: <20260322014606.1415363-1-luca.boccassi@...277...>
In-Reply-To: <20260322014606.1415363-1-luca.boccassi@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 25 Mar 2026 17:54:01 -0400
Message-ID: <CAKuzo_iwvHHST4br9F+V0vGHQUOBSw0ju_yGTtCXGj7ws59pXA@...278...>
Content-Type: multipart/alternative; boundary="0000000000004e6836064de04fe7"
Subject: Re: [Openvpn-devel] [PATCH] management: add multi-line base64 input
 for passwords
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: luca.boccassi@...277...
Cc: openvpn-devel@lists.sourceforge.net

--0000000000004e6836064de04fe7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 21, 2026 at 9:47=E2=80=AFPM <luca.boccassi@...277...> wrote:

> From: Luca Boccassi <luca.boccassi@...277...>
>
> Allow management clients to send long passwords via the
> usual multi-line base64 encoded protocol.
>
> A client sends a 'password <type>' line, followed by
> as many lines (each up to 1024 bytes) as needed, in base64
> encoded format, terminated by 'END'.
>
> This is useful when a password is a JIT-generated use-once
> token.
>
> Signed-off-by: Luca Boccassi <luca.boccassi@...277...>
>

I think this is a step in the right direction: allows arbitrary long
passwords to be passed via the management interface bringing it in line
with stdin/console input. No other intrusive changes like option parsing.
Until now, the largish USER_PASS_LEN =3D 4096 was mostly a waste of space as
it was often not possible to use it even locally within the client because
of the 255 byte restriction in the management interface.

I have only skimmed through the patch, but reusing "password" with no
argument could break existing UI clients, hypothetically.  If any UI client
is currently using an empty password to quit the dialog, it will get into a
stalemate. I guess a new keyword or an extra token after 'Auth'  to
indicate multi-line input would be required.

Selva
P.S.
Next version could go into gerrit for a more thorough review.

--0000000000004e6836064de04fe7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br>=
<div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Ma=
r 21, 2026 at 9:47=E2=80=AFPM &lt;<a href=3D"mailto:luca.boccassi@...277...=
" target=3D"_blank">luca.boccassi@...277...</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">From: Luca Boccassi &lt;<a href=
=3D"mailto:luca.boccassi@...277..." target=3D"_blank">luca.boccassi@...1354...=
..</a>&gt;<br>
<br>
Allow management clients to send long passwords via the<br>
usual multi-line base64 encoded protocol.<br>
<br>
A client sends a &#39;password &lt;type&gt;&#39; line, followed by<br>
as many lines (each up to 1024 bytes) as needed, in base64<br>
encoded format, terminated by &#39;END&#39;.<br>
<br>
This is useful when a password is a JIT-generated use-once<br>
token.<br>
<br>
Signed-off-by: Luca Boccassi &lt;<a href=3D"mailto:luca.boccassi@...277..."=
 target=3D"_blank">luca.boccassi@...277...</a>&gt;<br></blockquote><div><br=
></div><div>I think this is a=C2=A0step in the right direction: allows arbi=
trary long passwords to be passed via the management interface bringing it=
=C2=A0in line with stdin/console input. No other intrusive=C2=A0changes lik=
e option parsing. Until now, the largish USER_PASS_LEN =3D 4096 was mostly =
a waste of space as it was often not possible to use it even locally within=
 the client because of the 255 byte restriction in the management interface=
.</div><div><br></div><div>I have only skimmed through the patch, but reusi=
ng &quot;password&quot; with no argument could break existing=C2=A0UI clien=
ts, hypothetically.=C2=A0 If any UI client is currently using an empty pass=
word to quit the=C2=A0dialog, it will get into a stalemate. I guess a new k=
eyword or an extra token after &#39;Auth&#39;=C2=A0 to indicate multi-line =
input would be required.=C2=A0</div><div><br>Selva</div><div>P.S.</div><div=
>Next version could go into gerrit for a more thorough review.</div></div><=
/div>
</div>
</div>
</div>
</div>
</div>
</div>

--0000000000004e6836064de04fe7--

