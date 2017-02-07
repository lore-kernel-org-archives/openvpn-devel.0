MIME-Version: 1.0
In-Reply-To: <7cfc9e24-236d-ad55-9ed3-5904c4042a06@...515...>
References: <1486364115-9801-1-git-send-email-chipitsine@...277...>
	<20170206104444.12662-1-davids@...515...>
	<13044f0c-953c-af95-79dc-d7b641ae6573@...515...>
	<7cfc9e24-236d-ad55-9ed3-5904c4042a06@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 7 Feb 2017 15:23:07 +0500
Message-ID: <CAFHpkQEWA-yiCu0UreWxb88GRU2Oas8hHdthcp1+SaHSfuJF2A@...278...>
Content-Type: multipart/alternative; boundary=001a1148e7c2623d2f0547ee22f2
Subject: Re: [Openvpn-devel] [PATCH applied] github: Add PR template with
 contributor related information
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, David Sommerseth <davids@...515...>

--001a1148e7c2623d2f0547ee22f2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-02-07 15:09 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:

> On 07/02/2017 11:06, Samuli Sepp=C3=A4nen wrote:
>
>> On 06/02/2017 12:44, David Sommerseth wrote:
>>
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
>>> I have ACKed and applied this, just to get this one resolved.  But I am
>>> very
>>> disappointed that you have yet again completely ignored the guidelines
>>> described in the URL[1] already provided to you - which describes how a
>>> patch
>>> and commit message should look like.
>>>
>>> In fact - your SUBJECT line was 167 characters long, _including_ a URL.
>>> It
>>> did not even have a proper body message.  *sigh*
>>>
>>
>> The 80 character limit is only documented here:
>>
>> <https://community.openvpn.net/openvpn/wiki/CodeStyle>
>>
>>
> Actually, that was just the line length for _code_, not for commit
> messages. So the only indirect guideline for Git commit message line leng=
th
> was
>
> "The maximum length of the line differs between projects, it's usually
> somewhere between 50 and 78 characters"
>
> which was on this page:
>
> <http://who-t.blogspot.fi/2009/12/on-commit-messages.html>
>
> The "seven rules" URL David linked to says the following:
>
> * Limit the subject line to 50 characters
> * Wrap the body at 72 characters
>

as I am somehow related to this topic...
well, I did not mean to annoy David in purpose, it happened accidently (as
I already said).

as for compliance check, it will always annoy people if it is something
written somewhere. people will forget to have a look at it.
can we involve something like that

https://github.com/openresty/lua-nginx-module/blob/master/.travis.yml#L61-L=
62
?

and other checks we agreed upon


>
> I can't recall us ever agreeing to such limits.
>
> Let's agree on what we want and then document it properly.
>
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
> This is a fairly new page and not linked to from anywhere. On top of
>> that the page says that "This coding style is not final and not yet in
>> effect."
>>
>> Moreover, our developer documentation is quite a mess right now:
>>
>> <https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation>
>> <https://community.openvpn.net/openvpn/wiki/Contributing>
>>
>> For example, the DeveloperDocumentation page links to here:
>>
>> <https://community.openvpn.net/openvpn/wiki/CodingConventions>
>>
>> That page is a stub with very little and possibly outdated/false
>> information. Then we have
>>
>> <https://community.openvpn.net/openvpn/wiki/DeveloperDocumen
>> tation#Formatting>
>>
>> which says we use "GNU coding style". And then we have the actual 2.4
>> code style instructions here:
>>
>> <https://community.openvpn.net/openvpn/wiki/CodeStyle>
>>
>> There is a fairly well-hidden link on the DeveloperDocumentation page to
>> these Git commit message instructions:
>>
>> <http://who-t.blogspot.com/2009/12/on-commit-messages.html>
>>
>> I think that blog posting is too verbose. The essential information,
>> such as the "seven rules" you linked to should be directly on the
>> DeveloperDocumentation page, with links to the original documents.
>>
>> I don't want to argue whether Ilya should know the 80 character limit or
>> not. But how can we expect _new_ developers to get our rules if they are
>> not documented properly or if documentation is contradictory? Or if the
>> documentation is hidden as well as the CodeStyle page?
>>
>> I will create a copy of the DeveloperDocumentation page and clean that
>> one up. Then I will send a link so that others can have a look.
>>
>>
>
>

--001a1148e7c2623d2f0547ee22f2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-02-07 15:09 GMT+05:00 Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt;<=
a target=3D"_blank" href=3D"mailto:samuli@...515...">samuli@...515...</a>&g=
t;</span>:<br><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote"><span class=
=3D"gmail-">On 07/02/2017 11:06, Samuli Sepp=C3=A4nen wrote:<br>
<blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex" class=3D"gmail_quote">
On 06/02/2017 12:44, David Sommerseth wrote:<br>
<blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex" class=3D"gmail_quote">
-----BEGIN PGP SIGNED MESSAGE-----<br>
Hash: SHA1<br>
<br>
I have ACKed and applied this, just to get this one resolved.=C2=A0 But I a=
m very<br>
disappointed that you have yet again completely ignored the guidelines<br>
described in the URL[1] already provided to you - which describes how a pat=
ch<br>
and commit message should look like.<br>
<br>
In fact - your SUBJECT line was 167 characters long, _including_ a URL.=C2=
=A0 It<br>
did not even have a proper body message.=C2=A0 *sigh*<br>
</blockquote>
<br>
The 80 character limit is only documented here:<br>
<br>
&lt;<a target=3D"_blank" rel=3D"noreferrer" href=3D"https://community.openv=
pn.net/openvpn/wiki/CodeStyle">https://community.openvpn.net<wbr>/openvpn/w=
iki/CodeStyle</a>&gt;<br>
<br>
</blockquote>
<br></span>
Actually, that was just the line length for _code_, not for commit messages=
. So the only indirect guideline for Git commit message line length was<br>
<br>
&quot;The maximum length of the line differs between projects, it&#39;s usu=
ally somewhere between 50 and 78 characters&quot;<br>
<br>
which was on this page:<br>
<br>
&lt;<a target=3D"_blank" rel=3D"noreferrer" href=3D"http://who-t.blogspot.f=
i/2009/12/on-commit-messages.html">http://who-t.blogspot.fi/2009<wbr>/12/on=
-commit-messages.html</a>&gt;<br>
<br>
The &quot;seven rules&quot; URL David linked to says the following:<br>
<br>
* Limit the subject line to 50 characters<br>
* Wrap the body at 72 characters<br></blockquote><div><br></div><div>as I a=
m somehow related to this topic...<br></div><div>well, I did not mean to an=
noy David in purpose, it happened accidently (as I already said).<br><br></=
div><div>as for compliance check, it will always annoy people if it is some=
thing written somewhere. people will forget to have a look at it.<br></div>=
<div>can we involve something like that <br><br><a href=3D"https://github.c=
om/openresty/lua-nginx-module/blob/master/.travis.yml#L61-L62">https://gith=
ub.com/openresty/lua-nginx-module/blob/master/.travis.yml#L61-L62</a> ?<br>=
<br></div><div>and other checks we agreed upon<br></div><div>=C2=A0</div><b=
lockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex" class=3D"gmail_quote">
<br>
I can&#39;t recall us ever agreeing to such limits.<br>
<br>
Let&#39;s agree on what we want and then document it properly.<div class=3D=
"gmail-HOEnZb"><div class=3D"gmail-h5"><br>
<br>
-- <br>
Samuli Sepp=C3=A4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
<br>
<blockquote style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex" class=3D"gmail_quote">
This is a fairly new page and not linked to from anywhere. On top of<br>
that the page says that &quot;This coding style is not final and not yet in=
<br>
effect.&quot;<br>
<br>
Moreover, our developer documentation is quite a mess right now:<br>
<br>
&lt;<a target=3D"_blank" rel=3D"noreferrer" href=3D"https://community.openv=
pn.net/openvpn/wiki/DeveloperDocumentation">https://community.openvpn.net<w=
br>/openvpn/wiki/DeveloperDocumen<wbr>tation</a>&gt;<br>
&lt;<a target=3D"_blank" rel=3D"noreferrer" href=3D"https://community.openv=
pn.net/openvpn/wiki/Contributing">https://community.openvpn.net<wbr>/openvp=
n/wiki/Contributing</a>&gt;<br>
<br>
For example, the DeveloperDocumentation page links to here:<br>
<br>
&lt;<a target=3D"_blank" rel=3D"noreferrer" href=3D"https://community.openv=
pn.net/openvpn/wiki/CodingConventions">https://community.openvpn.net<wbr>/o=
penvpn/wiki/CodingConvention<wbr>s</a>&gt;<br>
<br>
That page is a stub with very little and possibly outdated/false<br>
information. Then we have<br>
<br>
&lt;<a target=3D"_blank" rel=3D"noreferrer" href=3D"https://community.openv=
pn.net/openvpn/wiki/DeveloperDocumentation#Formatting">https://community.op=
envpn.net<wbr>/openvpn/wiki/DeveloperDocumen<wbr>tation#Formatting</a>&gt;<=
br>
<br>
which says we use &quot;GNU coding style&quot;. And then we have the actual=
 2.4<br>
code style instructions here:<br>
<br>
&lt;<a target=3D"_blank" rel=3D"noreferrer" href=3D"https://community.openv=
pn.net/openvpn/wiki/CodeStyle">https://community.openvpn.net<wbr>/openvpn/w=
iki/CodeStyle</a>&gt;<br>
<br>
There is a fairly well-hidden link on the DeveloperDocumentation page to<br>
these Git commit message instructions:<br>
<br>
&lt;<a target=3D"_blank" rel=3D"noreferrer" href=3D"http://who-t.blogspot.c=
om/2009/12/on-commit-messages.html">http://who-t.blogspot.com/200<wbr>9/12/=
on-commit-messages.html</a>&gt;<br>
<br>
I think that blog posting is too verbose. The essential information,<br>
such as the &quot;seven rules&quot; you linked to should be directly on the=
<br>
DeveloperDocumentation page, with links to the original documents.<br>
<br>
I don&#39;t want to argue whether Ilya should know the 80 character limit o=
r<br>
not. But how can we expect _new_ developers to get our rules if they are<br>
not documented properly or if documentation is contradictory? Or if the<br>
documentation is hidden as well as the CodeStyle page?<br>
<br>
I will create a copy of the DeveloperDocumentation page and clean that<br>
one up. Then I will send a link so that others can have a look.<br>
<br>
</blockquote>
<br>
<br>
</div></div></blockquote></div><br></div></div>

--001a1148e7c2623d2f0547ee22f2--

