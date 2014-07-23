In-Reply-To: <20140722193436.GI1118@...1296...>
References: <OF80C424FD.27405071-ONC1257C07.004692C7-C1257C07.004BC7CB@...1923...>
	<OFF4D01B5D.C068F160-ONC1257D1D.0055C3F1-C1257D1D.005A2BE1@...1846...>
	<9998AE72-2992-4D02-8E27-BE9A55BDBDF6@...1286...>
	<20140722193436.GI1118@...1296...>
MIME-Version: 1.0
From: arno.odermatt@...1845...
Message-ID: <OF0A6F87B6.7643FAD4-ONC1257D1E.00208574-C1257D1E.0022B4AF@...1846...>
Date: Wed, 23 Jul 2014 08:19:04 +0200
Content-Type: multipart/alternative;
	boundary="=_alternative 0022B493C1257D1E_="
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
To: Gert Doering <gert@...1296...>, Eric Crist <ecrist@...1286...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multipart message in MIME format.
--=_alternative 0022B493C1257D1E_=
Content-Type: text/plain; charset="US-ASCII"

Dear both,

thank you for your reply.
Yes, we are using the "--client-connect" and according to 2.3 OpenVPN 
manual (see section below) it does create files by writing to "file named 
by $1."

Gert, we are sure, there was not a problem with the resources (eg.: max 
open files, max filed descriptors, etc.) on the system.
What else can I do about it?


--client-connect script
Run script on client connection. The script is passed the common name and 
IP address of the just-authenticated client as environmental variables 
(see environmental variable section below). The script is also passed the 
pathname of a not-yet-created temporary file as $1 (i.e. the first command 
line argument), to be used by the script to pass dynamically generated 
config file directives back to OpenVPN.
If the script wants to generate a dynamic config file to be applied on the 
server when the client connects, it should write it to the file named by 
$1.


thank you again

Arno






From:   Gert Doering <gert@...1296...>
To:     Eric Crist <ecrist@...1286...>, 
Cc:     arno.odermatt@...1845..., 
openvpn-devel@lists.sourceforge.net
Date:   22.07.2014 21:34
Subject:        Re: [Openvpn-devel] Openvpn 2.3.2: "Could not create 
temporary file" ....Too many open files



Hi,

On Tue, Jul 22, 2014 at 12:37:19PM -0500, Eric Crist wrote:
> This isn't an OpenVPN problem, directly.  It appears you have a client 
connect script, or are storing connection information in temp files.  You 
can increase the maximum allowed open files in Fedora (you'll have to 
research that yourself).  Alternatively, stop storing connection data in a 
temp file for new connections.  OpenVPN, by itself, does not create these 
temporary files.

Uh, this is not fully correct.  If you use --client-connect (or any of
the other up scripts that enable passing of config values back), OpenVPN
will create the temp file to be used for that, to avoid race conditions.

I'm not sure when this was added, but "recentish" (2.2.x)

Now the sema-files do not ring a bell, but we need to check whether we
properly clean up the other files - but that should be visible in "lsof"
while OpenVPN is running and after a few connections have completed.

gert

-- 
USENET is *not* the non-clickable part of WWW!
 //www.muc.de/~gert/
Gert Doering - Munich, Germany gert@...1296...
fax: +49-89-35655025 gert@...1297...
[attachment "attp7yyb.dat" deleted by Arno Odermatt/R&D/SCH/SCHINDLER] 


******************************************************
Notice: The information contained in this message is intended only for use of the individual(s) named above and may contain confidential, proprietary or legally privileged information. No confidentiality or privilege is waived or lost by any mistransmission. If you are not the intended recipient of this message you are hereby notified that you must not use, disseminate , copy it in any form or take any action in reliance of it. If you have received this message in error please delete it and any copies of it and notify the sender immediately.
*******************************************************
--=_alternative 0022B493C1257D1E_=
Content-Type: text/html; charset="US-ASCII"

<tt><font size=2>Dear both,</font></tt>
<br>
<br><tt><font size=2>thank you for your reply.</font></tt>
<br><tt><font size=2>Yes, we are using the &quot;--client-connect&quot;
and according to 2.3 OpenVPN manual (see section below) it does create
files by writing to &quot;</font></tt><font size=2 face="sans-serif">file
named by $1.&quot;<br>
<br>
Gert, we are sure, there was not a problem with the resources (eg.: max
open files, max filed descriptors, etc.) on the system.</font>
<br><font size=2 face="sans-serif">What else can I do about it?</font>
<br>
<br>
<br><font size=2 face="sans-serif">--client-connect script</font>
<br><font size=2 face="sans-serif">Run script on client connection. The
script is passed the common name and IP address of the just-authenticated
client as environmental variables (see environmental variable section below).
The script is also passed the pathname of a not-yet-created temporary file
as $1 (i.e. the first command line argument), to be used by the script
to pass dynamically generated config file directives back to OpenVPN.</font>
<br><font size=2 face="sans-serif">If the script wants to generate a dynamic
config file to be applied on the server when the client connects, it should
write it to the file named by $1.</font>
<br>
<br>
<br><tt><font size=2>thank you again</font></tt>
<br>
<br><tt><font size=2>Arno</font></tt>
<br><font size=1 color=#5f5f5f face="Arial"><br>
</font><font size=1 color=#008000 face="Arial"><br>
</font>
<br>
<br>
<br>
<br><font size=1 color=#5f5f5f face="sans-serif">From: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Gert Doering &lt;gert@...1296...&gt;</font>
<br><font size=1 color=#5f5f5f face="sans-serif">To: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">Eric Crist &lt;ecrist@...1286...&gt;,
</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Cc: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">arno.odermatt@...1845...,
openvpn-devel@lists.sourceforge.net</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">22.07.2014 21:34</font>
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
On Tue, Jul 22, 2014 at 12:37:19PM -0500, Eric Crist wrote:<br>
&gt; This isn't an OpenVPN problem, directly. &nbsp;It appears you have
a client connect script, or are storing connection information in temp
files. &nbsp;You can increase the maximum allowed open files in Fedora
(you'll have to research that yourself). &nbsp;Alternatively, stop storing
connection data in a temp file for new connections. &nbsp;OpenVPN, by itself,
does not create these temporary files.<br>
<br>
Uh, this is not fully correct. &nbsp;If you use --client-connect (or any
of<br>
the other up scripts that enable passing of config values back), OpenVPN<br>
will create the temp file to be used for that, to avoid race conditions.<br>
<br>
I'm not sure when this was added, but &quot;recentish&quot; (2.2.x)<br>
<br>
Now the sema-files do not ring a bell, but we need to check whether we<br>
properly clean up the other files - but that should be visible in &quot;lsof&quot;<br>
while OpenVPN is running and after a few connections have completed.<br>
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
[attachment &quot;attp7yyb.dat&quot; deleted by Arno Odermatt/R&amp;D/SCH/SCHINDLER]
</font></tt>
<br>
<br clear="both">
******************************************************<BR>
Notice: The information contained in this message is intended only for use of the individual(s) named above and may contain confidential, proprietary or legally privileged information. No confidentiality or privilege is waived or lost by any mistransmission. If you are not the intended recipient of this message you are hereby notified that you must not use, disseminate , copy it in any form or take any action in reliance of it. If you have received this message in error please delete it and any copies of it and notify the sender immediately.<BR>
*******************************************************<BR>

--=_alternative 0022B493C1257D1E_=--

