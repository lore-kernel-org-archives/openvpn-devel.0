Message-ID: <4B5FB064.3070308@...1299...>
Date: Wed, 27 Jan 2010 16:17:56 +1300
From: Jason Haar <Jason.Haar@...1299...>
MIME-Version: 1.0
References: <4B5E2895.4030906@...1299...> <1264523745.26411.1@...1207...>
	<4B5F33E4.5080508@...1299...>
In-Reply-To: <4B5F33E4.5080508@...1299...>
Subject: Re: [Openvpn-devel] win32 openvpn-2.1.1 has bug with "nobind"?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net


I have been googling around and others reported this back in 2005!
Looking at the code (I'm no programmer), there seems to be a hint that
the "nobind" option only works for TCP - not UDP?

Is this true? There's no reason for it that I can think of, but it would
explain what I'm seeing: in UDP mode, openvpn ignores "nobind". Even on
my Linux box, I have "nobind" set and yet it's using 1194 for lport...

Confirmed. I have a server running on 1194 tcp and udp and if I toggle
between tcp and udp on the client (ie nobind remains the same), I see
lport=1194 for udp and lport=>1023 for tcp


Jason

-- 
Cheers

Jason Haar
Information Security Manager, Trimble Navigation Ltd.
Phone: +64 3 9635 377 Fax: +64 3 9635 417
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1


