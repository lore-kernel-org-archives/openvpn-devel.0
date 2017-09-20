MIME-Version: 1.0
In-Reply-To: <CAKuzo_jzvzxh-exre_W1oG7pUU7+RBOe-zX2P0RDq4nv-pSbQw@...278...>
References: <CAKuzo_jzvzxh-exre_W1oG7pUU7+RBOe-zX2P0RDq4nv-pSbQw@...278...>
From: Selva <selva.nair@...277...>
Date: Wed, 20 Sep 2017 11:38:30 -0400
Message-ID: <CAKuzo_hGkfDCUnLSg54za+NFS1jabfEm2620hiGwJox45L_bfg@...278...>
Content-Type: multipart/alternative; boundary="001a113d512ec301850559a0c564"
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113d512ec301850559a0c564
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, Sep 14, 2017 at 3:21 PM, Selva <selva.nair@...277...> wrote:

> Hi,
>
> Quoting from the meeting logs:
>
>
>> Discussed having more fine-grained signalling from OpenVPN to OpenVPN
>> GUI. The lack of clear signals from OpenVPN to OpenVPN GUI has been a
>> rather common problem:
>>
>
>
>> <https://github.com/OpenVPN/openvpn-gui/issues/168#issuecomment-305243166
>> >
>> <https://github.com/OpenVPN/openvpn-gui/issues/9>
>> <https://github.com/OpenVPN/openvpn-gui/issues/183>
>>
>
>
>> This problem is probably not limited to OpenVPN GUI (Windows), but also
>> affects other GUI's like NetworkManager. It was agreed that the best
>> approach is that Selva, mattock and others involved on the Windows side
>> come up with a PoC or "RFC" of how this issue could be tackled ...
>> OpenVPN core will then be modified if necessary.
>
>
> No time to write an "RFC" or such for something of this sort, but here are
> some comments/suggestions:
>
> 0. Do not send a status message that reads "CONNECTED, SUCCESS" to the
> management when there has been critical errors such as: failed to add
> routes or to set ipv6 address using the service or to talk to the service,
> etc.. Send something like "CONNECTED,ERROR".
>
> A status signalling with more fine-grained info to the management would be
> helpful, but as a short-term fix, just changing SUCCESS to ERROR in some
> cases may be a good start.
>
> 1. Mark all messages to the management as I (for info), W (for warning), N
> (for non fatal error) etc. -- on some log lines this info is currently
> missing. I think, part of the problem is not all messages are printed with
> an M_xx flag.
>
> 2. Mark non-fatal opevpn_execve errors as M_NONFATAL instead of M_WARN
>
> 3. Treat failure to talk to the service (when msg_channnel is defined) as
> M_NONFATAL not M_WARN
>
> 4. Mark route add/del errors via service as M_NONFATAL -- currently
> M_WARN.
>  Mark route addition failure by other means as M_NONFATAL -- currently
> M_WARN on all platforms, and all methods, I think.
>
> 5. Mark "ifconfig" (set address) errors as consistently M_FATAL or
> M_NONFATAL (see comment on "fatality" below).
> Currently these are M_WARN if done by service, M_FATAL otherwise.
>
> Given that M_FATAL should be used only very rarely, if at all --- e.g., if
> proceeding further makes no sense ---  most errors should be M_NONFATAL.
> The above comments reflect that sentiment.
>
> That said, whether address and route addition errors should be FATAL
> deserves some discussion -- In case of address addition, an error probably
> has to be FATAL, but "route add" failures are borderline cases. E.g., if
>  "--redirect-gateway" fails, the tunnel may be  considered meaningless in
> many use cases and thus a fatal error. So, some but not all route-add
> errors may have to be treated as FATAL.
>
> If there is consensus, and an appetite for patch review, I can send in
> some patches for 2 to 5 and possibly 1. For 0, I'm not sure how to keep
> track of past errors to construct a useful status message.
>
> Thanks,
>

Any feedback on how to go about these ? I want to make the GUI not show
green when there are route errors, but need some co-operation from the
core..

Selva

--001a113d512ec301850559a0c564
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Thu, Sep 14, 2017 at 3:21 PM, Selva <span dir=3D"ltr">&lt;<a href=
=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div>=
Hi,</div><div><br></div><div>Quoting from the meeting logs:</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">Discussed having=
 more fine-grained signalling from OpenVPN to OpenVPN<br>GUI. The lack of c=
lear signals from OpenVPN to OpenVPN GUI has been a<br>rather common proble=
m:<br></blockquote><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">&lt;<a href=3D"https://github.com/OpenVPN/openvpn-gui/issues/168=
#issuecomment-305243166" target=3D"_blank">https://github.com/OpenVPN/<wbr>=
openvpn-gui/issues/168#<wbr>issuecomment-305243166</a>&gt;<br>&lt;<a href=
=3D"https://github.com/OpenVPN/openvpn-gui/issues/9" target=3D"_blank">http=
s://github.com/OpenVPN/<wbr>openvpn-gui/issues/9</a>&gt;<br>&lt;<a href=3D"=
https://github.com/OpenVPN/openvpn-gui/issues/183" target=3D"_blank">https:=
//github.com/OpenVPN/<wbr>openvpn-gui/issues/183</a>&gt;<br></blockquote><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">This probl=
em is probably not limited to OpenVPN GUI (Windows), but also<br>affects ot=
her GUI&#39;s like NetworkManager. It was agreed that the best<br>approach =
is that Selva, mattock and others involved on the Windows side<br>come up w=
ith a PoC or &quot;RFC&quot; of how this issue could be tackled ...<br>Open=
VPN core will then be modified if necessary.</blockquote><div><br></div><di=
v>No time to write an &quot;RFC&quot; or such for something of this sort, b=
ut here are some comments/suggestions:<br></div><div><br></div><div>0. Do n=
ot send a status message that reads &quot;CONNECTED, SUCCESS&quot; to the m=
anagement when there has been critical errors such as: failed to add routes=
 or to set ipv6 address using the service or to talk to the service, etc.. =
Send something like &quot;CONNECTED,ERROR&quot;.</div><div><br></div><div>A=
 status signalling with more fine-grained info to the management would be h=
elpful, but as a short-term fix, just changing SUCCESS to ERROR in some cas=
es may be a good start.</div><div>=C2=A0</div><div>1. Mark all messages to =
the management as I (for info), W (for warning), N (for non fatal error) et=
c. -- on some log lines this info is currently missing. I think, part of th=
e problem is not all messages are printed with an M_xx flag.</div><div><br>=
</div><div>2. Mark non-fatal=C2=A0<span class=3D"m_-7052940395377632336J-JK=
9eJ-PJVNOc" id=3D"m_-7052940395377632336gmail-:2mk.1" style=3D"background:y=
ellow">opevpn</span>_<span class=3D"m_-7052940395377632336J-JK9eJ-PJVNOc" i=
d=3D"m_-7052940395377632336gmail-:2mk.2" style=3D"background:yellow">execve=
</span>=C2=A0errors as M_NONFATAL instead of M_WARN =C2=A0</div><div><br></=
div><div>3. Treat failure to talk to the service (when=C2=A0<span class=3D"=
m_-7052940395377632336J-JK9eJ-PJVNOc" id=3D"m_-7052940395377632336gmail-:2m=
k.3" style=3D"background:yellow">msg</span>_<span class=3D"m_-7052940395377=
632336J-JK9eJ-PJVNOc" id=3D"m_-7052940395377632336gmail-:2mk.4" style=3D"ba=
ckground:yellow">channnel</span>=C2=A0is defined) as M_NONFATAL not M_WARN<=
/div><div><br></div><div>4. Mark route add/<span class=3D"m_-70529403953776=
32336J-JK9eJ-PJVNOc" id=3D"m_-7052940395377632336gmail-:2mk.5" style=3D"bac=
kground:yellow">del</span>=C2=A0errors via service as M_NONFATAL -- current=
ly M_WARN.</div><div>=C2=A0Mark route addition failure by other means as M_=
NONFATAL -- currently M_WARN on all platforms, and all methods, I think.</d=
iv><div><br></div><div>5. Mark &quot;<span class=3D"m_-7052940395377632336J=
-JK9eJ-PJVNOc" id=3D"m_-7052940395377632336gmail-:2mk.6" style=3D"backgroun=
d:yellow">ifconfig</span>&quot; (set address) errors as consistently M_FATA=
L or M_NONFATAL (see comment on &quot;fatality&quot; below).</div><div>Curr=
ently these are M_WARN if done by service, M_FATAL otherwise.</div><div><br=
></div><div>Given that M_FATAL should be used only very rarely, if at all -=
-- e.g., if proceeding further makes no sense --- =C2=A0most errors should =
be M_NONFATAL. The above comments reflect that sentiment.<br></div><div><br=
></div><div>That said, whether address and route addition errors should be =
FATAL deserves some discussion -- In case of address addition, an error pro=
bably has to be FATAL, but &quot;route add&quot; failures are borderline ca=
ses. E.g., if =C2=A0&quot;--redirect-gateway&quot; fails, the tunnel may be=
 =C2=A0considered meaningless in many use cases and thus a fatal error. So,=
 some but not all route-add errors may have to be treated as FATAL.=C2=A0</=
div><div><br></div><div>If there is consensus, and an appetite for patch re=
view, I can send in some patches for 2 to 5 and possibly 1. For 0, I&#39;m =
not sure how to keep track of past errors to construct a useful status mess=
age.</div><div><br></div><div>Thanks,</div></div>
</blockquote></div></div><div class=3D"gmail_extra"><br></div><div class=3D=
"gmail_extra">Any feedback on how to go about these ? I want to make the GU=
I not show green when there are route errors, but need some co-operation fr=
om the core..<br></div><div class=3D"gmail_extra"><br></div><div class=3D"g=
mail_extra">Selva</div></div>

--001a113d512ec301850559a0c564--

