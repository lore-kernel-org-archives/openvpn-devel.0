MIME-Version: 1.0
In-Reply-To: <CAKuzo_jsRqZq7z=qq=+ea=kZFvq+OhCQqw0iL9-8cQ5DVBOiew@...278...>
References: <1467430368-25437-1-git-send-email-selva.nair@...277...>
	<1467502488-31549-1-git-send-email-selva.nair@...277...>
	<11772d2a-4877-0ed0-2484-7ef66e059737@...1227...>
	<CAKuzo_jjiW9hyVc_+Wo=2aBtAgUmmyOTuLmqCbsq7yq7PCdmGQ@...278...>
	<f94abd87-0113-19c7-12de-745ed1de8e42@...1227...>
	<CAKuzo_iJKTBzc1RSQAhA0qGA8GkJfMkjhdKhcB0SJ0QKbobKqg@...278...>
	<ec1d4830-2f67-55c5-9c43-c9e92a9fdef5@...1227...>
	<CAKuzo_jsRqZq7z=qq=+ea=kZFvq+OhCQqw0iL9-8cQ5DVBOiew@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 4 Jul 2016 22:01:05 -0400
Message-ID: <CAKuzo_gy-8umucBPYAFnLJS7A9rDHCrt3OfzyXjSAUBsdgMwww@...278...>
Content-Type: multipart/alternative; boundary=001a1149e9268a20c60536d9d486
Subject: Re: [Openvpn-devel] [PATCH v2] Exponentially back off on repeated
 connect retries
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a1149e9268a20c60536d9d486
Content-Type: text/plain; charset=UTF-8

Hi,

On Mon, Jul 4, 2016 at 5:40 PM, Selva Nair <selva.nair@...277...> wrote:

>
> On Mon, Jul 4, 2016 at 5:01 PM, Arne Schwabe <arne@...1227...> wrote:
>
>> > Or do you have tcp-client in mind? In case of tcp-client, before this
>> > patch, "--connect-retry 0" will hammer the server with repeated
>> > retries.  That will be avoided as max sec defaults to 300 sec, unless
>> > the user specifies "--connect-retry 0 0".  Shall we require that the
>> > second arg to connect-retry should be greater than some minimum, say, at
>> > least 10 sec?
>>
>> No, the TCP-SERVER line there is for p2p mode but with tcp-server. In
>> p2p mode with p2p the code will also execute that socket-restart code
>> after the other side will disconnect.
>
>
> In the p2p case the tcp server will just do a SIGUSR1 restart and wait for
> the client, isn't it -- at least that's what my tests showed on Linux.
> With "--connect-retry 0",  the pause time for tcp-server before restart
> will be "1, 1, 1, 1, 1, 2, 4, 8 .." seconds until it reaches the max value.
> If I move the "if for TCP_SERVER" to below the exponential backoff, the
> server restart pause interval will stay fixed at 1 sec with no backoff. Is
> that what is preferred? Or am I missing something?
>

Please ignore that. I think I finally got the DOS attack on p2p tcp-server
you alluded to. Will move TCP_SERVER case to after the backoff logic in
version 3.

Selva

--001a1149e9268a20c60536d9d486
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div><div class=3D"gmail_extra"><br><div class=3D"g=
mail_quote">On Mon, Jul 4, 2016 at 5:40 PM, Selva Nair <span dir=3D"ltr">&l=
t;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...1665...=
77...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=
=3D""></span><br><span class=3D""></span><div dir=3D"ltr"><div class=3D"gma=
il_extra"><span class=3D""><div class=3D"gmail_quote">On Mon, Jul 4, 2016 a=
t 5:01 PM, Arne Schwabe <span dir=3D"ltr">&lt;<a href=3D"mailto:arne@...2068...=
7..." target=3D"_blank">arne@...1227...</a>&gt;</span> wrote:<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex"><span>&gt; Or do you have tcp-client in mind? In case =
of tcp-client, before this<br>
&gt; patch, &quot;--connect-retry 0&quot; will hammer the server with repea=
ted<br>
&gt; retries.=C2=A0 That will be avoided as max sec defaults to 300 sec, un=
less<br>
&gt; the user specifies &quot;--connect-retry 0 0&quot;.=C2=A0 Shall we req=
uire that the<br>
&gt; second arg to connect-retry should be greater than some minimum, say, =
at<br>
&gt; least 10 sec?<br>
<br>
</span>No, the TCP-SERVER line there is for p2p mode but with tcp-server. I=
n<br>
p2p mode with p2p the code will also execute that socket-restart code<br>
after the other side will disconnect.</blockquote></div><br></span>In the p=
2p case the tcp server will just do a SIGUSR1 restart and wait for the clie=
nt, isn&#39;t it -- at least that&#39;s what my tests showed on Linux.=C2=
=A0 With &quot;--connect-retry 0&quot;, =C2=A0the pause time for tcp-server=
 before restart will be &quot;1, 1, 1, 1, 1, 2, 4, 8 ..&quot; seconds until=
 it reaches the max value. If I move the &quot;if for TCP_SERVER&quot; to b=
elow the exponential backoff, the server restart pause interval will stay f=
ixed at 1 sec with no backoff. Is that what is preferred? Or am I missing s=
omething?</div></div></blockquote><div>=C2=A0</div></div></div><div class=
=3D"gmail_extra">Please ignore that. I think I finally got the DOS attack o=
n p2p tcp-server you alluded to. Will move TCP_SERVER case to after the bac=
koff logic in version 3.<br><br></div><div class=3D"gmail_extra">Selva<br><=
/div></div></div>

--001a1149e9268a20c60536d9d486--

