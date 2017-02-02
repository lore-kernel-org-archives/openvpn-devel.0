MIME-Version: 1.0
In-Reply-To: <b907084b-77a5-3152-3ff9-366ecd1bf5a4@...515...>
References: <1484297432-14435-1-git-send-email-chipitsine@...277...>
	<7dc75a19-451e-effa-503a-ac5b75a23bab@...515...>
	<ac93d2de-d56a-0ff9-b97a-a590923f5cf8@...2080...>
	<CAFHpkQEHRCveRiiBWscwLQ7U3UoJ+yY5_0Lx82UMc=f4ucwMbQ@...278...>
	<CAFHpkQFs5x_7MEH5gjieUsp=1f2SPdG9Fr6PeakgBGrSEPQC_Q@...278...>
	<6256c846-ca60-be4f-7122-60465374a322@...515...>
	<7e7799f0-e2f1-8773-18aa-6a89b87d3500@...2080...>
	<b907084b-77a5-3152-3ff9-366ecd1bf5a4@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 2 Feb 2017 16:58:37 +0500
Message-ID: <CAFHpkQHF7Wxw_WMBsnyzz5qgDr+ghYnoiWkDJp+rbfK2qr1mQA@...278...>
Content-Type: multipart/alternative; boundary=001a1141d210b3b13a05478ae21f
Subject: Re: [Openvpn-devel] [PATCH] add PR template in order to simplify
 new developers cooperate properly if they open PR. discussed here:
 https://sourceforge.net/p/openvpn/mailman/message/35601310/
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

--001a1141d210b3b13a05478ae21f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-02-02 13:27 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:

> On 31/01/2017 15:49, David Sommerseth wrote:
>
>> On 30/01/17 13:34, Samuli Sepp=C3=A4nen wrote:
>>
>>> I agree with you on keeping the pull request template minimal and having
>>> the more fine-grained information in Trac.
>>>
>>> ACK.
>>>
>>
>> Don't get me wrong!  I agree we should keep the template minimal.  But I
>> yet have to see a developer full of enthusiasm with a fix ready, who
>> just clicked "Send pull request!" who will actually instantly go reading
>> further.  And especially when the information need is fairly
>> comprehensive and not even directly in the first URL being listed.
>>
>> In fact the first place where the patch process is described is here:
>> <https://community.openvpn.net/openvpn/wiki/DeveloperDocumen
>> tation#Communitypatchesandtheacceptanceprocessofthesepatches>.
>>  That is "hidden" in the middle of the wiki on the second URL.  And the
>> first URL provides just a link to the same DeveloperDocumentation wiki
>> page.
>>
>> So I kindly ask you to reconsider the text more carefully once more.
>>
>> From my experience, to get the best success, provide the most critical
>> and as accurate information as quickly as possible.  Once things are
>> behind one URL you need to visit, many ignores it.  If you need to read
>> through more text on that URL, even more will fall off.  But provide
>> links to the more verbose documentation, as some will read it if the
>> first 2-3 sentences sounds intriguing and the contributor have time to
>> be curious.
>>
>> Most developers are lazy beasts ... they just want their patches out
>> ASAP, and documentation are too easily ignored.
>>
>>
>>
> Well, I asked if anyone had any comments regarding the PR template text,
> and nobody did. Except when it was ACKed, of course :).
>
> I think we need to lure GitHub people into sending patches to the mailing
> list. If we describe the full process in the pull request template, many
> will just say "meh, too difficult". Once they've sent their patch to the
> list they're quite far already, and are unlikely to quit if we ask them to
> make minor changes.
>
> So what about this:
>
> ---
>
> # Thank you for your contribution
>
> You are welcome to open PR, but they are used for discussion only. All
> patches must eventually go to the openvpn-devel mailing list for review:
>
> * https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
> Please send your patch using [git-send-email](https://git-s
> cm.com/docs/git-send-email). For example to send your latest commit to
> the list:
>
>     $ git-send-email --to=3Dopenvpn-devel@lists.sourceforge.net HEAD~1
>

documentation seems to be confusing here.
I could not get "git-send-email" for fedora, it is "git send-email" instead.
something like "send patches to list" should be ok




>
> For details, see these Wiki articles:
>
> * https://community.openvpn.net/openvpn/wiki/Contributing
> * https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation
>
> ---
>
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>

--001a1141d210b3b13a05478ae21f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-02-02 13:27 GMT+05:00 Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt;<=
a href=3D"mailto:samuli@...515..." target=3D"_blank">samuli@...515...</a>&g=
t;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 31/01/2017=
 15:49, David Sommerseth wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On 30/01/17 13:34, Samuli Sepp=C3=A4nen wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
I agree with you on keeping the pull request template minimal and having<br>
the more fine-grained information in Trac.<br>
<br>
ACK.<br>
</blockquote>
<br>
Don&#39;t get me wrong!=C2=A0 I agree we should keep the template minimal.=
=C2=A0 But I<br>
yet have to see a developer full of enthusiasm with a fix ready, who<br>
just clicked &quot;Send pull request!&quot; who will actually instantly go =
reading<br>
further.=C2=A0 And especially when the information need is fairly<br>
comprehensive and not even directly in the first URL being listed.<br>
<br>
In fact the first place where the patch process is described is here:<br>
&lt;<a href=3D"https://community.openvpn.net/openvpn/wiki/DeveloperDocument=
ation#Communitypatchesandtheacceptanceprocessofthesepatches" rel=3D"norefer=
rer" target=3D"_blank">https://community.openvpn.net<wbr>/openvpn/wiki/Deve=
loperDocumen<wbr>tation#Communitypatchesandthea<wbr>cceptanceprocessofthese=
patches</a><wbr>&gt;.<br>
=C2=A0That is &quot;hidden&quot; in the middle of the wiki on the second UR=
L.=C2=A0 And the<br>
first URL provides just a link to the same DeveloperDocumentation wiki page=
.<br>
<br>
So I kindly ask you to reconsider the text more carefully once more.<br>
<br>
From my experience, to get the best success, provide the most critical<br>
and as accurate information as quickly as possible.=C2=A0 Once things are<b=
r>
behind one URL you need to visit, many ignores it.=C2=A0 If you need to rea=
d<br>
through more text on that URL, even more will fall off.=C2=A0 But provide<b=
r>
links to the more verbose documentation, as some will read it if the<br>
first 2-3 sentences sounds intriguing and the contributor have time to<br>
be curious.<br>
<br>
Most developers are lazy beasts ... they just want their patches out<br>
ASAP, and documentation are too easily ignored.<br>
<br>
<br>
</blockquote>
<br></span>
Well, I asked if anyone had any comments regarding the PR template text, an=
d nobody did. Except when it was ACKed, of course :).<br>
<br>
I think we need to lure GitHub people into sending patches to the mailing l=
ist. If we describe the full process in the pull request template, many wil=
l just say &quot;meh, too difficult&quot;. Once they&#39;ve sent their patc=
h to the list they&#39;re quite far already, and are unlikely to quit if we=
 ask them to make minor changes.<br>
<br>
So what about this:<br>
<br>
---<span class=3D""><br>
<br>
# Thank you for your contribution<br>
<br></span><span class=3D"">
You are welcome to open PR, but they are used for discussion only. All<br><=
/span>
patches must eventually go to the openvpn-devel mailing list for review:<br>
<br>
* <a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" re=
l=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists=
/listinfo/openvpn-devel</a><br>
<br>
Please send your patch using [git-send-email](<a href=3D"https://git-scm.co=
m/docs/git-send-email" rel=3D"noreferrer" target=3D"_blank">https://git-s<w=
br>cm.com/docs/git-send-email</a>). For example to send your latest commit =
to the list:<br>
<br>
=C2=A0 =C2=A0 $ git-send-email --to=3D<a href=3D"mailto:openvpn-devel@...1697...=
.sourceforge.net" target=3D"_blank">openvpn-devel@...1011...<wbr>eforge.net=
</a> HEAD~1<span class=3D""><br></span></blockquote><div><br></div><div>doc=
umentation seems to be confusing here.<br></div><div>I could not get &quot;=
git-send-email&quot; for fedora, it is &quot;git send-email&quot; instead.<=
br></div><div>something like &quot;send patches to list&quot; should be ok<=
br></div><div><br></div><div><br>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
><span class=3D"">
<br>
For details, see these Wiki articles:<br>
<br></span>
* <a href=3D"https://community.openvpn.net/openvpn/wiki/Contributing" rel=
=3D"noreferrer" target=3D"_blank">https://community.openvpn.net/<wbr>openvp=
n/wiki/Contributing</a><br>
* <a href=3D"https://community.openvpn.net/openvpn/wiki/DeveloperDocumentat=
ion" rel=3D"noreferrer" target=3D"_blank">https://community.openvpn.net/<wb=
r>openvpn/wiki/DeveloperDocument<wbr>ation</a><br>
<br>
---<div class=3D"HOEnZb"><div class=3D"h5"><br>
<br>
-- <br>
Samuli Sepp=C3=A4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
</div></div></blockquote></div><br></div></div>

--001a1141d210b3b13a05478ae21f--

