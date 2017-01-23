MIME-Version: 1.0
In-Reply-To: <7a5e68c0-0eba-4306-d95b-c857d7a69e14@...515...>
References: <3decc2ec-f8a3-cb6c-a33f-e7f6368dd1b3@...515...>
	<f1b1c4ec-989b-67ef-2c97-006bee3bea0b@...277...>
	<efc2a91b-9b69-484a-c1d9-576d0ab30931@...515...>
	<CAKuzo_jh4cxwwv+ENDU1C1ED83hjnCHTEJuv9BHO0w5TYLTTeg@...278...>
	<CAKuzo_hVK4zoTokCM4=vWW_4D4xSmfDJ7em=XL_qVoynjR=q2A@...278...>
	<7a5e68c0-0eba-4306-d95b-c857d7a69e14@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 23 Jan 2017 11:54:12 -0500
Message-ID: <CAKuzo_g5GvZoLLL-igZAAz91UV3mBpVnfbgcdyPxSVsku1EA1g@...278...>
Content-Type: multipart/alternative; boundary=001a113e7bf68cdfb30546c5da8a
Subject: Re: [Openvpn-devel] ASLR/DEP -enabled 2.4.0 Windows installer
	available
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113e7bf68cdfb30546c5da8a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 23, 2017 at 4:55 AM, Samuli Sepp=C3=A4nen <samuli@...515...> wr=
ote:

>
>> Checked this on win7. Process explorer shows ASLR flag is set on the
>> executable. But ASLR is not really active. The GUI is loaded at the same
>> address each time (as per vmmap from sysinternals). I see no address
>> randomization.
>>
>> Recompiling by exporting at least one function fixes this so the linker
>> is indeed not adding reloc section to the exe otherwise.
>>
>> The build option does make ASLR work for openssl dll so the only thing
>> missing there was the flag in the header. Not so for the executables.
>>
>> We need to find some fix for this, else I fear this will be ASLR in name
>> only.
>>
>> Selva
>>
>
> So we need a small code change in OpenVPN to get ASLR actually working,
> like in OpenVPN GUI?
>
> <https://github.com/OpenVPN/openvpn-gui/pull/123/>
>
> In particular something like this:
>
> <https://github.com/OpenVPN/openvpn-gui/pull/123/files#diff-
> 2045016cb90d1e65d71c2407a2570927R72>
>
> Correct?


There are many suggestions online including add --export-all-symbols to
LDFLAGS, mark main() with dllexport etc. I thought --export-all-symbols is
an overkill and suggested to just export a dummy variable for the GUI.

I don't fully understand how ASLR is implemented on Windows but my tests
show code, stack, heap and PEB addresses are randomized if dynamicbase flag
is on and there is a .reloc section in the exec (ld appears to add this
only if something is exported). So I can only say this works, not sure its
the best workaround.

I wrote a small program to see ASLR in action: it prints some
representative pointers to code, stack, heap etc to see how they change
between runs. The program and test results are here <
https://gist.github.com/selvanair/c8ffa0fe60710e05c0e38f7d0097468d>

Selva

--001a113e7bf68cdfb30546c5da8a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Mon, Jan 23, 2017 at 4:55 AM, Samuli=
 Sepp=C3=A4nen <span dir=3D"ltr">&lt;<a href=3D"mailto:samuli@...515..." ta=
rget=3D"_blank">samuli@...515...</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><span class=3D"gmail-"><br>
Checked this on win7. Process explorer shows ASLR flag is set on the<br>
executable. But ASLR is not really active. The GUI is loaded at the same<br>
address each time (as per vmmap from sysinternals). I see no address<br>
randomization.<br>
<br>
Recompiling by exporting at least one function fixes this so the linker<br>
is indeed not adding reloc section to the exe otherwise.<br>
<br>
The build option does make ASLR work for openssl dll so the only thing<br>
missing there was the flag in the header. Not so for the executables.<br>
<br>
We need to find some fix for this, else I fear this will be ASLR in name<br>
only.<br>
<br>
Selva<br>
</span></blockquote>
<br>
So we need a small code change in OpenVPN to get ASLR actually working, lik=
e in OpenVPN GUI?<br>
<br>
&lt;<a href=3D"https://github.com/OpenVPN/openvpn-gui/pull/123/" rel=3D"nor=
eferrer" target=3D"_blank">https://github.com/OpenVPN/op<wbr>envpn-gui/pull=
/123/</a>&gt;<br>
<br>
In particular something like this:<br>
<br>
&lt;<a href=3D"https://github.com/OpenVPN/openvpn-gui/pull/123/files#diff-2=
045016cb90d1e65d71c2407a2570927R72" rel=3D"noreferrer" target=3D"_blank">ht=
tps://github.com/OpenVPN/op<wbr>envpn-gui/pull/123/files#diff-<wbr>2045016c=
b90d1e65d71c2407a25709<wbr>27R72</a>&gt;<br>
<br>
Correct?</blockquote></div><br>There are many suggestions online including =
add --export-all-symbols to LDFLAGS, mark main() with dllexport etc. I thou=
ght --export-all-symbols is an overkill and suggested to just export a dumm=
y variable for the GUI.</div><div class=3D"gmail_extra"><br></div><div clas=
s=3D"gmail_extra">I don&#39;t fully understand how ASLR is implemented on W=
indows but my tests show code, stack, heap and PEB addresses are randomized=
 if dynamicbase flag is on and there is a .reloc section in the exec (ld ap=
pears to add this only if something is exported). So I can only say this wo=
rks, not sure its the best workaround.=C2=A0</div><div class=3D"gmail_extra=
"><br></div><div class=3D"gmail_extra">I wrote a small program to see ASLR =
in action: it prints some representative pointers to code, stack, heap etc =
to see how they change between runs. The program and test results are here =
&lt;<a href=3D"https://gist.github.com/selvanair/c8ffa0fe60710e05c0e38f7d00=
97468d">https://gist.github.com/selvanair/c8ffa0fe60710e05c0e38f7d0097468d<=
/a>&gt;</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra=
">Selva</div></div>

--001a113e7bf68cdfb30546c5da8a--

