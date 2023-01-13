From: Kristof Provost <kp@...1376...>
Date: Fri, 13 Jan 2023 21:32:52 +1300
Message-ID: <A4236869-0DD6-48AF-8CD0-3758E2FA4C70@...1376...>
In-Reply-To: <Y8EJzGoG6yEJaGmU@...1296...>
References: <20230111235052.24855-1-a@...2181...>
 <Y8EJzGoG6yEJaGmU@...1296...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="=_MailMate_E3B18EB4-06E1-4B32-A782-05F731D9C16A_="
Content-Transfer-Encoding: 8bit
Subject: Re: [Openvpn-devel] [PATCH] dco: print proper message in case of
 transport disconnection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

--=_MailMate_E3B18EB4-06E1-4B32-A782-05F731D9C16A_=
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

On 13 Jan 2023, at 20:35, Gert Doering wrote:
> On Thu, Jan 12, 2023 at 12:50:52AM +0100, Antonio Quartulli wrote:
>> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
>> index 77dcaa60..99123c39 100644
>> --- a/src/openvpn/multi.c
>> +++ b/src/openvpn/multi.c
>> @@ -3244,6 +3244,10 @@ process_incoming_del_peer(struct multi_context 
>> *m, struct multi_instance *mi,
>>              reason = "ovpn-dco: transport error";
>>              break;
>>
>> +        case OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT:
>> +            reason = "ovpn-dco: transport disconnected";
>> +            break;
>> +
>
> We were too fast in ACKing and merging this "because rc2" - this 
> breaks
> compilation on FreeBSD+DCO, because it only adds the necessary enum
> element for Linux.
>
> This being an enum, I can't even add an "#ifdef 
> ...TRANSPORT_DISCONNECT"
> here, and because these codes need to be synchronized between kernel 
> and
> userland, I can't "just add it to freebsd_dco.h".
>
> So consider me not very amused...
>
> As a quick bandaid, I'll send a patch that adds an #ifdef TARGET_LINUX
> around this clause so I can update the FreeBSD openvpn-devel port - 
> but
> that is not a really good solution either.  @kp, what would you 
> suggest
> how to handle this on the FreeBSD side?
>
I’m happy to add `OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT` to the 
FreeBSD `enum ovpn_del_reason`. The FreeBSD if_ovpn code won’t ever 
send it (because no TCP) but that’s not really a concern. It’ll 
build and work just fine.

Going forward we should try to remember this, and coordinate additions 
like this.
I’m not sure how we’d cope with supporting building on older 
releases though. Not a worry just yet, because FreeBSD main is the only 
version with DCO support in it, but it’ll be a problem sooner or 
later.

For that I see two paths: either we change the enum (probably both 
ovpn_notif_type and ovpn_del_reason) to be defines, so we can `#ifdef 
OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT`, or we keep the enums and 
extend the autoconf code to check for us. That’s the sort of thing 
it’s supposed to be for, after all.

Best regards,
Kristof
--=_MailMate_E3B18EB4-06E1-4B32-A782-05F731D9C16A_=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/xhtml; charset=3Dutf-8">
</head>
<body><div style=3D"font-family: sans-serif;"><div class=3D"markdown" style=
=3D"white-space: normal;">
<p dir=3D"auto">On 13 Jan 2023, at 20:35, Gert Doering wrote:</p>
</div><div class=3D"plaintext" style=3D"white-space: normal;"><blockquote s=
tyle=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px solid #136BCE;=
 color: #136BCE;"><p dir=3D"auto">On Thu, Jan 12, 2023 at 12:50:52AM +0100,=
 Antonio Quartulli wrote:</p>
<blockquote style=3D"margin: 0 0 5px; padding-left: 5px; border-left: 2px s=
olid #136BCE; border-left-color: #4B89CF; color: #4B89CF;"><p dir=3D"auto">=
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
<br>
index 77dcaa60..99123c39 100644
<br>
--- a/src/openvpn/multi.c
<br>
+++ b/src/openvpn/multi.c
<br>
@@ -3244,6 +3244,10 @@ process_incoming_del_peer(struct multi_context *m, s=
truct multi_instance *mi,
<br>
             reason =3D "ovpn-dco: transport error";
<br>
             break;</p>
<p dir=3D"auto">+        case OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT:
<br>
+            reason =3D "ovpn-dco: transport disconnected";
<br>
+            break;
<br>
+</p>
</blockquote><p dir=3D"auto">We were too fast in ACKing and merging this "b=
ecause rc2" - this breaks
<br>
compilation on FreeBSD+DCO, because it only adds the necessary enum
<br>
element for Linux.</p>
<p dir=3D"auto">This being an enum, I can't even add an "#ifdef ...TRANSPOR=
T_DISCONNECT"
<br>
here, and because these codes need to be synchronized between kernel and
<br>
userland, I can't "just add it to freebsd_dco.h".</p>
<p dir=3D"auto">So consider me not very amused...</p>
<p dir=3D"auto">As a quick bandaid, I'll send a patch that adds an #ifdef T=
ARGET_LINUX
<br>
around this clause so I can update the FreeBSD openvpn-devel port - but
<br>
that is not a really good solution either.  @kp, what would you suggest
<br>
how to handle this on the FreeBSD side?</p>
<br></blockquote></div>
<div class=3D"markdown" style=3D"white-space: normal;">
<p dir=3D"auto">I=E2=80=99m happy to add <code style=3D"padding: 0 0.25em; =
background-color: #E4E4E4;">OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT</code=
> to the FreeBSD <code style=3D"padding: 0 0.25em; background-color: #E4E4E=
4;">enum ovpn_del_reason</code>. The FreeBSD if_ovpn code won=E2=80=99t eve=
r send it (because no TCP) but that=E2=80=99s not really a concern. It=E2=
=80=99ll build and work just fine.</p>
<p dir=3D"auto">Going forward we should try to remember this, and coordinat=
e additions like this.<br>
I=E2=80=99m not sure how we=E2=80=99d cope with supporting building on olde=
r releases though. Not a worry just yet, because FreeBSD main is the only v=
ersion with DCO support in it, but it=E2=80=99ll be a problem sooner or lat=
er.</p>
<p dir=3D"auto">For that I see two paths: either we change the enum (probab=
ly both ovpn_notif_type and ovpn_del_reason) to be defines, so we can <code=
 style=3D"padding: 0 0.25em; background-color: #E4E4E4;">#ifdef OVPN_DEL_PE=
ER_REASON_TRANSPORT_DISCONNECT</code>, or we keep the enums and extend the =
autoconf code to check for us. That=E2=80=99s the sort of thing it=E2=80=99=
s supposed to be for, after all.</p>
<p dir=3D"auto">Best regards,<br>
Kristof</p>

</div>
</div>
</body>

</html>

--=_MailMate_E3B18EB4-06E1-4B32-A782-05F731D9C16A_=--

