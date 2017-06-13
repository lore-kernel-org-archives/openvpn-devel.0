MIME-Version: 1.0
In-Reply-To: <d9c2e940-e72b-cb12-193d-a164bc4ac270@...277...>
References: <c97c0fd6-3d34-fb94-40e4-3ec8dc7af0c9@...277...>
	<f73269d2-ba02-5360-9498-378f1e221a56@...277...>
	<CAKuzo_jkyATwPyQkg4mZRAYbUFqc198+yKE-4kyK_--KbRtU=g@...278...>
	<d9c2e940-e72b-cb12-193d-a164bc4ac270@...277...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 13 Jun 2017 22:25:02 +0500
Message-ID: <CAFHpkQF2fF_69jsquGJ=eamkSMVWPRbO7bFOLixP=27QgEEs5g@...278...>
Content-Type: multipart/alternative; boundary="94eb2c074b4e41c0420551dab786"
Subject: Re: [Openvpn-devel] W10 Client assigns old AND new IPv6 address to
 TAP with GUI+Service but not with cmd prompt
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Debbie Tent <debbie10t@...277...>
Cc: Selva Nair <selva.nair@...277...>, openvpn-devel@lists.sourceforge.net

--94eb2c074b4e41c0420551dab786
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

13 =D0=B8=D1=8E=D0=BD. 2017 =D0=B3. 7:29 =D0=9F=D0=9F =D0=BF=D0=BE=D0=BB=D1=
=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C "debbie10t" <debbie10t@=
...277...>
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:

Hi Selva, thanks for your answer.


On 12/06/17 20:23, Selva Nair wrote:

> On Wed, Jun 7, 2017 at 12:41 PM, debbie10t <debbie10t@...277...> wrote:
>
> Hi,
>>
>> I have a basic setup and discovered that my W10 client was assigning a
>> second IPv6 address to TAP even though it is *not* being pushed by the
>> server.  The second address is an old address from a server that I
>> sometimes connect to.  The server is still running but the client is not
>> connected to it.
>>
>> The most significant information here is that this *only* happens when
>> using the openvpn-GUI + interactive-service.
>>
>
The service should delete the address when openvpn terminates so can't
> think of any reason why an old address would linger even if the same tap
> adapter was used for the previous connection.
>

I decided to try some tests .. in fact I only did one test.
I rebooted the PC and now the second IP address has gone.
(Windows Fast shutdown/reboot disabled .. so full reboot)

I also tried to recreate the problem but so far cannot ..


It might happen if openvpn dies without a chance of deleting associated
ipv6 routes.

Try sysinternals utilities to kill it in such way.


Also, Samuli is developing openvpn test suite for windows, probably we
should add some test like that


No changes have been made to my configs or host W10 pc ..
but I did realise that both configs in question *do* use the same TAP
adapter .. connecting to each server in turn repeatedly did not recreate
the problem .. and even doing crazy things one might do while under the
influence did not recreate the problem.  Even terminating via task manager
could not recreate the problem ..

Chalk this one down to windows weirdness .. Just have to watch out if it
ever happens again.


Does this happen only on Win 10?
>

Only one time I have seen it and now can't recreate it.


Wed Jun 07 16:33:53 2017 us=3D125353 ROUTE: route addition failed using
>
>> service: The object already exists.   [status=3D5010 if_index=3D17]
>>
>
>
> This is a known issue (route not deleted on termination so fails to
> recreate later) and is not a critical. FWIW, there is a patch on the ML to
> fix it.
>

I'll keep an eye open for this.


Thanks



------------------------------------------------------------
------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--94eb2c074b4e41c0420551dab786
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">13 =D0=B8=D1=8E=D0=BD. 2017 =D0=B3. 7:29 =D0=9F=D0=9F =D0=BF=D0=
=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=D1=82=D0=B5=D0=BB=D1=8C &quot;debbi=
e10t&quot; &lt;<a href=3D"mailto:debbie10t@...277...">debbie10t@...277...</=
a>&gt; =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:<br type=3D"attribution">=
<blockquote class=3D"quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">Hi Selva, thanks for your answer.<div class=3D"quo=
ted-text"><br>
<br>
On 12/06/17 20:23, Selva Nair wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On Wed, Jun 7, 2017 at 12:41 PM, debbie10t &lt;<a href=3D"mailto:debbie10t@=
...277..." target=3D"_blank">debbie10t@...277...</a>&gt; wrote:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hi,<br>
<br>
I have a basic setup and discovered that my W10 client was assigning a<br>
second IPv6 address to TAP even though it is *not* being pushed by the<br>
server.=C2=A0 The second address is an old address from a server that I<br>
sometimes connect to.=C2=A0 The server is still running but the client is n=
ot<br>
connected to it.<br>
<br>
The most significant information here is that this *only* happens when<br>
using the openvpn-GUI + interactive-service.<br>
</blockquote></blockquote>
<br>
</div><div class=3D"quoted-text"><blockquote class=3D"gmail_quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
The service should delete the address when openvpn terminates so can&#39;t<=
br>
think of any reason why an old address would linger even if the same tap<br>
adapter was used for the previous connection.<br>
</blockquote>
<br></div>
I decided to try some tests .. in fact I only did one test.<br>
I rebooted the PC and now the second IP address has gone.<br>
(Windows Fast shutdown/reboot disabled .. so full reboot)<br>
<br>
I also tried to recreate the problem but so far cannot ..<br></blockquote><=
/div></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">It might hap=
pen if openvpn dies without a chance of deleting associated ipv6 routes.</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">Try sysinternals utilities=
 to kill it in such way.</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
><br></div><div dir=3D"auto">Also, Samuli is developing openvpn test suite =
for windows, probably we should add some test like that</div><div dir=3D"au=
to"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"g=
mail_extra"><div class=3D"gmail_quote"><blockquote class=3D"quote" style=3D=
"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
No changes have been made to my configs or host W10 pc ..<br>
but I did realise that both configs in question *do* use the same TAP adapt=
er .. connecting to each server in turn repeatedly did not recreate the pro=
blem .. and even doing crazy things one might do while under the influence =
did not recreate the problem.=C2=A0 Even terminating via task manager could=
 not recreate the problem ..<br>
<br>
Chalk this one down to windows weirdness .. Just have to watch out if it ev=
er happens again.<div class=3D"quoted-text"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Does this happen only on Win 10?<br>
</blockquote>
<br></div>
Only one time I have seen it and now can&#39;t recreate it.<div class=3D"qu=
oted-text"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Wed Jun 07 16:33:53 2017 us=3D125353 ROUTE: route addition failed using<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
service: The object already exists.=C2=A0 =C2=A0[status=3D5010 if_index=3D1=
7]<br>
</blockquote>
<br>
<br>
This is a known issue (route not deleted on termination so fails to<br>
recreate later) and is not a critical. FWIW, there is a patch on the ML to<=
br>
fix it.<br>
</blockquote>
<br></div>
I&#39;ll keep an eye open for this.<div class=3D"elided-text"><br>
<br>
Thanks<br>
<br>
<br>
<br>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, Slashdot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@...1483...<wbr>e.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
</div></blockquote></div><br></div></div></div>

--94eb2c074b4e41c0420551dab786--

