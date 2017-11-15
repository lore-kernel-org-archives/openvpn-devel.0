MIME-Version: 1.0
In-Reply-To: <5A0ADEF0.5040507@...1147...>
References: <20171110163946.7656-1-fkooman@...2318...>
 <63ccd0e3-491f-3fb3-e611-9b6674d3d501@...2298...>
 <aef485c7-f619-eaac-6534-0828ab9d41f5@...2318...>
 <CAKuzo_jfJQOBhYMEyT4oiNN1xAZkvkxZm8eeDT=xcUfToaC9kQ@...278...>
 <20171112214244.GI958@...1296...>
 <34a7cc97-16e2-becc-4f97-ff8dbf8ecb0a@...2318...>
 <4ea94797-c52a-da17-b5ba-c7f8d9411326@...2181...>
 <4717a1f2-b8c6-26ae-2cf4-42ae5f34c3eb@...1435...>
 <6ad9db3e-63b5-78fe-0105-81c92746feb2@...2080...>
 <20171114083134.GV958@...1296...> <5A0ADEF0.5040507@...1147...>
From: Selva <selva.nair@...277...>
Date: Wed, 15 Nov 2017 10:09:18 -0500
Message-ID: <CAKuzo_jG8ZqXW5FQDNNkKjxHucGzWm62753Qxp2_j=6cdj_LXg@...278...>
Content-Type: multipart/alternative; boundary="001a11472b5677c3c9055e06e466"
Subject: Re: [Openvpn-devel] [PATCH] Implement "status 4" (JSON) for
 management interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11472b5677c3c9055e06e466
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 14, 2017 at 7:17 AM, Jan Just Keijser <janjust@...1147...> wrote:

> On 14/11/17 09:31, Gert Doering wrote:
>
>> On Mon, Nov 13, 2017 at 01:16:46PM +0100, David Sommerseth wrote:
>>
>>> But we should consider if we want to make use of a JSON library
>>> producing the JSON streams.  The reason is to ensure the output is
>>> according to the specification and that escaping if contents is
>>> consistent and proper.  Imagine if someone puts a double-quote into the
>>> CN field of a certificate?
>>>
>>>   CN="} Lets explode things, O=Hacktivist0
>>>
>>> Or other characters which needs escaping.
>>>
>> I'm not convinced we want to import a new library dependency and a heap
>> of #ifdef for this.
>>
>> Escaping on *output* is pretty trivial ("characters from <this set>
>> need to be encoded <like this>") - and as long as we do not need to parse
>> *incoming* JSON, a full-blown new library is mainly adding complications
>> (like, configure flags, #ifdefs, library version dependencies, ...).
>>
>> But you knew that this response would be coming :-)
>>
>>
>> +1



Piling on... with another +1 :)

I would even say that if an external library is required reconsider whether
we really
need JSON output.

Selva

--001a11472b5677c3c9055e06e466
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Nov 14, 2017 at 7:17 AM, Jan Just Keijser <span dir=3D"ltr">&lt;<a =
href=3D"mailto:janjust@...1147..." target=3D"_blank">janjust@...1147...</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 14=
/11/17 09:31, Gert Doering wrote:<br>
</span><span class=3D""><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
On Mon, Nov 13, 2017 at 01:16:46PM +0100, David Sommerseth wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
But we should consider if we want to make use of a JSON library<br>
producing the JSON streams.=C2=A0 The reason is to ensure the output is<br>
according to the specification and that escaping if contents is<br>
consistent and proper.=C2=A0 Imagine if someone puts a double-quote into th=
e<br>
CN field of a certificate?<br>
<br>
=C2=A0 CN=3D&quot;} Lets explode things, O=3DHacktivist0<br>
<br>
Or other characters which needs escaping.<br>
</blockquote>
I&#39;m not convinced we want to import a new library dependency and a heap=
<br>
of #ifdef for this.<br>
<br>
Escaping on *output* is pretty trivial (&quot;characters from &lt;this set&=
gt;<br>
need to be encoded &lt;like this&gt;&quot;) - and as long as we do not need=
 to parse<br>
*incoming* JSON, a full-blown new library is mainly adding complications<br>
(like, configure flags, #ifdefs, library version dependencies, ...).<br>
<br>
But you knew that this response would be coming :-)<br>
<br>
<br>
</blockquote></span>
+1</blockquote><div><br></div><div><br></div><div>Piling on... with another=
 +1 :)</div><div><br></div><div>I would even say that if an external librar=
y is required reconsider whether we really</div><div>need JSON output.</div=
><div><br></div><div>Selva</div></div></div></div>

--001a11472b5677c3c9055e06e466--

