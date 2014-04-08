References: <mailman.102140.1396970007.2171.openvpn-devel@lists.sourceforge.net>
Message-ID: <1396981531.68582.YahooMailNeo@...1882...>
Date: Tue, 8 Apr 2014 11:25:31 -0700 (PDT)
From: randy bercheni <mom47303@...109...>
In-Reply-To: <mailman.102140.1396970007.2171.openvpn-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="-433406958-1104364303-1396981531=:68582"
Subject: Re: [Openvpn-devel] Openvpn-devel Digest, Vol 95, Issue 3
Reply-To: randy bercheni <mom47303@...109...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

---433406958-1104364303-1396981531=:68582
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I do not know why you sent me this. I do not know you. Please do not e-mail=
 me again.


On Tuesday, April 8, 2014 1:31 PM, "openvpn-devel-request@...282...=
.net" <openvpn-devel-request@lists.sourceforge.net> wrote:
=20
Send Openvpn-devel mailing list submissions to
=A0=A0=A0 openvpn-devel@lists.sourceforge.net

To subscribe or unsubscribe via the World Wide Web, visit
=A0=A0=A0 https://lists.sourceforge.net/lists/listinfo/openvpn-devel
or, via email, send a message with subject or body 'help' to
=A0=A0=A0 openvpn-devel-request@lists.sourceforge.net

You can reach the person managing the list at
=A0=A0=A0 openvpn-devel-owner@lists.sourceforge.net

When replying, please edit your Subject line so it is more specific
than "Re: Contents of Openvpn-devel digest..."


Today's Topics:

=A0  1. Re: Heartbleed (Mike Tancsa)
=A0  2. Re: Heartbleed (Steffan Karger)
=A0  3. Re: Heartbleed (Mike Tancsa)
=A0  4. Re: Heartbleed (Enno Gr?per)
=A0  5. Re: Heartbleed (Samuli Sepp?nen)
=A0  6. Re: Heartbleed (Gert Doering)


----------------------------------------------------------------------

Message: 1
Date: Tue, 08 Apr 2014 10:04:06 -0400
From: Mike Tancsa <mike@...1800...>
Subject: Re: [Openvpn-devel] Heartbleed
To: Steffan Karger <steffan.karger@...1435...>,=A0=A0=A0 Adriaan de Jong
=A0=A0=A0 <dejong@...1435...>, "openvpn-devel@lists.sourceforge.net"
=A0=A0=A0 <openvpn-devel@lists.sourceforge.net>
Message-ID: <534401D6.1080604@...1800...>
Content-Type: text/plain; charset=3DISO-8859-1; format=3Dflowed

On 4/8/2014 9:42 AM, Steffan Karger wrote:

>> Perhaps a dumb question, but if the server instance is linked against
>> an older version of openssl (9.8.x), but the client is compiled and
>> linked against the vulnerable version, is it still an issue for both
>> sides, or is the client going to leak private information ?
>
> The client can then leak keys (both private master key and session keys),=
 which completely breaks your secure connection, for that client.
>
> So when the server is not vulnerable, each client has to be attacked indi=
vidually, and not-vulnerable clients have a secure connection to the server=
. As long as there are vulnerable clients, you should consider those as pot=
entially malicious, and thus you should consider the network as insecure.

Thanks for the replay. I am still trying to understand as it relates to=20
the analysis here

http://blog.existentialize.com/diagnosis-of-the-openssl-heartbleed-bug.html

How does one attack the client ? In my case, the client only connects to=20
my servers ? I use a tls-auth key file as well. If I understand=20
correctly, the scenario would be the attacker would have to have the=20
tls-auth key file, and then do a man in the middle attack to pretend its=20
the server's IP, and then coax the client into allocating the 64k block=20
of memory as described in the above link ?

=A0=A0=A0 ---Mike

--=20
-------------------
Mike Tancsa, tel +1 519 651 3400
Sentex Communications, mike@...1800...
Providing Internet services since 1994 www.sentex.net
Cambridge, Ontario Canada=A0 http://www.tancsa.com/



------------------------------

Message: 2
Date: Tue, 8 Apr 2014 16:13:59 +0200
From: Steffan Karger <steffan.karger@...1435...>
Subject: Re: [Openvpn-devel] Heartbleed
To: Mike Tancsa <mike@...1800...>, Adriaan de Jong
=A0=A0=A0 <dejong@...1435...>,=A0=A0=A0 "openvpn-devel@...475...=
t"
=A0=A0=A0 <openvpn-devel@lists.sourceforge.net>
Message-ID:
=A0=A0=A0 <1CED409804E2164C8104F9E623B08B90170093CEF0@...1436...>
Content-Type: text/plain; charset=3D"us-ascii"

On 08/04/2014 16:04, Mike Tancsa wrote:
> How does one attack the client ? In my case, the client only connects
> to my servers ? I use a tls-auth key file as well. If I understand
> correctly, the scenario would be the attacker would have to have the
> tls-auth key file, and then do a man in the middle attack to pretend
> its the server's IP, and then coax the client into allocating the 64k
> block of memory as described in the above link ?

Correct. But man-in-the-middle can also be something like DNS poisoning.

If you use TLS-auth, the attacker must have previously obtained the TLS-aut=
h key. When the user base is large, it is not unlikely that one of the user=
s was compromised and should be considered malicious.

-Steffan



------------------------------

Message: 3
Date: Tue, 08 Apr 2014 10:23:53 -0400
From: Mike Tancsa <mike@...1800...>
Subject: Re: [Openvpn-devel] Heartbleed
To: Steffan Karger <steffan.karger@...1435...>,=A0=A0=A0 Adriaan de Jong
=A0=A0=A0 <dejong@...1435...>, "openvpn-devel@lists.sourceforge.net"
=A0=A0=A0 <openvpn-devel@lists.sourceforge.net>
Message-ID: <53440679.8060800@...1800...>
Content-Type: text/plain; charset=3DISO-8859-1; format=3Dflowed

On 4/8/2014 10:13 AM, Steffan Karger wrote:
> On 08/04/2014 16:04, Mike Tancsa wrote:
>> How does one attack the client ? In my case, the client only connects
>> to my servers ? I use a tls-auth key file as well. If I understand
>> correctly, the scenario would be the attacker would have to have the
>> tls-auth key file, and then do a man in the middle attack to pretend
>> its the server's IP, and then coax the client into allocating the 64k
>> block of memory as described in the above link ?
>
> Correct. But man-in-the-middle can also be something like DNS poisoning.

> If you use TLS-auth, the attacker must have previously obtained the TLS-a=
uth key. When the user base is large, it is not unlikely that one of the us=
ers was compromised and should be considered malicious.

Thanks!=A0 Although we are certainly planing to update the vulnerable=20
clients, this is not quite as dire and urgent as first described in the=20
popular press-- at least as it applies to my client base. We also use IP=20
addresses for the target servers in the client configs.

=A0=A0=A0 ---Mike

--=20
-------------------
Mike Tancsa, tel +1 519 651 3400
Sentex Communications, mike@...1800...
Providing Internet services since 1994 www.sentex.net
Cambridge, Ontario Canada=A0 http://www.tancsa.com/



------------------------------

Message: 4
Date: Tue, 08 Apr 2014 15:53:05 +0200
From: Enno Gr?per <groepeen@...1879...>
Subject: Re: [Openvpn-devel] Heartbleed
To: openvpn-devel@lists.sourceforge.net
Message-ID: <5343FF41.3080406@...1879...>
Content-Type: text/plain; charset=3D"iso-8859-1"

Hi,

Am 08.04.2014 15:42, schrieb Steffan Karger:
>> Perhaps a dumb question, but if the server instance is linked
>> against an older version of openssl (9.8.x), but the client is
>> compiled and linked against the vulnerable version, is it still an
>> issue for both sides, or is the client going to leak private
>> information ?
>
> The client can then leak keys (both private master key and session
> keys), which completely breaks your secure connection, for that
> client.
>
> So when the server is not vulnerable, each client has to be attacked
> individually, and not-vulnerable clients have a secure connection to
> the server. As long as there are vulnerable clients, you should
> consider those as potentially malicious, and thus you should consider
> the network as insecure.
Then OpenVPN should release new Windows Versions.
The current binaries are linked against OpenSSL (ssleay32.dll,=20
libeay32.dll) 1.0.1.5 (-> 1.0.1e).

Greetings,
Enno

--=20
Enno Gr?per
groepeen@...1879... - Raum 2'325, Rudower Chaussee 26
Tel. +49.(0)30.2093.70053=A0 Fax +49.(0)30.2093.2959
Humboldt-Universit?t zu Berlin - http://www.hu-berlin.de/
ZE Computer- und Medienservice - http://www.cms.hu-berlin.de/
Unter den Linden 6, D-10099 Berlin, Germany

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 4781 bytes
Desc: S/MIME Cryptographic Signature

------------------------------

Message: 5
Date: Tue, 08 Apr 2014 18:09:17 +0300
From: Samuli Sepp?nen <samuli@...515...>
Subject: Re: [Openvpn-devel] Heartbleed
To: Enno Gr?per <groepeen@...1879...>,
=A0=A0=A0 "openvpn-devel@lists.sourceforge.net"
=A0=A0=A0 <openvpn-devel@lists.sourceforge.net>
Message-ID: <5344111D.3080408@...515...>
Content-Type: text/plain; charset=3DISO-8859-1


> Hi,
>
> Am 08.04.2014 15:42, schrieb Steffan Karger:
>>> Perhaps a dumb question, but if the server instance is linked
>>> against an older version of openssl (9.8.x), but the client is
>>> compiled and linked against the vulnerable version, is it still an
>>> issue for both sides, or is the client going to leak private
>>> information ?
>> The client can then leak keys (both private master key and session
>> keys), which completely breaks your secure connection, for that
>> client.
>>
>> So when the server is not vulnerable, each client has to be attacked
>> individually, and not-vulnerable clients have a secure connection to
>> the server. As long as there are vulnerable clients, you should
>> consider those as potentially malicious, and thus you should consider
>> the network as insecure.
> Then OpenVPN should release new Windows Versions.
> The current binaries are linked against OpenSSL (ssleay32.dll,=20
> libeay32.dll) 1.0.1.5 (-> 1.0.1e).
>
>
Hi all,

We'll try to push OpenVPN 2.3.3 out today. The Windows installer will
contain OpenSSL 1.0.1g which fixes this particular problem. In addition
several other small changes and enhancements will be included.

--=20
Samuli Sepp?nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock




------------------------------

Message: 6
Date: Tue, 8 Apr 2014 17:13:15 +0200
From: Gert Doering <gert@...1296...>
Subject: Re: [Openvpn-devel] Heartbleed
To: Enno Gr?per <groepeen@...1879...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <20140408151315.GD16637@...1296...>
Content-Type: text/plain; charset=3D"iso-8859-1"

Hi,

On Tue, Apr 08, 2014 at 03:53:05PM +0200, Enno Gr?per wrote:
> Then OpenVPN should release new Windows Versions.

Yeah, always glad to have people tell us what to do.

Working on it...

gert
--=20
USENET is *not* the non-clickable part of WWW!
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0  //www.muc.de/~gert/
Gert Doering - Munich, Germany=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 gert@...1296...
fax: +49-89-35655025=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gert@...1186...=
.1297...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 305 bytes
Desc: not available

------------------------------

---------------------------------------------------------------------------=
---
Put Bad Developers to Shame
Dominate Development with Jenkins Continuous Integration
Continuously Automate Build, Test & Deployment=20
Start a new project now. Try Jenkins in the cloud.
http://p.sf.net/sfu/13600_Cloudbees

------------------------------

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel


End of Openvpn-devel Digest, Vol 95, Issue 3
********************************************=

---433406958-1104364303-1396981531=:68582
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:He=
lveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif;fo=
nt-size:12pt">I do not know why you sent me this. I do not know you. Please=
 do not e-mail me again.<br><div><span><br></span></div><div style=3D"displ=
ay: block;" class=3D"yahoo_quoted"> <div style=3D"font-family: HelveticaNeu=
e, Helvetica Neue, Helvetica, Arial, Lucida Grande, sans-serif; font-size: =
12pt;"> <div style=3D"font-family: HelveticaNeue, Helvetica Neue, Helvetica=
, Arial, Lucida Grande, sans-serif; font-size: 12pt;"> <div dir=3D"ltr"> <f=
ont face=3D"Arial" size=3D"2"> On Tuesday, April 8, 2014 1:31 PM, "openvpn-=
devel-request@lists.sourceforge.net" &lt;openvpn-devel-request@...1659...=
forge.net&gt; wrote:<br> </font> </div>  <div class=3D"y_msg_container">Sen=
d Openvpn-devel mailing list submissions to<br>&nbsp;&nbsp;&nbsp; <a ymailt=
o=3D"mailto:openvpn-devel@lists.sourceforge.net"
 href=3D"mailto:openvpn-devel@lists.sourceforge.net">openvpn-devel@...1466...=
urceforge.net</a><br><br>To subscribe or unsubscribe via the World Wide Web=
, visit<br>&nbsp;&nbsp;&nbsp; <a href=3D"https://lists.sourceforge.net/list=
s/listinfo/openvpn-devel" target=3D"_blank">https://lists.sourceforge.net/l=
ists/listinfo/openvpn-devel</a><br>or, via email, send a message with subje=
ct or body 'help' to<br>&nbsp;&nbsp;&nbsp; <a ymailto=3D"mailto:openvpn-dev=
el-request@lists.sourceforge.net" href=3D"mailto:openvpn-devel-request@...1514...=
s.sourceforge.net">openvpn-devel-request@lists.sourceforge.net</a><br><br>Y=
ou can reach the person managing the list at<br>&nbsp;&nbsp;&nbsp; <a ymail=
to=3D"mailto:openvpn-devel-owner@lists.sourceforge.net" href=3D"mailto:open=
vpn-devel-owner@lists.sourceforge.net">openvpn-devel-owner@...1483...=
e.net</a><br><br>When replying, please edit your Subject line so it is more=
 specific<br>than "Re: Contents of Openvpn-devel digest..."<br><br><br>Toda=
y's
 Topics:<br><br>&nbsp;  1. Re: Heartbleed (Mike Tancsa)<br>&nbsp;  2. Re: H=
eartbleed (Steffan Karger)<br>&nbsp;  3. Re: Heartbleed (Mike Tancsa)<br>&n=
bsp;  4. Re: Heartbleed (Enno Gr?per)<br>&nbsp;  5. Re: Heartbleed (Samuli =
Sepp?nen)<br>&nbsp;  6. Re: Heartbleed (Gert Doering)<br><br><br>----------=
------------------------------------------------------------<br><br>Message=
: 1<br>Date: Tue, 08 Apr 2014 10:04:06 -0400<br>From: Mike Tancsa &lt;<a ym=
ailto=3D"mailto:mike@...1800..." href=3D"mailto:mike@...1800...">mike@...1883...=
00...</a>&gt;<br>Subject: Re: [Openvpn-devel] Heartbleed<br>To: Steffan Kar=
ger &lt;<a ymailto=3D"mailto:steffan.karger@...1435..." href=3D"mailto:stef=
fan.karger@...1435...">steffan.karger@...1435...</a>&gt;,&nbsp;&nbsp;&nbsp;=
 Adriaan de Jong<br>&nbsp;&nbsp;&nbsp; &lt;<a ymailto=3D"mailto:dejong@...1386...=
435..." href=3D"mailto:dejong@...1435...">dejong@...1435...</a>&gt;, "<a ym=
ailto=3D"mailto:openvpn-devel@lists.sourceforge.net"
 href=3D"mailto:openvpn-devel@lists.sourceforge.net">openvpn-devel@...1466...=
urceforge.net</a>"<br>&nbsp;&nbsp;&nbsp; &lt;<a ymailto=3D"mailto:openvpn-d=
evel@lists.sourceforge.net" href=3D"mailto:openvpn-devel@...290...=
net">openvpn-devel@lists.sourceforge.net</a>&gt;<br>Message-ID: &lt;<a ymai=
lto=3D"mailto:534401D6.1080604@...1800..." href=3D"mailto:534401D6.1080604@=
...1800...">534401D6.1080604@...1800...</a>&gt;<br>Content-Type: text/plain=
; charset=3DISO-8859-1; format=3Dflowed<br><br>On 4/8/2014 9:42 AM, Steffan=
 Karger wrote:<br><br>&gt;&gt; Perhaps a dumb question, but if the server i=
nstance is linked against<br>&gt;&gt; an older version of openssl (9.8.x), =
but the client is compiled and<br>&gt;&gt; linked against the vulnerable ve=
rsion, is it still an issue for both<br>&gt;&gt; sides, or is the client go=
ing to leak private information ?<br>&gt;<br>&gt; The client can then leak =
keys (both private master key and session keys), which completely breaks yo=
ur
 secure connection, for that client.<br>&gt;<br>&gt; So when the server is =
not vulnerable, each client has to be attacked individually, and not-vulner=
able clients have a secure connection to the server. As long as there are v=
ulnerable clients, you should consider those as potentially malicious, and =
thus you should consider the network as insecure.<br><br>Thanks for the rep=
lay. I am still trying to understand as it relates to <br>the analysis here=
<br><br><a href=3D"http://blog.existentialize.com/diagnosis-of-the-openssl-=
heartbleed-bug.html" target=3D"_blank">http://blog.existentialize.com/diagn=
osis-of-the-openssl-heartbleed-bug.html</a><br><br>How does one attack the =
client ? In my case, the client only connects to <br>my servers ? I use a t=
ls-auth key file as well. If I understand <br>correctly, the scenario would=
 be the attacker would have to have the <br>tls-auth key file, and then do =
a man in the middle attack to pretend its <br>the server's IP, and then
 coax the client into allocating the 64k block <br>of memory as described i=
n the above link ?<br><br>&nbsp;&nbsp;&nbsp; ---Mike<br><br>-- <br>--------=
-----------<br>Mike Tancsa, tel +1 519 651 3400<br>Sentex Communications, <=
a ymailto=3D"mailto:mike@...1800..." href=3D"mailto:mike@...1800...">mike@...220...=
..1800...</a><br>Providing Internet services since 1994 www.sentex.net<br>C=
ambridge, Ontario Canada&nbsp;  <a href=3D"http://www.tancsa.com/" target=
=3D"_blank">http://www.tancsa.com/</a><br><br><br><br>---------------------=
---------<br><br>Message: 2<br>Date: Tue, 8 Apr 2014 16:13:59 +0200<br>From=
: Steffan Karger &lt;<a ymailto=3D"mailto:steffan.karger@...1435..." href=
=3D"mailto:steffan.karger@...1435...">steffan.karger@...1435...</a>&gt;<br>=
Subject: Re: [Openvpn-devel] Heartbleed<br>To: Mike Tancsa &lt;<a ymailto=
=3D"mailto:mike@...1800..." href=3D"mailto:mike@...1800...">mike@...1800...=
</a>&gt;, Adriaan de Jong<br>&nbsp;&nbsp;&nbsp; &lt;<a ymailto=3D"mailto:de=
jong@...1435..."
 href=3D"mailto:dejong@...1435...">dejong@...1435...</a>&gt;,&nbsp;&nbsp;&n=
bsp; "<a ymailto=3D"mailto:openvpn-devel@lists.sourceforge.net" href=3D"mai=
lto:openvpn-devel@lists.sourceforge.net">openvpn-devel@...475...=
t</a>"<br>&nbsp;&nbsp;&nbsp; &lt;<a ymailto=3D"mailto:openvpn-devel@...1096...=
ourceforge.net" href=3D"mailto:openvpn-devel@lists.sourceforge.net">openvpn=
-devel@lists.sourceforge.net</a>&gt;<br>Message-ID:<br>&nbsp;&nbsp;&nbsp; &=
lt;<a ymailto=3D"mailto:1CED409804E2164C8104F9E623B08B90170093CEF0@...1884...=
.." href=3D"mailto:1CED409804E2164C8104F9E623B08B90170093CEF0@...1436...">1=
CED409804E2164C8104F9E623B08B90170093CEF0@...1436...</a>&gt;<br>Content-Typ=
e: text/plain; charset=3D"us-ascii"<br><br>On 08/04/2014 16:04, Mike Tancsa=
 wrote:<br>&gt; How does one attack the client ? In my case, the client onl=
y connects<br>&gt; to my servers ? I use a tls-auth key file as well. If I =
understand<br>&gt; correctly, the scenario would be the
 attacker would have to have the<br>&gt; tls-auth key file, and then do a m=
an in the middle attack to pretend<br>&gt; its the server's IP, and then co=
ax the client into allocating the 64k<br>&gt; block of memory as described =
in the above link ?<br><br>Correct. But man-in-the-middle can also be somet=
hing like DNS poisoning.<br><br>If you use TLS-auth, the attacker must have=
 previously obtained the TLS-auth key. When the user base is large, it is n=
ot unlikely that one of the users was compromised and should be considered =
malicious.<br><br>-Steffan<br><br><br><br>------------------------------<br=
><br>Message: 3<br>Date: Tue, 08 Apr 2014 10:23:53 -0400<br>From: Mike Tanc=
sa &lt;<a ymailto=3D"mailto:mike@...1800..." href=3D"mailto:mike@...1800...=
">mike@...1800...</a>&gt;<br>Subject: Re: [Openvpn-devel] Heartbleed<br>To:=
 Steffan Karger &lt;<a ymailto=3D"mailto:steffan.karger@...1435..."
 href=3D"mailto:steffan.karger@...1435...">steffan.karger@...1435...</a>&gt=
;,&nbsp;&nbsp;&nbsp; Adriaan de Jong<br>&nbsp;&nbsp;&nbsp; &lt;<a ymailto=
=3D"mailto:dejong@...1435..." href=3D"mailto:dejong@...1435...">dejong@...1386...=
435...</a>&gt;, "<a ymailto=3D"mailto:openvpn-devel@lists.sourceforge.net" =
href=3D"mailto:openvpn-devel@lists.sourceforge.net">openvpn-devel@...1885...=
rceforge.net</a>"<br>&nbsp;&nbsp;&nbsp; &lt;<a ymailto=3D"mailto:openvpn-de=
vel@lists.sourceforge.net" href=3D"mailto:openvpn-devel@...1223...=
et">openvpn-devel@lists.sourceforge.net</a>&gt;<br>Message-ID: &lt;<a ymail=
to=3D"mailto:53440679.8060800@...1800..." href=3D"mailto:53440679.8060800@...220...=
..1800...">53440679.8060800@...1800...</a>&gt;<br>Content-Type: text/plain;=
 charset=3DISO-8859-1; format=3Dflowed<br><br>On 4/8/2014 10:13 AM, Steffan=
 Karger wrote:<br>&gt; On 08/04/2014 16:04, Mike Tancsa wrote:<br>&gt;&gt; =
How does one attack the client ? In my case, the client only connects<br>&g=
t;&gt; to my
 servers ? I use a tls-auth key file as well. If I understand<br>&gt;&gt; c=
orrectly, the scenario would be the attacker would have to have the<br>&gt;=
&gt; tls-auth key file, and then do a man in the middle attack to pretend<b=
r>&gt;&gt; its the server's IP, and then coax the client into allocating th=
e 64k<br>&gt;&gt; block of memory as described in the above link ?<br>&gt;<=
br>&gt; Correct. But man-in-the-middle can also be something like DNS poiso=
ning.<br><br>&gt; If you use TLS-auth, the attacker must have previously ob=
tained the TLS-auth key. When the user base is large, it is not unlikely th=
at one of the users was compromised and should be considered malicious.<br>=
<br>Thanks!&nbsp; Although we are certainly planing to update the vulnerabl=
e <br>clients, this is not quite as dire and urgent as first described in t=
he <br>popular press-- at least as it applies to my client base. We also us=
e IP <br>addresses for the target servers in the client
 configs.<br><br>&nbsp;&nbsp;&nbsp; ---Mike<br><br>-- <br>-----------------=
--<br>Mike Tancsa, tel +1 519 651 3400<br>Sentex Communications, <a ymailto=
=3D"mailto:mike@...1800..." href=3D"mailto:mike@...1800...">mike@...1800...=
</a><br>Providing Internet services since 1994 www.sentex.net<br>Cambridge,=
 Ontario Canada&nbsp;  <a href=3D"http://www.tancsa.com/" target=3D"_blank"=
>http://www.tancsa.com/</a><br><br><br><br>------------------------------<b=
r><br>Message: 4<br>Date: Tue, 08 Apr 2014 15:53:05 +0200<br>From: Enno Gr?=
per &lt;<a ymailto=3D"mailto:groepeen@...1879..." href=3D"mailto:groepeen@...220...=
..1879...">groepeen@...1879...</a>&gt;<br>Subject: Re: [Openvpn-devel] Hear=
tbleed<br>To: <a ymailto=3D"mailto:openvpn-devel@lists.sourceforge.net" hre=
f=3D"mailto:openvpn-devel@lists.sourceforge.net">openvpn-devel@...1659...=
forge.net</a><br>Message-ID: &lt;<a ymailto=3D"mailto:5343FF41.3080406@...1386...=
879..."
 href=3D"mailto:5343FF41.3080406@...1879...">5343FF41.3080406@...1879...</a=
>&gt;<br>Content-Type: text/plain; charset=3D"iso-8859-1"<br><br>Hi,<br><br=
>Am 08.04.2014 15:42, schrieb Steffan Karger:<br>&gt;&gt; Perhaps a dumb qu=
estion, but if the server instance is linked<br>&gt;&gt; against an older v=
ersion of openssl (9.8.x), but the client is<br>&gt;&gt; compiled and linke=
d against the vulnerable version, is it still an<br>&gt;&gt; issue for both=
 sides, or is the client going to leak private<br>&gt;&gt; information ?<br=
>&gt;<br>&gt; The client can then leak keys (both private master key and se=
ssion<br>&gt; keys), which completely breaks your secure connection, for th=
at<br>&gt; client.<br>&gt;<br>&gt; So when the server is not vulnerable, ea=
ch client has to be attacked<br>&gt; individually, and not-vulnerable clien=
ts have a secure connection to<br>&gt; the server. As long as there are vul=
nerable clients, you should<br>&gt; consider those as
 potentially malicious, and thus you should consider<br>&gt; the network as=
 insecure.<br>Then OpenVPN should release new Windows Versions.<br>The curr=
ent binaries are linked against OpenSSL (ssleay32.dll, <br>libeay32.dll) 1.=
0.1.5 (-&gt; 1.0.1e).<br><br>Greetings,<br>Enno<br><br>-- <br>Enno Gr?per<b=
r><a ymailto=3D"mailto:groepeen@...1879..." href=3D"mailto:groepeen@...1886...=
...">groepeen@...1879...</a> - Raum 2'325, Rudower Chaussee 26<br>Tel. +49.=
(0)30.2093.70053&nbsp; Fax +49.(0)30.2093.2959<br>Humboldt-Universit?t zu B=
erlin - <a href=3D"http://www.hu-berlin.de/" target=3D"_blank">http://www.h=
u-berlin.de/</a><br>ZE Computer- und Medienservice - <a href=3D"http://www.=
cms.hu-berlin.de/" target=3D"_blank">http://www.cms.hu-berlin.de/</a><br>Un=
ter den Linden 6, D-10099 Berlin, Germany<br><br>-------------- next part -=
-------------<br>A non-text attachment was scrubbed...<br>Name: smime.p7s<b=
r>Type: application/pkcs7-signature<br>Size: 4781
 bytes<br>Desc: S/MIME Cryptographic Signature<br><br>---------------------=
---------<br><br>Message: 5<br>Date: Tue, 08 Apr 2014 18:09:17 +0300<br>Fro=
m: Samuli Sepp?nen &lt;<a ymailto=3D"mailto:samuli@...515..." href=3D"mailt=
o:samuli@...515...">samuli@...515...</a>&gt;<br>Subject: Re: [Openvpn-devel=
] Heartbleed<br>To: Enno Gr?per &lt;<a ymailto=3D"mailto:groepeen@...1887...=
." href=3D"mailto:groepeen@...1879...">groepeen@...1879...</a>&gt;,<br>&nbs=
p;&nbsp;&nbsp; "<a ymailto=3D"mailto:openvpn-devel@lists.sourceforge.net" h=
ref=3D"mailto:openvpn-devel@lists.sourceforge.net">openvpn-devel@...1439...=
ceforge.net</a>"<br>&nbsp;&nbsp;&nbsp; &lt;<a ymailto=3D"mailto:openvpn-dev=
el@lists.sourceforge.net" href=3D"mailto:openvpn-devel@...475...=
t">openvpn-devel@lists.sourceforge.net</a>&gt;<br>Message-ID: &lt;<a ymailt=
o=3D"mailto:5344111D.3080408@...515..."
 href=3D"mailto:5344111D.3080408@...515...">5344111D.3080408@...515...</a>&=
gt;<br>Content-Type: text/plain; charset=3DISO-8859-1<br><br><br>&gt; Hi,<b=
r>&gt;<br>&gt; Am 08.04.2014 15:42, schrieb Steffan Karger:<br>&gt;&gt;&gt;=
 Perhaps a dumb question, but if the server instance is linked<br>&gt;&gt;&=
gt; against an older version of openssl (9.8.x), but the client is<br>&gt;&=
gt;&gt; compiled and linked against the vulnerable version, is it still an<=
br>&gt;&gt;&gt; issue for both sides, or is the client going to leak privat=
e<br>&gt;&gt;&gt; information ?<br>&gt;&gt; The client can then leak keys (=
both private master key and session<br>&gt;&gt; keys), which completely bre=
aks your secure connection, for that<br>&gt;&gt; client.<br>&gt;&gt;<br>&gt=
;&gt; So when the server is not vulnerable, each client has to be attacked<=
br>&gt;&gt; individually, and not-vulnerable clients have a secure connecti=
on to<br>&gt;&gt; the server. As long as there are vulnerable
 clients, you should<br>&gt;&gt; consider those as potentially malicious, a=
nd thus you should consider<br>&gt;&gt; the network as insecure.<br>&gt; Th=
en OpenVPN should release new Windows Versions.<br>&gt; The current binarie=
s are linked against OpenSSL (ssleay32.dll, <br>&gt; libeay32.dll) 1.0.1.5 =
(-&gt; 1.0.1e).<br>&gt;<br>&gt;<br>Hi all,<br><br>We'll try to push OpenVPN=
 2.3.3 out today. The Windows installer will<br>contain OpenSSL 1.0.1g whic=
h fixes this particular problem. In addition<br>several other small changes=
 and enhancements will be included.<br><br>-- <br>Samuli Sepp?nen<br>Commun=
ity Manager<br>OpenVPN Technologies, Inc<br><br>irc freenode net: mattock<b=
r><br><br><br><br>------------------------------<br><br>Message: 6<br>Date:=
 Tue, 8 Apr 2014 17:13:15 +0200<br>From: Gert Doering &lt;<a ymailto=3D"mai=
lto:gert@...1296..." href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt=
;<br>Subject: Re: [Openvpn-devel] Heartbleed<br>To: Enno
 Gr?per &lt;<a ymailto=3D"mailto:groepeen@...1879..." href=3D"mailto:groepe=
en@...1879...">groepeen@...1879...</a>&gt;<br>Cc: <a ymailto=3D"mailto:open=
vpn-devel@lists.sourceforge.net" href=3D"mailto:openvpn-devel@...1535...=
orge.net">openvpn-devel@lists.sourceforge.net</a><br>Message-ID: &lt;<a yma=
ilto=3D"mailto:20140408151315.GD16637@...1296..." href=3D"mailto:2014040815=
1315.GD16637@...1296...">20140408151315.GD16637@...1296...</a>&gt;<br>Conte=
nt-Type: text/plain; charset=3D"iso-8859-1"<br><br>Hi,<br><br>On Tue, Apr 0=
8, 2014 at 03:53:05PM +0200, Enno Gr?per wrote:<br>&gt; Then OpenVPN should=
 release new Windows Versions.<br><br>Yeah, always glad to have people tell=
 us what to do.<br><br>Working on it...<br><br>gert<br>-- <br>USENET is *no=
t* the non-clickable part of WWW!<br>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  //www.muc.de/~gert/<br>Gert Doe=
ring - Munich, Germany&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;  <a ymailto=3D"mailto:gert@...493...=
1296..." href=3D"mailto:gert@...1296...">gert@...1296...</a><br>fax: +49-89=
-35655025&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp; &nbsp; &nbsp; <a ymailto=3D"mailto:gert@...1297..." href=3D"mailto:gert=
@...1297...">gert@...1297...</a><br>-------------- next part --------------=
<br>A non-text attachment was scrubbed...<br>Name: not available<br>Type: a=
pplication/pgp-signature<br>Size: 305 bytes<br>Desc: not available<br><br>-=
-----------------------------<br><br>--------------------------------------=
----------------------------------------<br>Put Bad Developers to Shame<br>=
Dominate Development with Jenkins Continuous Integration<br>Continuously Au=
tomate
 Build, Test &amp; Deployment <br>Start a new project now. Try Jenkins in t=
he cloud.<br><a href=3D"http://p.sf.net/sfu/13600_Cloudbees" target=3D"_bla=
nk">http://p.sf.net/sfu/13600_Cloudbees</a><br><br>------------------------=
------<br><br>_______________________________________________<br>Openvpn-de=
vel mailing list<br><a ymailto=3D"mailto:Openvpn-devel@...475...=
t" href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br><a href=3D"https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel" target=3D"_blank">https://lists.sourceforge.net/lists/li=
stinfo/openvpn-devel</a><br><br><br>End of Openvpn-devel Digest, Vol 95, Is=
sue 3<br>********************************************<br><br><br></div>  </=
div> </div>  </div> </div></body></html>=

---433406958-1104364303-1396981531=:68582--

