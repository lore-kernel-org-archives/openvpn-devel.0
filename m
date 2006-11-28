Message-ID: <20061128084901.6716.qmail@...953...>
Date: Tue, 28 Nov 2006 08:49:01 +0000 (GMT)
From: gautham gggg <gauthammail1984@...293...>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1467849907-1164703741=:4170"
Content-Transfer-Encoding: 8bit
Subject: [Openvpn-devel] WHat if TUN/TAP interface comes down after OPENVPN
	is up
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--0-1467849907-1164703741=:4170
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi all,
   After OPENVPN is up, if i make the TUN/TAP interface (tun0) down ( by using ifdown tun0 ) in linux, OPENVPN was not able to detect that TUN interface is down. and still be running fine giving CONNECTED state in management interface.
   If i'm not wrong, in source code , it wait for any discriptor change of tun interface, and if it returns -1 on a read call then OPENVPN will exit. But in this case no reads where happening. OPENVPN still thinks as TUN interface is up.
   What could be the solution for the problem if tun interface is made sown and OPENVPN detects it and stops itself. Any change required in TUN driver ??

thanks and regards.
    

 				
---------------------------------
 Find out what India is talking about on  - Yahoo! Answers India 
 Send FREE SMS to your friend's mobile from Yahoo! Messenger Version 8. Get it NOW
--0-1467849907-1164703741=:4170
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi all,<br>&nbsp;&nbsp; After OPENVPN is up, if i make the TUN/TAP interface (tun0) down ( by using ifdown tun0 ) in linux, OPENVPN was not able to detect that TUN interface is down. and still be running fine giving CONNECTED state in management interface.<br>&nbsp;&nbsp; If i'm not wrong, in source code , it wait for any discriptor change of tun interface, and if it returns -1 on a read call then OPENVPN will exit. But in this case no reads where happening. OPENVPN still thinks as TUN interface is up.<br>&nbsp;&nbsp; What could be the solution for the problem if tun interface is made sown and OPENVPN detects it and stops itself. Any change required in TUN driver ??<br><br>thanks and regards.<br>&nbsp;&nbsp;&nbsp; <br><p>&#32;
	

	
		<hr size=1></hr> 
Find out what India is talking about on  - <a href="http://us.rd.yahoo.com/mail/in/yanswers/*http://in.answers.yahoo.com/">Yahoo! Answers India</a> <BR> 
Send FREE SMS to your friend's mobile from Yahoo! Messenger Version 8. <a href="http://us.rd.yahoo.com/mail/in/messengertagline/*http://in.messenger.yahoo.com">Get it NOW</a>
--0-1467849907-1164703741=:4170--

