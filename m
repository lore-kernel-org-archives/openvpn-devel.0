In-Reply-To: <20140724181032.GX1118@...1296...>
References: <OF80C424FD.27405071-ONC1257C07.004692C7-C1257C07.004BC7CB@...1923...>
	<OFF4D01B5D.C068F160-ONC1257D1D.0055C3F1-C1257D1D.005A2BE1@...1846...>
	<9998AE72-2992-4D02-8E27-BE9A55BDBDF6@...1286...>
	<20140722193436.GI1118@...1296...>
	<OF0A6F87B6.7643FAD4-ONC1257D1E.00208574-C1257D1E.0022B4AF@...1846...>
	<53D02C7F.10900@...1147...> <20140724140845.GT1118@...1296...>
	<OF5C660519.1F3B315A-ONC1257D1F.004F8E28-C1257D1F.005477F1@...1846...>
	<20140724181032.GX1118@...1296...>
MIME-Version: 1.0
From: arno.odermatt@...1845...
Message-ID: <OFEE52CA7B.0B454DC4-ONC1257D20.003B627E-C1257D20.003C5BBD@...1846...>
Date: Fri, 25 Jul 2014 12:59:15 +0200
Content-Type: multipart/alternative;
	boundary="=_alternative 003C5B6AC1257D20_="
Subject: Re: [Openvpn-devel] Openvpn 2.3.2: "Could not create temporary
 file" ....Too many open files
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
--=_alternative 003C5B6AC1257D20_=
Content-Type: text/plain; charset="US-ASCII"

Dear Gert,

thx.
We also studied the situation from point of view of usage of resources. We 
beliefe, not to have run into a real resource problem, since we are far 
away fromthe different max-values, such as eg. max open files, max 
file-descriptor, max i-nodes per partition.
We still can not imagine, why we saw "TOO MAN Y OPEN..." and what was the 
root cause.

Anyway, pls find below the result of   "$ ulimit -a" of that machine 3 
OpenVpn Processes are running on, whereas there is no "nofile" -line to 
find:

- 

172-16-128-100 ~]$ ulimit -a
core file size          (blocks, -c) 0
data seg size           (kbytes, -d) unlimited
scheduling priority             (-e) 0
file size               (blocks, -f) unlimited
pending signals                 (-i) 29678
max locked memory       (kbytes, -l) 64
max memory size         (kbytes, -m) unlimited
open files                      (-n) 655350
pipe size            (512 bytes, -p) 8
POSIX message queues     (bytes, -q) 819200
real-time priority              (-r) 0
stack size              (kbytes, -s) 8192
cpu time               (seconds, -t) unlimited
max user processes              (-u) 1024
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimited

Normally, this value might be read out by using: 

less /proc/sys/fs/file-max      1527073         # Defintion of max open 
files 
less  /proc/sys/fs/file-nr                       3680    0       1527073  
# Read out value of current situation

We are unsure, if a file would be locked and O-VPN would try to write to 
it, whether in this situation we also would see as well " TOO MAN Y 
OPEN..."     ???

regards

Arno






From:   Gert Doering <gert@...1296...>
To:     arno.odermatt@...1845..., 
Cc:     Gert Doering <gert@...1296...>, Eric Crist 
<ecrist@...1286...>, Jan Just Keijser <janjust@...1147...>, 
openvpn-devel@lists.sourceforge.net
Date:   24.07.2014 20:13
Subject:        Re: [Openvpn-devel] Openvpn 2.3.2: "Could not create 
temporary file" ....Too many open files



Hi,

On Thu, Jul 24, 2014 at 05:22:37PM +0200, arno.odermatt@...1845... 
wrote:
> I did the first part:
> 
> NO, we are not using any Plugins, only client -connects scripts

Mmmh, ok.

> lsof -n | wc -l           4405 

That doesn't tell much, except "the total number of open files in
the system is 4405".

> lsof -p 25211 > openvpn1.txt
> lsof -p 25232 > openvpn2.txt
> lsof -p 25252 > openvpn3.txt
> 
> It looks like, we got much more then just some lines:
> 
> openvpn3.txt    openvpn2.txt    openvpn1.txt

If you look at the files (in attachment), you'll see that the large bulk
of it is "TCP" - so your openvpn processes are using up the amount of file
descriptors the system is willing to give them for TCP connects, as every
TCP client needs to have it's own socket.

If you run "ulimit -a" from the same environment where you start the
OpenVPN processes, you'll see a line that looks like this:

$ ulimit -a
...
nofile                         (-n)  1024

that's the maximum number of file descriptors - subtract some 20-odd,
and you have ~1000 left for about 1000 clients.

$ ulimit -n 2000

can usually be used to raise that limit to 2000 (if run as root, in the 
same shell that starts openvpn later)...  I'm not a Fedora expert, so 
maybe they have some other limitations, or ways to control the limits.

gert


-- 
USENET is *not* the non-clickable part of WWW!
 //www.muc.de/~gert/
Gert Doering - Munich, Germany gert@...1296...
fax: +49-89-35655025 gert@...1297...
[attachment "attpc7ko.dat" deleted by Arno Odermatt/R&D/SCH/SCHINDLER] 


******************************************************
Notice: The information contained in this message is intended only for use of the individual(s) named above and may contain confidential, proprietary or legally privileged information. No confidentiality or privilege is waived or lost by any mistransmission. If you are not the intended recipient of this message you are hereby notified that you must not use, disseminate , copy it in any form or take any action in reliance of it. If you have received this message in error please delete it and any copies of it and notify the sender immediately.
*******************************************************
--=_alternative 003C5B6AC1257D20_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Dear Gert,</font>
<br>
<br><font size=2 face="sans-serif">thx.</font>
<br><font size=2 face="sans-serif">We also studied the situation from point
of view of usage of resources. We beliefe, not to have run into a real
resource problem, since we are far away fromthe different max-values, such
as eg. max open files, max file-descriptor, max i-nodes per partition.</font>
<br><font size=2 face="sans-serif">We still can not imagine, why we saw
&quot;TOO MAN Y OPEN...&quot; and what was the root cause.</font>
<br>
<br><font size=2 face="sans-serif">Anyway, pls find below the result of
</font><tt><font size=2>&nbsp; &quot;$ ulimit -a&quot; </font></tt><font size=2 face="sans-serif">of
that machine 3 OpenVpn Processes are running on, whereas there is no &quot;nofile&quot;
-line to find:<br>
<br>
- </font>
<br>
<br><font size=2 face="sans-serif">172-16-128-100 ~]$ ulimit -a</font>
<br><font size=2 face="sans-serif">core file size &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;(blocks, -c) 0</font>
<br><font size=2 face="sans-serif">data seg size &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; (kbytes, -d) unlimited</font>
<br><font size=2 face="sans-serif">scheduling priority &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; (-e) 0</font>
<br><font size=2 face="sans-serif">file size &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; (blocks, -f) unlimited</font>
<br><font size=2 face="sans-serif">pending signals &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (-i) 29678</font>
<br><font size=2 face="sans-serif">max locked memory &nbsp; &nbsp; &nbsp;
(kbytes, -l) 64</font>
<br><font size=2 face="sans-serif">max memory size &nbsp; &nbsp; &nbsp;
&nbsp; (kbytes, -m) unlimited</font>
<br><font size=2 face="sans-serif">open files &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(-n) 655350</font>
<br><font size=2 face="sans-serif">pipe size &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;(512 bytes, -p) 8</font>
<br><font size=2 face="sans-serif">POSIX message queues &nbsp; &nbsp; (bytes,
-q) 819200</font>
<br><font size=2 face="sans-serif">real-time priority &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;(-r) 0</font>
<br><font size=2 face="sans-serif">stack size &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;(kbytes, -s) 8192</font>
<br><font size=2 face="sans-serif">cpu time &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; (seconds, -t) unlimited</font>
<br><font size=2 face="sans-serif">max user processes &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;(-u) 1024</font>
<br><font size=2 face="sans-serif">virtual memory &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;(kbytes, -v) unlimited</font>
<br><font size=2 face="sans-serif">file locks &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(-x) unlimited</font>
<br>
<br><font size=2 face="sans-serif">Normally, this value might be read out
by using: <br>
<br>
less /proc/sys/fs/file-max &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;1527073 &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;# Defintion
of max open files &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;<br>
less &nbsp;/proc/sys/fs/file-nr &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;3680
&nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp; 1527073 &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;# Read out value of current situation</font>
<br><font size=2 face="sans-serif"><br>
We are unsure, if a file would be locked and O-VPN would try to write to
it, whether in this situation we also would see as well &quot; TOO MAN
Y OPEN...&quot; &nbsp; &nbsp; ???<br>
<br>
regards<br>
<br>
Arno</font><font size=1 face="Arial"><br>
</font><font size=1 color=#5f5f5f face="Arial"><br>
</font><font size=1 color=#008000 face="Arial"><br>
</font>
<br>
<br>
<br>
<br><font size=1 color=#5f5f5f face="sans-serif">From: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Gert Doering &lt;gert@...1296...&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">To: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">arno.odermatt@...1845...,
</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Cc: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Gert Doering &lt;gert@...1296...&gt;,
Eric Crist &lt;ecrist@...1286...&gt;, Jan Just Keijser &lt;janjust@...1147...&gt;,
openvpn-devel@lists.sourceforge.net</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">24.07.2014 20:13</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [Openvpn-devel]
Openvpn 2.3.2: &quot;Could not create temporary file&quot; ....Too many
open files</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=2>Hi,<br>
<br>
On Thu, Jul 24, 2014 at 05:22:37PM +0200, arno.odermatt@...1845...
wrote:<br>
&gt; I did the first part:<br>
&gt; <br>
&gt; NO, we are not using any Plugins, only client -connects scripts<br>
<br>
Mmmh, ok.<br>
<br>
&gt; lsof -n | wc -l &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 4405 <br>
<br>
That doesn't tell much, except &quot;the total number of open files in<br>
the system is 4405&quot;.<br>
<br>
&gt; lsof -p 25211 &gt; openvpn1.txt<br>
&gt; lsof -p 25232 &gt; openvpn2.txt<br>
&gt; lsof -p 25252 &gt; openvpn3.txt<br>
&gt; <br>
&gt; It looks like, we got much more then just some lines:<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<br>
&gt; openvpn3.txt &nbsp; &nbsp;openvpn2.txt &nbsp; &nbsp;openvpn1.txt<br>
<br>
If you look at the files (in attachment), you'll see that the large bulk<br>
of it is &quot;TCP&quot; - so your openvpn processes are using up the amount
of file<br>
descriptors the system is willing to give them for TCP connects, as every<br>
TCP client needs to have it's own socket.<br>
<br>
If you run &quot;ulimit -a&quot; from the same environment where you start
the<br>
OpenVPN processes, you'll see a line that looks like this:<br>
<br>
$ ulimit -a<br>
...<br>
nofile &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; (-n) &nbsp;1024<br>
<br>
that's the maximum number of file descriptors - subtract some 20-odd,<br>
and you have ~1000 left for about 1000 clients.<br>
<br>
$ ulimit -n 2000<br>
<br>
can usually be used to raise that limit to 2000 (if run as root, in the
<br>
same shell that starts openvpn later)... &nbsp;I'm not a Fedora expert,
so <br>
maybe they have some other limitations, or ways to control the limits.<br>
<br>
gert<br>
<br>
<br>
-- <br>
USENET is *not* the non-clickable part of WWW!<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; //www.muc.de/~gert/<br>
Gert Doering - Munich, Germany &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; gert@...1296...<br>
fax: +49-89-35655025 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;gert@...1297...<br>
[attachment &quot;attpc7ko.dat&quot; deleted by Arno Odermatt/R&amp;D/SCH/SCHINDLER]
</font></tt>
<br>
<br clear="both">
******************************************************<BR>
Notice: The information contained in this message is intended only for use of the individual(s) named above and may contain confidential, proprietary or legally privileged information. No confidentiality or privilege is waived or lost by any mistransmission. If you are not the intended recipient of this message you are hereby notified that you must not use, disseminate , copy it in any form or take any action in reliance of it. If you have received this message in error please delete it and any copies of it and notify the sender immediately.<BR>
*******************************************************<BR>

--=_alternative 003C5B6AC1257D20_=--

