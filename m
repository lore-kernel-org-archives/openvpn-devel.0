MIME-Version: 1.0
In-Reply-To: <CAKuzo_iQv5qR3bZ3O0k6_vW26KzvZVRMwu7dtg_QE7j=eYc7Fw@...278...>
References: <1484036287-12801-1-git-send-email-chipitsine@...277...>
	<CAKuzo_iQv5qR3bZ3O0k6_vW26KzvZVRMwu7dtg_QE7j=eYc7Fw@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 10 Jan 2017 20:47:50 +0500
Message-ID: <CAFHpkQFFo3g1c=STKOt-qiRLxNNfqTfBa83DE8t5CDby_erT_Q@...278...>
Content-Type: multipart/alternative; boundary=089e01419e1e18088e0545bf687c
Subject: Re: [Openvpn-devel] [PATCH] resolving trivial issue found by clang
 static analyzer variable "ret" is assigned a value that is redefined later
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--089e01419e1e18088e0545bf687c
Content-Type: text/plain; charset=UTF-8

2017-01-10 20:20 GMT+05:00 Selva Nair <selva.nair@...277...>:

>
> On Tue, Jan 10, 2017 at 3:18 AM, Ilya Shipitsin <chipitsine@...277...>
> wrote:
>
>> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
>> index b2547f4..5b39929 100644
>> --- a/src/openvpn/init.c
>> +++ b/src/openvpn/init.c
>> @@ -266,7 +266,6 @@ ce_management_query_remote(struct context *c)
>>              management_event_loop_n_seconds(management, 1);
>>              if (IS_SIG(c))
>>              {
>> -                ret = false;
>>                  break;
>>              }
>>          }
>>
>
> This looks like an arbitrary fix to silence the analyzer. Something else
> is likely wrong here. Why "ret" is over-written later (line 276) as
>
> ret = (flags != CE_MAN_QUERY_REMOTE_SKIP);
>
> is the real question. Looks like a bug that causes signal to be ignored.
>

hmm



>
> Selva
>
>

--089e01419e1e18088e0545bf687c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-01-10 20:20 GMT+05:00 Selva Nair <span dir=3D"ltr">&lt;<a href=3D"=
mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;=
</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div class=3D"g=
mail_extra"><span class=3D""><br><div class=3D"gmail_quote">On Tue, Jan 10,=
 2017 at 3:18 AM, Ilya Shipitsin <span dir=3D"ltr">&lt;<a href=3D"mailto:ch=
ipitsine@...277..." target=3D"_blank">chipitsine@...277...</a>&gt;</span> w=
rote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-styl=
e:solid;padding-left:1ex"><div id=3D"m_7096772325036632961gmail-:1xv" class=
=3D"m_7096772325036632961gmail-a3s m_7096772325036632961gmail-aXjCH m_70967=
72325036632961gmail-m15987769fe5d938b">diff --git a/src/openvpn/init.c b/sr=
c/openvpn/init.c<br>
index b2547f4..5b39929 100644<br>
--- a/src/openvpn/init.c<br>
+++ b/src/openvpn/init.c<br>
@@ -266,7 +266,6 @@ ce_management_query_remote(str<wbr>uct context *c)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0management_event_loop_n_sec=
on<wbr>ds(management, 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_SIG(c))<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D false;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div></blockquote></div><br></span>This=
 looks like an arbitrary fix to silence the analyzer. Something else is lik=
ely wrong here. Why &quot;ret&quot; is over-written later (line 276) as</di=
v><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">ret =3D (=
flags !=3D CE_MAN_QUERY_REMOTE_SKIP);<br></div><div class=3D"gmail_extra"><=
br></div><div class=3D"gmail_extra">is the real question. Looks like a bug =
that causes signal to be ignored.</div></div></blockquote><div><br></div><d=
iv>hmm<br></div><div><br>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div di=
r=3D"ltr"><span class=3D"HOEnZb"><font color=3D"#888888"><div class=3D"gmai=
l_extra"><br></div><div class=3D"gmail_extra">Selva=C2=A0</div><div class=
=3D"gmail_extra"><br></div></font></span></div>
</blockquote></div><br></div></div>

--089e01419e1e18088e0545bf687c--

