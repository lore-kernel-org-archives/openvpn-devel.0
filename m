Message-ID: <1351086345.72493.YahooMailNeo@...1779...>
Date: Wed, 24 Oct 2012 06:45:45 -0700 (PDT)
From: ehsan enayati <ehsan_en85@...109...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="406169123-250744944-1351086345=:72493"
Subject: [Openvpn-devel] how packet queue gets updated
Reply-To: ehsan enayati <ehsan_en85@...109...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--406169123-250744944-1351086345=:72493
Content-Type: text/plain; charset=us-ascii

hi everybody,I have some problems about entry point of packets into openvpn. I know that there is a multi_instance structure which is created per packet and there is a scheduler which detects a packet with earliest wakeup but suppose two clients are connecting to openvpn we know that there is a queue for holding their packets and process these packets, respectively. I have two questions, where is this queue exatly (i mean which structure in code is responsible for holding packets)? and how it's get updated (where does queue and dequeue operation happen?)

Thanks
Ehsan

--406169123-250744944-1351086345=:72493
Content-Type: text/html; charset=us-ascii

<html><body><div style="color:#000; background-color:#fff; font-family:arial, helvetica, sans-serif;font-size:14pt"><div><span>hi everybody,</span></div>I have some problems about entry point of packets into openvpn. I know that there is a multi_instance structure which is created per packet and there is a scheduler which detects a packet with earliest wakeup but suppose two clients are connecting to openvpn we know that there is a queue for holding their packets and process these packets, respectively. I have two questions, where is this queue exatly (i mean which structure in code is responsible for holding packets)? and how it's get updated (where does queue and dequeue operation happen?)<br><br>Thanks<br>Ehsan<br></div></body></html>
--406169123-250744944-1351086345=:72493--

