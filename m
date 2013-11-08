In-Reply-To: <20131023141829.GA13900@...1296...>
References: <CAN_jwOsXhs-qTqOmrqhNk+Jf6-pRSBVVTovShLGgQAKKTZkE4g@...278...>	<554440252.59882.1380270883311.JavaMail.zimbra@...1795...>
	<CAN_jwOvixY5Jz7Rheq-=o40saprsoQmxRB9yn3-jdCmFa9VM0A@...278...>	<52456F61.3000104@...1114...>
	<CAN_jwOt4kiM09YjZi5=jh6qFgQTpLFgPOSO1opFOF72EY8fyCw@...278...>	<CAN_jwOuJcwF-Co0r=pukUHO2z0a0ff5xtERp7_mc2PYot9yv-Q@...278...>
	<CAN_jwOuQR6rxUTA5Nho9tBkvSBMU75Yzfv=PFpFUHa2Kq8=E2A@...278...>
	<20131023141829.GA13900@...1296...>
MIME-Version: 1.0
From: arno.odermatt@...1845...
Message-ID: <OF070A0C19.BDAE46A9-ONC1257C1D.003AD8C1-C1257C1D.003BF068@...1846...>
Date: Fri, 8 Nov 2013 11:54:41 +0100
Content-Type: multipart/alternative;
	boundary="=_alternative 003BEFD6C1257C1D_="
Subject: Re: [Openvpn-devel] Does openvpn 2.3.2 has memory leak?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multipart message in MIME format.
--=_alternative 003BEFD6C1257C1D_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Dear Gert,

after having been able to spend a smooth operating time of the around 3400=
=20

permanent connected O-VPN clients (after having attached memory in form of=
=20

a 10Gb swap partition), we just recognized a hickout, where all clients=20
got disconnected.

Unfortunately, after around 3270 disconnected clients, memory was'nt freed=
=20

at all:

3270 /etc/openvpn/cgwvpn/persipoff

top - 10:31:58 up 31 days, 20:10,  2 users,  load average: 0.78, 0.70,=20
0.69
Tasks:  71 total,   2 running,  69 sleeping,   0 stopped,   0 zombie
Cpu(s):  0.3%us, 23.2%sy,  0.0%ni, 50.0%id,  0.0%wa, 14.4%hi,  0.0%si,=20
12.0%st
Mem:   7629920k total,  5073576k used,  2556344k free,   159504k buffers
Swap: 10485756k total,        0k used, 10485756k free,   192536k cached

PID USER          PR  NI  VIRT      RES     SHR      S      %CPU     %MEM=
=20=20

 TIME+       COMMAND
22810 root      20   0     4481m   4.2g    1996   S      62.5 58.1 5102:38=
=20

     openvpn
12619 root      20   0       8             4           0        R      3.0=
=20

             0.0          0:00.09      openvpn
12222 root      20   0    15228   1216    932       R  0.3  0.0   0:00.02=20
top

Unfortunately, this is not something, we had expected.
We have not applied the patch yet, which brings back the "2.1" behavior.


freundlich gr=FCsst,
kind regards,

_________________________
_________________________
_________________________
_________________________
_________________________
________________=20

Arno Odermatt=20
Phone +41414454053=20
arno.odermatt@...1845...=20

Schindler Elevator Ltd. | Corporate Research & Development | CRD/CO-BAT=20
Zugerstr. 13 | CH-6030 Ebikon, Switzerland=20
http://www.schindler.com=20
_________________________
_________________________
_________________________
_________________________
_________________________
________________=20

Please consider your environment.=20

Schindler supports sustainable urban development with
safe, reliable and ecologically sound mobility solutions.





From:   Gert Doering <gert@...1296...>
To:     Brad Zhang <hebei5000@...277...>,=20
Cc:     openvpn-devel@lists.sourceforge.net
Date:   23.10.2013 16:20
Subject:        Re: [Openvpn-devel] Does openvpn 2.3.2 has memory leak?



Hi,

On Sun, Oct 06, 2013 at 09:21:46PM +0800, Brad Zhang wrote:
> Do you have some idea about this issue?  Looking forward to your reply.

Coming back to *this* thread, after some debugging in the other thread
with Arno, I think what I can say so far is that we're observing two
different things:

 - the first renegotiation brings a big jump in memory, but this is to
   be expected, because the new keying material needs extra memory, and
   the memory for the old key is not released right away (it seems to be
   released at the next renegotiation, or at client disconnect - I've=20
   seen VSZ/RSS go down(!) when clients disconnect, so that seems to
   work right).  This is the "big" jump in memory consumption which is
   actually killing Arno's setup, because there is not enough virtual
   memory available to hold all that is needed for 3000 clients (but
   that can be fixed by increasing max-memory limits if there is enough=20
   RAM).

 - each further renegotiation leaks "a few kbyte" of memory per client,
   which should also be fully returned when the client disconnects - this
   is the issue I discovered earlier, with the GC handling of the=20
per-client
   environment set, and I'll send a patch for that "soon" (as soon as I
   have fully understood the code involved).

Now, what I do not really understand is why the memory consumption on the
3rd, 4th, 5th renegotiation seems to slow down - there seems to be some
additional memory fragmentation involved in the 2nd+3rd renegotiation,
which leads to memory re-use later on.  Or so.

Testing this with "reneg-sec 60" is actually quite interesting...  here's
*disconnect* of a client:

USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root     19892  0.0  0.0   7052  4304 pts/7    SN+  17:48   0:01 openvpn=20
../serv
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root     19892  0.0  0.0   6300  3740 pts/7    SN+  17:48   0:01 openvpn=20
../serv

... so you can see that memory is returned to the OS.  (I think this will
not be visible if many clients are connected as the free()ed memory will
be "somewhere in the middle" - but disconnecting *all* clients should also
show memory being returned)

Now going to stare more at the code... :-)

gert


--=20
USENET is *not* the non-clickable part of WWW!
 //www.muc.de/~gert/
Gert Doering - Munich, Germany gert@...1296...
fax: +49-89-35655025 gert@...1297...
[attachment "attxgxs6.dat" deleted by Arno Odermatt/R&D/SCH/SCHINDLER]=20
---------------------------------------------------------------------------=
---
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most=20
from=20
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=3D60135991&iu=3D/4140/ostg.cl=
ktrk
_________________________
______________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel


******************************************************
Notice: The information contained in this message is intended only for use =
of the individual(s) named above and may contain confidential, proprietary =
or legally privileged information. No confidentiality or privilege is waive=
d or lost by any mistransmission. If you are not the intended recipient of =
this message you are hereby notified that you must not use, disseminate , c=
opy it in any form or take any action in reliance of it. If you have receiv=
ed this message in error please delete it and any copies of it and notify t=
he sender immediately.
*******************************************************=

--=_alternative 003BEFD6C1257C1D_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<font size=3D2 face=3D"sans-serif">Dear Gert,</font>
<br>
<br><font size=3D2 face=3D"sans-serif">after having been able to spend a sm=
ooth
operating time of the around 3400 permanent connected O-VPN clients (after
having attached memory in form of a 10Gb swap partition), we just recognized
a hickout, where all clients got disconnected.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Unfortunately, after around 3270 dis=
connected
clients, memory was'nt freed at all:<br>
</font>
<br><font size=3D2 face=3D"sans-serif">3270 /etc/openvpn/cgwvpn/persipoff</=
font>
<br><font size=3D2 face=3D"sans-serif"><br>
</font><font size=3D2 face=3D"Calibri">top - 10:31:58 up 31 days, 20:10, &n=
bsp;2
users, &nbsp;load average: 0.78, 0.70, 0.69</font>
<br><font size=3D2 face=3D"Calibri">Tasks: &nbsp;71 total, &nbsp; 2 running,
&nbsp;69 sleeping, &nbsp; 0 stopped, &nbsp; 0 zombie</font>
<p><font size=3D2 face=3D"Calibri">Cpu(s): &nbsp;0.3%us, 23.2%sy, &nbsp;0.0=
%ni,
50.0%id, &nbsp;0.0%wa, 14.4%hi, &nbsp;0.0%si, 12.0%st</font>
<p><font size=3D2 face=3D"Calibri">Mem: &nbsp; 7629920k total, &nbsp;507357=
6k
used, &nbsp;2556344k free, &nbsp; 159504k buffers</font>
<p><font size=3D2 face=3D"Calibri">Swap: 10485756k total, &nbsp; &nbsp; &nb=
sp;
&nbsp;0k used, 10485756k free, &nbsp; 192536k cached</font>
<p>
<p><font size=3D2 face=3D"Calibri">PID USER &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;PR
&nbsp;NI &nbsp;VIRT &nbsp; &nbsp; &nbsp;RES &nbsp; &nbsp; SHR &nbsp; &nbsp;
&nbsp;S &nbsp; &nbsp; &nbsp;%CPU &nbsp; &nbsp; %MEM &nbsp; &nbsp;TIME+
&nbsp; &nbsp; &nbsp; COMMAND</font>
<p><font size=3D2 face=3D"Calibri">22810 root &nbsp; &nbsp; &nbsp;20 &nbsp;
0 &nbsp; &nbsp; </font><font size=3D2 color=3Dred face=3D"Calibri"><b>4481m=
</b></font><font size=3D2 face=3D"Calibri">
&nbsp; </font><font size=3D2 color=3Dred face=3D"Calibri"><b>4.2g</b></font=
><font size=3D2 face=3D"Calibri">
&nbsp; &nbsp;1996 &nbsp; S &nbsp; &nbsp; &nbsp;62.5 &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;58.1 &nbsp; &nbsp; &nbsp; 5102:38 &nbsp; &nbsp; &nbsp;o=
penvpn</font>
<p><font size=3D2 face=3D"Calibri">12619 root &nbsp; &nbsp; &nbsp;20 &nbsp;
0 &nbsp; &nbsp; &nbsp; 8 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 4 &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; 0 &nbsp; &nbsp; &nbsp; &nbsp;R &nbsp; &nbsp;
&nbsp;3.0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0.0 &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;0:00.09 &nbsp; &nbsp; &nbsp;openvpn</font>
<p><font size=3D2 face=3D"Calibri">12222 root &nbsp; &nbsp; &nbsp;20 &nbsp;
0 &nbsp; &nbsp;15228 &nbsp; 1216 &nbsp; &nbsp;932 &nbsp; &nbsp; &nbsp;
R &nbsp;0.3 &nbsp;0.0 &nbsp; 0:00.02 top<br>
<br>
Unfortunately, this is not something, we had expected.</font>
<p><font size=3D2 face=3D"Calibri">We have not applied the patch yet, which
brings back the &quot;2.1&quot; behavior.</font>
<p>
<br><font size=3D2 face=3D"sans-serif"><br>
freundlich gr=FCsst,<br>
kind regards,<br>
</font><font size=3D1 face=3D"Arial"><br>
_________________________
_________________________
_________________________
_________________________
_________________________
________________
</font><font size=3D2 face=3D"sans-serif"><br>
Arno Odermatt <br>
Phone +41414454053 <br>
arno.odermatt@...1845... <br>
<br>
Schindler Elevator Ltd. | Corporate Research &amp; Development | CRD/CO-BAT
<br>
Zugerstr. 13 | CH-6030 Ebikon, Switzerland <br>
</font><a href=3Dhttp://www.schindler.com/><font size=3D2 face=3D"sans-seri=
f">http://www.schindler.com</font></a><font size=3D2 face=3D"sans-serif">
</font><font size=3D1 face=3D"Arial"><br>
_________________________
_________________________
_________________________
_________________________
_________________________
________________
</font><font size=3D1 color=3D#008000 face=3D"Arial"><br>
Please consider your environment. <br>
</font><font size=3D1 color=3D#5f5f5f face=3D"Arial"><br>
Schindler supports sustainable urban development with<br>
safe, reliable and ecologically sound mobility solutions.<br>
</font><font size=3D1 color=3D#008000 face=3D"Arial"><br>
</font>
<br>
<br>
<br>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">From: &nbsp; &nbsp; =
&nbsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">Gert Doering &lt;gert@...1711...=
96...&gt;</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">To: &nbsp; &nbsp; &n=
bsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">Brad Zhang &lt;hebei5000@...1186...=
.277...&gt;,
</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Cc: &nbsp; &nbsp; &n=
bsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">openvpn-devel@...1535...=
orge.net</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Date: &nbsp; &nbsp; =
&nbsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">23.10.2013 16:20</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Subject: &nbsp; &nbs=
p;
&nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">Re: [Openvpn-devel]
Does openvpn 2.3.2 has memory leak?</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=3D2>Hi,<br>
<br>
On Sun, Oct 06, 2013 at 09:21:46PM +0800, Brad Zhang wrote:<br>
&gt; Do you have some idea about this issue? &nbsp;Looking forward to your
reply.<br>
<br>
Coming back to *this* thread, after some debugging in the other thread<br>
with Arno, I think what I can say so far is that we're observing two<br>
different things:<br>
<br>
 - the first renegotiation brings a big jump in memory, but this is to<br>
 &nbsp; be expected, because the new keying material needs extra memory,
and<br>
 &nbsp; the memory for the old key is not released right away (it seems
to be<br>
 &nbsp; released at the next renegotiation, or at client disconnect - I've
<br>
 &nbsp; seen VSZ/RSS go down(!) when clients disconnect, so that seems
to<br>
 &nbsp; work right). &nbsp;This is the &quot;big&quot; jump in memory consu=
mption
which is<br>
 &nbsp; actually killing Arno's setup, because there is not enough virtual<=
br>
 &nbsp; memory available to hold all that is needed for 3000 clients (but<b=
r>
 &nbsp; that can be fixed by increasing max-memory limits if there is enough
<br>
 &nbsp; RAM).<br>
<br>
 - each further renegotiation leaks &quot;a few kbyte&quot; of memory per
client,<br>
 &nbsp; which should also be fully returned when the client disconnects
- this<br>
 &nbsp; is the issue I discovered earlier, with the GC handling of the
per-client<br>
 &nbsp; environment set, and I'll send a patch for that &quot;soon&quot;
(as soon as I<br>
 &nbsp; have fully understood the code involved).<br>
<br>
Now, what I do not really understand is why the memory consumption on the<b=
r>
3rd, 4th, 5th renegotiation seems to slow down - there seems to be some<br>
additional memory fragmentation involved in the 2nd+3rd renegotiation,<br>
which leads to memory re-use later on. &nbsp;Or so.<br>
<br>
Testing this with &quot;reneg-sec 60&quot; is actually quite interesting...
&nbsp;here's<br>
*disconnect* of a client:<br>
<br>
USER &nbsp; &nbsp; &nbsp; PID %CPU %MEM &nbsp; &nbsp;VSZ &nbsp; RSS TTY
&nbsp; &nbsp; &nbsp;STAT START &nbsp; TIME COMMAND<br>
root &nbsp; &nbsp; 19892 &nbsp;0.0 &nbsp;0.0 &nbsp; 7052 &nbsp;4304 pts/7
&nbsp; &nbsp;SN+ &nbsp;17:48 &nbsp; 0:01 openvpn ../serv<br>
USER &nbsp; &nbsp; &nbsp; PID %CPU %MEM &nbsp; &nbsp;VSZ &nbsp; RSS TTY
&nbsp; &nbsp; &nbsp;STAT START &nbsp; TIME COMMAND<br>
root &nbsp; &nbsp; 19892 &nbsp;0.0 &nbsp;0.0 &nbsp; 6300 &nbsp;3740 pts/7
&nbsp; &nbsp;SN+ &nbsp;17:48 &nbsp; 0:01 openvpn ../serv<br>
<br>
... so you can see that memory is returned to the OS. &nbsp;(I think this
will<br>
not be visible if many clients are connected as the free()ed memory will<br>
be &quot;somewhere in the middle&quot; - but disconnecting *all* clients
should also<br>
show memory being returned)<br>
<br>
Now going to stare more at the code... :-)<br>
<br>
gert<br>
<br>
<br>
-- <br>
USENET is *not* the non-clickable part of WWW!<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; //www.muc.de/~gert/=
<br>
Gert Doering - Munich, Germany &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; gert@...1296...<br>
fax: +49-89-35655025 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;gert@...1297...<br>
[attachment &quot;attxgxs6.dat&quot; deleted by Arno Odermatt/R&amp;D/SCH/S=
CHINDLER]
---------------------------------------------------------------------------=
---<br>
October Webinars: Code for Performance<br>
Free Intel webinars can help you accelerate application performance.<br>
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most
from <br>
the latest Intel processors and coprocessors. See abstracts and register
&gt;<br>
</font></tt><a href=3D"http://pubads.g.doubleclick.net/gampad/clk?id=3D6013=
5991&amp;iu=3D/4140/ostg.clktrk"><tt><font size=3D2>http://pubads.g.doublec=
lick.net/gampad/clk?id=3D60135991&amp;iu=3D/4140/ostg.clktrk</font></tt></a=
><tt><font size=3D2>__________________
_________________________
____<br>
Openvpn-devel mailing list<br>
Openvpn-devel@lists.sourceforge.net<br>
</font></tt><a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn=
-devel"><tt><font size=3D2>https://lists.sourceforge.net/lists/listinfo/ope=
nvpn-devel</font></tt></a><tt><font size=3D2><br>
</font></tt>
<br><br clear=3D"both">
******************************************************<BR>
Notice: The information contained in this message is intended only for use =
of the individual(s) named above and may contain confidential, proprietary =
or legally privileged information. No confidentiality or privilege is waive=
d or lost by any mistransmission. If you are not the intended recipient of =
this message you are hereby notified that you must not use, disseminate , c=
opy it in any form or take any action in reliance of it. If you have receiv=
ed this message in error please delete it and any copies of it and notify t=
he sender immediately.<BR>
*******************************************************<BR>

--=_alternative 003BEFD6C1257C1D_=--

