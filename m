Message-ID: <40A1124D.3030508@...199...>
From: Mike Auty <m.auty@...199...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] 2.0: public linux <- nat -> private win2k
References: <40A102C0.6020101@...61...>
In-Reply-To: <40A102C0.6020101@...61...>
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
Date: Tue May 11 10:52:07 2004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Julien TOUCHE <julien.touche@...61...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,
	The "RWRWRRRWWWRWRRR" is related to transfer and traffic.  It is 
because you have the line "verb 5" (or higher) in your config file. 
This is different from 1.x as far as I'm aware, and is simply debugging 
information (read up on the verb keyword for more information as to what 
level shows what readout).  As to whether this is intentional or a 
regression, you'd have to ask James about that one.
	As to the pull option it is (as far as I know) only for "mode server", 
since for a single to single connection the options are unlikely to 
change and so might as well be written directly into the configuration 
files.
	Hope this helps,
	Mike  5:)

