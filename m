MIME-Version: 1.0
References: <CAAYFXLmLN3mJ1hqJrhhhqBeXwWaFHOMCMUx91BujJpnm0KM-Kg@...278...>
 <YlFBo/UOAxeNlBPf@...1296...>
In-Reply-To: <YlFBo/UOAxeNlBPf@...1296...>
From: Pete Nelson <petiepooo@...277...>
Date: Sat, 9 Apr 2022 13:37:02 +0000
Message-ID: <CAAYFXL=AiKBkn86y-e7tQZyDvcD9WyM614MAWa7ML_a505w_cg@...278...>
Content-Type: multipart/alternative; boundary="0000000000000faf4005dc38cf2c"
Subject: Re: [Openvpn-devel] Tips for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000000faf4005dc38cf2c
Content-Type: text/plain; charset="UTF-8"

Hi.

On Sat, Apr 9, 2022 at 8:19 AM Gert Doering <gert@...1296...> wrote:

> The openvpn tree itself brings a test script, "t_client.sh", which runs
> a number of OpenVPN instances, verifies that they come up, interface IPs
> are "as expected", and then runs pings to see if the tunnel works.  There
> are no pre-defined tests, as you need a server side to run the test against
> (but see tests/t_client.rc-sample).  If a t_client.rc file exists, this
> is run as part of "make check".
>

I didn't expect there to be a "run this script to test all scenarios" even
though I was secretly hoping for that.  I'll look into the t_client.sh
script; that's at least a start.

It sounds like a framework that runs some basic client and server tests,
say based on docker, may be a welcome contribution.

Thanks.
--
Pete

--0000000000000faf4005dc38cf2c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi.</div><br></div><div class=3D"gma=
il_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Apr 9, 2022 at 8:19=
 AM Gert Doering &lt;<a href=3D"mailto:gert@...1296...">gert@...1296...</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">The =
openvpn tree itself brings a test script, &quot;t_client.sh&quot;, which ru=
ns<br>
a number of OpenVPN instances, verifies that they come up, interface IPs<br>
are &quot;as expected&quot;, and then runs pings to see if the tunnel works=
.=C2=A0 There<br>
are no pre-defined tests, as you need a server side to run the test against=
<br>
(but see tests/t_client.rc-sample).=C2=A0 If a t_client.rc file exists, thi=
s<br>
is run as part of &quot;make check&quot;.<br></blockquote><div><div dir=3D"=
ltr"><div><br></div><div>I didn&#39;t expect=20
there to be a &quot;run this script to test all scenarios&quot; even though=
 I was=20
secretly hoping for that.=C2=A0 I&#39;ll look into the
t_client.sh script; that&#39;s at least a start.</div><div><br></div><div>I=
t sounds like a framework that runs some basic client and server tests, say=
 based on docker, may be a welcome contribution.<br></div><div><br></div><d=
iv>Thanks.</div><div>--</div><div>Pete<br></div></div></div></div></div>

--0000000000000faf4005dc38cf2c--

