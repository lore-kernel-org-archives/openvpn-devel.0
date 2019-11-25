MIME-Version: 1.0
References: <1573148729-27339-1-git-send-email-lstipakov@...277...>
 <1573148729-27339-4-git-send-email-lstipakov@...277...>
 <CAKuzo_g7kyhuoDNAC3dbg=HHZO4iSpR+zKQrd0Lpcn8cj9tH=Q@...278...>
 <CAGyAFMVdYrTgcA6kRawsVXjj48DXUqKw2Z0F7EpWQBOrTKrEFg@...278...>
 <CAKuzo_i0BouG604qJAO--qoX5TeTmYi_2CskF3FfqzOTO6dEWQ@...278...>
 <CAGyAFMWeN-G7qf=MJfuuZK5M72VJ_03ahdAFsi6aLDcUT_me6g@...278...>
 <CAKuzo_h4hbQmaQrPHdDTkPjGOdGS55tsGDKm4RfHY0vWuqF5Fw@...278...>
 <99D61A626FDA8A4B90A270669121BE10C9AF9896@...2294...>
 <CAGyAFMWEc0c_GRiphD+=zikh2BkMckxD4rjZXrmQfmLUejAkgA@...278...>
 <CAKuzo_howdUtX86vj9kTYga=r8Ce0rbnrSiciqfCNtVVVeFwbw@...278...>
 <CAGyAFMWc=A=D_HRUpHJTXcPZSqxWKK44Hvd1ykAyb8JgQZD_2Q@...278...>
In-Reply-To: <CAGyAFMWc=A=D_HRUpHJTXcPZSqxWKK44Hvd1ykAyb8JgQZD_2Q@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 25 Nov 2019 11:48:47 -0500
Message-ID: <CAKuzo_iLChLmtbJbBZyD0WNxyUFr1cj-yBtWK-kETNRR8gwk_Q@...278...>
Content-Type: multipart/alternative; boundary="0000000000009c7b5c05982e8af2"
Subject: Re: [Openvpn-devel] [PATCH v2 3/7] wintun: implement opening wintun
 device
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000009c7b5c05982e8af2
Content-Type: text/plain; charset="UTF-8"

Hi

On Mon, Nov 25, 2019 at 4:03 AM Lev Stipakov <lstipakov@...277...> wrote:

> Hi,
>
> (cc:ed to -devel)
>
>
>> I would vote for B and not the combination.
>>
>> With wintun there is no backwards compatibility requirements, so we could
>> use a cleaner, consistent and simpler approach (i.e B). Do not create any
>> adapter during installation and dynamically create a temporary adapter at
>> connection time.
>>
>
> My main concern with creating tun adapter on demand is that it is far from
> instant:
>
> $ time ./tapctl.exe create --hwid wintun
> {D9F56B7A-3054-4ADC-9457-61030F0B469D}
>
> real    0m2,090s
>
> I don't think we want to add it to connection time.
>

No, we don't want that.

I do realize what I wrote earlier was far from ideal. I had forgotten my
travails two years back attempting to add dynamic tap adapter creation to
OpnVPN....

As an easy way for supporting multiple tunnels, can we treat success of
open-device + ring-buffer-registration calls together as a successful open
of the adapter, and move on to the next one when that fails? That would be
very similar to what we do for tapwindows right now.

To assist users, when we fail with no free adapters, we could add a feature
to the GUI to add a new one using the RunAsAdmin shell-execute we already
have support for. Will need an improved devcon/tapinstall that does not
reset all adapters when a new one is added, except when unavoidable due to
driver version change.

Simon's suggestion of persistent adapters as required and kept disabled
when not in use sounds interesting. As some providers do supply 100's of
configs, I think we should refrain from creating one adapter per ovpn,
though. They should be using multiple --remote lines in a single config,
but, for that to work well, we need to improve --management-remote option
to provide a friendly UI for remote selection.

Selva

--0000000000009c7b5c05982e8af2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, Nov 25, 2019 at 4:03 AM Lev Stipakov =
&lt;<a href=3D"mailto:lstipakov@...277..." target=3D"_blank">lstipakov@...1665...=
77...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div>Hi,</div><div><br></d=
iv><div>(cc:ed to -devel)</div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><div>I w=
ould vote for B and not the combination.<br></div><div><br></div><div>With =
wintun there is no backwards compatibility requirements, so we could use a =
cleaner, consistent and simpler approach (i.e B). Do not create any adapter=
 during installation and dynamically create a temporary adapter at connecti=
on time.</div></div></div></blockquote><div><br></div><div>My main concern =
with creating tun adapter on demand is that it is far from instant:</div><d=
iv><br></div><div>$ time ./tapctl.exe create --hwid wintun<br>{D9F56B7A-305=
4-4ADC-9457-61030F0B469D}<br><br>real =C2=A0 =C2=A00m2,090s<br></div><div><=
br></div><div>I don&#39;t think we want to add it to connection time.</div>=
</div></div></blockquote><div><br></div><div>No, we don&#39;t want that.<br=
></div><div><br></div><div>I do realize what I wrote earlier was far from i=
deal. I had forgotten my travails two years back attempting to add dynamic =
tap adapter creation to OpnVPN....<br></div><div><br></div><div>As an easy =
way for supporting multiple tunnels, can we treat success of open-device + =
ring-buffer-registration calls together as a successful open of the adapter=
, and move on to the next one when that fails? That would be very similar t=
o what we do for tapwindows right now.</div><div><br></div><div>To assist u=
sers, when we fail with no free adapters, we could add a feature to the GUI=
 to add a new one using the RunAsAdmin shell-execute we already have suppor=
t for. Will need an improved devcon/tapinstall that does not reset all adap=
ters when a new one is added, except when unavoidable due to driver version=
 change. <br></div><div><br></div><div>Simon&#39;s suggestion of persistent=
 adapters as required and kept disabled when not in use sounds interesting.=
 As some providers do supply 100&#39;s of configs, I think we should refrai=
n from creating one adapter per ovpn, though. They should be using multiple=
 --remote lines in a single config, but, for that to work well, we need to =
improve --management-remote option to provide a friendly UI for remote sele=
ction.<br></div><div><br></div><div>Selva</div></div></div>

--0000000000009c7b5c05982e8af2--

