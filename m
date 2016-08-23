MIME-Version: 1.0
In-Reply-To: <CAKuzo_goKiVr4k7+eQbLK93fzQ99ZH+pkk1uVw0k2_OGb0mH4A@...278...>
References: <CAKuzo_jO0FLo=xMakh1yB6_h=huE4Pqp6Xtk2QEgXikeui-F6w@...278...>
	<073f348b-77a8-3967-2874-77f2c973dbf4@...2070...>
	<CAKuzo_goKiVr4k7+eQbLK93fzQ99ZH+pkk1uVw0k2_OGb0mH4A@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 23 Aug 2016 11:23:29 -0400
Message-ID: <CAKuzo_jRJcTGWRqv51O3TPc7rU=8aomQqFeib0FF_G-dtUmeQg@...278...>
Content-Type: multipart/alternative; boundary=001a114a6a22722ade053abec083
Subject: Re: [Openvpn-devel] block-outside-dns and multiple tunnels
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--001a114a6a22722ade053abec083
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,


On Tue, Aug 16, 2016 at 1:42 PM, Selva Nair <selva.nair@...277...> wrote:

> Hi,
>
> On Tue, Aug 16, 2016 at 12:41 PM, ValdikSS <iam@...2070...> wrote:
>
>> This is known issue (for me), and it was superficially discussed on IRC
>> at some point. It wasn't considered significant to implement
>> block-outside-dns for multiple connections.
>>
>> Is there ahy reason to use block-outside-dns on multiple connections?
>> Just asked supergregg (bug reporter), he probably has a reason if he
>> created the bug.
>>
>
> I have no strong reason except that if an end user gets two configs with
> block-outside-dns enabled it should just work without having to edit the
> configs. Support for dns traffic through each tunnel may not be required,
> but at least one of them working even if block-outside-dns is specified in
> multiple configs looks like a nice thing to do.  Not all users can be
> expected to edit configs.
>
> Selva
>

The IRC summary of Aug 22  says

Discussed "=E2=80=8Bblock-outside-dns and multiple tunnels":

<https://sourceforge.net/p/openvpn/mailman/message/35263770/>
<https://community.openvpn.net/openvpn/ticket/718>

It was agreed to move this forward by looking into the approaches
suggested by Selva, and by giving him feedback.


So what is the consensus? Should we support DNS through all tunnels for
which block-outside-dns is specified or just make sure DNS works through at
least one of the tunnels if the option is used on multiple ones?

Thanks,

Selva

--001a114a6a22722ade053abec083
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br><div class=3D"gmail_extra"><br><div class=3D"g=
mail_quote">On Tue, Aug 16, 2016 at 1:42 PM, Selva Nair <span dir=3D"ltr">&=
lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...493...=
277...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,20=
4,204);border-left-style:solid;padding-left:1ex"><div dir=3D"ltr"><div clas=
s=3D"gmail_extra">Hi,</div><div class=3D"gmail_extra"><span><br><div class=
=3D"gmail_quote">On Tue, Aug 16, 2016 at 12:41 PM, ValdikSS <span dir=3D"lt=
r">&lt;<a href=3D"mailto:iam@...2070..." target=3D"_blank">iam@...2070...</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left-width:1px;border-left-color:rgb(204,204,204);b=
order-left-style:solid;padding-left:1ex"><div text=3D"#000000" bgcolor=3D"#=
FFFFFF">This is known issue (for me), and it was superficially discussed on
    IRC at some point. It wasn&#39;t considered significant to implement
    block-outside-dns for multiple connections.<br>
    <br>
    Is there ahy reason to use block-outside-dns on multiple
    connections? Just asked supergregg (bug reporter), he probably has a
    reason if he created the bug.</div></blockquote></div><br></span>I have=
 no strong reason except that if an end user gets two configs with block-ou=
tside-dns enabled it should just work without having to edit the configs. S=
upport for dns traffic through each tunnel may not be required, but at leas=
t one of them working even if block-outside-dns is specified in multiple co=
nfigs looks like a nice thing to do.=C2=A0 Not all users can be expected to=
 edit configs.</div><span><font color=3D"#888888"><div class=3D"gmail_extra=
"><br></div><div class=3D"gmail_extra">Selva</div></font></span></div>
</blockquote></div><br></div></div><div class=3D"gmail_extra">The IRC summa=
ry of Aug 22 =C2=A0says</div><div class=3D"gmail_extra"><div class=3D"gmail=
_extra"><br></div></div><blockquote style=3D"margin:0 0 0 40px;border:none;=
padding:0px"><div class=3D"gmail_extra"><div class=3D"gmail_extra">Discusse=
d &quot;=E2=80=8Bblock-outside-dns and multiple tunnels&quot;:</div></div><=
div class=3D"gmail_extra"><div class=3D"gmail_extra"><br></div></div><div c=
lass=3D"gmail_extra"><div class=3D"gmail_extra">&lt;<a href=3D"https://sour=
ceforge.net/p/openvpn/mailman/message/35263770/" target=3D"_blank">https://=
sourceforge.net/p/ope<wbr>nvpn/mailman/message/35263770/</a><wbr>&gt;</div>=
</div><div class=3D"gmail_extra"><div class=3D"gmail_extra">&lt;<a href=3D"=
https://community.openvpn.net/openvpn/ticket/718" target=3D"_blank">https:/=
/community.openvpn.net<wbr>/openvpn/ticket/718</a>&gt;</div></div><div clas=
s=3D"gmail_extra"><div class=3D"gmail_extra"><br></div></div><div class=3D"=
gmail_extra"><div class=3D"gmail_extra">It was agreed to move this forward =
by looking into the approaches</div></div><div class=3D"gmail_extra"><div c=
lass=3D"gmail_extra">suggested by Selva, and by giving him feedback.</div><=
/div></blockquote><div class=3D"gmail_extra"><div class=3D"gmail_extra"><br=
></div><div class=3D"gmail_extra">So what is the consensus? Should we suppo=
rt DNS through all tunnels for which block-outside-dns is specified or just=
 make sure DNS works through at least one of the tunnels if the option is u=
sed on multiple ones?</div><div class=3D"gmail_extra"><br></div><div class=
=3D"gmail_extra">Thanks,</div><div class=3D"gmail_extra"><br></div><div cla=
ss=3D"gmail_extra">Selva</div></div></div>

--001a114a6a22722ade053abec083--

