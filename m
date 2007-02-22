MIME-Version: 1.0
From: Deon George <dgeorge@...1003...>
Message-ID: <OF25FB7300.F6EEDD7F-ONCA25728A.0017516A-CA25728A.0023B6DE@...1003...>
Date: Thu, 22 Feb 2007 17:30:06 +1100
Content-Type: multipart/alternative;
	boundary="=_alternative 0023B699CA25728A_="
Subject: [Openvpn-devel] RHEL5 openvpn performance issues.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multipart message in MIME format.
--=_alternative 0023B699CA25728A_=
Content-Type: text/plain; charset="US-ASCII"

Hey Gang,

I've just installed a RHEL5 based desktop (based on beta2) and got hold of 
openvpn and lzo2 from dag wieers.

My initial install of openvpn (2.0.9), shows connectivity without any 
problems (as I have been previously using with a RHEL4 based desktop), 
however very bad network performance.

So I recompiled everything (using the src.rpms on dag wieers site) and 
still the same problem.

I've confirmed its not my laptop, but using my compiled RPMs on a 
completely differnet laptop (still using the RHEL5 based desktop).

If I go back to my RHEL4 based laptop, everything performs quite well.

My quick analysis of the performance using ping shows that an idle OpenVPN 
link having a ping response time of a few milliseconds, however, when I 
connect to a webserver on the other side of the link, the ping response 
time increases to over 3000 ms - and making everything from the remote 
network painfully slow.

Anybody got any ideas why it might be this way? (Its unusable).

...deon
---
Deon George, Tivoli Storage Technical Pre-Sales Specialist, IBM Australia
Office: +61 3 9626 6058, Fax: +61 3 9626 6622, Mobile: +61 412 366 816
VOIP: +61 2 8852 3469
mailto:dgeorge@...1003..., http://ibm.com/tivoli
--=_alternative 0023B699CA25728A_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hey Gang,</font>
<br>
<br><font size=2 face="sans-serif">I've just installed a RHEL5 based desktop
(based on beta2) and got hold of openvpn and lzo2 from dag wieers.</font>
<br>
<br><font size=2 face="sans-serif">My initial install of openvpn (2.0.9),
shows connectivity without any problems (as I have been previously using
with a RHEL4 based desktop), however very bad network performance.</font>
<br>
<br><font size=2 face="sans-serif">So I recompiled everything (using the
src.rpms on dag wieers site) and still the same problem.</font>
<br>
<br><font size=2 face="sans-serif">I've confirmed its not my laptop, but
using my compiled RPMs on a completely differnet laptop (still using the
RHEL5 based desktop).</font>
<br>
<br><font size=2 face="sans-serif">If I go back to my RHEL4 based laptop,
everything performs quite well.</font>
<br>
<br><font size=2 face="sans-serif">My quick analysis of the performance
using ping shows that an idle OpenVPN link having a ping response time
of a few milliseconds, however, when I connect to a webserver on the other
side of the link, the ping response time increases to over 3000 ms - and
making everything from the remote network painfully slow.</font>
<br>
<br><font size=2 face="sans-serif">Anybody got any ideas why it might be
this way? (Its unusable).</font>
<br>
<br><font size=2 face="sans-serif">...deon<br>
---<br>
Deon George, Tivoli Storage Technical Pre-Sales Specialist, IBM Australia<br>
Office: +61 3 9626 6058, Fax: +61 3 9626 6622, Mobile: +61 412 366 816<br>
VOIP: +61 2 8852 3469<br>
mailto:dgeorge@...1003..., http://ibm.com/tivoli</font>
--=_alternative 0023B699CA25728A_=--

