Message-ID: <434AB530.4010202@...361...>
From: Rolf Fokkens <r.fokkens@...361...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Patch: TAP usage made non ARP dependent
References: <43404D99.8080309@...361...>  <434189C7.5090304@...361...>	 <1128369731.6952.59.camel@...399...> <4342703F.90607@...361...>	 <1128428582.7061.18.camel@...399...>	 <4342D092.4050502@...361...>	 <1128619301.7000.58.camel@...399...>	 <4346A01F.4030106@...361...>	 <1128702738.7000.97.camel@...399...>	 <4346ED46.4040204@...361...> <43478832.9050200@...361...>	 <Pine.LNX.4.58.0510081447170.32321@...41...> <4348E1EF.8020906@...361...>	 <4348FD69.6010807@...361...> <1128947877.32068.39.camel@...399...>
In-Reply-To: <1128947877.32068.39.camel@...399...>
Content-Type: multipart/alternative;
 boundary="------------020906060102080804070604"
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Oct 10 11:39:49 2005
To: Marcelo Toledo <marcelo@...461...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------020906060102080804070604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Marcelo Toledo wrote:

>Sat Oct  8 14:28:25 2005 Data Channel MTU parms [ L:1576 D:1450 EF:44
>EB:135 ET:32 EL:0 AF:3/1 ]
>Sat Oct  8 14:28:25 2005 Listening for incoming TCP connection on
>[undef]:1194
>Sat Oct  8 14:28:25 2005 TCPv4_SERVER link local (bound): [undef]:1194
>Sat Oct  8 14:28:25 2005 TCPv4_SERVER link remote: [undef]
>Sat Oct  8 14:28:25 2005 Initialization Sequence Completed
>Sat Oct  8 14:30:16 2005 Assertion failed at multi.c:1815
>Sat Oct  8 14:30:16 2005 Exiting
>  
>
I tried to reproduce, but no problems at all:

Mon Oct 10 20:31:05 2005 Listening for incoming TCP connection on 
[undef]:5000
Mon Oct 10 20:31:05 2005 TCPv4_SERVER link local (bound): [undef]:5000
Mon Oct 10 20:31:05 2005 TCPv4_SERVER link remote: [undef]
Mon Oct 10 20:31:05 2005 Initialization Sequence Completed
Mon Oct 10 20:32:18 2005 Re-using SSL/TLS context
Mon Oct 10 20:32:18 2005 Control Channel MTU parms [ L:1591 D:140 EF:40 
EB:0 ET:0 EL:0 ]
Mon Oct 10 20:32:18 2005 Data Channel MTU parms [ L:1591 D:1450 EF:59 
EB:4 ET:32 EL:0 ]

I need more info,:

    * What server params do you use?
      Apparently you use TCP , and the default 1194 port. I need more
      I'm afraid.
    * What OS are you using?
      I'm running Fedora Core 3 and Fedora Core 4.


--------------020906060102080804070604
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=UTF-8" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Marcelo Toledo wrote:
<blockquote cite="mid1128947877.32068.39.camel@...399..."
 type="cite">
  <pre wrap="">Sat Oct  8 14:28:25 2005 Data Channel MTU parms [ L:1576 D:1450 EF:44
EB:135 ET:32 EL:0 AF:3/1 ]
Sat Oct  8 14:28:25 2005 Listening for incoming TCP connection on
[undef]:1194
Sat Oct  8 14:28:25 2005 TCPv4_SERVER link local (bound): [undef]:1194
Sat Oct  8 14:28:25 2005 TCPv4_SERVER link remote: [undef]
Sat Oct  8 14:28:25 2005 Initialization Sequence Completed
Sat Oct  8 14:30:16 2005 Assertion failed at multi.c:1815
Sat Oct  8 14:30:16 2005 Exiting
  </pre>
</blockquote>
I tried to reproduce, but no problems at all:<br>
<br>
<tt>Mon Oct 10 20:31:05 2005 Listening for incoming TCP connection on
[undef]:5000<br>
Mon Oct 10 20:31:05 2005 TCPv4_SERVER link local (bound): [undef]:5000<br>
Mon Oct 10 20:31:05 2005 TCPv4_SERVER link remote: [undef]<br>
Mon Oct 10 20:31:05 2005 Initialization Sequence Completed<br>
Mon Oct 10 20:32:18 2005 Re-using SSL/TLS context<br>
Mon Oct 10 20:32:18 2005 Control Channel MTU parms [ L:1591 D:140 EF:40
EB:0 ET:0 EL:0 ]<br>
Mon Oct 10 20:32:18 2005 Data Channel MTU parms [ L:1591 D:1450 EF:59
EB:4 ET:32 EL:0 ]</tt><br>
<br>
I need more info,:<br>
<ul>
  <li>What server params do you use?<br>
Apparently you use TCP , and the default 1194 port. I need more I'm
afraid.<br>
  </li>
  <li>What OS are you using?<br>
I'm running Fedora Core 3 and Fedora Core 4.<br>
  </li>
</ul>
</body>
</html>

--------------020906060102080804070604--

