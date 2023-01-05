MIME-Version: 1.0
References: <20230101215109.1521549-5-selva.nair@...277...>
 <20230102194156.1560195-1-selva.nair@...277...>
 <CAGyAFMU30BuPUVyjebLj=JDZaNLzAPkHhb8JGvFt1FHuQCVfkw@...278...>
 <CAKuzo_iXw5TJSLdScp-Wf8g-sG6n3bUuE+BYWxqAs4CJFncZcQ@...278...>
In-Reply-To: <CAKuzo_iXw5TJSLdScp-Wf8g-sG6n3bUuE+BYWxqAs4CJFncZcQ@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 5 Jan 2023 14:40:10 -0500
Message-ID: <CAKuzo_hUM_L7YwpGs_3Ui7GvXVXp+5nk78D3W=CA_dVtyPhG0A@...278...>
Content-Type: multipart/alternative; boundary="000000000000fdb85205f1897834"
Subject: Re: [Openvpn-devel] [PATCH v2 4/5] Fix signal handling on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--000000000000fdb85205f1897834
Content-Type: text/plain; charset="UTF-8"

Hi


>
>>
>> Under what circumstances are we supposed to do the waiting again? If
>> we get a signal, we bail out.
>> If the wait times out, we bail out. If wait fails, we do Sleep
>> (although at this point we probably have a bigger issue).
>>
>
> Probably never -- there is a WAIT_ABANDONED which may not apply here. But,
> sometimes windows functions do exit with error codes not listed in the
> docs. As the loop is slowed down by a Sleep(1000), this can't hurt, can it?
>

I see your point now :) I had a different logic earlier where it always
slept for a second before trying to wait again, but not so any longer.  v3
is coming!

Selva

>

--000000000000fdb85205f1897834
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><div><br></div><div class=3D"gmail_quote"><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=
=3D"gmail_quote"><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
Under what circumstances are we supposed to do the waiting again? If<br>
we get a signal, we bail out.<br>
If the wait times out, we bail out. If wait fails, we do Sleep<br>
(although at this point we probably have a bigger issue).<br></blockquote><=
div><br></div><div>Probably never -- there is a WAIT_ABANDONED which may no=
t apply here. But, sometimes windows functions do exit with error codes not=
 listed in the docs. As the loop is slowed down by a Sleep(1000), this can&=
#39;t=C2=A0hurt, can it?</div></div></div></blockquote><div><br></div><div>=
I see your point now :) I had a different logic earlier where it always sle=
pt for a second before trying to wait again, but not so any longer.=C2=A0 v=
3 is coming!</div><div><br></div><div>Selva</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
</blockquote></div></div>

--000000000000fdb85205f1897834--

