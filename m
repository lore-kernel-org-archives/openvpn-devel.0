In-Reply-To: <20131017141929.GC161@...1296...>
References: <OF80C424FD.27405071-ONC1257C07.004692C7-C1257C07.004BC866@...1846...>
	<20131017141929.GC161@...1296...>
MIME-Version: 1.0
From: arno.odermatt@...1845...
Message-ID: <OF103608A1.B8847B78-ONC1257C0B.002E1D46-C1257C0B.002F1965@...1846...>
Date: Mon, 21 Oct 2013 10:34:27 +0200
Content-Type: multipart/alternative;
	boundary="=_alternative 002F18A2C1257C0B_="
Subject: [Openvpn-devel] Openvpn 2.3.2 potential memory-leak after 24hours
	(addendum3)
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
--=_alternative 002F18A2C1257C0B_=
Content-Type: text/plain; charset="US-ASCII"

Good Morning,

thank you for replying.
Do you see any time window, you potentially could have time for this?

Meanwhile, we have been able to rise the memory limits of the system be 
adding to  /etc/sysctl.conf:
   "vm.overcommit_ratio = 80"
   "vm.overcommit_memory = 2"

and by adding "virtual memory" by increasing the amount of swap space.

Using this setup, we now were able to successfully walk through the first 
re-negotiation cycle, which really seems to double memory consumption, 
which never is being freed, after the re-neg process is completed.


 regards,

Arno






From:   Gert Doering <gert@...1296...>
To:     arno.odermatt@...1845..., 
Cc:     openvpn-devel@lists.sourceforge.net
Date:   17.10.2013 16:19
Subject:        Re: [Openvpn-devel] Openvpn 2.3.2 potential memory-leak 
after 24hours (addendum2)



Hi,

On Thu, Oct 17, 2013 at 03:47:44PM +0200, arno.odermatt@...1845... 
wrote:
> Pls. can anyone provide me with a response, whether this mailing list is 

> the right place to deal with this kind of problem?

It is the right place to deal with this kind of problems.

The problem is that nobody seems to have time to start debugging this 
into more detail yet.  What I'd try (if I had time) is to compile 
OpenVPN with valgrind (a memory leak searching tool), run it through
a few client key renegotiations, and then check the output to see
whether it shows anything "obvious".

In any case, thanks for tracing this so far and making it clear to us
that we have an issue there.  Even if it looks like nobody is caring.

gert

-- 
USENET is *not* the non-clickable part of WWW!
 //www.muc.de/~gert/
Gert Doering - Munich, Germany gert@...1296...
fax: +49-89-35655025 gert@...1297...



******************************************************
Notice: The information contained in this message is intended only for use of the individual(s) named above and may contain confidential, proprietary or legally privileged information. No confidentiality or privilege is waived or lost by any mistransmission. If you are not the intended recipient of this message you are hereby notified that you must not use, disseminate , copy it in any form or take any action in reliance of it. If you have received this message in error please delete it and any copies of it and notify the sender immediately.
*******************************************************
--=_alternative 002F18A2C1257C0B_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Good Morning,</font>
<br>
<br><font size=2 face="sans-serif">thank you for replying.</font>
<br><font size=2 face="sans-serif">Do you see any time window, you potentially
could have time for this?<br>
<br>
Meanwhile, we have been able to rise the memory limits of the system be
adding to &nbsp;/etc/sysctl.conf:<br>
 &nbsp; &quot;vm.overcommit_ratio = 80&quot;<br>
 &nbsp; &quot;vm.overcommit_memory = 2&quot;<br>
<br>
and by adding &quot;virtual memory&quot; by increasing the amount of swap
space.<br>
<br>
Using this setup, we now were able to successfully walk through the first
re-negotiation cycle, which really seems to double memory consumption,
which never is being freed, after the re-neg process is completed.<br>
</font>
<br><font size=2 face="sans-serif"><br>
 regards,</font>
<br>
<br><font size=2 face="sans-serif">Arno<br>
</font><font size=1 face="Arial"><br>
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
&nbsp;</font><font size=1 face="sans-serif">openvpn-devel@lists.sourceforge.net</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">17.10.2013 16:19</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">Re: [Openvpn-devel]
Openvpn 2.3.2 potential memory-leak after 24hours (addendum2)</font>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=2>Hi,<br>
<br>
On Thu, Oct 17, 2013 at 03:47:44PM +0200, arno.odermatt@...1845...
wrote:<br>
&gt; Pls. can anyone provide me with a response, whether this mailing list
is <br>
&gt; the right place to deal with this kind of problem?<br>
<br>
It is the right place to deal with this kind of problems.<br>
<br>
The problem is that nobody seems to have time to start debugging this <br>
into more detail yet. &nbsp;What I'd try (if I had time) is to compile
<br>
OpenVPN with valgrind (a memory leak searching tool), run it through<br>
a few client key renegotiations, and then check the output to see<br>
whether it shows anything &quot;obvious&quot;.<br>
<br>
In any case, thanks for tracing this so far and making it clear to us<br>
that we have an issue there. &nbsp;Even if it looks like nobody is caring.<br>
<br>
gert<br>
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
</font></tt>
<br>
<br clear="both">
******************************************************<BR>
Notice: The information contained in this message is intended only for use of the individual(s) named above and may contain confidential, proprietary or legally privileged information. No confidentiality or privilege is waived or lost by any mistransmission. If you are not the intended recipient of this message you are hereby notified that you must not use, disseminate , copy it in any form or take any action in reliance of it. If you have received this message in error please delete it and any copies of it and notify the sender immediately.<BR>
*******************************************************<BR>

--=_alternative 002F18A2C1257C0B_=--

