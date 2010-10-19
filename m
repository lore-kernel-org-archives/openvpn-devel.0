From: Markus Feilner <lists@...646...>
Date: Tue, 19 Oct 2010 02:14:05 +0200
References: <7a2e6f85bccdf9dc5b9d2a1c05d7bd91.squirrel@...1166...>
In-Reply-To: <7a2e6f85bccdf9dc5b9d2a1c05d7bd91.squirrel@...1166...>
MIME-Version: 1.0
Message-Id: <201010190214.06504.lists@...646...>
Subject: Re: [Openvpn-devel] Intelligent OpenVPN service?
Reply-To: mfeilner@...646...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Am Montag, 18. Oktober 2010, um 20:19:53 schrieb Daniel Johnson:
> As a bonus, I'd like the service to fail over to TCP if it cannot
> establish a UDP connection.  However, multiple simultaneous VPN
> connections would very likely be bad so I can't just have the
> service try both.

Hi Daniel,
have a look at the connection profiles in Openvpn 2.1 - that should do that 
trick. You'll find a great description in the manpage.

For the "don't connect from inside"-issue i would use some ifup-magic 
(skripting) or - for windows clients - probably use the firewall approach 
mentioned in this thread.

-- 

Best Regards - Mit freundlichen Gruessen
Markus Feilner

-------------------------
Feilner IT Linux & GIS
Linux Solutions, Training, Seminare, Workshops and Authoring
Koetztinger Strasse 6c		93057 Regensburg - Germany
Phone:				+49 941 8 10 79 89
Mobile:				+49 170 3 02 70 92
Web: www.feilner-it.net 	mail: mfeilner@...646...
Xing: http://www.xing.com/profile/Markus_Feilner
Linkedin: http://de.linkedin.com/in/markusfeilner
Linux Magazine Germany: 	mfeilner@...1310...
--------------------------------------
My books at Packt: Open source - privacy and connectivity for everyone!
 New and revised:  	http://www.packtpub.com/learning-openvpn-2-0-9/book
 Sold over 3000 times:	http://www.packtpub.com/openvpn/book
 My Groupware book: 	http://www.packtpub.com/scalix/book

