In-Reply-To: <OF80C424FD.27405071-ONC1257C07.004692C7-C1257C07.004BC7CB@...1923...>
References: <OF80C424FD.27405071-ONC1257C07.004692C7-C1257C07.004BC7CB@...1923...>
MIME-Version: 1.0
From: arno.odermatt@...1845...
Message-ID: <OFF4D01B5D.C068F160-ONC1257D1D.0055C3F1-C1257D1D.005A2BE1@...1846...>
Date: Tue, 22 Jul 2014 18:24:54 +0200
Content-Type: multipart/alternative;
	boundary="=_alternative 005A2BB1C1257D1D_="
Subject: [Openvpn-devel] Openvpn 2.3.2: "Could not create temporary file"
	....Too many open files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multipart message in MIME format.
--=_alternative 005A2BB1C1257D1D_=
Content-Type: text/plain; charset="US-ASCII"

Dear all,

we are driving O-VPN 2.3.2 on Fedora20.
Since we have quit many permanently connected O-VPN clients, we have 
started three O-VPN processes, listening on three different ports and 
setting up three different tap interfaces:

Today, all three O-VPN processes crashed suddenly, whereas we found 
following error:

 ip-172-16-128-101 openvpn[654]: <CN>/172.16.253.10:44214 Could not create 
temporary file '/var/tmp/openvpn_cc_1bd37815cbacd70936015e40e25198aa.tmp': 
Too many open files

We did not find any helpful information, neither in the the mail-archives, 
nor in other forums/panels, beside something related to user/password 
authentication (openvpn-auth-pam), which we are not using (using 
TLS-server) and also lsof did not provide any helpful information to 
correlate this error to a (file-) resource problem

https://forums.openvpn.net/topic13474.html 
https://community.openvpn.net/openvpn/ticket/201 


After this happened, we found:

- in /tmp:      -rw-r--r--.  1 root    0 Jul 18 10:51 vpn3_sema_15198 
#sema files laying around

- in /var/tmp   -rw-------.  1 root        0 Jul 18 10:51 
openvpn_cc_0e211df697b9f5620da89bd05f44ef48.tmp


Deleting of the sema-files and restarting O-VPN brought back everything to 
life.

Has anybody ever experienced something similar, can this be a bug and what 
could be the corrective action to overcome, this to repeat again?

Thank you for any help in this

Ar



******************************************************
Notice: The information contained in this message is intended only for use of the individual(s) named above and may contain confidential, proprietary or legally privileged information. No confidentiality or privilege is waived or lost by any mistransmission. If you are not the intended recipient of this message you are hereby notified that you must not use, disseminate , copy it in any form or take any action in reliance of it. If you have received this message in error please delete it and any copies of it and notify the sender immediately.
*******************************************************
--=_alternative 005A2BB1C1257D1D_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Dear all,</font>
<br>
<br><font size=2 face="sans-serif">we are driving O-VPN 2.3.2 on Fedora20.</font>
<br><font size=2 face="sans-serif">Since we have quit many permanently
connected O-VPN clients, we have started three O-VPN processes, listening
on three different ports and setting up three different tap interfaces:<br>
<br>
Today, all three O-VPN processes crashed suddenly, whereas we found following
error:<br>
<br>
</font><font size=2 face="Calibri"> ip-172-16-128-101 openvpn[654]: &lt;CN&gt;/172.16.253.10:44214
Could not create temporary file '/var/tmp/openvpn_cc_1bd37815cbacd70936015e40e25198aa.tmp':
</font><font size=2 color=blue face="Calibri"><b>Too many open files</b></font><font size=2 face="sans-serif"><br>
<br>
We did not find any helpful information, neither in the the mail-archives,
nor in other forums/panels, beside something related to user/password authentication
(openvpn-auth-pam), which we are not using (using TLS-server) and also
lsof did not provide any helpful information to correlate this error to
a (file-) resource problem</font>
<br>
<table width=267 style="border-collapse:collapse;">
<tr valign=top height=8>
<td width=265 style="border-style:solid;border-color:#000000;border-width:0px 0px 0px 0px;padding:1px 1px;"><a href=https://forums.openvpn.net/topic13474.html><font size=1 color=blue><b><u>https://forums.openvpn.net/topic13474.html</u></b></font></a><font size=1>
</font><font size=1 color=blue><b><u><br>
</u></b></font><a href=https://community.openvpn.net/openvpn/ticket/201><font size=1 color=blue><b><u>https://community.openvpn.net/openvpn/ticket/201</u></b></font></a><font size=1>
</font></table>
<br>
<br><font size=2 face="sans-serif"><br>
After this happened, we found:</font>
<br>
<br><font size=2 face="sans-serif">- in /tmp: &nbsp; &nbsp; &nbsp; &nbsp;</font><font size=2 face="Calibri">-rw-r--r--.
&nbsp;1 root &nbsp; &nbsp;0 Jul 18 10:51 vpn3_sema_15198</font><font size=2 face="sans-serif">
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;#sema
files laying around</font>
<br>
<br><font size=2 face="sans-serif">- in /var/tmp &nbsp; &nbsp; &nbsp; &nbsp;-rw-------.
&nbsp;1 root &nbsp; &nbsp; &nbsp; &nbsp;0 Jul 18 10:51 openvpn_cc_0e211df697b9f5620da89bd05f44ef48.tmp</font>
<br>
<br><font size=2 face="sans-serif"><br>
Deleting of the sema-files and restarting O-VPN brought back everything
to life.</font>
<br>
<br><font size=2 face="sans-serif">Has anybody ever experienced something
similar, can this be a bug and what could be the corrective action to overcome,
this to repeat again?</font>
<br><font size=2 face="sans-serif"><br>
Thank you for any help in this</font>
<br>
<br><font size=2 face="sans-serif">Ar<br>
</font><font size=1 face="Arial"><br>
</font>
<br clear="both">
******************************************************<BR>
Notice: The information contained in this message is intended only for use of the individual(s) named above and may contain confidential, proprietary or legally privileged information. No confidentiality or privilege is waived or lost by any mistransmission. If you are not the intended recipient of this message you are hereby notified that you must not use, disseminate , copy it in any form or take any action in reliance of it. If you have received this message in error please delete it and any copies of it and notify the sender immediately.<BR>
*******************************************************<BR>

--=_alternative 005A2BB1C1257D1D_=--

