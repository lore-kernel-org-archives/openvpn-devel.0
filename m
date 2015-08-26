MIME-Version: 1.0
Date: Wed, 26 Aug 2015 16:29:53 -0700
Message-ID: <CAAF3xa_HR=0DVaSQ_vuJ7PT9YohfL82BoMY0=WA+of5Lmn9nxg@...278...>
From: Marvin <volleynbike@...277...>
Content-Type: multipart/alternative; boundary=001a113ec7104f411b051e3f3a6b
Subject: Re: [Openvpn-devel] [PATCH] Added two features to Network Address
	Translator
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--001a113ec7104f411b051e3f3a6b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Author:  Rafael Gava de Oliveira <Rafael.Oliveira@...2056...>

I wanted to give an ACK to both of Gava=E2=80=99s patches 1) client-nat
localhost/client-ip patch and 2) active ftp patch.

We had asked Gava to develop these patches so that we could use OpenVPN in
our remote service network.  We currently have OpenVPN 2.3.5 with this
patch applied in deployed to about 3000 devices both in the US and EU.
Some of the devices we have to connect to are over 15 years old and active
ftp is unavoidable, so his active ftp patch is a must.  Additionally,
without his client-nat localhost/client-ip patch using OpenVPN would be
prohibitively complex.

We have been running 3000 devices since Feb 2015 with no issues.  Please
also consider this a pre-testing report.

Marvin

Signed-off-by: Rafael Gava de Oliveira <Rafael.Oliveira@...2056...>
Acked by:  Marvin Adeff <Marvin.Adeff@...2060...>

>Hi JJK,
>
>"client-ip" instead of "localhost" sounds good to me.
>
>BR
>
>Gava
>
>On Wed, Aug 26, 2015 at 10:01 AM, Jan Just Keijser <janjust@...493...>
>wrote:
>
>> Hi,
>>
>> Rafael Gava wrote:
>>
>>>
>>> this is my first submission to the list and I hope that I'm doing in the
>>> right way. :-)
>>>
>>>
>>> Well, the features added to Network Address Translator are:
>>>
>>> 1) Allow the user to use the string "localhost" on the client-nat
network
>>> configuration in a way that is not necessary to inform the IP address
>>> beforehand. Openvpn will set the dynamic received IP from DHCP. Example:
>>>
>>> client-nat snat localhost 255.255.255.255 172.20.1.15 # replaces the
>>> 'localhost' string with the DHCP address received from openvpn server.
>>>
>>> I understand the idea behind it but it would be a NACK from me on the
>> string "localhost" - to me, localhost is 127.0.0.1 or ::1, not the
DHCP-IP
>> ; perhaps use something like "client-ip"   ?
>>
>>
>> 2) Allow the user to enable the FTP NAT support through the
>>> --enable-nat-ftp-support option. This is useful for systems that don't
have
>>> conntrack-tools support, for example on Windows systems. On windows this
>>> feature is enabled by default.
>>>
>>> enable-nat-ftp-support (yes | no)
>>>
>>> sounds like a useful feature to me.
>>
>>
>> JJK

--001a113ec7104f411b051e3f3a6b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Author: =C2=A0Rafael Gava de Oliveira &lt;<a href=3D"=
mailto:Rafael.Oliveira@...2056...">Rafael.Oliveira@...2056...</a>&gt;</div>=
<div><br></div><div>I wanted to give an ACK to both of Gava=E2=80=99s patch=
es 1) client-nat localhost/client-ip patch and 2) active ftp patch.</div><d=
iv><br></div><div>We had asked Gava to develop these patches so that we cou=
ld use OpenVPN in our remote service network.=C2=A0 We currently have OpenV=
PN 2.3.5 with this patch applied in deployed to about 3000 devices both in =
the US and EU.=C2=A0 Some of the devices we have to connect to are over 15 =
years old and active ftp is unavoidable, so his active ftp patch is a must.=
=C2=A0 Additionally, without his client-nat localhost/client-ip patch using=
 OpenVPN would be prohibitively complex.</div><div><br></div><div>We have b=
een running 3000 devices since Feb 2015 with no issues.=C2=A0 Please also c=
onsider this a pre-testing report.</div><div><br></div><div>Marvin</div><di=
v><br></div><div>Signed-off-by: Rafael Gava de Oliveira &lt;<a href=3D"mail=
to:Rafael.Oliveira@...2056...">Rafael.Oliveira@...2056...</a>&gt;</div><div=
>Acked by: =C2=A0Marvin Adeff &lt;<a href=3D"mailto:Marvin.Adeff@...2060...=
">Marvin.Adeff@...2060...</a>&gt;</div><div><br></div><div>&gt;Hi JJK,</div=
><div>&gt;</div><div>&gt;&quot;client-ip&quot; instead of &quot;localhost&q=
uot; sounds good to me.</div><div>&gt;</div><div>&gt;BR</div><div>&gt;</div=
><div>&gt;Gava</div><div>&gt;</div><div>&gt;On Wed, Aug 26, 2015 at 10:01 A=
M, Jan Just Keijser &lt;janjust@...493...&gt;</div><div>&gt;wrote:</div><di=
v>&gt;</div><div>&gt;&gt; Hi,</div><div>&gt;&gt;</div><div>&gt;&gt; Rafael =
Gava wrote:</div><div>&gt;&gt;</div><div>&gt;&gt;&gt;</div><div>&gt;&gt;&gt=
; this is my first submission to the list and I hope that I&#39;m doing in =
the</div><div>&gt;&gt;&gt; right way. :-)</div><div>&gt;&gt;&gt;</div><div>=
&gt;&gt;&gt;</div><div>&gt;&gt;&gt; Well, the features added to Network Add=
ress Translator are:</div><div>&gt;&gt;&gt;</div><div>&gt;&gt;&gt; 1) Allow=
 the user to use the string &quot;localhost&quot; on the client-nat network=
</div><div>&gt;&gt;&gt; configuration in a way that is not necessary to inf=
orm the IP address</div><div>&gt;&gt;&gt; beforehand. Openvpn will set the =
dynamic received IP from DHCP. Example:</div><div>&gt;&gt;&gt;</div><div>&g=
t;&gt;&gt; client-nat snat localhost 255.255.255.255 172.20.1.15 # replaces=
 the</div><div>&gt;&gt;&gt; &#39;localhost&#39; string with the DHCP addres=
s received from openvpn server.</div><div>&gt;&gt;&gt;</div><div>&gt;&gt;&g=
t; I understand the idea behind it but it would be a NACK from me on the</d=
iv><div>&gt;&gt; string &quot;localhost&quot; - to me, localhost is 127.0.0=
.1 or ::1, not the DHCP-IP</div><div>&gt;&gt; ; perhaps use something like =
&quot;client-ip&quot; =C2=A0 ?</div><div>&gt;&gt;</div><div>&gt;&gt;</div><=
div>&gt;&gt; 2) Allow the user to enable the FTP NAT support through the</d=
iv><div>&gt;&gt;&gt; --enable-nat-ftp-support option. This is useful for sy=
stems that don&#39;t have</div><div>&gt;&gt;&gt; conntrack-tools support, f=
or example on Windows systems. On windows this</div><div>&gt;&gt;&gt; featu=
re is enabled by default.</div><div>&gt;&gt;&gt;</div><div>&gt;&gt;&gt; ena=
ble-nat-ftp-support (yes | no)</div><div>&gt;&gt;&gt;</div><div>&gt;&gt;&gt=
; sounds like a useful feature to me.</div><div>&gt;&gt;</div><div>&gt;&gt;=
</div><div>&gt;&gt; JJK</div><div><br></div></div>

--001a113ec7104f411b051e3f3a6b--

