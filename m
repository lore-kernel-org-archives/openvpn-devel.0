MIME-Version: 1.0
In-Reply-To: <CALKXstsZLjqxCrzo3E-qGiyhJo3yi9bW1Jf2bKGYphkB+4b0Qg@...278...>
References: <CALKXstsZLjqxCrzo3E-qGiyhJo3yi9bW1Jf2bKGYphkB+4b0Qg@...278...>
Date: Thu, 30 Jul 2015 12:55:00 +0530
Message-ID: <CALKXsttsrkPxgrT1A+gpRh5WoxTxw6djkBQJh7BjKTSk5itDig@...278...>
From: Rahul Arora <rahul1991.arora@...277...>
Content-Type: multipart/alternative; boundary=001a1133a352e7b361051c129983
Subject: Re: [Openvpn-devel] Openvpn is not working with hardware encryption
	enabled CPU.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

--001a1133a352e7b361051c129983
Content-Type: text/plain; charset=UTF-8

Sorry for my last incomplete email.I sent it by mistake.Here is the
complete description.

We have a hardware encryption enabled CPU,we want to test how does its
hardware encryption engine will improve Openvpn performance.

*We are getting outstanding improved performance in openssl*, from 48 times
up to 100 times in openssl encryption test with cryptodev engine supported.

The 'numbers' are in 1000s of bytes per second processed.
type             16 bytes     64 bytes    256 bytes   1024 bytes   8192
bytes
aes-128-cbc      12386.33k    41985.48k   312989.87k   823944.53k
infk


Then *while running the openvpn between 2 machine's* (one for server, one
for client, and both side cipher used aes-128-cbc), we can get the Openvpn
tunnel working, but when we tried to use iperf to test its traffic
throughput capacity, the throughput of Iperf shows only *16Mbits/sec with
cryptodev hardware engine* !!!, it is *even low than without cryptodev
hardware engine enabled(its around 80Mbits/sec)*.

If some body knows this issue,can you please point me to the source code
path where i can tweak something to improve performance with cryptodev case.

I am using below versions of the sources.

*OpenSSL 1.0.1g 7 Apr 2014*

*Openvpn --version*
OpenVPN 2.1.3 arm-fsl-linux-gnueabi [SSL] [LZO2] [EPOLL] built on Jul 29
2015
Originally developed by James Yonan
Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>

*Cryptodev 1.6 version*


Please feel free to revert if any information is missing.

Thanks for the help.









On Thu, Jul 30, 2015 at 12:33 PM, Rahul Arora <rahul1991.arora@...277...>
wrote:

> Hi Team,
>
> We have a hardware encryption enabled CPU,we want to test how does its
> hardware encryption engine will improve Openvpn performance.
>
> We are getting outstanding improved performance in openssl, from 48 times
> up to 100 times in openssl encryption test with cryptodev engine supported.
>
>

--001a1133a352e7b361051c129983
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Sorry for my last incomplete email.I sent it by mista=
ke.Here is the complete description.<br><br>We have a hardware encryption e=
nabled CPU,we want=20
to test how does its hardware encryption engine will improve Openvpn=20
performance.<br><br><b>We are getting outstanding improved performance in o=
penssl</b>, from 48 times up
 to 100 times in openssl encryption test with cryptodev engine supported.<b=
r><br>The &#39;numbers&#39; are in 1000s of bytes per second processed.<br>=
type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 16 bytes=C2=A0=C2=A0=C2=A0=C2=A0 64 bytes=C2=A0=C2=A0=C2=A0 256 bytes=
=C2=A0=C2=A0 1024 bytes=C2=A0=C2=A0 8192 bytes<br>aes-128-cbc=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 12386.33k=C2=A0=C2=A0=C2=A0 41985.48k=C2=A0=C2=A0 312989=
.87k=C2=A0=C2=A0 823944.53k=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 infk<br><br><br>Then <b>while running the openvpn between 2 machine&#39;s<=
/b> (one for server, one for=20
client, and both side cipher used aes-128-cbc), we can get the Openvpn=20
tunnel working, but when we tried to use iperf to test its traffic=20
throughput capacity, the throughput of Iperf shows only <b>16Mbits/sec with
 cryptodev hardware engine</b> !!!, it is <b>even low than without cryptode=
v=20
hardware engine enabled(its around 80Mbits/sec)</b>.<br><br></div><div>If s=
ome body knows this issue,can you please point me to the source code path w=
here i can tweak something to improve performance with cryptodev case.<br><=
br></div><div>I am using below versions of the sources.<br><br><b>OpenSSL 1=
.0.1g 7 Apr 2014</b><br></div><div><br><b>Openvpn --version</b><br>OpenVPN =
2.1.3 arm-fsl-linux-gnueabi [SSL] [LZO2] [EPOLL] built on Jul 29 2015<br>Or=
iginally developed by James Yonan<br>Copyright (C) 2002-2010 OpenVPN Techno=
logies, Inc. &lt;<a href=3D"mailto:sales@...515...">sales@...515...</a>&gt;=
<br><br></div><div><b>Cryptodev 1.6 version</b><br><br></div><div><br></div=
><div>Please feel free to revert if any information is missing.<br><br>Than=
ks for the help.<br></div><div><br><br><br></div><div><br><br></div><br><br=
><br><div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu,=
 Jul 30, 2015 at 12:33 PM, Rahul Arora <span dir=3D"ltr">&lt;<a href=3D"mai=
lto:rahul1991.arora@...277..." target=3D"_blank">rahul1991.arora@...277...<=
/a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:=
0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hi=
 Team,<br><br>We have a hardware encryption enabled CPU,we want=20
to test how does its hardware encryption engine will improve Openvpn=20
performance.<br><br>We are getting outstanding improved performance in open=
ssl, from 48 times up
 to 100 times in openssl encryption test with cryptodev engine supported.<b=
r><br></div>
</blockquote></div><br></div></div></div>

--001a1133a352e7b361051c129983--

