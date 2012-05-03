MIME-Version: 1.0
In-Reply-To: <CAAhp1KAyH3MkeAn7YS_E1474mUbjzTMeqztFNmc-RKD6JZgTyw@...278...>
References: <CAAhp1KAp8DDJvgE9CTDST8HEGO4HTiMDmv88sTMpNxtWptyX+g@...278...>
	<CAOazyz35GLCBFFBfZe8KfXZerozZt3ULYD03mFtbhkS6ruxWDg@...278...>
	<CAAhp1KAyH3MkeAn7YS_E1474mUbjzTMeqztFNmc-RKD6JZgTyw@...278...>
Date: Thu, 3 May 2012 12:14:28 +0530
Message-ID: <CAAhp1KCJBqZfjKTRC28wk6g5Bkj=-8cP_oe--cY+cJ82-paNsw@...278...>
From: Gauri Bhave <gaurib123@...277...>
Content-Type: multipart/alternative; boundary=14dae9c09bc2af2b3604bf1c22b8
Subject: Re: [Openvpn-devel] Does OpenVPN Support Unicode Username and
	Password
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>, openvpn-devel@lists.sourceforge.net

--14dae9c09bc2af2b3604bf1c22b8
Content-Type: text/plain; charset=ISO-8859-1

Hi,

Can you tell me which version of openvpn started supporting utf8. I am
using openvpn-2.1_rc15 but all my utf8 characters get converted to '_'
(underscores), when i see the log on the server side and AD gives me an
error authentication failed.

Please help me
Thanks
Gauri Bhave

On Wed, May 2, 2012 at 3:15 PM, Gauri Bhave <gaurib123@...277...> wrote:

> Hi,
>
> Thanks for your prompt reply. I am currently using version
> openvpn-2.1_rc15. But it changes all the non printable characters in the
> hindi username to '_'. I am sending it a  UTF8 username.
>
> Thanks
> Gauri Bhave
>
>
>
> On Wed, May 2, 2012 at 2:45 PM, Alon Bar-Lev <alon.barlev@...277...>wrote:
>
>> Hello,
>>
>> OpenVPN is basically UTF-8 enabled.
>> There was a recent patch to fix some issue with the management
>> interface in this regard.
>> Most probably you will need to convert UCS-2 to UTF-8 when sending the
>> user/password into openvpn.
>> So you can try out the master branch and see if it works for you.
>>
>> Alon.
>>
>> On Wed, May 2, 2012 at 12:10 PM, Gauri Bhave <gaurib123@...277...> wrote:
>> > Hi,
>> >
>> > I am customizing the openvpn GUI to support multiple languages. I want
>> to
>> > connect using a non ASCII username, Say a chinese or hindi user name.
>> Is it
>> > possible in Open VPN.
>> >
>> > Thanks
>> > Gauri Bhave
>> >
>> >
>> ------------------------------------------------------------------------------
>> > Live Security Virtual Conference
>> > Exclusive live event will cover all the ways today's security and
>> > threat landscape has changed and how IT managers can respond.
>> Discussions
>> > will include endpoint security, mobile security and the latest in
>> malware
>> > threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
>> > _______________________________________________
>> > Openvpn-devel mailing list
>> > Openvpn-devel@lists.sourceforge.net
>> > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>> >
>>
>
>

--14dae9c09bc2af2b3604bf1c22b8
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>Can you tell me which version of openvpn started supporting utf8=
. I am using openvpn-2.1_rc15 but all my utf8 characters get converted to &=
#39;_&#39; (underscores), when i see the log on the server side and AD give=
s me an error authentication failed.<br>
<br>Please help me<br>Thanks<br>Gauri Bhave<br><br><div class=3D"gmail_quot=
e">On Wed, May 2, 2012 at 3:15 PM, Gauri Bhave <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:gaurib123@...277..." target=3D"_blank">gaurib123@...277...</a>&=
gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi,<br>
<br>
Thanks for your prompt reply. I am currently using version openvpn-2.1_rc15=
.=20
But it changes all the non printable characters in the hindi username to
 &#39;_&#39;. I am sending it a=A0 UTF8 username.<br>
<br>
Thanks<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Gauri Bhave</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br><br><b=
r><div class=3D"gmail_quote">On Wed, May 2, 2012 at 2:45 PM, Alon Bar-Lev <=
span dir=3D"ltr">&lt;<a href=3D"mailto:alon.barlev@...277..." target=3D"_bl=
ank">alon.barlev@...277...</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Hello,<br>
<br>
OpenVPN is basically UTF-8 enabled.<br>
There was a recent patch to fix some issue with the management<br>
interface in this regard.<br>
Most probably you will need to convert UCS-2 to UTF-8 when sending the<br>
user/password into openvpn.<br>
So you can try out the master branch and see if it works for you.<br>
<br>
Alon.<br>
<div><div><br>
On Wed, May 2, 2012 at 12:10 PM, Gauri Bhave &lt;<a href=3D"mailto:gaurib12=
3@...277..." target=3D"_blank">gaurib123@...277...</a>&gt; wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; I am customizing the openvpn GUI to support multiple languages. I want=
 to<br>
&gt; connect using a non ASCII username, Say a chinese or hindi user name. =
Is it<br>
&gt; possible in Open VPN.<br>
&gt;<br>
&gt; Thanks<br>
&gt; Gauri Bhave<br>
&gt;<br>
</div></div>&gt; ----------------------------------------------------------=
--------------------<br>
&gt; Live Security Virtual Conference<br>
&gt; Exclusive live event will cover all the ways today&#39;s security and<=
br>
&gt; threat landscape has changed and how IT managers can respond. Discussi=
ons<br>
&gt; will include endpoint security, mobile security and the latest in malw=
are<br>
&gt; threats. <a href=3D"http://www.accelacomm.com/jaw/sfrnl04242012/114/50=
122263/" target=3D"_blank">http://www.accelacomm.com/jaw/sfrnl04242012/114/=
50122263/</a><br>
&gt; _______________________________________________<br>
&gt; Openvpn-devel mailing list<br>
&gt; <a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blan=
k">Openvpn-devel@lists.sourceforge.net</a><br>
&gt; <a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel"=
 target=3D"_blank">https://lists.sourceforge.net/lists/listinfo/openvpn-dev=
el</a><br>
&gt;<br>
</blockquote></div><br>
</div></div></blockquote></div><br>

--14dae9c09bc2af2b3604bf1c22b8--

