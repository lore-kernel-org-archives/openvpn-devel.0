In-Reply-To: <20131022114017.GD161@...1296...>
References: <OF80C424FD.27405071-ONC1257C07.004692C7-C1257C07.004BC866@...1846...>
	<20131017141929.GC161@...1296...>
	<OF103608A1.B8847B78-ONC1257C0B.002E1D46-C1257C0B.002F1965@...1846...>
	<20131022114017.GD161@...1296...>
MIME-Version: 1.0
From: arno.odermatt@...1845...
Message-ID: <OFBB1A3798.4E8F6223-ONC1257C0C.00463442-C1257C0C.0048EC64@...1846...>
Date: Tue, 22 Oct 2013 15:16:30 +0200
Content-Type: multipart/alternative;
	boundary="=_alternative 0048EBA0C1257C0C_="
Subject: Re: [Openvpn-devel] Openvpn 2.3.2 potential memory-leak after
	24hours (addendum3)
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
--=_alternative 0048EBA0C1257C0C_=
Content-Type: text/plain; charset="US-ASCII"

Dear Gert,


thank you so much.
Meanwhile, we can define the substantial memory growth for the phase of 
the first renegotiation cycle.
Memory is growing by almost double.
Surely, if one had only 50 to 100 concurrent sessions, it is not quit 
hurting anything. But driving the amount of concurrent session as we got 
it in our scenario, memory treatment seems to become key.


kind regards,

_____________________________________________________________________________________________________________________________________________ 

Arno 




From:   Gert Doering <gert@...1296...>
To:     arno.odermatt@...1845..., 
Cc:     Gert Doering <gert@...1296...>, 
openvpn-devel@lists.sourceforge.net
Date:   22.10.2013 13:43
Subject:        Re: Openvpn 2.3.2 potential memory-leak after 24hours 
(addendum3)



Hi,

On Mon, Oct 21, 2013 at 10:34:27AM +0200, arno.odermatt@...1845... 
wrote:
> thank you for replying.
> Do you see any time window, you potentially could have time for this?

I just gave it an initial try (using the "master" branch but that code
should have the same issues, if any, as no (known) fixes have been 
commited).

Valgrind isn't telling me about any clear mem-leaks yet...

==1953== HEAP SUMMARY:
==1953==     in use at exit: 2,560 bytes in 52 blocks
==1953==   total heap usage: 52,139 allocs, 52,087 frees, 15,723,723 bytes 
allocated

... but I could see memory go up in "while sleep 1; do ps wwup 1953 ; 
done" 
listings at exactly the point in time where renegotiation was taking 
place,
with two clients connected to it.

I could use some ideas on how to debug this further - if valgrind isn't
complaining, normally our memory management should be OK, but why is
VSZ/RSZ still growing, then...?

gert
-- 
USENET is *not* the non-clickable part of WWW!
 //www.muc.de/~gert/
Gert Doering - Munich, Germany gert@...1296...
fax: +49-89-35655025 gert@...1297...
[attachment "attmxcg3.dat" deleted by Arno Odermatt/R&D/SCH/SCHINDLER] 


******************************************************
Notice: The information contained in this message is intended only for use of the individual(s) named above and may contain confidential, proprietary or legally privileged information. No confidentiality or privilege is waived or lost by any mistransmission. If you are not the intended recipient of this message you are hereby notified that you must not use, disseminate , copy it in any form or take any action in reliance of it. If you have received this message in error please delete it and any copies of it and notify the sender immediately.
*******************************************************
--=_alternative 0048EBA0C1257C0C_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Dear Gert,</font>
<br>
<br>
<br><font size=2 face="sans-serif">thank you so much.</font>
<br><font size=2 face="sans-serif">Meanwhile, we can define the substantial
memory growth for the phase of the first renegotiation cycle.</font>
<br><font size=2 face="sans-serif">Memory is growing by almost double.</font>
<br><font size=2 face="sans-serif">Surely, if one had only 50 to 100 concurrent
sessions, it is not quit hurting anything. But driving the amount of concurrent
session as we got it in our scenario, memory treatment seems to become
key.<br>
<br>
<br>
kind regards,<br>
</font><font size=1 face="Arial"><br>
_____________________________________________________________________________________________________________________________________________
</font><font size=2 face="sans-serif"><br>
Arno </font><font size=1 color=#008000 face="Arial"><br>
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
openvpn-devel@lists.sourceforge.net</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">22.10.2013 13:43</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: Openvpn
2.3.2 potential memory-leak after 24hours (addendum3)</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=2>Hi,<br>
<br>
On Mon, Oct 21, 2013 at 10:34:27AM +0200, arno.odermatt@...1845...
wrote:<br>
&gt; thank you for replying.<br>
&gt; Do you see any time window, you potentially could have time for this?<br>
<br>
I just gave it an initial try (using the &quot;master&quot; branch but
that code<br>
should have the same issues, if any, as no (known) fixes have been commited).<br>
<br>
Valgrind isn't telling me about any clear mem-leaks yet...<br>
<br>
==1953== HEAP SUMMARY:<br>
==1953== &nbsp; &nbsp; in use at exit: 2,560 bytes in 52 blocks<br>
==1953== &nbsp; total heap usage: 52,139 allocs, 52,087 frees, 15,723,723
bytes allocated<br>
<br>
... but I could see memory go up in &quot;while sleep 1; do ps wwup 1953
; done&quot; <br>
listings at exactly the point in time where renegotiation was taking place,<br>
with two clients connected to it.<br>
<br>
I could use some ideas on how to debug this further - if valgrind isn't<br>
complaining, normally our memory management should be OK, but why is<br>
VSZ/RSZ still growing, then...?<br>
<br>
gert<br>
-- <br>
USENET is *not* the non-clickable part of WWW!<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; //www.muc.de/~gert/<br>
Gert Doering - Munich, Germany &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; gert@...1296...<br>
fax: +49-89-35655025 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;gert@...1297...<br>
[attachment &quot;attmxcg3.dat&quot; deleted by Arno Odermatt/R&amp;D/SCH/SCHINDLER]
</font></tt>
<br>
<br clear="both">
******************************************************<BR>
Notice: The information contained in this message is intended only for use of the individual(s) named above and may contain confidential, proprietary or legally privileged information. No confidentiality or privilege is waived or lost by any mistransmission. If you are not the intended recipient of this message you are hereby notified that you must not use, disseminate , copy it in any form or take any action in reliance of it. If you have received this message in error please delete it and any copies of it and notify the sender immediately.<BR>
*******************************************************<BR>

--=_alternative 0048EBA0C1257C0C_=--

