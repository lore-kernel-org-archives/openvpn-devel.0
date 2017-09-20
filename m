MIME-Version: 1.0
In-Reply-To: <CAKuzo_hGkfDCUnLSg54za+NFS1jabfEm2620hiGwJox45L_bfg@...278...>
References: <CAKuzo_jzvzxh-exre_W1oG7pUU7+RBOe-zX2P0RDq4nv-pSbQw@...278...>
 <CAKuzo_hGkfDCUnLSg54za+NFS1jabfEm2620hiGwJox45L_bfg@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 20 Sep 2017 20:50:47 +0500
Message-ID: <CAFHpkQHQHX4NyDavubf2iY0vAHu76NO2hic9Hm51nCzq6Pk1Ew@...278...>
Content-Type: multipart/alternative; boundary="001a11448be684ea9b0559a0f073"
Subject: Re: [Openvpn-devel] Better error recognition and error/status
 reporting to the mgmt i/f
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--001a11448be684ea9b0559a0f073
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, I beleive that people will ignore "not green" status. I think
there're should be an option of treating that situation as fatal error.

However, I agree that it requires help from core

20 =D1=81=D0=B5=D0=BD=D1=82. 2017 =D0=B3. 8:39 =D0=9F=D0=9F =D0=BF=D0=BE=D0=
=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C "Selva" <selva.na=
ir@...277...>
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:

> Hi,
>
> On Thu, Sep 14, 2017 at 3:21 PM, Selva <selva.nair@...277...> wrote:
>
>> Hi,
>>
>> Quoting from the meeting logs:
>>
>>
>>> Discussed having more fine-grained signalling from OpenVPN to OpenVPN
>>> GUI. The lack of clear signals from OpenVPN to OpenVPN GUI has been a
>>> rather common problem:
>>>
>>
>>
>>> <https://github.com/OpenVPN/openvpn-gui/issues/168#issuecomm
>>> ent-305243166>
>>> <https://github.com/OpenVPN/openvpn-gui/issues/9>
>>> <https://github.com/OpenVPN/openvpn-gui/issues/183>
>>>
>>
>>
>>> This problem is probably not limited to OpenVPN GUI (Windows), but also
>>> affects other GUI's like NetworkManager. It was agreed that the best
>>> approach is that Selva, mattock and others involved on the Windows side
>>> come up with a PoC or "RFC" of how this issue could be tackled ...
>>> OpenVPN core will then be modified if necessary.
>>
>>
>> No time to write an "RFC" or such for something of this sort, but here
>> are some comments/suggestions:
>>
>> 0. Do not send a status message that reads "CONNECTED, SUCCESS" to the
>> management when there has been critical errors such as: failed to add
>> routes or to set ipv6 address using the service or to talk to the servic=
e,
>> etc.. Send something like "CONNECTED,ERROR".
>>
>> A status signalling with more fine-grained info to the management would
>> be helpful, but as a short-term fix, just changing SUCCESS to ERROR in s=
ome
>> cases may be a good start.
>>
>> 1. Mark all messages to the management as I (for info), W (for warning),
>> N (for non fatal error) etc. -- on some log lines this info is currently
>> missing. I think, part of the problem is not all messages are printed wi=
th
>> an M_xx flag.
>>
>> 2. Mark non-fatal opevpn_execve errors as M_NONFATAL instead of M_WARN
>>
>> 3. Treat failure to talk to the service (when msg_channnel is defined)
>> as M_NONFATAL not M_WARN
>>
>> 4. Mark route add/del errors via service as M_NONFATAL -- currently
>> M_WARN.
>>  Mark route addition failure by other means as M_NONFATAL -- currently
>> M_WARN on all platforms, and all methods, I think.
>>
>> 5. Mark "ifconfig" (set address) errors as consistently M_FATAL or
>> M_NONFATAL (see comment on "fatality" below).
>> Currently these are M_WARN if done by service, M_FATAL otherwise.
>>
>> Given that M_FATAL should be used only very rarely, if at all --- e.g.,
>> if proceeding further makes no sense ---  most errors should be M_NONFAT=
AL.
>> The above comments reflect that sentiment.
>>
>> That said, whether address and route addition errors should be FATAL
>> deserves some discussion -- In case of address addition, an error probab=
ly
>> has to be FATAL, but "route add" failures are borderline cases. E.g., if
>>  "--redirect-gateway" fails, the tunnel may be  considered meaningless in
>> many use cases and thus a fatal error. So, some but not all route-add
>> errors may have to be treated as FATAL.
>>
>> If there is consensus, and an appetite for patch review, I can send in
>> some patches for 2 to 5 and possibly 1. For 0, I'm not sure how to keep
>> track of past errors to construct a useful status message.
>>
>> Thanks,
>>
>
> Any feedback on how to go about these ? I want to make the GUI not show
> green when there are route errors, but need some co-operation from the
> core..
>
> Selva
>
> ------------------------------------------------------------
> ------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>

--001a11448be684ea9b0559a0f073
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hello, I beleive that people will ignore &quot;not green&=
quot; status. I think there&#39;re should be an option of treating that sit=
uation as fatal error.<div dir=3D"auto"><br></div><div dir=3D"auto">However=
, I agree that it requires help from core</div></div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">20 =D1=81=D0=B5=D0=BD=D1=82. 2017 =D0=
=B3. 8:39 =D0=9F=D0=9F =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=
=82=D0=B5=D0=BB=D1=8C &quot;Selva&quot; &lt;<a href=3D"mailto:selva.nair@...1186...=
.277...">selva.nair@...277...</a>&gt; =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
=D0=BB:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"=
ltr">Hi,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Th=
u, Sep 14, 2017 at 3:21 PM, Selva <span dir=3D"ltr">&lt;<a href=3D"mailto:s=
elva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;</span> =
wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div>Hi,</div><di=
v><br></div><div>Quoting from the meeting logs:</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">Discussed having more fine-gra=
ined signalling from OpenVPN to OpenVPN<br>GUI. The lack of clear signals f=
rom OpenVPN to OpenVPN GUI has been a<br>rather common problem:<br></blockq=
uote><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&lt=
;<a href=3D"https://github.com/OpenVPN/openvpn-gui/issues/168#issuecomment-=
305243166" target=3D"_blank">https://github.com/OpenVPN/op<wbr>envpn-gui/is=
sues/168#issuecomm<wbr>ent-305243166</a>&gt;<br>&lt;<a href=3D"https://gith=
ub.com/OpenVPN/openvpn-gui/issues/9" target=3D"_blank">https://github.com/O=
penVPN/op<wbr>envpn-gui/issues/9</a>&gt;<br>&lt;<a href=3D"https://github.c=
om/OpenVPN/openvpn-gui/issues/183" target=3D"_blank">https://github.com/Ope=
nVPN/op<wbr>envpn-gui/issues/183</a>&gt;<br></blockquote><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">This problem is probably n=
ot limited to OpenVPN GUI (Windows), but also<br>affects other GUI&#39;s li=
ke NetworkManager. It was agreed that the best<br>approach is that Selva, m=
attock and others involved on the Windows side<br>come up with a PoC or &qu=
ot;RFC&quot; of how this issue could be tackled ...<br>OpenVPN core will th=
en be modified if necessary.</blockquote><div><br></div><div>No time to wri=
te an &quot;RFC&quot; or such for something of this sort, but here are some=
 comments/suggestions:<br></div><div><br></div><div>0. Do not send a status=
 message that reads &quot;CONNECTED, SUCCESS&quot; to the management when t=
here has been critical errors such as: failed to add routes or to set ipv6 =
address using the service or to talk to the service, etc.. Send something l=
ike &quot;CONNECTED,ERROR&quot;.</div><div><br></div><div>A status signalli=
ng with more fine-grained info to the management would be helpful, but as a=
 short-term fix, just changing SUCCESS to ERROR in some cases may be a good=
 start.</div><div>=C2=A0</div><div>1. Mark all messages to the management a=
s I (for info), W (for warning), N (for non fatal error) etc. -- on some lo=
g lines this info is currently missing. I think, part of the problem is not=
 all messages are printed with an M_xx flag.</div><div><br></div><div>2. Ma=
rk non-fatal=C2=A0<span class=3D"m_8048013445085075463m_-705294039537763233=
6J-JK9eJ-PJVNOc" id=3D"m_8048013445085075463m_-7052940395377632336gmail-:2m=
k.1" style=3D"background:yellow">opevpn</span>_<span class=3D"m_80480134450=
85075463m_-7052940395377632336J-JK9eJ-PJVNOc" id=3D"m_8048013445085075463m_=
-7052940395377632336gmail-:2mk.2" style=3D"background:yellow">execve</span>=
=C2=A0errors as M_NONFATAL instead of M_WARN =C2=A0</div><div><br></div><di=
v>3. Treat failure to talk to the service (when=C2=A0<span class=3D"m_80480=
13445085075463m_-7052940395377632336J-JK9eJ-PJVNOc" id=3D"m_804801344508507=
5463m_-7052940395377632336gmail-:2mk.3" style=3D"background:yellow">msg</sp=
an>_<span class=3D"m_8048013445085075463m_-7052940395377632336J-JK9eJ-PJVNO=
c" id=3D"m_8048013445085075463m_-7052940395377632336gmail-:2mk.4" style=3D"=
background:yellow">channnel</span>=C2=A0is defined) as M_NONFATAL not M_WAR=
N</div><div><br></div><div>4. Mark route add/<span class=3D"m_8048013445085=
075463m_-7052940395377632336J-JK9eJ-PJVNOc" id=3D"m_8048013445085075463m_-7=
052940395377632336gmail-:2mk.5" style=3D"background:yellow">del</span>=C2=
=A0errors via service as M_NONFATAL -- currently M_WARN.</div><div>=C2=A0Ma=
rk route addition failure by other means as M_NONFATAL -- currently M_WARN =
on all platforms, and all methods, I think.</div><div><br></div><div>5. Mar=
k &quot;<span class=3D"m_8048013445085075463m_-7052940395377632336J-JK9eJ-P=
JVNOc" id=3D"m_8048013445085075463m_-7052940395377632336gmail-:2mk.6" style=
=3D"background:yellow">ifconfig</span>&quot; (set address) errors as consis=
tently M_FATAL or M_NONFATAL (see comment on &quot;fatality&quot; below).</=
div><div>Currently these are M_WARN if done by service, M_FATAL otherwise.<=
/div><div><br></div><div>Given that M_FATAL should be used only very rarely=
, if at all --- e.g., if proceeding further makes no sense --- =C2=A0most e=
rrors should be M_NONFATAL. The above comments reflect that sentiment.<br><=
/div><div><br></div><div>That said, whether address and route addition erro=
rs should be FATAL deserves some discussion -- In case of address addition,=
 an error probably has to be FATAL, but &quot;route add&quot; failures are =
borderline cases. E.g., if =C2=A0&quot;--redirect-gateway&quot; fails, the =
tunnel may be =C2=A0considered meaningless in many use cases and thus a fat=
al error. So, some but not all route-add errors may have to be treated as F=
ATAL.=C2=A0</div><div><br></div><div>If there is consensus, and an appetite=
 for patch review, I can send in some patches for 2 to 5 and possibly 1. Fo=
r 0, I&#39;m not sure how to keep track of past errors to construct a usefu=
l status message.</div><div><br></div><div>Thanks,</div></div>
</blockquote></div></div><div class=3D"gmail_extra"><br></div><div class=3D=
"gmail_extra">Any feedback on how to go about these ? I want to make the GU=
I not show green when there are route errors, but need some co-operation fr=
om the core..<br></div><div class=3D"gmail_extra"><br></div><div class=3D"g=
mail_extra">Selva</div></div>
<br>------------------------------<wbr>------------------------------<wbr>-=
-----------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, Slashdot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>_________=
_____________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
<br></blockquote></div></div>

--001a11448be684ea9b0559a0f073--

