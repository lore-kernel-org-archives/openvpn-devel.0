MIME-Version: 1.0
In-Reply-To: <CAKuzo_iMXUVZJz0U3OKLi3VvC4vv2S_5+8uTdn5o=21mA8tODA@...278...>
References: <OpenVPN/openvpn-gui/issues/168@...1714...>
	<OpenVPN/openvpn-gui/issues/168/305250704@...1714...>
	<CAKuzo_iMXUVZJz0U3OKLi3VvC4vv2S_5+8uTdn5o=21mA8tODA@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 26 Jun 2017 18:57:13 +0500
Message-ID: <CAFHpkQHWem3ozYj_X1RF-9ttz6UfOGV6oXdKM0bAKbU6vkYvnQ@...278...>
Content-Type: multipart/alternative; boundary="001a11441ffc00b01a0552dd5499"
Subject: Re: [Openvpn-devel] [OpenVPN/openvpn-gui] better handling of
 interactive service failure (#168)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11441ffc00b01a0552dd5499
Content-Type: text/plain; charset="UTF-8"

2017-05-31 22:54 GMT+05:00 Selva Nair <selva.nair@...277...>:

> Hi,
>
> Copying openvpn-devel:
> As this is related to openvpn best to have this discussion in the devel
> list, I suppose.
> (see also: https://github.com/OpenVPN/openvpn-gui/issues/
> 168#issuecomment-305250704)
>
> On Wed, May 31, 2017 at 12:58 PM, Gert Doering <notifications@...1714...>
> wrote:
>
>> On Wed, May 31, 2017 at 09:43:21AM -0700, Selva Nair wrote:
>> > As I said, get openvpn to report route errors in the status and then we
>> can
>> > add a warning to the status popup, turn the icon red etc instead of the
>> > current misleading "successfully connected" behaviour.
>>
>> This is actually a discussion I was trying to have a long time ago
>> (a few years) - "why do we ignore route addition errors?".
>>
>> The IPv6 code doesn't (because I think that errors are errors, not
>> warnings...) and that was always some sort of weird asymmetry...
>>
>> I still don't know the reasoning here, but I suspect it's something along
>> "you push a route that is identical to the local subnet" (192.168.1.0/24,
>> for example, because the user happens to be in a bad NAT network) and
>> "all of a sudden it fails"... so this might need more discussion, and
>> also some code cleanups to gracefully handle situations where an error
>> is "tolerated".
>>
>
> That and some route addition errors like "route already exists" are often
> benign. So a fatal error is not appropriate. But, IIRC,
>  openvpn_execve_check only allows printing of errors as FATAL or WARN.
> Currently we do not parse the log message flags (error vs warning etc.) in
> the Windows GUI, but that could be improved if openvpn can log route errors
> like access denied as such.
>
> In any case, the status reported to the management when connected with
> errors should be something other than "CONNECTED,SUCCESS" -- say
> "CONNECTED,ROUTE-FAILED" etc. so that  UI can intimate the user.
>
> Selva
>

I want to bring it to attention again.
actually, there're couple of things

a) should "ipv4 route manipulation failure" be fatal
b) how to signal (and handle) those failures within openvpn-gui




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

--001a11441ffc00b01a0552dd5499
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-05-31 22:54 GMT+05:00 Selva Nair <span dir=3D"ltr">&lt;<a href=3D"=
mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;=
</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div class=3D"g=
mail_extra">Hi,<br></div><div class=3D"gmail_extra"><br></div><div class=3D=
"gmail_extra">Copying openvpn-devel:</div><div class=3D"gmail_extra">As thi=
s is related to openvpn best to have this discussion in the devel list, I s=
uppose.=C2=A0<br><div class=3D"gmail_quote">(see also:=C2=A0<a href=3D"http=
s://github.com/OpenVPN/openvpn-gui/issues/168#issuecomment-305250704" targe=
t=3D"_blank">https://github.com/<wbr>OpenVPN/openvpn-gui/issues/<wbr>168#is=
suecomment-305250704</a>)</div><span class=3D""><div class=3D"gmail_quote">=
<br></div><div class=3D"gmail_quote">On Wed, May 31, 2017 at 12:58 PM, Gert=
 Doering <span dir=3D"ltr">&lt;<a href=3D"mailto:notifications@...1714..." =
target=3D"_blank">notifications@...1714...</a>&gt;</span> wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-wi=
dth:1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-=
left:1ex"><div id=3D"m_-2263706883911241230gmail-m_-6518952545098238565m_85=
20566217958298647:2n" class=3D"m_-2263706883911241230gmail-m_-6518952545098=
238565m_8520566217958298647a3s m_-2263706883911241230gmail-m_-6518952545098=
238565m_8520566217958298647aXjCH m_-2263706883911241230gmail-m_-65189525450=
98238565m_8520566217958298647m15c5f719c883a87f">On Wed, May 31, 2017 at 09:=
43:21AM -0700, Selva Nair wrote:<br>
&gt; As I said, get openvpn to report route errors in the status and then w=
e can<br>
&gt; add a warning to the status popup, turn the icon red etc instead of th=
e<br>
&gt; current misleading &quot;successfully connected&quot; behaviour.<br>
<br>
This is actually a discussion I was trying to have a long time ago<br>
(a few years) - &quot;why do we ignore route addition errors?&quot;.  <br>
<br>
The IPv6 code doesn&#39;t (because I think that errors are errors, not <br>
warnings...) and that was always some sort of weird asymmetry...<br>
<br>
I still don&#39;t know the reasoning here, but I suspect it&#39;s something=
 along<br>
&quot;you push a route that is identical to the local subnet&quot; (<a href=
=3D"http://192.168.1.0/24" target=3D"_blank">192.168.1.0/24</a>,<br>
for example, because the user happens to be in a bad NAT network) and <br>
&quot;all of a sudden it fails&quot;...  so this might need more discussion=
, and<br>
also some code cleanups to gracefully handle situations where an error<br>
is &quot;tolerated&quot;.</div></blockquote></div><div class=3D"gmail_extra=
"><br></div></span><div class=3D"gmail_extra">That and some route addition =
errors like &quot;route already exists&quot; are often benign. So a fatal e=
rror is not appropriate. But, IIRC, =C2=A0openvpn_execve_check only allows =
printing of errors as FATAL or WARN. Currently we do not parse the log mess=
age flags (error vs warning etc.) in the Windows GUI, but that could be imp=
roved if openvpn can log route errors like access denied as such.</div><div=
 class=3D"gmail_extra"><br></div>In any case, the status reported to the ma=
nagement when connected with errors should be something other than &quot;CO=
NNECTED,SUCCESS&quot; -- say &quot;CONNECTED,ROUTE-FAILED&quot; etc. so tha=
t =C2=A0UI can intimate the user.</div><span class=3D"HOEnZb"><font color=
=3D"#888888"><div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra=
">Selva</div></font></span></div></blockquote><div><br></div><div>I want to=
 bring it to attention again.<br></div><div>actually, there&#39;re couple o=
f things<br><br></div><div>a) should &quot;ipv4 route manipulation failure&=
quot; be fatal<br></div><div>b) how to signal (and handle) those failures w=
ithin openvpn-gui<br><br></div><div><br>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">
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
<br></blockquote></div><br></div></div>

--001a11441ffc00b01a0552dd5499--

