MIME-Version: 1.0
From: Jon Chiappetta <root@...2904...>
Date: Sun, 2 Nov 2025 01:35:30 -0400
Message-ID: <CAOh3LPP9XVUU7TGHP51RdBEYSRKW1ih3EV_-FxiNxmiZCCS47g@...278...>
Content-Type: multipart/alternative; boundary="00000000000027a46f064295f8f9"
References: <CAOh3LPP9XVUU7TGHP51RdBEYSRKW1ih3EV_-FxiNxmiZCCS47g.ref@...278...>
Subject: [Openvpn-devel] Question for the devs - Found something interesting
 in the OpenVPN source code that I change in my modified version...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, Gert Doering <gert@...1296...>

--00000000000027a46f064295f8f9
Content-Type: text/plain; charset="UTF-8"

Hi Gert and devs!

While I was working on the modified version of OpenVPN and tracing through
the SSL library, I found what I think is a potential invalid memory index
access. I wanted to verify with you all if this could be correct.

https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/ssl.c#L3682
https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/ssl_common.h#L712

In this file and that line number there is an integer i that is outside the
for loop so that it can look for the matching session key index number.
However, there is an if statement after the loop which checks for the
following conditions:

if (i == TM_SIZE && is_hard_reset_method2(op))

If the key is not found, i will equal TM_SIZE but if the second condition
is false for whatever reason, the code will enter the else block and during
my debugging, it entered into an invalid index of the array!

struct tls_session *session = &multi->session[i]; (->
multi->session[TM_SIZE] !)

And as you can see, the session array is only sized for this amount:

struct tls_session session[TM_SIZE];

In my modified version I wasn't sure of when this hard reset check
condition would be true but to prevent an invalid memory access I changed
my code to be this instead:

if (i == TM_SIZE || is_hard_reset_method2(op))

That way it helps to protect the else block and from potentially going into
an invalid index number in the worst case.

Does this seem correct to anyone else or am I missing something else here?

Thanks again,
Jon C

--00000000000027a46f064295f8f9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Gert and devs!<div><br></div><div>While I was working o=
n the modified version of OpenVPN and tracing through the SSL library, I fo=
und what I think is a potential invalid memory index access. I wanted to ve=
rify with you all if this could be correct.=C2=A0</div><div><br></div><div>=
<a href=3D"https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/ssl.c=
#L3682">https://github.com/OpenVPN/openvpn/blob/master/src/openvpn/ssl.c#L3=
682</a><br></div><div><a href=3D"https://github.com/OpenVPN/openvpn/blob/ma=
ster/src/openvpn/ssl_common.h#L712">https://github.com/OpenVPN/openvpn/blob=
/master/src/openvpn/ssl_common.h#L712</a><br></div><div><br></div><div>In t=
his file and that line number there is an integer i that is outside the for=
 loop so that it can look for the matching session key index number. Howeve=
r, there is an if statement after the loop which checks for the following c=
onditions:</div><div><br></div><div>if (i =3D=3D TM_SIZE &amp;&amp; is_hard=
_reset_method2(op))<br></div><div><br></div><div>If the key is not found, i=
 will equal TM_SIZE but if the second condition is false for whatever reaso=
n, the code will enter the else block and during my debugging, it entered i=
nto an invalid index of the array!</div><div><br></div><div>struct tls_sess=
ion *session =3D &amp;multi-&gt;session[i]; (-&gt; multi-&gt;session[TM_SIZ=
E] !)</div><div><br></div><div>And as you can see, the session array is onl=
y sized for this amount:</div><div><br></div><div>struct tls_session sessio=
n[TM_SIZE];<br></div><div><br></div><div>In my modified version I wasn&#39;=
t sure of when this hard reset check condition would be true but to prevent=
 an invalid memory access I changed my code to be this instead:</div><div><=
br></div><div><div>if (i =3D=3D TM_SIZE || is_hard_reset_method2(op))<br></=
div><br class=3D"gmail-Apple-interchange-newline"></div><div>That way it he=
lps to protect the else block and from potentially going into an invalid in=
dex number in the worst case.=C2=A0</div><div><br></div><div>Does this seem=
 correct to anyone else or am I missing something else here?</div><div><br>=
</div><div>Thanks again,</div><div>Jon C</div><div><br></div></div>

--00000000000027a46f064295f8f9--

