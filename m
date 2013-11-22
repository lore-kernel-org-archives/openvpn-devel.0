MIME-Version: 1.0
From: arno.odermatt@...1845...
Message-ID: <OF05315ED1.21B1F5C0-ONC1257C2B.0035DBF4-C1257C2B.00362669@...1846...>
Date: Fri, 22 Nov 2013 10:51:27 +0100
Content-Type: multipart/alternative;
	boundary="=_alternative 003625D8C1257C2B_="
Subject: [Openvpn-devel] Does openvpn 2.3.2 has memory leak? (addendum3 and
	4)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net
Cc: Brad Zhang <hebei5000@...277...>

This is a multipart message in MIME format.
--=_alternative 003625D8C1257C2B_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Dear Gert, Brad all,

as I also had reported to have recognized, that memory was not freed, even=
=20

though the openvpn disconnect-script was disconnecting all of the 3400=20
Openvpn-sessions (pls see mail below).
Would you think, this is also improved by the change from malloc to=20
calloc, so we could update to 2.3.3 to improve the memory-leak situation?


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
Date:   20.11.2013 19:33
Subject:        Re: [Openvpn-devel] Does openvpn 2.3.2 has memory leak?



Hi,

to bring this discussion to an end...

On Thu, Nov 07, 2013 at 06:25:55PM +0800, Brad Zhang wrote:
> Thank you so much. I am testing Openvpn 2.3.2 with your patch memory=20
usage
> some days. Here is result:

Thanks for the exhaustive tests.  This is really good to see, and it's
impressive how much less memory PolarSSL need!

The patch in question has been acked by David, has been pushed to git,
and will be in 2.3.3 when we release that.

[..]
> I noticed your mail said if clients are disconnected, the memory will be
> free, but when I tested openvpn + polarssl (no your patch), the memory=20
did
> not free completely, for example:
> Openvpn 2.3.2 + Polarssl
> 62672  55m 1408 S  0.0  2.8   0:06.91 openvpn  (Have 200 connections)
> 37864  34m 1412 S  0.0  1.7   0:06.84 openvpn  (disconnect all=20
connections)
[..]
> It is odd that memory do not free completely because I saw all the=20
clients
> disconnect correctly from Openvpn server logs.
> I tried to disable the option "persist-key" and "persist-tun", it did=20
not
> make better when clients disconnected.

Finding the reason for that is not trivial.  What comes into play here is
how the "malloc()" and "free()" functions works on that particular=20
operating system - usually, not all malloc() requests fetch memory from=20
the
kernel directly, but usually malloc() will request a larger block (with
sbrk() or mmap()), and maintain that locally in the process, saving on=20
syscall overhead.  free() will also work only locally first, and only if
the library decides "it's worth returing something to the kernel" it will
actually do so - so it's not unusual to never see memory usage actually
go down if your library just keeps the memory chunks around...

So it might be that in this case, there's a memory allocation right in
the middle of a larger area which is still in use, so the larger area
cannot be returned (but the memory might be re-used when the clients
connect again, so is not "lost") - but without very extensive debugging,
including fully understanding the way the local malloc()/free()=20
implementations work, this is impossible to give a definite answer to.

What we know, and this is good :-), is that openvpn *does* call free()
on everything it allocates - this we can learn from valgrind, but it
will only tell us how the situation is at program end, not how the
memory layout looks like while it runs (I think it can be told to do
so, but there are *many* short-lived malloc()/free() uses in OpenVPN,
so looking at the log files would be a huge amount of work).

Anyway.  I think what we have is "good enough" given the amount of
work we can invest here, and that there are so many other areas where
we need to fix bugs...

Thanks for bringing this up, and making us reconsider the buffer changes
we did in best faith :-)

gert
--=20
USENET is *not* the non-clickable part of WWW!
 //www.muc.de/~gert/
Gert Doering - Munich, Germany gert@...1296...
fax: +49-89-35655025 gert@...1297...
[attachment "att77ku7.dat" deleted by Arno Odermatt/R&D/SCH/SCHINDLER]=20
---------------------------------------------------------------------------=
---
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing=20
conversations that shape the rapidly evolving mobile landscape. Sign up=20
now.=20
http://pubads.g.doubleclick.net/gampad/clk?id=3D63431311&iu=3D/4140/ostg.cl=
ktrk
_________________________
______________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel




----- Forwarded by Arno Odermatt/R&D/SCH/SCHINDLER on 22.11.2013 10:48=20
-----

From:   arno.odermatt@...1845...
To:     Gert Doering <gert@...1296...>,=20
Cc:     openvpn-devel@lists.sourceforge.net
Date:   08.11.2013 11:56
Subject:        Re: [Openvpn-devel] Does openvpn 2.3.2 has memory leak?



Dear Gert,=20

after having been able to spend a smooth operating time of the around 3400=
=20

permanent connected O-VPN clients (after having attached memory in form of=
=20

a 10Gb swap partition), we just recognized a hickout, where all clients=20
got disconnected.=20

Unfortunately, after around 3270 disconnected clients, memory was'nt freed=
=20

at all:

3270 /etc/openvpn/cgwvpn/persipoff=20

top - 10:31:58 up 31 days, 20:10,  2 users,  load average: 0.78, 0.70,=20
0.69=20
Tasks:  71 total,   2 running,  69 sleeping,   0 stopped,   0 zombie=20
Cpu(s):  0.3%us, 23.2%sy,  0.0%ni, 50.0%id,  0.0%wa, 14.4%hi,  0.0%si,=20
12.0%st=20
Mem:   7629920k total,  5073576k used,  2556344k free,   159504k buffers=20
Swap: 10485756k total,        0k used, 10485756k free,   192536k cached=20
PID USER          PR  NI  VIRT      RES     SHR      S      %CPU     %MEM=
=20=20

 TIME+       COMMAND=20
22810 root      20   0     4481m   4.2g    1996   S      62.5 58.1 5102:38=
=20

     openvpn=20
12619 root      20   0       8             4           0        R      3.0=
=20

             0.0          0:00.09      openvpn=20
12222 root      20   0    15228   1216    932       R  0.3  0.0   0:00.02=20
top

Unfortunately, this is not something, we had expected.=20
We have not applied the patch yet, which brings back the "2.1" behavior.=20


freundlich gr=FCsst,
kind regards,

_________________________ _________________________=20
_________________________ _________________________=20
_________________________ ________________=20
Arno Odermatt=20
Phone +41414454053=20
arno.odermatt@...1845...=20

Schindler Elevator Ltd. | Corporate Research & Development | CRD/CO-BAT=20
Zugerstr. 13 | CH-6030 Ebikon, Switzerland=20
http://www.schindler.com=20
_________________________ _________________________=20
_________________________ _________________________=20
_________________________ ________________=20
Please consider your environment.=20

Schindler supports sustainable urban development with
safe, reliable and ecologically sound mobility solutions.





From:        Gert Doering <gert@...1296...>=20
To:        Brad Zhang <hebei5000@...277...>,=20
Cc:        openvpn-devel@lists.sourceforge.net=20
Date:        23.10.2013 16:20=20
Subject:        Re: [Openvpn-devel] Does openvpn 2.3.2 has memory leak?=20



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
__________________ _________________________ ____
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel


******************************************************
Notice: The information contained in this message is intended only for use=
=20

of the individual(s) named above and may contain confidential, proprietary=
=20

or legally privileged information. No confidentiality or privilege is=20
waived or lost by any mistransmission. If you are not the intended=20
recipient of this message you are hereby notified that you must not use,=20
disseminate , copy it in any form or take any action in reliance of it. If=
=20

you have received this message in error please delete it and any copies of=
=20

it and notify the sender immediately.
*******************************************************
---------------------------------------------------------------------------=
---
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models.=20
Explore
techniques for threading, error checking, porting, and tuning. Get the=20
most=20
from the latest Intel processors and coprocessors. See abstracts and=20
register
http://pubads.g.doubleclick.net/gampad/clk?id=3D60136231&iu=3D/4140/ostg.cl=
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

--=_alternative 003625D8C1257C2B_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<font size=3D2 face=3D"sans-serif">Dear Gert, Brad all,</font>
<br>
<br><font size=3D2 face=3D"sans-serif">as I also had reported to have recog=
nized,
that memory was not freed, even though the openvpn disconnect-script was
disconnecting all of the 3400 Openvpn-sessions (pls see mail below).</font>
<br><font size=3D2 face=3D"sans-serif">Would you think, this is also improv=
ed
by the change from malloc to calloc, so we could update to 2.3.3 to improve
the memory-leak situation?</font>
<br>
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
&nbsp;</font><font size=3D1 face=3D"sans-serif">20.11.2013 19:33</font>
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
to bring this discussion to an end...<br>
<br>
On Thu, Nov 07, 2013 at 06:25:55PM +0800, Brad Zhang wrote:<br>
&gt; Thank you so much. I am testing Openvpn 2.3.2 with your patch memory
usage<br>
&gt; some days. Here is result:<br>
<br>
Thanks for the exhaustive tests. &nbsp;This is really good to see, and
it's<br>
impressive how much less memory PolarSSL need!<br>
<br>
The patch in question has been acked by David, has been pushed to git,<br>
and will be in 2.3.3 when we release that.<br>
<br>
[..]<br>
&gt; I noticed your mail said if clients are disconnected, the memory will
be<br>
&gt; free, but when I tested openvpn + polarssl (no your patch), the memory
did<br>
&gt; not free completely, for example:<br>
&gt; Openvpn 2.3.2 + Polarssl<br>
&gt; 62672 &nbsp;55m 1408 S &nbsp;0.0 &nbsp;2.8 &nbsp; 0:06.91 openvpn
&nbsp;(Have 200 connections)<br>
&gt; 37864 &nbsp;34m 1412 S &nbsp;0.0 &nbsp;1.7 &nbsp; 0:06.84 openvpn
&nbsp;(disconnect all connections)<br>
[..]<br>
&gt; It is odd that memory do not free completely because I saw all the
clients<br>
&gt; disconnect correctly from Openvpn server logs.<br>
&gt; I tried to disable the option &quot;persist-key&quot; and &quot;persis=
t-tun&quot;,
it did not<br>
&gt; make better when clients disconnected.<br>
<br>
Finding the reason for that is not trivial. &nbsp;What comes into play
here is<br>
how the &quot;malloc()&quot; and &quot;free()&quot; functions works on
that particular <br>
operating system - usually, not all malloc() requests fetch memory from
the<br>
kernel directly, but usually malloc() will request a larger block (with<br>
sbrk() or mmap()), and maintain that locally in the process, saving on
<br>
syscall overhead. &nbsp;free() will also work only locally first, and only
if<br>
the library decides &quot;it's worth returing something to the kernel&quot;
it will<br>
actually do so - so it's not unusual to never see memory usage actually<br>
go down if your library just keeps the memory chunks around...<br>
<br>
So it might be that in this case, there's a memory allocation right in<br>
the middle of a larger area which is still in use, so the larger area<br>
cannot be returned (but the memory might be re-used when the clients<br>
connect again, so is not &quot;lost&quot;) - but without very extensive
debugging,<br>
including fully understanding the way the local malloc()/free() <br>
implementations work, this is impossible to give a definite answer to.<br>
<br>
What we know, and this is good :-), is that openvpn *does* call free()<br>
on everything it allocates - this we can learn from valgrind, but it<br>
will only tell us how the situation is at program end, not how the<br>
memory layout looks like while it runs (I think it can be told to do<br>
so, but there are *many* short-lived malloc()/free() uses in OpenVPN,<br>
so looking at the log files would be a huge amount of work).<br>
<br>
Anyway. &nbsp;I think what we have is &quot;good enough&quot; given the
amount of<br>
work we can invest here, and that there are so many other areas where<br>
we need to fix bugs...<br>
<br>
Thanks for bringing this up, and making us reconsider the buffer changes<br>
we did in best faith :-)<br>
<br>
gert<br>
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
[attachment &quot;att77ku7.dat&quot; deleted by Arno Odermatt/R&amp;D/SCH/S=
CHINDLER]
---------------------------------------------------------------------------=
---<br>
Shape the Mobile Experience: Free Subscription<br>
Software experts and developers: Be at the forefront of tech innovation.<br>
Intel(R) Software Adrenaline delivers strategic insight and game-changing
<br>
conversations that shape the rapidly evolving mobile landscape. Sign up
now. <br>
</font></tt><a href=3D"http://pubads.g.doubleclick.net/gampad/clk?id=3D6343=
1311&amp;iu=3D/4140/ostg.clktrk"><tt><font size=3D2>http://pubads.g.doublec=
lick.net/gampad/clk?id=3D63431311&amp;iu=3D/4140/ostg.clktrk</font></tt></a=
><tt><font size=3D2>__________________
_________________________
____<br>
Openvpn-devel mailing list<br>
Openvpn-devel@lists.sourceforge.net<br>
</font></tt><a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn=
-devel"><tt><font size=3D2>https://lists.sourceforge.net/lists/listinfo/ope=
nvpn-devel</font></tt></a><tt><font size=3D2><br>
</font></tt>
<br><font size=3D1 color=3D#5f5f5f face=3D"Arial"><br>
</font><font size=3D1 color=3D#008000 face=3D"Arial"><br>
</font>
<br><font size=3D1 color=3D#800080 face=3D"sans-serif">----- Forwarded by A=
rno
Odermatt/R&amp;D/SCH/SCHINDLER on 22.11.2013 10:48 -----</font>
<br>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">From: &nbsp; &nbsp; =
&nbsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">arno.odermatt@...1845...</f=
ont>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">To: &nbsp; &nbsp; &n=
bsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">Gert Doering &lt;gert@...1711...=
96...&gt;,
</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Cc: &nbsp; &nbsp; &n=
bsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">openvpn-devel@...1535...=
orge.net</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Date: &nbsp; &nbsp; =
&nbsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">08.11.2013 11:56</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Subject: &nbsp; &nbs=
p;
&nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">Re: [Openvpn-devel]
Does openvpn 2.3.2 has memory leak?</font>
<br>
<hr noshade>
<br>
<br>
<br><font size=3D2 face=3D"sans-serif">Dear Gert,</font><font size=3D3> <br>
</font><font size=3D2 face=3D"sans-serif"><br>
after having been able to spend a smooth operating time of the around 3400
permanent connected O-VPN clients (after having attached memory in form
of a 10Gb swap partition), we just recognized a hickout, where all clients
got disconnected.</font><font size=3D3> <br>
</font><font size=3D2 face=3D"sans-serif"><br>
Unfortunately, after around 3270 disconnected clients, memory was'nt freed
at all:</font><font size=3D3><br>
</font><font size=3D2 face=3D"sans-serif"><br>
3270 /etc/openvpn/cgwvpn/persipoff</font><font size=3D3> </font><font size
=3D2 face=3D"sans-serif"><br>
</font><font size=3D2 face=3D"Calibri"><br>
top - 10:31:58 up 31 days, 20:10, &nbsp;2 users, &nbsp;load average: 0.78,
0.70, 0.69</font><font size=3D3> </font><font size=3D2 face=3D"Calibri"><br>
Tasks: &nbsp;71 total, &nbsp; 2 running, &nbsp;69 sleeping, &nbsp; 0 stoppe=
d,
&nbsp; 0 zombie</font><font size=3D3> </font>
<p><font size=3D2 face=3D"Calibri">Cpu(s): &nbsp;0.3%us, 23.2%sy, &nbsp;0.0=
%ni,
50.0%id, &nbsp;0.0%wa, 14.4%hi, &nbsp;0.0%si, 12.0%st</font><font size=3D3>
</font>
<p><font size=3D2 face=3D"Calibri">Mem: &nbsp; 7629920k total, &nbsp;507357=
6k
used, &nbsp;2556344k free, &nbsp; 159504k buffers</font><font size=3D3> </f=
ont>
<p><font size=3D2 face=3D"Calibri">Swap: 10485756k total, &nbsp; &nbsp; &nb=
sp;
&nbsp;0k used, 10485756k free, &nbsp; 192536k cached</font><font size=3D3>
</font>
<p><font size=3D2 face=3D"Calibri">PID USER &nbsp; &nbsp; &nbsp; &nbsp; &nb=
sp;PR
&nbsp;NI &nbsp;VIRT &nbsp; &nbsp; &nbsp;RES &nbsp; &nbsp; SHR &nbsp; &nbsp;
&nbsp;S &nbsp; &nbsp; &nbsp;%CPU &nbsp; &nbsp; %MEM &nbsp; &nbsp;TIME+
&nbsp; &nbsp; &nbsp; COMMAND</font><font size=3D3> </font>
<p><font size=3D2 face=3D"Calibri">22810 root &nbsp; &nbsp; &nbsp;20 &nbsp;
0 &nbsp; &nbsp; </font><font size=3D2 color=3Dred face=3D"Calibri"><b>4481m=
</b></font><font size=3D2 face=3D"Calibri">
&nbsp; </font><font size=3D2 color=3Dred face=3D"Calibri"><b>4.2g</b></font=
><font size=3D2 face=3D"Calibri">
&nbsp; &nbsp;1996 &nbsp; S &nbsp; &nbsp; &nbsp;62.5 &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;58.1 &nbsp; &nbsp; &nbsp; 5102:38 &nbsp; &nbsp; &nbsp;o=
penvpn</font><font size=3D3>
</font>
<p><font size=3D2 face=3D"Calibri">12619 root &nbsp; &nbsp; &nbsp;20 &nbsp;
0 &nbsp; &nbsp; &nbsp; 8 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 4 &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; 0 &nbsp; &nbsp; &nbsp; &nbsp;R &nbsp; &nbsp;
&nbsp;3.0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0.0 &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;0:00.09 &nbsp; &nbsp; &nbsp;openvpn</font><font size=3D=
3>
</font>
<p><font size=3D2 face=3D"Calibri">12222 root &nbsp; &nbsp; &nbsp;20 &nbsp;
0 &nbsp; &nbsp;15228 &nbsp; 1216 &nbsp; &nbsp;932 &nbsp; &nbsp; &nbsp;
R &nbsp;0.3 &nbsp;0.0 &nbsp; 0:00.02 top<br>
<br>
Unfortunately, this is not something, we had expected.</font><font size=3D3>
</font>
<p><font size=3D2 face=3D"Calibri">We have not applied the patch yet, which
brings back the &quot;2.1&quot; behavior.</font><font size=3D3> </font>
<p><font size=3D2 face=3D"sans-serif"><br>
<br>
freundlich gr=FCsst,<br>
kind regards,</font><font size=3D1 face=3D"Arial"><br>
<br>
_________________________ _________________________ _______________________=
__
_________________________ _________________________ ________________ </font=
><font size=3D2 face=3D"sans-serif"><br>
Arno Odermatt <br>
Phone +41414454053 <br>
arno.odermatt@...1845... <br>
<br>
Schindler Elevator Ltd. | Corporate Research &amp; Development | CRD/CO-BAT
<br>
Zugerstr. 13 | CH-6030 Ebikon, Switzerland </font><font size=3D3 color=3Dbl=
ue><u><br>
</u></font><a href=3Dhttp://www.schindler.com/><font size=3D2 color=3Dblue =
face=3D"sans-serif"><u>http://www.schindler.com</u></font></a><font size=3D=
2 face=3D"sans-serif">
</font><font size=3D1 face=3D"Arial"><br>
_________________________ _________________________ _______________________=
__
_________________________ _________________________ ________________ </font=
><font size=3D1 color=3D#008000 face=3D"Arial"><br>
Please consider your environment. </font><font size=3D1 color=3D#5f5f5f fac=
e=3D"Arial"><br>
<br>
Schindler supports sustainable urban development with<br>
safe, reliable and ecologically sound mobility solutions.</font><font size
=3D1 color=3D#008000 face=3D"Arial"><br>
</font><font size=3D3><br>
<br>
<br>
<br>
</font><font size=3D1 color=3D#5f5f5f face=3D"sans-serif"><br>
From: &nbsp; &nbsp; &nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">=
Gert
Doering &lt;gert@...1296...&gt;</font><font size=3D3> </font><font size
=3D1 color=3D#5f5f5f face=3D"sans-serif"><br>
To: &nbsp; &nbsp; &nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">Br=
ad
Zhang &lt;hebei5000@...277...&gt;, </font><font size=3D1 color=3D#5f5f5f fa=
ce=3D"sans-serif"><br>
Cc: &nbsp; &nbsp; &nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">op=
envpn-devel@lists.sourceforge.net</font><font size=3D3>
</font><font size=3D1 color=3D#5f5f5f face=3D"sans-serif"><br>
Date: &nbsp; &nbsp; &nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">=
23.10.2013
16:20</font><font size=3D3> </font><font size=3D1 color=3D#5f5f5f face=3D"s=
ans-serif"><br>
Subject: &nbsp; &nbsp; &nbsp; &nbsp;</font><font size=3D1 face=3D"sans-seri=
f">Re:
[Openvpn-devel] Does openvpn 2.3.2 has memory leak?</font><font size=3D3>
<br>
</font>
<hr noshade><font size=3D3><br>
<br>
</font><tt><font size=3D2><br>
Hi,<br>
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
 &nbsp;be expected, because the new keying material needs extra memory,
and<br>
 &nbsp;the memory for the old key is not released right away (it seems
to be<br>
 &nbsp;released at the next renegotiation, or at client disconnect - I've
<br>
 &nbsp;seen VSZ/RSS go down(!) when clients disconnect, so that seems to<br>
 &nbsp;work right). &nbsp;This is the &quot;big&quot; jump in memory consum=
ption
which is<br>
 &nbsp;actually killing Arno's setup, because there is not enough virtual<b=
r>
 &nbsp;memory available to hold all that is needed for 3000 clients (but<br>
 &nbsp;that can be fixed by increasing max-memory limits if there is enough
<br>
 &nbsp;RAM).<br>
<br>
- each further renegotiation leaks &quot;a few kbyte&quot; of memory per
client,<br>
 &nbsp;which should also be fully returned when the client disconnects
- this<br>
 &nbsp;is the issue I discovered earlier, with the GC handling of the per-c=
lient<br>
 &nbsp;environment set, and I'll send a patch for that &quot;soon&quot;
(as soon as I<br>
 &nbsp;have fully understood the code involved).<br>
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
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;//www.muc.de/~gert/<=
br>
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
&gt;</font></tt><font size=3D3 color=3Dblue><u><br>
</u></font><a href=3D"http://pubads.g.doubleclick.net/gampad/clk?id=3D60135=
991&amp;iu=3D/4140/ostg.clktrk"><tt><font size=3D2 color=3Dblue><u>http://p=
ubads.g.doubleclick.net/gampad/clk?id=3D60135991&amp;iu=3D/4140/ostg.clktrk=
</u></font></tt></a><tt><font size=3D2>____________
______
_________________________ ____<br>
Openvpn-devel mailing list<br>
Openvpn-devel@lists.sourceforge.net</font></tt><font size=3D3 color=3Dblue>=
<u><br>
</u></font><a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-=
devel"><tt><font size=3D2 color=3Dblue><u>https://lists.sourceforge.net/lis=
ts/listinfo/openvpn-devel</u></font></tt></a><font size=3D3><br>
<br>
<br>
******************************************************<br>
Notice: The information contained in this message is intended only for
use of the individual(s) named above and may contain confidential, propriet=
ary
or legally privileged information. No confidentiality or privilege is waived
or lost by any mistransmission. If you are not the intended recipient of
this message you are hereby notified that you must not use, disseminate
, copy it in any form or take any action in reliance of it. If you have
received this message in error please delete it and any copies of it and
notify the sender immediately.<br>
*******************************************************</font><tt><font siz=
e=3D2>---------------------------------------------------------------------=
---------<br>
November Webinars for C, C++, Fortran Developers<br>
Accelerate application performance with scalable programming models. Explor=
e<br>
techniques for threading, error checking, porting, and tuning. Get the
most <br>
from the latest Intel processors and coprocessors. See abstracts and regist=
er<br>
</font></tt><a href=3D"http://pubads.g.doubleclick.net/gampad/clk?id=3D6013=
6231&amp;iu=3D/4140/ostg.clktrk"><tt><font size=3D2>http://pubads.g.doublec=
lick.net/gampad/clk?id=3D60136231&amp;iu=3D/4140/ostg.clktrk</font></tt></a=
><tt><font size=3D2>__________________
_________________________
____<br>
Openvpn-devel mailing list<br>
Openvpn-devel@lists.sourceforge.net<br>
</font></tt><a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn=
-devel"><tt><font size=3D2>https://lists.sourceforge.net/lists/listinfo/ope=
nvpn-devel</font></tt></a><tt><font size=3D2><br>
</font></tt><br clear=3D"both">
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

--=_alternative 003625D8C1257C2B_=--

